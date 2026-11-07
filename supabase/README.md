# Banco no Supabase — Escola de Esdras

Este diretório contém o schema PostgreSQL do Supabase (tabelas, RLS e geração
de planos) que dá suporte aos planos de leitura em grupo da igreja.

Os planos **não são devocionais** — são planos de **leitura sequencial da Bíblia
completa** (Gênesis → Apocalipse, ordem canônica).

## Arquivos

- `import_inspiracoes_9.sql` — importa 325 hinos/vínculos; publica apenas os dez
  primeiros, conferidos no PDF, e deixa 315 em rascunho. Executar após
  `migration_hymnals.sql`. Não publica todo o OCR. Ver `../docs/hinarios/README.md`.

- `migration_hymnals.sql` — preparação do catálogo de hinários, letras, compositores e
  créditos com RLS. Não publica conteúdo automaticamente. Ver `../docs/hinarios/README.md`.

- `schema.sql` — schema "verde" para ambientes novos: tabelas, políticas de
  segurança (RLS), trigger de criação de perfil e a função geradora
  `generate_bible_plan` (com o plano "Bíblia Completa" já criado no final).
- `migration_planos_v2.sql` — script de ALTERAÇÃO para quem já aplicou o schema
  antigo (devocional). Recria `plan_day_contents` no novo modelo, remove o seed
  antigo e gera o plano "Bíblia Completa".
- `migration_sync_v1.sql` — script de CRIAÇÃO das tabelas de sync do progresso
  de leitura (`chapter_progress` e `chapter_progress_deletions`) com RLS.
  Idempotente e sem seed; use em ambientes que já aplicaram o `schema.sql`
  antes da Fase 4.

## Regra de geração dos planos

- **4 capítulos por dia**, de segunda a sábado (24 por semana).
- **Salmos 119** (176 versículos) é a única exceção: é dividido em **6 partes**
  (uma por dia), ocupando a semana inteira.
- Progresso é marcado **por dia** (`user_plan_progress`).
- O plano "Bíblia Completa" tem **303 dias**:
  - 149 dias × 4 capítulos (de Gênesis 1 a Salmos 118);
  - 6 dias do Salmos 119;
  - 148 dias × 4 capítulos (de Salmos 120 a Apocalipse 22).

### Divisão exata do Salmos 119 (6 blocos balanceados)

| Parte | Versículos | Total |
| ----- | ---------- | ----- |
| 1     | 1–30       | 30    |
| 2     | 31–60      | 30    |
| 3     | 61–89      | 29    |
| 4     | 90–118     | 29    |
| 5     | 119–147    | 29    |
| 6     | 148–176    | 29    |

## Pré-requisitos

