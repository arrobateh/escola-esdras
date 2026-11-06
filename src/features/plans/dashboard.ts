import { BOOKS_CATALOG } from '../../db/books-catalog';
import { fetchPlans, fetchUserPlanProgress } from './api';
import type { PlanDayProgress, PlanWithContents } from './types';

/** Capítulos distintos cobertos pelos objetivos concluídos, sem depender do Rastreamento. */
export function summarizePlanReading(entries: { plan: PlanWithContents; progress: PlanDayProgress[] }[]) {
  const chapters = new Set<string>();
  const psalm119 = new Set<number>();
  let completedChallenges = 0;
  for (const { plan, progress } of entries) {
    const done = new Set(progress.filter((day) => day.status === 'COMPLETED').map((day) => day.day_number));
    completedChallenges += done.size;
    for (const content of plan.contents) {
      if (!done.has(content.day_number)) continue;
      const book = BOOKS_CATALOG.find((book) => book.abbrev === content.book_abbrev);
      if (!book || content.chapter < 1 || content.chapter > book.total_chapters) continue;
      if (content.start_verse == null && content.end_verse == null) chapters.add(`${book.abbrev}:${content.chapter}`);
      else if (book.abbrev === 'sl' && content.chapter === 119 && content.start_verse && content.end_verse) {
        for (let verse = Math.max(1, content.start_verse); verse <= Math.min(176, content.end_verse); verse++) psalm119.add(verse);
      }
    }
  }
  if (psalm119.size === 176) chapters.add('sl:119');
  const count = (testament: 'AT' | 'NT') => BOOKS_CATALOG.filter((book) => book.testament === testament).reduce((sum, book) => sum + Array.from({ length: book.total_chapters }, (_, i) => chapters.has(`${book.abbrev}:${i + 1}`) ? 1 : 0).reduce((a: number, b) => a + b, 0), 0);
  const totalChapters = BOOKS_CATALOG.reduce((sum, book) => sum + book.total_chapters, 0);
  const totalRead = chapters.size;
  const booksCompleted = BOOKS_CATALOG.filter((book) => Array.from({ length: book.total_chapters }, (_, i) => `${book.abbrev}:${i + 1}`).every((key) => chapters.has(key))).length;
  return { totalRead, totalChapters, percent: Math.round(totalRead / totalChapters * 100), otRead: count('AT'), ntRead: count('NT'), otTotal: 929, ntTotal: 260, booksCompleted, completedChallenges };
}
export async function fetchPlanDashboard(userId: string) {
  const plans = await fetchPlans();
  const entries = await Promise.all(plans.map(async (plan) => ({ plan, progress: await fetchUserPlanProgress(plan.id, userId) })));
  return summarizePlanReading(entries);
}
