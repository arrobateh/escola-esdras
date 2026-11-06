-- ============================================================================
-- Escola de Esdras — Migration dos planos de leitura (v2)
-- ============================================================================
-- CORREÇÃO DE REQUISITO: os planos NÃO são devocionais — são planos de
-- leitura SEQUENCIAL da Bíblia completa (Gênesis → Apocalipse, ordem canônica).
--
-- Regra de geração:
--   * 4 capítulos por dia, de segunda a sábado (24/semana);
--   * Salmos 119 (176 versículos) é a única exceção: dividido em 6 partes
--     (uma por dia), ocupando a semana inteira;
--   * Progresso marcado POR DIA (`user_plan_progress`).
--
-- O QUE ESTE SCRIPT FAZ:
--   1. Recria `plan_day_contents` no novo modelo (um registro POR capítulo).
--   2. Remove o seed devocional antigo ("Ansioso Por Nada").
--   3. Cria a função geradora `public.generate_bible_plan(...)`.
--   4. Gera o plano "Bíblia Completa" (303 dias).
--
-- COMO APLICAR (executar UMA única vez):
--   1. Painel do Supabase → SQL Editor → New query.
--   2. Cole TODO este arquivo e clique em "Run".
--
-- IMPORTANTE (idempotência):
--   * Este script NÃO é idempotente por design: `drop table ... cascade` apaga
--     os conteúdos atuais de `plan_day_contents` e a chamada final de
--     `generate_bible_plan` cria UM plano novo a cada execução. Se rodar de
--     novo, você perde os conteúdos já gerados e duplica o plano. Rode apenas
--     uma vez, ou gere planos extras manualmente via
--     `select public.generate_bible_plan('Meu Plano');`.
--
-- ESCOLHA drop/create vs alter table:
--   * Optamos por recriar a tabela (drop + create) porque a semântica mudou
--     por completo: entram colunas NOT NULL sem default (`book_abbrev`,
--     `chapter`) e saem colunas antigas (`content_type`, `title`,
--     `start_chapter`, `end_chapter`). Fazer isso via `alter table` exigiria
--     uma sequência frágil de passos (apagar dados, dropar constraints, add/
--     drop columns, tornar NOT NULL), sem ganho real.
--   * A tabela antiga continha apenas o seed devocional, que é removido mesmo.
--   * `user_plan_progress` referencia apenas `reading_plans` (não esta tabela),
--     então não há FK órfã ao dropar `plan_day_contents`.
--   * Ao dropar a tabela, as policies dela caem junto — por isso as recriamos.
-- ============================================================================

begin;

alter table public.reading_plans add column if not exists start_date date;

-- ----------------------------------------------------------------------------
-- 1) Remove o seed devocional antigo.
--    (o `on delete cascade` de `user_plan_progress` limpa o progresso órfão.)
-- ----------------------------------------------------------------------------
delete from public.reading_plans where title = 'Ansioso Por Nada';

-- ----------------------------------------------------------------------------
-- 2) Recria `plan_day_contents` no novo modelo.
-- ----------------------------------------------------------------------------
drop table if exists public.plan_day_contents cascade;

create table public.plan_day_contents (
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
create index plan_day_contents_plan_day_idx
  on public.plan_day_contents (plan_id, day_number, sort_order);

-- ----------------------------------------------------------------------------
-- 3) RLS + grants + policies (recriadas, pois a tabela foi recriada).
--    Mantém exatamente a mesma política do schema original.
-- ----------------------------------------------------------------------------
alter table public.plan_day_contents enable row level security;

revoke all on public.plan_day_contents from anon;
grant all on public.plan_day_contents to authenticated;

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
-- 4) Função geradora do plano "Bíblia Completa".
-- ----------------------------------------------------------------------------
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
        -- Fecha o dia corrente. Como o agrupamento emite os capítulos
        -- incrementalmente, se houver 1..3 capítulos já atribuídos ao dia
        -- atual, aquele dia simplesmente fica com menos de 4 (nada é movido).
        -- Zerar `v_sort_order` força a próxima leitura (Salmos 120) a abrir
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

-- ----------------------------------------------------------------------------
-- 5) Gera o plano "Bíblia Completa".
--    Resultado esperado: 303 dias (149 dias × 4 cap. até Salmos 118
--    + 6 dias de Salmos 119 + 148 dias × 4 cap. de Salmos 120 a Apocalipse).
-- ----------------------------------------------------------------------------
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

commit;
