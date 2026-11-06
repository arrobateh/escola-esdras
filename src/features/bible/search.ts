import type { SQLiteDatabase } from 'expo-sqlite';

/**
 * Busca full-text (FTS5) sobre o texto bíblico importado.
 * Usado na Fase 1 como controle mínimo para validar o índice FTS5.
 */

export interface SearchResult {
  translation: string;
  bookAbbrev: string;
  chapter: number;
  verse: number;
  text: string;
}

/**
 * Busca versículos por termo, usando o índice `verses_fts` (external content).
 * O índice usa o `rowid` da tabela `verses`; o JOIN recupera as colunas reais.
 * Retorna até `limit` resultados. Se FTS5 estiver indisponível, retorna `[]`.
 */
export async function searchVerses(
  db: SQLiteDatabase,
  term: string,
  limit = 20
): Promise<SearchResult[]> {
  const query = term.trim();
  if (query.length === 0) return [];

  const hasFts = await hasFtsTable(db);
  if (!hasFts) return [];

  // `MATCH` aceita sintaxe FTS5; aspas duplas buscam a frase exata.
  const rows = await db.getAllAsync<SearchResult>(
    `SELECT v.translation, v.book_abbrev AS bookAbbrev, v.chapter, v.verse, v.text
     FROM verses_fts f
     JOIN verses v ON v.rowid = f.rowid
     WHERE verses_fts MATCH ?
     ORDER BY v.book_abbrev, v.chapter, v.verse
     LIMIT ?`,
    query,
    limit
  );

  return rows;
}

async function hasFtsTable(db: SQLiteDatabase): Promise<boolean> {
  const row = await db.getFirstAsync<{ name: string }>(
    "SELECT name FROM sqlite_master WHERE type = 'table' AND name = 'verses_fts'"
  );
  return row != null;
}
