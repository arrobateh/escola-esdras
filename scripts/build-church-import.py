#!/usr/bin/env python3
"""Gera importação revisável, sem executar no banco remoto."""
import json
from pathlib import Path
root=Path(__file__).resolve().parents[2]
rows=json.loads((root/'docs/catalogo-igrejas/igrejas.json').read_text())
assert len(rows)==len({r['source_url'] for r in rows})
base=(root/'mobile/supabase/migration_profile_churches.sql').read_text().split('-- Cria o perfil ausente')[0]
extra='''
alter table public.churches
 add column if not exists source_url text,
 add column if not exists maps_url text,
 add column if not exists contact text,
 add column if not exists services_text text,
 add column if not exists organization_date_text text,
 add column if not exists latitude double precision,
 add column if not exists longitude double precision,
 add column if not exists source_metadata jsonb;
create unique index if not exists churches_source_url_idx on public.churches(source_url);

do $import$
declare r jsonb; target_id uuid; matches integer;
begin
 for r in select value from jsonb_array_elements($catalog$'''+json.dumps(rows,ensure_ascii=False)+'''$catalog$::jsonb)
 loop
  select count(*) into matches from public.churches
  where source_url = r->>'source_url' or (source_url is null and name = r->>'name');
  if matches > 1 then raise exception 'Correspondência ambígua para %. Revise as igrejas existentes.', r->>'name'; end if;
  select id into target_id from public.churches
  where source_url = r->>'source_url' or (source_url is null and name = r->>'name');
  if target_id is null then
   insert into public.churches(name,source_url) values(r->>'name', r->>'source_url') returning id into target_id;
  end if;
  update public.churches set
   source_url = r->>'source_url',
   address = coalesce(r->>'address', address),
   pastor_name = coalesce(r->>'pastor_name', pastor_name),
   photo_url = coalesce(r->>'photo_url', photo_url),
   maps_url = coalesce(r->>'maps_url', maps_url),
   contact = coalesce(r->>'contact', contact),
   services_text = coalesce(r->>'services_text', services_text),
   organization_date_text = coalesce(r->>'organization_date_text', organization_date_text),
   latitude = coalesce((r->>'latitude')::double precision, latitude),
   longitude = coalesce((r->>'longitude')::double precision, longitude),
   source_metadata = r
  where id = target_id;
 end loop;
end;
$import$;
commit;
notify pgrst, 'reload schema';
select count(*) as imported_churches from public.churches where source_url like 'https://imobrart.org/igrejas/%';
'''
(root/'mobile/supabase/import_imobrart_churches.sql').write_text('-- Catálogo público IMOBRART, coletado em 05/11/2026.\n-- Reexecutável: preserva IDs e valores existentes quando a fonte não informa.\n'+base+extra)
print('SQL gerado:',len(rows),'igrejas')
