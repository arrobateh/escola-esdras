import { colors } from '../../theme/colors';
import { makeRedirectUri } from 'expo-auth-session';
import * as WebBrowser from 'expo-web-browser';
import { createContext, useContext, useEffect, useState, type ReactNode } from 'react';
import { ActivityIndicator, StyleSheet, Text, View } from 'react-native';

import { APP_NAME } from '../../config/constants';
import { migrateProvisionalProgress, useDatabase } from '../../db';
import { isSupabaseConfigured, supabase } from '../../lib/supabase';

interface AuthContextValue {
  user: User | null;
  session: Session | null;
  loading: boolean;
  configured: boolean;
  signInWithEmail: (email: string, password: string) => Promise<void>;
  signUpWithEmail: (email: string, password: string, fullName: string) => Promise<void>;
  signInWithGoogle: () => Promise<void>;
  signOut: () => Promise<void>;
}

interface User {
  id: string;
  email?: string;
  user_metadata?: Record<string, unknown>;
}

interface Session {
  access_token: string;
  refresh_token: string;
  user: User;
}

const AuthContext = createContext<AuthContextValue | null>(null);

export function useAuth(): AuthContextValue {
  const ctx = useContext(AuthContext);
  if (!ctx) {
    throw new Error('useAuth deve ser usado dentro de <AuthProvider>');
  }
  return ctx;
}

interface AuthProviderProps {
  children: ReactNode;
}

