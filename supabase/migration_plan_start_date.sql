-- Execute este arquivo no SQL Editor do Supabase para a instalação existente.
-- Não reexecute schema.sql ou migration_planos_v2.sql: eles geram planos.
-- Não altera conteúdos, conclusões nem o progresso dos usuários.
begin;

alter table public.reading_plans
  add column if not exists start_date date;

comment on column public.reading_plans.start_date is
  'Início do calendário compartilhado do plano. Data inclusiva, segunda a sábado; domingos não contam. NULL significa calendário ainda não configurado.';

-- Evita atualizar silenciosamente o plano errado caso existam títulos repetidos.
do $$
declare
  target_count integer;
begin
  select count(*) into target_count
  from public.reading_plans where title = 'Bíblia Completa';
  if target_count != 1 then
    raise exception 'Esperado exatamente um plano Bíblia Completa; encontrados %. Identifique o plano pelo UUID antes de aplicar a data.', target_count;
  end if;

  update public.reading_plans
  set start_date = date '2026-02-26', updated_at = now()
  where title = 'Bíblia Completa';
end;
$$;

commit;

-- Conferência: 05/11/2026 deve corresponder ao dia 217 (Ezequiel 40–43).
select p.id, p.title, p.start_date, p.duration_days,
  (select count(*) from generate_series(0, date '2026-11-05' - p.start_date) as d(day_offset)
   where extract(isodow from (p.start_date + d.day_offset)) != 7) as day_on_2026_11_05
from public.reading_plans p
where p.title = 'Bíblia Completa';

select c.day_number, c.book_abbrev, c.chapter, c.start_verse, c.end_verse
from public.plan_day_contents c
join public.reading_plans p on p.id = c.plan_id
where p.title = 'Bíblia Completa' and c.day_number = 217
order by c.sort_order;
