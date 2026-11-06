import { colors } from '../theme/colors';
import { useState } from 'react';
import {
  ActivityIndicator,
  KeyboardAvoidingView,
  Platform,
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  TextInput,
  View,
} from 'react-native';

import { APP_NAME } from '../config/constants';
import { useAuth } from '../features/auth';

type Mode = 'sign-in' | 'sign-up';

export default function LoginScreen() {
  const { signInWithEmail, signUpWithEmail, signInWithGoogle, loading: authLoading } = useAuth();

  const [mode, setMode] = useState<Mode>('sign-in');
  const [fullName, setFullName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [message, setMessage] = useState<string | null>(null);

  async function handleSubmit() {
    setError(null);
    setMessage(null);

    if (!email.trim() || !password.trim()) {
      setError('Preencha e-mail e senha.');
      return;
    }

    if (mode === 'sign-up' && !fullName.trim()) {
      setError('Preencha seu nome completo.');
      return;
    }

    setLoading(true);
    try {
      if (mode === 'sign-in') {
        await signInWithEmail(email.trim(), password);
      } else {
        await signUpWithEmail(email.trim(), password, fullName.trim());
        setMessage('Conta criada! Verifique seu e-mail para confirmar, se necessário.');
      }
    } catch (err) {
      const msg = err instanceof Error ? err.message : 'Erro desconhecido.';
      setError(msg);
    } finally {
      setLoading(false);
    }
  }

  async function handleGoogle() {
    setError(null);
    setMessage(null);
    setLoading(true);
    try {
      await signInWithGoogle();
    } catch (err) {
      const msg = err instanceof Error ? err.message : 'Erro desconhecido.';
      setError(msg);
    } finally {
      setLoading(false);
    }
  }

  const isBusy = loading || authLoading;

  return (
    <KeyboardAvoidingView
      style={styles.container}
      behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
    >
      <ScrollView contentContainerStyle={styles.content} keyboardShouldPersistTaps="handled">
        <Text style={styles.title}>{APP_NAME}</Text>
        <Text style={styles.subtitle}>
          {mode === 'sign-in' ? 'Entre na sua conta' : 'Crie sua conta'}
        </Text>

        {error && <Text style={styles.error}>{error}</Text>}
        {message && <Text style={styles.message}>{message}</Text>}

        {mode === 'sign-up' && (
          <TextInput placeholderTextColor={colors.muted}
            style={styles.input}
            placeholder="Nome completo"
            value={fullName}
            onChangeText={setFullName}
            autoCapitalize="words"
            editable={!isBusy}
          />
        )}

        <TextInput placeholderTextColor={colors.muted}
          style={styles.input}
          placeholder="E-mail"
          value={email}
          onChangeText={setEmail}
          autoCapitalize="none"
          keyboardType="email-address"
          editable={!isBusy}
        />

        <TextInput placeholderTextColor={colors.muted}
          style={styles.input}
          placeholder="Senha"
          value={password}
          onChangeText={setPassword}
          secureTextEntry
          editable={!isBusy}
        />

        <Pressable
          style={({ pressed }) => [styles.primaryButton, pressed && styles.pressed]}
          onPress={handleSubmit}
          disabled={isBusy}
        >
          {isBusy ? (
            <ActivityIndicator color="#fff" />
          ) : (
            <Text style={styles.primaryButtonText}>
              {mode === 'sign-in' ? 'Entrar' : 'Criar conta'}
            </Text>
          )}
        </Pressable>

        <View style={styles.divider}>
          <View style={styles.dividerLine} />
          <Text style={styles.dividerText}>ou</Text>
          <View style={styles.dividerLine} />
        </View>

        <Pressable
          style={({ pressed }) => [styles.googleButton, pressed && styles.pressed]}
          onPress={handleGoogle}
          disabled={isBusy}
        >
          <Text style={styles.googleButtonText}>Entrar com Google</Text>
        </Pressable>

        <Pressable style={styles.switchButton} onPress={() => setMode(mode === 'sign-in' ? 'sign-up' : 'sign-in')}>
          <Text style={styles.switchButtonText}>
            {mode === 'sign-in'
              ? 'Não tem conta? Cadastre-se'
              : 'Já tem conta? Faça login'}
          </Text>
        </Pressable>

        <Text style={styles.hint}>
          O login com Google exige configuração no painel do Supabase (Authentication → URL Configuration).
        </Text>
      </ScrollView>
    </KeyboardAvoidingView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },
  content: {
    flexGrow: 1,
    justifyContent: 'center',
    padding: 24,
  },
  title: {
    color: colors.text,
    fontSize: 28,
    fontWeight: 'bold',
    textAlign: 'center',
    marginBottom: 8,
  },
  subtitle: {
    fontSize: 16,
    color: colors.muted,
    textAlign: 'center',
    marginBottom: 24,
  },
  input: {
    color: colors.text,
    backgroundColor: colors.surface,
    borderWidth: 1,
    borderColor: colors.border,
    borderRadius: 18,
    paddingHorizontal: 14,
    paddingVertical: 12,
    fontSize: 15,
    marginBottom: 12,
  },
  primaryButton: {
    backgroundColor: colors.primary,
    borderRadius: 18,
    paddingVertical: 14,
    alignItems: 'center',
    marginTop: 4,
  },
  primaryButtonText: {
    color: colors.text,
    fontWeight: 'bold',
    fontSize: 15,
  },
  divider: {
    flexDirection: 'row',
    alignItems: 'center',
    marginVertical: 20,
  },
  dividerLine: {
    flex: 1,
    height: 1,
    backgroundColor: colors.border,
  },
  dividerText: {
    marginHorizontal: 10,
    color: colors.muted,
    fontSize: 13,
  },
  googleButton: {
    backgroundColor: colors.surface,
    borderRadius: 18,
    paddingVertical: 14,
    alignItems: 'center',
    borderWidth: 1,
    borderColor: colors.border,
  },
  googleButtonText: {
    color: colors.text,
    fontWeight: '600',
    fontSize: 15,
  },
  switchButton: {
    marginTop: 20,
    alignItems: 'center',
  },
  switchButtonText: {
    color: colors.accent,
    fontWeight: '600',
  },
  error: {
    color: colors.danger,
    textAlign: 'center',
    marginBottom: 12,
  },
  message: {
    color: colors.accent,
    textAlign: 'center',
    marginBottom: 12,
  },
  hint: {
    marginTop: 24,
    fontSize: 12,
    color: colors.muted,
    textAlign: 'center',
  },
  pressed: {
    opacity: 0.7,
  },
});
