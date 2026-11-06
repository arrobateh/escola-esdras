-- ============================================================================
-- Escola de Esdras — Schema do Supabase (PostgreSQL + Auth + RLS)
-- ============================================================================
-- Como aplicar:
--   1. Abra o painel do Supabase (Dashboard) do projeto.
--   2. Vá em "SQL Editor" (ou "Editor SQL") no menu lateral.
--   3. Cole este arquivo inteiro e clique em "Run".
--   4. Depois, marque o dono como administrador (veja o README.md).
--
-- Observações importantes:
--   * O SQL Editor roda como `postgres` (owner/superuser) e, por isso,
--     IGNORA as políticas de RLS. Ou seja: o SEED incluído aqui pode ser
--     executado normalmente, mesmo com o RLS já habilitado.
--   * Este script é idempotente para as definições (tabelas, funções,
--     triggers e policies usam IF NOT EXISTS / DROP IF EXISTS). O SEED,
--     porém, cria UM PLANO NOVO a cada execução (gera um novo UUID).
-- ============================================================================

-- ============================================================================
-- 1) Tabela `profiles` — perfil público (do ponto de vista do app) do usuário.
--    Espelha `auth.users` e carrega dados extras (nome, igreja, admin).
-- ============================================================================

create table if not exists public.profiles (
  id          uuid primary key references auth.users(id) on delete cascade,
  full_name   text,
  church_name text,
  is_admin    boolean not null default false,
  created_at  timestamptz not null default now()
);

-- ----------------------------------------------------------------------------
-- Helper de segurança (boas práticas do Supabase): verifica se o usuário
-- autenticado é administrador.
-- `security definer` + `set search_path = public` evita:
--   * recursão de RLS ao consultar `profiles` dentro de outra policy;
--   * "search_path hijacking" (sequestro do caminho de busca).
-- Definida APÓS `profiles` porque, em funções `language sql`, o corpo é
-- analisado (e as referências a tabelas são resolvidas) no CREATE FUNCTION.
-- ----------------------------------------------------------------------------
create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.profiles
    where id = auth.uid()
      and is_admin = true
  );
$$;

-- ----------------------------------------------------------------------------
-- Trigger que cria automaticamente um `profile` quando um usuário é criado.
-- `full_name` é lido de `raw_user_meta_data` (preenchido no signUp / OAuth).
-- ----------------------------------------------------------------------------
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, full_name)
  values (
    new.id,
    new.raw_user_meta_data ->> 'full_name'
  );
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- ============================================================================
-- 2) Tabela `reading_plans` — planos de leitura (criados pelo ADM no console).
-- ============================================================================

create table if not exists public.reading_plans (
  id              uuid primary key default gen_random_uuid(),
  title           text not null,
  description     text,
  duration_days   integer not null,
  start_date      date, -- Data de início compartilhada; domingos não contam.
  cover_image_url text,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now()
);

-- Compatibilidade ao aplicar o schema em uma instalação existente.
alter table public.reading_plans add column if not exists start_date date;

-- ============================================================================
-- 3) Tabela `plan_day_contents` — capítulos de cada dia de um plano.
--    Um registro POR capítulo, agrupado por dia (`day_number`) e ordenado por
--    `sort_order` (1..N) dentro do dia.
--    `book_abbrev` usa o mesmo padrão do catálogo local (ex.: "gn" = Gênesis).
--    `start_verse`/`end_verse` NULL = capítulo inteiro; usados APENAS nas
--    partes do Salmos 119 (176 versículos divididos em 6 blocos).
-- ============================================================================

create table if not exists public.plan_day_contents (
  id          uuid primary key default gen_random_uuid(),
  plan_id     uuid not null references public.reading_plans(id) on delete cascade,
  day_number  integer not null,
  sort_order  integer not null default 1,
  book_abbrev text not null,
  chapter     integer not null,
  start_verse integer,
  end_verse   integer
);

-- Índice para listar os dias de um plano na ordem correta.
create index if not exists plan_day_contents_plan_day_idx
  on public.plan_day_contents (plan_id, day_number, sort_order);

-- ============================================================================
-- 4) Tabela `user_plan_progress` — progresso de cada usuário em cada dia.
--    PK composta evita duplicidade; status: PENDING / COMPLETED / MISSED.
-- ============================================================================

