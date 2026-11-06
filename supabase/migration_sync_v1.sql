-- ============================================================================
-- Escola de Esdras — Migration do sync de progresso de leitura (v1)
-- ============================================================================
-- O que este script faz:
--   1. Cria `public.chapter_progress` — capítulo lido por usuário.
--   2. Cria `public.chapter_progress_deletions` — tombstones de desmarcação
--      (deleção lógica), para propagar "desmarcar capítulo" entre aparelhos
--      respeitando LWW (updated_at do read vs deleted_at do tombstone).
--   3. Habilita RLS e cria as policies (somente o próprio usuário) e grants
--      no mesmo padrão do `schema.sql` existente.
--
-- Como aplicar:
--   1. Painel do Supabase → SQL Editor → New query.
--   2. Cole TODO este arquivo e clique em "Run".
--
-- IMPORTANTE (idempotência):
--   * Este script é idempotente nas DEFINIÇÕES (tabelas usam IF NOT EXISTS;
--     policies usam DROP IF EXISTS antes do CREATE). Não há SEED — pode ser
--     reexecutado sem risco de duplicar dados.
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1) `chapter_progress` — progresso de capítulo lido.
--    PK composta `(user_id, book_abbrev, chapter_number)` já cobre consultas
--    por `user_id` (coluna líder), então um índice extra em `user_id` seria
--    redundante; optamos por não criar.
-- ----------------------------------------------------------------------------
create table if not exists public.chapter_progress (
  user_id         uuid not null references auth.users(id) on delete cascade,
  book_abbrev     text not null,
  chapter_number  integer not null,
  read_at         timestamptz,
  updated_at      timestamptz not null default now(),
  primary key (user_id, book_abbrev, chapter_number)
);

-- ----------------------------------------------------------------------------
-- 2) `chapter_progress_deletions` — tombstones de desmarcação.
--    Sempre que um usuário desmarca um capítulo, gravamos aqui o instante da
--    desmarcação (`deleted_at`). Durante o pull, o app compara, por chave, o
--    `updated_at` do read com o `deleted_at` do tombstone e aplica LWW. Sem
--    esta tabela, uma deleção (ausência de linha) não teria timestamp e um
--    aparelho desatualizado poderia "ressuscitar" a leitura no próximo push.
-- ----------------------------------------------------------------------------
create table if not exists public.chapter_progress_deletions (
  user_id         uuid not null references auth.users(id) on delete cascade,
  book_abbrev     text not null,
  chapter_number  integer not null,
  deleted_at      timestamptz not null default now(),
  primary key (user_id, book_abbrev, chapter_number)
);

-- ----------------------------------------------------------------------------
-- 3) Row Level Security (RLS).
-- ----------------------------------------------------------------------------
alter table public.chapter_progress           enable row level security;
alter table public.chapter_progress_deletions enable row level security;

-- ----------------------------------------------------------------------------
-- Grants: `anon` não enxerga nada; `authenticated` opera na própria tabela.
-- A proteção REAL é feita pela RLS (abaixo).
-- ----------------------------------------------------------------------------
revoke all on public.chapter_progress           from anon;
revoke all on public.chapter_progress_deletions from anon;

grant all on public.chapter_progress           to authenticated;
grant all on public.chapter_progress_deletions to authenticated;

-- ----------------------------------------------------------------------------
-- 3.1) `chapter_progress` — SELECT/INSERT/UPDATE/DELETE somente do próprio.
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

-- ----------------------------------------------------------------------------
-- 3.2) `chapter_progress_deletions` — mesmo padrão (só o próprio usuário).
-- ----------------------------------------------------------------------------
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
