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

-- Atualiza o cache de funções da API após a migração.
notify pgrst, 'reload schema';
