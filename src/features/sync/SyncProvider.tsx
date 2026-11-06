import { createContext, useCallback, useContext, useEffect, useState, type ReactNode } from 'react';
import { AppState } from 'react-native';

import { useDatabase } from '../../db';
import { useAuth } from '../auth';
import { syncProgress } from './sync';

interface SyncContextValue {
  /** Indica que há um sync em andamento. */
  syncing: boolean;
  /** Instante (ISO) do último sync concluído com sucesso. */
  lastSyncedAt: string | null;
  /** Mensagem do último erro (null quando o último sync foi OK). */
  lastError: string | null;
  /** Dispara o sync manualmente (fire-and-forget, não lança exceção). */
  syncNow: () => Promise<void>;
}

const SyncContext = createContext<SyncContextValue | null>(null);

/**
 * Hook que expõe o estado do sync de progresso de leitura e um disparador
 * manual. Deve ser usado dentro de `<SyncProvider>`.
 */
export function useSync(): SyncContextValue {
  const ctx = useContext(SyncContext);
  if (!ctx) {
    throw new Error('useSync deve ser usado dentro de <SyncProvider>');
  }
  return ctx;
}

interface SyncProviderProps {
  children: ReactNode;
}

/**
 * Provedor de sincronização do progresso de leitura.
 *
 * Responsável por:
 *   - disparar o sync ao logar / trocar de usuário;
 *   - disparar o sync ao voltar para o foreground (AppState "active");
 *   - expor estado (`syncing`, `lastSyncedAt`, `lastError`) e `syncNow`.
 *
 * O sync roda de forma assíncrona e nunca trava a UI; falhas de rede são
 * tratadas silenciosamente (com log) dentro de `syncProgress`.
 */
export function SyncProvider({ children }: SyncProviderProps) {
  const db = useDatabase();
  const { user } = useAuth();
  const userId = user?.id ?? null;

  const [syncing, setSyncing] = useState(false);
  const [lastSyncedAt, setLastSyncedAt] = useState<string | null>(null);
  const [lastError, setLastError] = useState<string | null>(null);

  const syncNow = useCallback(async () => {
    if (!userId) return;

    setSyncing(true);
    try {
      const result = await syncProgress(db, userId);
      if (result.ok) {
        setLastSyncedAt(new Date().toISOString());
        setLastError(null);
      } else if (!result.skipped) {
        setLastError(result.reason ?? 'Falha na sincronização.');
      }
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error);
      setLastError(message);
    } finally {
      setSyncing(false);
    }
  }, [db, userId]);

  // Sync ao logar / trocar de usuário. O disparo é adiado para fora do corpo do
  // efeito (evita setState síncrono dentro do efeito — regra do React Compiler).
  useEffect(() => {
    if (!userId) return;
    const id = setTimeout(() => {
      void syncNow();
    }, 0);
    return () => clearTimeout(id);
  }, [userId, syncNow]);

  // Sync ao voltar para o foreground ("reconectar").
  useEffect(() => {
    if (!userId) return;
    const subscription = AppState.addEventListener('change', (nextAppState) => {
      if (nextAppState === 'active') {
        void syncNow();
      }
    });
    return () => {
      subscription.remove();
    };
  }, [userId, syncNow]);

  return (
    <SyncContext.Provider value={{ syncing, lastSyncedAt, lastError, syncNow }}>
      {children}
    </SyncContext.Provider>
  );
}
