-- Preparação dos hinários. Executar após schema.sql (requer public.is_admin()).
-- Não publica letras: a edição inicial permanece em preparação.
begin;

create table if not exists public.hymn_composers (
  id uuid primary key default gen_random_uuid(),
  name text not null check (length(trim(name)) > 0),
  biography text,
  created_at timestamptz not null default now()
);

create table if not exists public.hymnals (
  id text primary key,
  title text not null,
  edition text not null,
  credited_name text, -- Crédito da publicação; não atribui autoria a cada hino.
  source_drive_id text,
  source_sha256 text,
  source_pages integer check (source_pages > 0),
  storage_path text, -- Futuro PDF em bucket privado; nunca salvar URL assinada.
  published boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists public.hymns (
  id uuid primary key default gen_random_uuid(),
  title text not null check (length(trim(title)) > 0),
  lyrics text, -- Estrofes separadas por linha em branco; texto simples, sem HTML.
  review_status text not null default 'draft'
    check (review_status in ('draft', 'reviewed', 'published')),
  reviewed_at timestamptz,
  created_at timestamptz not null default now(),
  constraint hymn_publication_review check (
    review_status = 'draft' or (reviewed_at is not null and length(trim(lyrics)) > 0 and lyrics is not null)
  )
);

create table if not exists public.hymnal_hymns (
  hymnal_id text not null references public.hymnals(id),
  hymn_id uuid not null references public.hymns(id),
  number integer not null check (number > 0),
  page_start integer not null check (page_start > 0),
  page_end integer not null check (page_end >= page_start),
  primary key (hymnal_id, number),
  unique (hymnal_id, hymn_id)
);

create table if not exists public.hymn_credits (
  hymn_id uuid not null references public.hymns(id),
  composer_id uuid not null references public.hymn_composers(id),
  role text not null check (role in ('lyrics', 'music', 'translation', 'adaptation')),
  primary key (hymn_id, composer_id, role)
);
create index if not exists hymnal_hymns_hymn_idx on public.hymnal_hymns(hymn_id);
create index if not exists hymn_credits_composer_idx on public.hymn_credits(composer_id);

alter table public.hymn_composers enable row level security;
alter table public.hymnals enable row level security;
alter table public.hymns enable row level security;
alter table public.hymnal_hymns enable row level security;
alter table public.hymn_credits enable row level security;

revoke all on public.hymn_composers, public.hymnals, public.hymns,
  public.hymnal_hymns, public.hymn_credits from anon;
grant select, insert, update, delete on public.hymn_composers, public.hymnals,
  public.hymns, public.hymnal_hymns, public.hymn_credits to authenticated;

drop policy if exists hymnals_read on public.hymnals;
create policy hymnals_read on public.hymnals for select to authenticated using (published);
drop policy if exists hymns_read on public.hymns;
create policy hymns_read on public.hymns for select to authenticated using (
  review_status = 'published' and exists (
    select 1 from public.hymnal_hymns hh where hh.hymn_id = hymns.id
  )
);
-- A política da associação consulta somente a edição, evitando recursão com hymns_read.
-- Os números podem existir sem letra publicada; a listagem do app deve usar inner join.
drop policy if exists hymnal_hymns_read on public.hymnal_hymns;
create policy hymnal_hymns_read on public.hymnal_hymns for select to authenticated using (
  exists (select 1 from public.hymnals h where h.id = hymnal_id and h.published)
);
drop policy if exists hymn_credits_read on public.hymn_credits;
create policy hymn_credits_read on public.hymn_credits for select to authenticated using (
  exists (select 1 from public.hymns h where h.id = hymn_id and h.review_status = 'published')
);
drop policy if exists hymn_composers_read on public.hymn_composers;
create policy hymn_composers_read on public.hymn_composers for select to authenticated using (
  exists (select 1 from public.hymn_credits c where c.composer_id = hymn_composers.id)
);

-- Escrita restrita ao administrador; usuários não podem publicar conteúdo pelo cliente.
do $$
declare relation_name text;
begin
  foreach relation_name in array array['hymn_composers', 'hymnals', 'hymns', 'hymnal_hymns', 'hymn_credits'] loop
    execute format('drop policy if exists hymn_admin on public.%I', relation_name);
    execute format('create policy hymn_admin on public.%I for all to authenticated using (public.is_admin()) with check (public.is_admin())', relation_name);
  end loop;
end $$;

insert into public.hymnals (id, title, edition, credited_name, source_drive_id, source_pages, source_sha256)
values ('inspiracoes-9-2019', 'Hinário Inspirações', '9ª edição — fevereiro de 2019',
  'Pr. Márcio de Barros Fuly', '1_SK93Hs-6o2CEoBwDPZ8Ou-m-VEGbSsm', 160,
  '2819eb6309376be77547d6802b0a92f277d645ee87925a6be083084d261c7da5')
on conflict (id) do nothing;
commit;
