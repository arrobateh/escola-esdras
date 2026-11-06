import 'react-native-url-polyfill/auto';

import { Stack } from 'expo-router';
import { StatusBar } from 'expo-status-bar';

import { DatabaseProvider } from '../db/DatabaseProvider';
import { AuthProvider, useAuth } from '../features/auth';
import { SyncProvider } from '../features/sync';
import { UsageTracker } from '../features/usage/UsageTracker';
import { ChurchWelcome } from '../features/profile/ChurchWelcome';
import LoginScreen from './login';
import '../lib/supabase';

export default function RootLayout() {
  return (
    <DatabaseProvider>
      <AuthProvider>
        <SyncProvider>
          <StatusBar style="light" />
          <UsageTracker />
          <AuthGuard />
        </SyncProvider>
      </AuthProvider>
    </DatabaseProvider>
  );
}

function AuthGuard() {
  const { user, loading } = useAuth();

  if (loading) {
    // O AuthProvider já renderiza um loader próprio antes de expor o contexto,
    // mas mantemos essa guarda para segurança.
    return null;
  }

  if (!user) {
    return <LoginScreen />;
  }

  return <><Stack screenOptions={{ headerShown: false, contentStyle: { backgroundColor: '#171717' } }} /><ChurchWelcome /></>;
}