create table if not exists public.user_plan_progress (
  user_id      uuid not null references auth.users(id) on delete cascade,
  plan_id      uuid not null references public.reading_plans(id) on delete cascade,
  day_number   integer not null,
  status       text not null default 'PENDING'
               check (status in ('PENDING','COMPLETED','MISSED')),
  completed_at timestamptz,
  updated_at   timestamptz not null default now(),
  primary key (user_id, plan_id, day_number)
);

-- Índice para consultas agregadas por plano (ex.: "quantos concluíram o dia X").
create index if not exists user_plan_progress_plan_idx
  on public.user_plan_progress (plan_id);

-- ============================================================================
-- 4.1) Tabelas de progresso de leitura de capítulos (sync Fase 4).
-- ============================================================================

-- `chapter_progress` — capítulo lido por usuário (espelho da tabela SQLite
-- local `chapter_progress`). A PK `(user_id, book_abbrev, chapter_number)` já
-- cobre consultas por `user_id` (coluna líder), então não criamos índice extra.
create table if not exists public.chapter_progress (
  user_id         uuid not null references auth.users(id) on delete cascade,
  book_abbrev     text not null,
  chapter_number  integer not null,
  read_at         timestamptz,
  updated_at      timestamptz not null default now(),
  primary key (user_id, book_abbrev, chapter_number)
);

-- `chapter_progress_deletions` — tombstones de desmarcação (deleção lógica).
-- Sempre que um capítulo é desmarcado, gravamos aqui o `deleted_at`. Durante o
-- pull, o app compara, por chave, o `updated_at` do read com o `deleted_at` do
-- tombstone e aplica LWW. Sem esta tabela, uma deleção (ausência de linha) não
-- teria timestamp e um aparelho desatualizado poderia "ressuscitar" a leitura.
create table if not exists public.chapter_progress_deletions (
  user_id         uuid not null references auth.users(id) on delete cascade,
  book_abbrev     text not null,
  chapter_number  integer not null,
  deleted_at      timestamptz not null default now(),
  primary key (user_id, book_abbrev, chapter_number)
);

-- ============================================================================
-- 5) Row Level Security (RLS) — habilita e define as políticas de acesso.
-- ============================================================================

alter table public.profiles                    enable row level security;
alter table public.reading_plans               enable row level security;
alter table public.plan_day_contents           enable row level security;
alter table public.user_plan_progress          enable row level security;
alter table public.chapter_progress            enable row level security;
alter table public.chapter_progress_deletions  enable row level security;

-- ----------------------------------------------------------------------------
-- Grants (permissões de tabela). A proteção REAL é feita pela RLS; aqui apenas
-- garantimos que `anon` não enxergue nada e que `authenticated` possa operar.
-- ----------------------------------------------------------------------------
revoke all on public.profiles                   from anon;
revoke all on public.reading_plans              from anon;
revoke all on public.plan_day_contents          from anon;
revoke all on public.user_plan_progress         from anon;
revoke all on public.chapter_progress           from anon;
revoke all on public.chapter_progress_deletions from anon;

revoke all on public.profiles from public, authenticated;
grant select on public.profiles to authenticated;
grant update(full_name, church_name) on public.profiles to authenticated;
grant all on public.reading_plans              to authenticated;
grant all on public.plan_day_contents          to authenticated;
grant all on public.user_plan_progress         to authenticated;
grant all on public.chapter_progress           to authenticated;
grant all on public.chapter_progress_deletions to authenticated;

-- ----------------------------------------------------------------------------
-- 5.1) `profiles`
-- DECISÃO: SELECT e UPDATE apenas para o PRÓPRIO usuário. Não há SELECT
-- público para outros usuários autenticados, para preservar privacidade
-- (ex.: `church_name`). Se futuramente for necessário exibir nome/igreja de
-- outros membros (ex.: lista de membros do grupo), adicione uma policy
-- específica aqui em vez de liberar a tabela inteira.
-- ----------------------------------------------------------------------------
drop policy if exists profiles_select_own on public.profiles;
create policy profiles_select_own
  on public.profiles
  for select
  to authenticated
  using (auth.uid() = id);

drop policy if exists profiles_update_own on public.profiles;
create policy profiles_update_own
  on public.profiles
  for update
  to authenticated
  using (auth.uid() = id)
  with check (auth.uid() = id);

