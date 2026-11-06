# Escola de Esdras — App Mobile

Aplicativo React Native com Expo, TypeScript e Expo Router para leitura bíblica.

## Pré-requisitos

- Node.js (testado com v24.21.0)
- npm ou yarn
- Expo Go instalado no dispositivo (opcional)

## Instalação

```bash
cd mobile
npm install --legacy-peer-deps
```

## Configuração do Supabase

1. Copie o arquivo de exemplo:

```bash
cp .env.example .env
```

2. Preencha as variáveis no `.env`:

```env
EXPO_PUBLIC_SUPABASE_URL=sua-url-do-supabase
EXPO_PUBLIC_SUPABASE_ANON_KEY=sua-chave-anon
```

> O app não quebra se as variáveis estiverem ausentes, mas o cliente Supabase só será inicializado quando elas forem configuradas.

## Autenticação

A tela de login (`src/app/login.tsx`) oferece:

- **Email + senha:** login (`signInWithPassword`) e cadastro (`signUp`), enviando `full_name` via `options.data`.
- **Google OAuth:** fluxo via `supabase.auth.signInWithOAuth` + `expo-web-browser`. Requer configuração no painel do Supabase.

### Configuração do Google OAuth

1. No painel do Supabase, vá em **Authentication → URL Configuration**.
2. Adicione os **Redirect URLs**:
   - `escolaesdras://auth/callback` (development/production build)
   - `exp://**` (Expo Go em desenvolvimento)
3. Habilite o provider **Google** em **Authentication → Providers**.
4. No Expo Go o deep link é `exp://`, portanto o fluxo pode falhar se o `redirectTo` não estiver allowlisted. O email/senha funciona independentemente.

## Como rodar

```bash
npx expo start
```

Depois escaneie o QR code com o Expo Go ou pressione:

- `a` para abrir no emulador Android
- `i` para abrir no simulador iOS (macOS apenas)
- `w` para rodar na web

> Para usar ícones de sistema nativo no futuro, será necessário um **development build** (`npx expo run:android` / `eas build --profile development`). No Expo Go padrão os ícones são emojis/texto.

## Estrutura de pastas

```
src/
  app/         # Rotas do Expo Router
  config/      # Constantes e configuração
  db/          # Acesso ao SQLite e migrations
  features/    # Módulos de funcionalidades
  lib/         # Cliente Supabase e utilitários
```

## Comandos úteis

```bash
npx tsc --noEmit        # Verificação de tipos
npx eslint .            # Lint do projeto
npx expo-doctor         # Diagnóstico de dependências
```

## Segurança antes de publicar

Execute `supabase/migration_security_hardening.sql` em instalações existentes: impede alteração de `profiles.is_admin` pelo cliente e restringe execução de `generate_bible_plan` ao backend/SQL Editor. As três verificações finais devem retornar `false`. Revise administradores já cadastrados; a migração não altera usuários nem audita acessos passados.

O `.env` não deve ser versionado. `.env.example` contém apenas nomes de variáveis. Use somente chave pública/anon no aplicativo; nunca service_role ou sb_secret em EXPO_PUBLIC_*. Documentos e catálogo em `../docs` ficam fora deste repositório Git (a raiz atual é `mobile/`).
