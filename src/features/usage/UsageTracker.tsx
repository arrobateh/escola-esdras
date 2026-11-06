import { useEffect } from 'react';
import { AppState } from 'react-native';
import { useDatabase } from '../../db';
import { useAuth } from '../auth';
import { churchDate } from '../plans/calendar';

/** Mede apenas tempo autenticado em primeiro plano; grava em intervalos curtos. */
export function UsageTracker() {
  const db = useDatabase();
  const { user } = useAuth();
  useEffect(() => {
    if (!user?.id) return;
    let active = AppState.currentState === 'active';
    let last = Date.now();
    let queue = Promise.resolve();
    function flush() {
      const end = Date.now();
      const start = last;
      last = end;
      if (!active || end <= start) return;
      // Divide também sessões que atravessam a meia-noite da igreja.
      const chunks = new Map<string, number>();
      for (let cursor = start; cursor < end;) {
        const next = Math.min(end, Math.floor(cursor / 1000) * 1000 + 1000);
        const day = churchDate(new Date(cursor));
        chunks.set(day, (chunks.get(day) ?? 0) + next - cursor);
        cursor = next;
      }
      queue = queue.then(async () => {
        for (const [day, milliseconds] of chunks) await db.runAsync('INSERT INTO app_usage(user_id, day, milliseconds) VALUES (?, ?, ?) ON CONFLICT(user_id, day) DO UPDATE SET milliseconds = milliseconds + excluded.milliseconds', user!.id, day, milliseconds);
      }).catch((error) => { console.warn('[usage] Falha ao registrar tempo', error); });
    }
    const timer = setInterval(flush, 10000);
    const subscription = AppState.addEventListener('change', (state) => { flush(); active = state === 'active'; last = Date.now(); });
    return () => { clearInterval(timer); subscription.remove(); flush(); };
  }, [db, user]);
  return null;
}