-- ----------------------------------------------------------------------------
-- 5.2) `reading_plans`
-- SELECT: qualquer usuário autenticado (todos veem os planos).
-- INSERT/UPDATE/DELETE: somente administradores (`is_admin()`).
-- ----------------------------------------------------------------------------
drop policy if exists reading_plans_select_authenticated on public.reading_plans;
create policy reading_plans_select_authenticated
  on public.reading_plans
  for select
  to authenticated
  using (true);

drop policy if exists reading_plans_insert_admin on public.reading_plans;
create policy reading_plans_insert_admin
  on public.reading_plans
  for insert
  to authenticated
  with check (public.is_admin());

drop policy if exists reading_plans_update_admin on public.reading_plans;
create policy reading_plans_update_admin
  on public.reading_plans
  for update
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

drop policy if exists reading_plans_delete_admin on public.reading_plans;
create policy reading_plans_delete_admin
  on public.reading_plans
  for delete
  to authenticated
  using (public.is_admin());

-- ----------------------------------------------------------------------------
-- 5.3) `plan_day_contents`
-- SELECT: qualquer usuário autenticado.
-- INSERT/UPDATE/DELETE: somente administradores.
-- ----------------------------------------------------------------------------
drop policy if exists plan_day_contents_select_authenticated on public.plan_day_contents;
create policy plan_day_contents_select_authenticated
  on public.plan_day_contents
  for select
  to authenticated
  using (true);

drop policy if exists plan_day_contents_insert_admin on public.plan_day_contents;
create policy plan_day_contents_insert_admin
  on public.plan_day_contents
  for insert
  to authenticated
  with check (public.is_admin());

drop policy if exists plan_day_contents_update_admin on public.plan_day_contents;
create policy plan_day_contents_update_admin
  on public.plan_day_contents
  for update
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

drop policy if exists plan_day_contents_delete_admin on public.plan_day_contents;
create policy plan_day_contents_delete_admin
  on public.plan_day_contents
  for delete
  to authenticated
  using (public.is_admin());

-- ----------------------------------------------------------------------------
-- 5.4) `user_plan_progress`
-- SELECT/INSERT/UPDATE/DELETE: somente o PRÓPRIO usuário.
-- ----------------------------------------------------------------------------
drop policy if exists progress_select_own on public.user_plan_progress;
create policy progress_select_own
  on public.user_plan_progress
  for select
  to authenticated
  using (auth.uid() = user_id);

drop policy if exists progress_insert_own on public.user_plan_progress;
create policy progress_insert_own
  on public.user_plan_progress
  for insert
  to authenticated
  with check (auth.uid() = user_id);

drop policy if exists progress_update_own on public.user_plan_progress;
create policy progress_update_own
  on public.user_plan_progress
  for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists progress_delete_own on public.user_plan_progress;
create policy progress_delete_own
  on public.user_plan_progress
  for delete
  to authenticated
  using (auth.uid() = user_id);

-- ----------------------------------------------------------------------------
-- 5.5) `chapter_progress` e `chapter_progress_deletions`
-- SELECT/INSERT/UPDATE/DELETE: somente o PRÓPRIO usuário.
-- ----------------------------------------------------------------------------
drop policy if exists chapter_progress_select_own on public.chapter_progress;
create policy chapter_progress_select_own
  on public.chapter_progress
  for select
  to authenticated
  using (auth.uid() = user_id);

drop policy if exists chapter_progress_insert_own on public.chapter_progress;
create policy chapter_progress_insert_own
  on public.chapter_progress
  for insert
  to authenticated
  with check (auth.uid() = user_id);

drop policy if exists chapter_progress_update_own on public.chapter_progress;
create policy chapter_progress_update_own
  on public.chapter_progress
  for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists chapter_progress_delete_own on public.chapter_progress;
create policy chapter_progress_delete_own
  on public.chapter_progress
  for delete
  to authenticated
  using (auth.uid() = user_id);

drop policy if exists chapter_progress_deletions_select_own on public.chapter_progress_deletions;
create policy chapter_progress_deletions_select_own
  on public.chapter_progress_deletions
  for select
  to authenticated
  using (auth.uid() = user_id);

drop policy if exists chapter_progress_deletions_insert_own on public.chapter_progress_deletions;
create policy chapter_progress_deletions_insert_own
  on public.chapter_progress_deletions
  for insert
  to authenticated
  with check (auth.uid() = user_id);

drop policy if exists chapter_progress_deletions_update_own on public.chapter_progress_deletions;
create policy chapter_progress_deletions_update_own
  on public.chapter_progress_deletions
  for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists chapter_progress_deletions_delete_own on public.chapter_progress_deletions;