export function AuthProvider({ children }: AuthProviderProps) {
  const db = useDatabase();
  const [user, setUser] = useState<User | null>(null);
  const [session, setSession] = useState<Session | null>(null);
  const [loading, setLoading] = useState(true);
  const configured = isSupabaseConfigured();

  useEffect(() => {
    if (!configured || !supabase) {
      // Quando não configurado, o componente já renderiza a mensagem adequada
      // antes de checar o estado de loading; não é necessário alterá-lo aqui.
      return;
    }

    const client = supabase;
    let subscription: { unsubscribe: () => void } | null = null;

    async function init() {
      const {
        data: { session: initialSession },
      } = await client.auth.getSession();

      const initialUser = mapUser(initialSession?.user ?? null);
      setSession(mapSession(initialSession));
      setUser(initialUser);
      if (initialUser) {
        await migrateProvisionalProgress(db, initialUser.id).catch(() => {
          // Falha na migração não deve travar o login.
        });
      }
      setLoading(false);

      subscription = client.auth.onAuthStateChange(async (_event, nextSession) => {
        const nextUser = mapUser(nextSession?.user ?? null);
        setSession(mapSession(nextSession));
        setUser(nextUser);
        if (nextUser) {
          await migrateProvisionalProgress(db, nextUser.id).catch(() => {
            // Falha na migração não deve travar o login.
          });
        }
      }).data.subscription;
    }

    init();

    return () => {
      subscription?.unsubscribe();
    };
  }, [configured, db]);

  async function signInWithEmail(email: string, password: string) {
    if (!supabase) throw new Error('Supabase não configurado.');
    const { error } = await supabase.auth.signInWithPassword({ email, password });
    if (error) throw normalizeAuthError(error.message);
  }

  async function signUpWithEmail(email: string, password: string, fullName: string) {
    if (!supabase) throw new Error('Supabase não configurado.');
    const { error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        data: { full_name: fullName },
      },
    });
    if (error) throw normalizeAuthError(error.message);
  }

  async function signInWithGoogle() {
    if (!supabase) throw new Error('Supabase não configurado.');

    const redirectTo = makeRedirectUri({
      scheme: 'escolaesdras',
      path: 'auth/callback',
    });

    const { data, error } = await supabase.auth.signInWithOAuth({
      provider: 'google',
      options: {
        redirectTo,
        skipBrowserRedirect: true,
      },
    });

    if (error) throw normalizeAuthError(error.message);
    if (!data?.url) throw new Error('Não foi possível obter a URL de autenticação do Google.');

    const result = await WebBrowser.openAuthSessionAsync(data.url, redirectTo);

    if (result.type === 'success') {
      await createSessionFromUrl(result.url);
    }
  }

  async function signOut() {
    if (!supabase) throw new Error('Supabase não configurado.');
    const { error } = await supabase.auth.signOut();
    if (error) throw normalizeAuthError(error.message);
  }

  if (!configured) {
    return (
      <View style={styles.centered}>
        <Text style={styles.title}>{APP_NAME}</Text>
        <Text style={styles.message}>
          Autenticação não configurada. Verifique as variáveis EXPO_PUBLIC_SUPABASE_* no arquivo .env.
        </Text>
      </View>
    );
  }

  if (loading) {
    return (
      <View style={styles.centered}>
        <ActivityIndicator size="large" />
        <Text style={styles.loadingText}>Verificando sessão...</Text>
      </View>
    );
  }

  return (
    <AuthContext.Provider
      value={{
        user,
        session,
        loading,
        configured,
        signInWithEmail,
        signUpWithEmail,
        signInWithGoogle,
        signOut,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
}

async function createSessionFromUrl(url: string) {
  if (!supabase) return;

  const params = parseUrlParams(url);
  const errorCode = params.error;
  if (errorCode) throw new Error(`Erro no callback OAuth: ${errorCode}`);

  const accessToken = params.access_token;
  const refreshToken = params.refresh_token;

  if (!accessToken) {
    // Fluxo PKCE: o callback pode vir com ?code= em vez de token no fragmento.
    const code = params.code;
    if (code) {
      const { error } = await supabase.auth.exchangeCodeForSession(code);
      if (error) throw normalizeAuthError(error.message);
      return;
    }
    throw new Error('Nenhum token de sessão encontrado no retorno do Google.');
  }

  const { error } = await supabase.auth.setSession({
    access_token: accessToken,
    refresh_token: refreshToken ?? '',
  });

  if (error) throw normalizeAuthError(error.message);
}

function parseUrlParams(url: string): Record<string, string> {
  const result: Record<string, string> = {};
  // O Supabase pode retornar tokens tanto no query string (?a=1) quanto no fragment (#a=1).
  const queryOrFragment = url.split('#')[1] ?? url.split('?')[1] ?? '';
  const pairs = queryOrFragment.split('&');
  for (const pair of pairs) {
    const [key, value] = pair.split('=');
    if (key && value != null) {
      result[decodeURIComponent(key)] = decodeURIComponent(value);
    }
  }
  return result;
}

function mapUser(raw: unknown): User | null {
  if (!raw || typeof raw !== 'object') return null;
  const u = raw as { id?: string; email?: string; user_metadata?: Record<string, unknown> };
  return {
    id: u.id ?? '',
    email: u.email,
    user_metadata: u.user_metadata,
  };
}

function mapSession(raw: unknown): Session | null {
  if (!raw || typeof raw !== 'object') return null;
  const s = raw as { access_token?: string; refresh_token?: string; user?: unknown };
  const user = mapUser(s.user ?? null);
  if (!s.access_token || !user) return null;
  return {
    access_token: s.access_token,
    refresh_token: s.refresh_token ?? '',
    user,
  };
}

function normalizeAuthError(message: string): Error {
  const lower = message.toLowerCase();
  if (lower.includes('invalid login credentials')) {
    return new Error('E-mail ou senha incorretos.');
  }
  if (lower.includes('user already registered') || lower.includes('already exists')) {
    return new Error('Este e-mail já está cadastrado.');
  }
  if (lower.includes('password')) {
    return new Error('Senha muito fraca. Use pelo menos 6 caracteres.');
  }
  if (lower.includes('email')) {
    return new Error('Verifique o e-mail informado.');
  }
  return new Error(message);
}

const styles = StyleSheet.create({
  centered: {
    backgroundColor: colors.background,
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 24,
  },
  title: {
    color: colors.text,
    fontSize: 22,
    fontWeight: 'bold',
    marginBottom: 12,
  },
  message: {
    textAlign: 'center',
    color: colors.muted,
  },
  loadingText: {
    marginTop: 12,
    color: colors.muted,
  },
});
