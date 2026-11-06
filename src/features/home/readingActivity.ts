import type { SQLiteDatabase } from 'expo-sqlite';
import { supabase } from '../../lib/supabase';

export function dayKey(date: Date): string {
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`;
}
function offset(date: Date, days: number): Date {
  const result = new Date(date);
  result.setDate(result.getDate() + days);
  return result;
}
export function summarizeActivity(days: string[], now = new Date()) {
  const completed = new Set(days.filter((day) => new Date(`${day}T12:00:00`).getDay() !== 0));
  const today = dayKey(now);
  const previousReadingDay = (date: Date) => {
    const previous = offset(date, -1);
    return previous.getDay() === 0 ? offset(previous, -1) : previous;
  };
  let cursor = now.getDay() !== 0 && completed.has(today) ? now : previousReadingDay(now);
  let streak = 0;
  while (completed.has(dayKey(cursor))) {
    streak += 1;
    cursor = previousReadingDay(cursor);
  }
  let bestStreak = 0;
  let run = 0;
  let previous: Date | null = null;
  for (const day of [...completed].sort()) {
    const date = new Date(`${day}T12:00:00`);
    run = previous && dayKey(previousReadingDay(date)) === dayKey(previous) ? run + 1 : 1;
    bestStreak = Math.max(bestStreak, run);
    previous = date;
  }
  const monday = offset(now, -((now.getDay() + 6) % 7));
  return {
    streak,
    bestStreak,
    week: ['S', 'T', 'Q', 'Q', 'S', 'S'].map((label, index) => {
      const date = dayKey(offset(monday, index));
      return { date, label, completed: completed.has(date), today: date === today };
    }),
  };
}
export async function readingActivity(_db: SQLiteDatabase, userId: string) {
  if (!supabase) throw new Error('Supabase não configurado.');
  // A conclusão do DIA do plano confirma o objetivo inteiro, não capítulos avulsos.
  const { data, error } = await supabase.from('user_plan_progress')
    .select('completed_at').eq('user_id', userId).eq('status', 'COMPLETED');
  if (error) throw new Error(error.message);
  const days = (data ?? []).flatMap((row: { completed_at: string | null }) => {
    if (!row.completed_at) return [];
    const date = new Date(row.completed_at);
    return Number.isNaN(date.getTime()) ? [] : [dayKey(date)];
  });
  return summarizeActivity(days);
}