create policy chapter_progress_deletions_delete_own
  on public.chapter_progress_deletions
  for delete
  to authenticated
  using (auth.uid() = user_id);

-- ============================================================================
-- 6) Função geradora do plano "Bíblia Completa" + seed.
-- ============================================================================
-- NOTA: o SQL Editor roda como `postgres` (owner/superuser) e, por isso,
-- IGNORA a RLS. A função é `security definer` (roda como owner), então também
-- insere em `reading_plans`/`plan_day_contents` sem depender das policies.
--
-- Regra de geração (planos de leitura SEQUENCIAL da Bíblia completa):
--   * Percorre os 66 livros em ordem canônica (Gênesis → Apocalipse).
--   * 4 capítulos por dia, de segunda a sábado (24/semana).
--   * Salmos 119 (176 versículos) é exceção: dividido em 6 partes, uma por dia.
--   * Resultado: 303 dias.
-- A função é idempotente no sentido de que cada chamada CRIA UM PLANO NOVO
-- (gera um novo UUID) — é o comportamento esperado.
-- ============================================================================

create or replace function public.generate_bible_plan(
  plan_title text default 'Bíblia Completa'
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  new_plan_id      uuid;
  v_day_number     integer := 0;
  v_sort_order     integer := 0; -- posição do próximo capítulo no dia (0 = vazio)
  v_total_chapters integer;
  v_start_verse    integer;
  v_end_verse      integer;
  v_part           integer;
  rec              record;
begin
  -- 1) Cria o plano. `duration_days` começa em 0 e é corrigido ao final.
  insert into public.reading_plans (title, description, duration_days)
  values (
    plan_title,
    'Leitura sequencial da Bíblia completa (Gênesis a Apocalipse). 4 capítulos por dia, de segunda a sábado (24 por semana). Salmos 119 é dividido em 6 partes, uma por dia.',
    0
  )
  returning id into new_plan_id;

  -- 2) Percorre os 66 livros em ORDEM CANÔNICA (mesma ordem do catálogo do app,
  --    `src/db/books-catalog.ts`). O Supabase não tem a tabela `books`, então a
  --    lista de livros (abbrev + total_chapters) é incorporada aqui.
  for rec in
    select t.book_abbrev, t.total_chapters
    from (values
      -- Pentateuco
      ('gn', 50), ('ex', 40), ('lv', 27), ('nm', 36), ('dt', 34),
      -- Históricos
      ('js', 24), ('jz', 21), ('rt', 4), ('1sm', 31), ('2sm', 24),
      ('1rs', 22), ('2rs', 25), ('1cr', 29), ('2cr', 36), ('ed', 10),
      ('ne', 13), ('et', 10),
      -- Poéticos
      ('jó', 42), ('sl', 150), ('pv', 31), ('ec', 12), ('ct', 8),
      -- Profetas maiores
      ('is', 66), ('jr', 52), ('lm', 5), ('ez', 48), ('dn', 12),
      -- Profetas menores
      ('os', 14), ('jl', 3), ('am', 9), ('ob', 1), ('jn', 4), ('mq', 7),
      ('na', 3), ('hc', 3), ('sf', 3), ('ag', 2), ('zc', 14), ('ml', 4),
      -- Evangelhos
      ('mt', 28), ('mc', 16), ('lc', 24), ('jo', 21),
      -- História
      ('atos', 28),
      -- Epístolas paulinas
      ('rm', 16), ('1co', 16), ('2co', 13), ('gl', 6), ('ef', 6),
      ('fp', 4), ('cl', 4), ('1ts', 5), ('2ts', 3), ('1tm', 6),
      ('2tm', 4), ('tt', 3), ('fm', 1),
      -- Epístolas gerais
      ('hb', 13), ('tg', 5), ('1pe', 5), ('2pe', 3), ('1jo', 5),
      ('2jo', 1), ('3jo', 1), ('jd', 1),
      -- Apocalipse
      ('ap', 22)
    ) as t(book_abbrev, total_chapters)
  loop
    v_total_chapters := rec.total_chapters;

    for ch in 1 .. v_total_chapters loop
      -- ---------------------------------------------------------------
      -- EXCEÇÃO: Salmos 119 (176 versículos) vira 6 dias, um por parte.
      -- ---------------------------------------------------------------
      if rec.book_abbrev = 'sl' and ch = 119 then
        -- Fecha o dia corrente (se houver 1..3 capítulos acumulados, aquele dia
        -- fica com menos de 4). Zerar `v_sort_order` força Salmos 120 a abrir
        -- um dia novo.
        v_sort_order := 0;

        -- Divisão balanceada dos 176 versículos em 6 blocos:
        --   30, 30, 29, 29, 29, 29 (total = 176).
        for v_part in 1 .. 6 loop
          case v_part
            when 1 then
              v_start_verse := 1;
              v_end_verse   := 30;
            when 2 then
              v_start_verse := 31;
              v_end_verse   := 60;
            when 3 then
              v_start_verse := 61;
              v_end_verse   := 89;
            when 4 then
              v_start_verse := 90;
              v_end_verse   := 118;
            when 5 then
              v_start_verse := 119;
              v_end_verse   := 147;
            else
              v_start_verse := 148;
              v_end_verse   := 176;
          end case;

          v_day_number := v_day_number + 1;

          insert into public.plan_day_contents
            (plan_id, day_number, sort_order, book_abbrev, chapter, start_verse, end_verse)
          values
            (new_plan_id, v_day_number, 1, 'sl', 119, v_start_verse, v_end_verse);
        end loop;

        -- Continua normalmente a partir de Salmos 120.
        continue;
      end if;

      -- ---------------------------------------------------------------
      -- Capítulo "normal": agrupa 4 por dia (sort_order 1..4).
      -- ---------------------------------------------------------------
      if v_sort_order = 0 then
        v_day_number := v_day_number + 1;
      end if;

      v_sort_order := v_sort_order + 1;

      insert into public.plan_day_contents
        (plan_id, day_number, sort_order, book_abbrev, chapter, start_verse, end_verse)
      values
        (new_plan_id, v_day_number, v_sort_order, rec.book_abbrev, ch, null, null);

      if v_sort_order = 4 then
        v_sort_order := 0;
      end if;
    end loop;
  end loop;

  -- 3) Define a duração real do plano (total de dias gerados = 303).
  update public.reading_plans
     set duration_days = v_day_number
   where id = new_plan_id;

  return new_plan_id;
