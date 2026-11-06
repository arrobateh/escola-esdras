import AsyncStorage from '@react-native-async-storage/async-storage';
import type { SQLiteDatabase } from 'expo-sqlite';
import { BOOKS_CATALOG } from '../../db/books-catalog';
import { getBookProgress } from '../../db/progress';
import { getChapterVerses, getImportedTranslations } from '../bible';

export interface DailyVerse { text: string; book: string; chapter: number; verse: number; translation: string }
const fallback: DailyVerse[] = [
  { text: 'Não sejas sábio aos teus próprios olhos; teme ao SENHOR e aparta-te do mal.', book: 'pv', chapter: 3, verse: 7, translation: 'pt_arc' },
  { text: 'O SENHOR é o meu pastor; nada me faltará.', book: 'sl', chapter: 23, verse: 1, translation: 'pt_arc' },
  { text: 'Lâmpada para os meus pés é tua palavra e luz, para o meu caminho.', book: 'sl', chapter: 119, verse: 105, translation: 'pt_arc' },
];
export function localDay() {
  const now = new Date();
  return `${now.getFullYear()}-${now.getMonth() + 1}-${now.getDate()}`;
}
export async function dailyVerse(db: SQLiteDatabase, userId: string): Promise<DailyVerse> {
  const key = `home:daily:${userId}`;
  const day = localDay();
  const cached = await AsyncStorage.getItem(key);
  let previous: { day: string; value: DailyVerse } | null = null;
  try { previous = cached ? JSON.parse(cached) : null; } catch { /* Cache antigo inválido. */ }
  if (previous?.day === day && previous.value?.text) return previous.value;
  const translations = await getImportedTranslations(db);
  const translation = translations.includes('pt_arc') ? 'pt_arc' : translations[0];
  const selected = translation ? await db.getFirstAsync<DailyVerse>(
    `SELECT text, book_abbrev AS book, chapter, verse, translation FROM verses
     WHERE translation = ? AND NOT (book_abbrev = ? AND chapter = ? AND verse = ?)
     ORDER BY RANDOM() LIMIT 1`, translation, previous?.value.book ?? '', previous?.value.chapter ?? 0, previous?.value.verse ?? 0,
  ) : null;
  const options = fallback.filter((item) => item.text !== previous?.value.text);
  const value = selected ?? options[Math.floor(Math.random() * options.length)];
  await AsyncStorage.setItem(key, JSON.stringify({ day, value }));
  return value;
}
export async function continuation(db: SQLiteDatabase, userId: string) {
  const latest = await db.getFirstAsync<{ book: string; chapter: number }>(
    `SELECT book_abbrev AS book, chapter_number AS chapter FROM chapter_progress
     WHERE user_id = ? AND read_at IS NOT NULL AND sync_status != 'PENDING_DELETE'
     ORDER BY read_at DESC, updated_at DESC LIMIT 1`, userId,
  );
  if (!latest) return null;
  const index = BOOKS_CATALOG.findIndex((book) => book.abbrev === latest.book);
  if (index < 0) return null;
  const current = BOOKS_CATALOG[index];
  const book = latest.chapter < current.total_chapters ? current : BOOKS_CATALOG[index + 1];
  if (!book) return null;
  const chapter = book === current ? latest.chapter + 1 : 1;
  const translations = await getImportedTranslations(db);
  const translation = translations.includes('pt_arc') ? 'pt_arc' : translations[0] ?? 'pt_arc';
  const verses = await getChapterVerses(db, translation, book.abbrev, chapter);
  const progress = await getBookProgress(db, userId, book.abbrev);
  return { book, chapter, translation, preview: verses[0]?.text, lastVerse: verses.at(-1)?.verse, percent: Math.round(progress.read.length / progress.total * 100) };
}