- Um projeto criado no [Supabase](https://supabase.com).
- **Auth já habilitada** no painel. No menu **Authentication → Providers**,
  confira se os provedores desejados (E-mail e/ou Google) estão ativados. O app
  usa o login do Supabase; este schema não configura provedores.

## Passo a passo

### 1. Aplicar o schema

Escolha **um** dos caminhos abaixo conforme o seu cenário.

#### a) Ambiente novo (nunca aplicou o schema)

1. Entre no [Dashboard do Supabase](https://supabase.com/dashboard) e abra o
   seu projeto.
2. No menu lateral, clique em **SQL Editor** (pode aparecer como
   **Editor SQL**).
3. Clique em **New query** (nova consulta) para abrir uma aba em branco.
4. Abra o arquivo `schema.sql`, copie **todo o conteúdo** e cole na aba do SQL
   Editor.
5. Clique em **Run** (Executar).
6. As definições são idempotentes (tabelas/funções/policies usam
   `IF NOT EXISTS` / `DROP IF EXISTS`). Atenção: a chamada final
   `select generate_bible_plan('Bíblia Completa');` cria **um plano novo** a
   cada execução.

#### b) Ambiente existente (já aplicou o schema antigo, devocional)

1. Abra o SQL Editor e uma aba em branco (New query).
2. Abra o arquivo `migration_planos_v2.sql`, copie **todo o conteúdo** e cole.
3. Clique em **Run**.
4. **Execute uma única vez.** Este script recria `plan_day_contents` (drop +
   create), então reexecutá-lo apaga os conteúdos já gerados e duplica o plano.

#### c) Ambiente existente que já tem planos (adicionar sync da Fase 4)

1. Abra o SQL Editor e uma aba em branco (New query).
2. Abra o arquivo `migration_sync_v1.sql`, copie **todo o conteúdo** e cole.
3. Clique em **Run**.
4. É idempotente e não tem seed: pode ser reexecutado sem risco (tabelas usam
   `IF NOT EXISTS`, policies usam `DROP IF EXISTS`).

### 2. Gerar (ou regenerar) o plano "Bíblia Completa"

Para criar um plano novo (ou um plano extra), rode no SQL Editor:

```sql
select public.generate_bible_plan('Bíblia Completa');
```

- Cada chamada cria **um plano novo** (novo UUID) — comportamento esperado.
- Para outro título, basta trocar o argumento:
  `select public.generate_bible_plan('Leitura 2026');`.
- A função é `security definer` e roda como owner, então ignora a RLS.

### 3. Marcar o dono como administrador (ADM)

O campo `profiles.is_admin` é quem libera a criação/edição/exclusão de planos.
Para tornar o dono administrador:

1. No SQL Editor, descubra o seu `id` de usuário:

   ```sql
   select * from auth.users;
   ```

   Localize a sua linha (pelo `email`) e copie o valor da coluna `id`
   (formato UUID, ex.: `00000000-0000-0000-0000-000000000000`).

2. Com o seu UUID em mãos, rode:

   ```sql
   update public.profiles
   set is_admin = true
   where id = '<seu-uuid>';
   ```

   Substitua `<seu-uuid>` pelo UUID copiado, mantendo as aspas simples.

3. Confirme:

   ```sql
   select id, full_name, is_admin from public.profiles;
   ```

   A sua linha deve mostrar `is_admin = true`.

> Dica: se o seu perfil ainda não existir (porque você se cadastrou antes de
> aplicar o schema), o trigger `on_auth_user_created` só cria perfil para
> usuários **novos**. Nesse caso, crie o perfil manualmente antes do UPDATE:
>
> ```sql
> insert into public.profiles (id, full_name, is_admin)
> values ('<seu-uuid>', 'Seu Nome', true);
> ```

### 4. Conferir que tudo foi criado

No SQL Editor, rode os comandos abaixo e verifique o resultado.

Tabelas:

```sql
select table_name
from information_schema.tables
where table_schema = 'public'
order by table_name;
```

Esperado: `chapter_progress`, `chapter_progress_deletions`,
`plan_day_contents`, `profiles`, `reading_plans`, `user_plan_progress`.

RLS habilitado (a coluna `rowsecurity` deve estar `true` para as 6 tabelas):

```sql
select relname, relrowsecurity
from pg_class
where relname in (
  'profiles', 'reading_plans', 'plan_day_contents', 'user_plan_progress',
  'chapter_progress', 'chapter_progress_deletions'
)
order by relname;
```

Policies:

```sql
select schemaname, tablename, policyname, cmd, roles
from pg_policies
where schemaname = 'public'
order by tablename, policyname;
```

Plano gerado (resumo por dia):

```sql
select p.title, p.duration_days, count(d.id) as capitulos
from public.reading_plans p
left join public.plan_day_contents d on d.plan_id = p.id
group by p.id, p.title, p.duration_days
order by p.created_at;
```

Conteúdo de um dia específico do plano (ex.: dia 150 deve ser Salmos 119:1–30):

```sql
select d.day_number, d.sort_order, d.book_abbrev, d.chapter, d.start_verse, d.end_verse
from public.plan_day_contents d
join public.reading_plans p on p.id = d.plan_id
where p.title = 'Bíblia Completa'
  and d.day_number = 150
order by d.sort_order;
```

### 5. Testar o acesso como usuário comum (opcional)

Por segurança, recomenda-se validar que um usuário **não admin** consegue apenas
**ler** os planos e **gerenciar o próprio progresso**, sem conseguir criar ou
editar planos. Isso pode ser feito via "API → Table Editor" usando um segundo
login, ou diretamente pelo app.

## Modelo de segurança (resumo)

| Tabela                          | SELECT                         | INSERT/UPDATE/DELETE                |
| ------------------------------- | ------------------------------ | ----------------------------------- |
| `profiles`                      | Só o próprio usuário           | UPDATE só o próprio usuário         |
| `reading_plans`                 | Qualquer usuário autenticado   | Só administrador                    |
| `plan_day_contents`             | Qualquer usuário autenticado   | Só administrador                    |
| `user_plan_progress`            | Só o próprio usuário           | Só o próprio usuário                |
| `chapter_progress`              | Só o próprio usuário           | Só o próprio usuário                |
| `chapter_progress_deletions`    | Só o próprio usuário           | Só o próprio usuário                |

- **`profiles.is_admin`** é o campo que controla quem pode criar/editar planos.
  O dono vira ADM via `update` manual no SQL Editor (passo 3 acima).
- **Seed vs RLS:** o SQL Editor roda como `postgres` (owner), que **ignora** a
  RLS. Por isso a geração do plano pode rodar no mesmo arquivo, mesmo com a RLS
  já ativada.
- **Trigger `on_auth_user_created`:** cria automaticamente um `profile` para cada
  novo usuário (padrão Supabase), lendo `full_name` de `raw_user_meta_data`.

## Observações

- Os `abbrev` dos livros (`book_abbrev`) seguem exatamente o catálogo do app
  (`mobile/src/db/books-catalog.ts`), no padrão minúsculas português. Exemplos:
  `gn` = Gênesis, `sl` = Salmos, `rm` = Romanos, `ap` = Apocalipse.
- `plan_day_contents` guarda **um registro por capítulo**, agrupado por
  `day_number` e ordenado por `sort_order`. O `start_verse`/`end_verse` só é
  preenchido nas 6 partes do Salmos 119 (NULL = capítulo inteiro).
- `user_plan_progress` usa a chave primária composta
  `(user_id, plan_id, day_number)`, então cada usuário tem no máximo um registro
  por dia de plano.
- `chapter_progress` e `chapter_progress_deletions` dão suporte ao sync do
  progresso de leitura (Fase 4). A desmarcação de um capítulo vira um tombstone
  em `chapter_progress_deletions` (com `deleted_at`), permitindo propagar o
  "desmarcar" entre aparelhos com resolução de conflito LWW (`updated_at` vs
  `deleted_at`). O app usa a coluna local `sync_status`
  (`PENDING` / `SYNCED` / `PENDING_DELETE`) para controlar o que precisa ser
  enviado.

## Data de início compartilhada do plano

Para uma instalação existente, execute apenas `migration_plan_start_date.sql` no SQL Editor. Adiciona `reading_plans.start_date` (DATE) e configura o plano único “Bíblia Completa” em **2026-02-26**. Se houver zero ou vários planos com esse título, aborta a transação para permitir identificação pelo UUID. As consultas finais conferem o dia 217 em 05/11/2026 e suas leituras Ezequiel 40–43.

Para administrar outras datas, edite `start_date` na linha correta de `reading_plans` pelo Table Editor. O início é inclusivo; domingos não são dias de leitura. Evite alterar datas de planos em andamento sem combinar com o grupo. NULL indica calendário não configurado.

Esta migração prepara os dados. O aplicativo ainda precisa passar a calcular o objetivo pela data de início, substituindo o primeiro dia pendente no detalhe do plano e no desafio do leitor. Não reexecute o schema consolidado nem a migração v2 numa instalação existente para essa alteração, pois geram planos.

Atualização: o aplicativo já consome start_date para calcular a leitura e o desafio de hoje em America/Sao_Paulo, pulando domingos. A pendência de integração mencionada acima foi resolvida. Não é necessário outro SQL para ativar o cálculo.