end;
$$;

revoke all on function public.generate_bible_plan(text) from public, anon, authenticated;
grant execute on function public.generate_bible_plan(text) to service_role;

-- Gera o plano de leitura sequencial da Bíblia completa.
do $$
declare
  seeded_plan_id uuid;
begin
  seeded_plan_id := public.generate_bible_plan('Bíblia Completa');
  update public.reading_plans
  set start_date = date '2026-02-26', updated_at = now()
  where id = seeded_plan_id;
end;
$$;

-- Cadastro de igrejas e gravação segura de perfil.
-- Aplicar no SQL Editor; não recria planos nem apaga dados.
begin;
create table if not exists public.churches (
 id uuid primary key default gen_random_uuid(),
 name text not null check (length(trim(name)) > 0),
 address text,
 pastor_name text,
 photo_url text,
 created_at timestamptz not null default now()
);
alter table public.churches enable row level security;
grant select on public.churches to authenticated;
grant insert, update, delete on public.churches to authenticated;
drop policy if exists churches_read on public.churches;
create policy churches_read on public.churches for select to authenticated using (true);
drop policy if exists churches_admin on public.churches;
create policy churches_admin on public.churches for all to authenticated using (public.is_admin()) with check (public.is_admin());

-- Cria o perfil ausente ou atualiza apenas dados pessoais do próprio usuário.
-- Nunca permite atribuir is_admin pelo cliente.
create or replace function public.save_own_profile(profile_name text, profile_church text)
returns setof public.profiles
language plpgsql security definer set search_path = public
as $$
begin
 if auth.uid() is null then raise exception 'Autenticação necessária'; end if;
 if nullif(trim(profile_name), '') is null then raise exception 'Informe seu nome'; end if;
 if profile_church is not null and not exists(select 1 from public.churches where name = profile_church) then
  raise exception 'Selecione uma igreja cadastrada';
 end if;
 return query
 insert into public.profiles(id, full_name, church_name)
 values (auth.uid(), trim(profile_name), profile_church)
 on conflict(id) do update set full_name = excluded.full_name, church_name = excluded.church_name
 returning *;
end;
$$;
revoke all on function public.save_own_profile(text, text) from public, anon;
grant execute on function public.save_own_profile(text, text) to authenticated;
commit;
