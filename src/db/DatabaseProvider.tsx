import { colors } from '../theme/colors';
import type { SQLiteDatabase } from 'expo-sqlite';
import { createContext, useContext, useEffect, useState, type ReactNode } from 'react';
import { ActivityIndicator, StyleSheet, Text, View } from 'react-native';

import { APP_NAME } from '../config/constants';
import { openDatabase } from './migrate';

interface DatabaseContextValue {
  db: SQLiteDatabase | null;
  ready: boolean;
  error: string | null;
}

const DatabaseContext = createContext<DatabaseContextValue>({
  db: null,
  ready: false,
  error: null,
});

export function useDatabase(): SQLiteDatabase {
  const { db, ready } = useContext(DatabaseContext);
  if (!ready || db == null) {
    throw new Error('useDatabase deve ser usado dentro de <DatabaseProvider> com banco pronto.');
  }
  return db;
}

export function useDatabaseStatus(): DatabaseContextValue {
  return useContext(DatabaseContext);
}

interface DatabaseProviderProps {
  children: ReactNode;
}

export function DatabaseProvider({ children }: DatabaseProviderProps) {
  const [db, setDb] = useState<SQLiteDatabase | null>(null);
  const [ready, setReady] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let cancelled = false;

    async function bootstrap() {
      try {
        const instance = await openDatabase();
        if (!cancelled) {
          setDb(instance);
          setReady(true);
        }
      } catch (err) {
        const message = err instanceof Error ? err.message : String(err);
        console.error('[DatabaseProvider] Falha ao inicializar o banco:', message);
        if (!cancelled) {
          setError(message);
        }
      }
    }

    bootstrap();
    return () => {
      cancelled = true;
    };
  }, []);

  if (error) {
    return (
      <View style={styles.centered}>
        <Text style={styles.title}>{APP_NAME}</Text>
        <Text style={styles.error}>Erro ao preparar o banco:</Text>
        <Text style={styles.errorDetail}>{error}</Text>
      </View>
    );
  }

  if (!ready) {
    return (
      <View style={styles.centered}>
        <ActivityIndicator size="large" />
        <Text style={styles.loadingText}>Preparando biblioteca...</Text>
      </View>
    );
  }

  return <DatabaseContext.Provider value={{ db, ready, error }}>{children}</DatabaseContext.Provider>;
}

const styles = StyleSheet.create({
  centered: {
    backgroundColor: colors.background,
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 24,
    gap: 12,
  },
  title: {
    color: colors.text,
    fontSize: 22,
    fontWeight: 'bold',
  },
  loadingText: {
    marginTop: 8,
    color: colors.muted,
  },
  error: {
    color: colors.danger,
    fontWeight: '600',
  },
  errorDetail: {
    color: colors.danger,
    textAlign: 'center',
  },
});
