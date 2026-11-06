#!/usr/bin/env python3
import json
from pathlib import Path
root=Path(__file__).resolve().parents[2]
regions=json.loads((root/'docs/catalogo-regioes/regioes.json').read_text())
assert len(regions)==11 and len({r['source_url'] for r in regions})==11
sql='''-- Catálogo de regiões IMOBRART, 05/11/2026.
-- Execute depois de import_imobrart_churches.sql. Preserva IDs e não apaga dados.
begin;
create table if not exists public.church_regions (
 id uuid primary key default gen_random_uuid(),
 number integer not null unique,
 name text not null,
 description text,
 photo_url text,
 source_url text not null unique,
 leadership jsonb not null default '[]'::jsonb,
 source_metadata jsonb,
 updated_at timestamptz not null default now()
);
create table if not exists public.church_region_memberships (
 church_id uuid not null references public.churches(id) on delete cascade,
 region_id uuid not null references public.church_regions(id) on delete cascade,
 source_url text not null,
 primary key(church_id, region_id)
);
alter table public.church_regions enable row level security;
alter table public.church_region_memberships enable row level security;
revoke all on public.church_regions, public.church_region_memberships from public, anon;
grant select, insert, update, delete on public.church_regions, public.church_region_memberships to authenticated;
drop policy if exists regions_read on public.church_regions;
create policy regions_read on public.church_regions for select to authenticated using (true);
drop policy if exists regions_admin on public.church_regions;
create policy regions_admin on public.church_regions for all to authenticated using(public.is_admin()) with check(public.is_admin());
drop policy if exists region_memberships_read on public.church_region_memberships;
create policy region_memberships_read on public.church_region_memberships for select to authenticated using(true);
drop policy if exists region_memberships_admin on public.church_region_memberships;
create policy region_memberships_admin on public.church_region_memberships for all to authenticated using(public.is_admin()) with check(public.is_admin());

do $import$
declare r jsonb; c jsonb; region_uuid uuid; church_uuid uuid;
begin
 for r in select value from jsonb_array_elements($regions$'''+json.dumps(regions,ensure_ascii=False)+'''$regions$::jsonb)
 loop
  insert into public.church_regions(number,name,description,photo_url,source_url,leadership,source_metadata)
  values((r->>'number')::integer,r->>'name',r->>'description',r->>'photo_url',r->>'source_url',r->'leadership',r)
  on conflict(source_url) do update set name=excluded.name,description=excluded.description,photo_url=excluded.photo_url,leadership=excluded.leadership,source_metadata=excluded.source_metadata,updated_at=now()
  returning id into region_uuid;
  for c in select value from jsonb_array_elements(r->'churches')
  loop
   select id into church_uuid from public.churches where source_url=c->>'church_source_url';
   if church_uuid is null then raise exception 'Igreja não importada: %. Execute antes a importação de igrejas.',c->>'church_source_url'; end if;
   insert into public.church_region_memberships(church_id,region_id,source_url)
   values(church_uuid,region_uuid,r->>'source_url')
   on conflict(church_id,region_id) do update set source_url=excluded.source_url;
  end loop;
 end loop;
end;
$import$;
commit;
notify pgrst, 'reload schema';

-- Conferência: 11 regiões e 80 vínculos desta coleta.
select r.number,r.name,count(m.church_id) as churches
from public.church_regions r left join public.church_region_memberships m on m.region_id=r.id
group by r.id order by r.number;
'''
(root/'mobile/supabase/import_imobrart_regions.sql').write_text(sql)
print('SQL gerado: 11 regiões,',sum(len(r['churches']) for r in regions),'vínculos')
