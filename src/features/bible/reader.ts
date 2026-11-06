import type { SQLiteDatabase } from 'expo-sqlite';

export interface Verse {
  verse: number;
  text: string;
}

/**
 * Busca os versículos de um capítulo específico, já ordenados.
 */
export async function getChapterVerses(
  db: SQLiteDatabase,
  translation: string,
  bookAbbrev: string,
  chapter: number
): Promise<Verse[]> {
  const rows = await db.getAllAsync<Verse>(
    'SELECT verse, text FROM verses WHERE translation = ? AND book_abbrev = ? AND chapter = ? ORDER BY verse',
    translation,
    bookAbbrev,
    chapter
  );
  return rows;
}
