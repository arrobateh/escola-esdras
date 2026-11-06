-- Aplicar no SQL Editor para instalações existentes. Não altera dados.
begin;
-- RLS restringe linhas, não colunas: proteger is_admin também por privilégios.
revoke all on public.profiles from public, anon, authenticated;
grant select on public.profiles to authenticated;
grant update(full_name, church_name) on public.profiles to authenticated;
-- Criação de perfis continua pelo trigger de cadastro ou save_own_profile.
-- Gerador é ferramenta administrativa para SQL Editor/backend, nunca cliente.
do $$
begin
 if to_regprocedure('public.generate_bible_plan(text)') is not null then
  revoke all on function public.generate_bible_plan(text) from public, anon, authenticated;
  grant execute on function public.generate_bible_plan(text) to service_role;
 end if;
end;
$$;
commit;
notify pgrst, 'reload schema';

-- Conferência esperada: false, false, false.
select
 has_column_privilege('authenticated', 'public.profiles', 'is_admin', 'UPDATE') as user_can_change_admin,
 has_function_privilege('anon', 'public.generate_bible_plan(text)', 'EXECUTE') as anonymous_can_generate,
 has_function_privilege('authenticated', 'public.generate_bible_plan(text)', 'EXECUTE') as user_can_generate;
