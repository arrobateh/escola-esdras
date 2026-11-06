import type { SQLiteDatabase } from 'expo-sqlite';

import { BOOKS_CATALOG, type Testament } from '../../db/books-catalog';
import type { BibleJson, ImportProgress, ImportResult } from './types';

/**
 * Tamanho do lote de INSERT em versículos. Cada lote gera um único statement
 * multi-VALUES com 5 parâmetros nomeados por linha (500 parâmetros para 100
 * versículos), mantendo-se bem abaixo do limite histórico de 999 variáveis do
 * SQLite e reduzindo o número de round-trips JS→native para ~1/100.
 */
const INSERT_CHUNK_SIZE = 100;

/** Metadado do catálogo por abreviação, para consulta rápida. */
const BOOK_META_BY_ABBREV = new Map(
  BOOKS_CATALOG.map((b) => [b.abbrev, { testament: b.testament, category: b.category }])
);

interface VerseRow {
  bookAbbrev: string;
  chapter: number;
  verse: number;
  text: string;
}

/**
 * Importa uma tradução bíblica completa no SQLite local de forma transacional
 * e idempotente (reimportar substitui os versículos da tradução sem duplicar).
 *
 * Fluxo:
 *  1. Em uma única transação: upsert dos livros no catálogo e substituição
 *     (DELETE + INSERT em lotes) dos versículos da tradução.
 *  2. Fora da transação: reconstrução do índice FTS5 (quando disponível).
 *
 * O download do JSON fica fora desta função (ver `downloadBibleJson`), para
 * permitir reportar progresso de rede independentemente da importação.
 */
export async function importTranslation(
  db: SQLiteDatabase,
  translation: string,
  bibleJson: BibleJson,
  onProgress?: (progress: ImportProgress) => void
): Promise<ImportResult> {
  const totalVerses = countVerses(bibleJson);

  await db.withTransactionAsync(async () => {
    await upsertBooks(db, bibleJson);

    // Remove versículos anteriores da tradução para garantir idempotência.
    await db.runAsync('DELETE FROM verses WHERE translation = ?', translation);

    const buffer: VerseRow[] = [];
    let processed = 0;

    const flush = async (): Promise<void> => {
      if (buffer.length === 0) return;
      await insertVerseBatch(db, translation, buffer);
      processed += buffer.length;
      buffer.length = 0;

      if (processed % INSERT_CHUNK_SIZE === 0 || processed === totalVerses) {
        onProgress?.({
          phase: 'import',
          processed,
          total: totalVerses,
          ratio: totalVerses > 0 ? processed / totalVerses : 0,
        });
      }
    };

    for (const book of bibleJson) {
      for (let chapterIndex = 0; chapterIndex < book.chapters.length; chapterIndex += 1) {
        const chapterVerses = book.chapters[chapterIndex];
        for (let verseIndex = 0; verseIndex < chapterVerses.length; verseIndex += 1) {
          buffer.push({
            bookAbbrev: book.abbrev,
            chapter: chapterIndex + 1,
            verse: verseIndex + 1,
            text: chapterVerses[verseIndex],
          });

          if (buffer.length >= INSERT_CHUNK_SIZE) {
            await flush();
          }
        }
      }
    }

    await flush();
  });

  // ---------- Reconstrução do índice FTS5 ----------
  onProgress?.({ phase: 'fts', processed: totalVerses, total: totalVerses, ratio: 1 });
  const ftsRebuilt = await rebuildFtsIndex(db);

  return {
    translation,
    versesImported: totalVerses,
    booksImported: bibleJson.length,
    ftsRebuilt,
  };
}

/** Insere um lote de versículos em um único statement multi-VALUES. */
async function insertVerseBatch(
  db: SQLiteDatabase,
  translation: string,
  rows: VerseRow[]
): Promise<void> {
  const values: string[] = [];
  const params: Record<string, string | number> = {};

  for (let i = 0; i < rows.length; i += 1) {
    const row = rows[i];
    params[`$t${i}`] = translation;
    params[`$b${i}`] = row.bookAbbrev;
    params[`$c${i}`] = row.chapter;
    params[`$v${i}`] = row.verse;
    params[`$x${i}`] = row.text;
    values.push(`($t${i},$b${i},$c${i},$v${i},$x${i})`);
  }

  const sql =
    'INSERT INTO verses (translation, book_abbrev, chapter, verse, text) VALUES ' +
    values.join(',');

  await db.runAsync(sql, params);
}

/** Conta o total de versículos em um JSON de tradução. */
function countVerses(bibleJson: BibleJson): number {
  let total = 0;
  for (const book of bibleJson) {
    for (const chapter of book.chapters) {
      total += chapter.length;
    }
  }
  return total;
}

/**
 * Insere/atualiza os livros no catálogo `books`. O `abbrev` vem do dataset;
 * `testament` e `category` vêm do catálogo canônico (fallback por posição).
 */
async function upsertBooks(db: SQLiteDatabase, bibleJson: BibleJson): Promise<void> {
  const statement = await db.prepareAsync(
    `INSERT INTO books (abbrev, name, testament, category, total_chapters)
     VALUES (?, ?, ?, ?, ?)
     ON CONFLICT(abbrev) DO UPDATE SET
       name = excluded.name,
       testament = excluded.testament,
       category = excluded.category,
       total_chapters = excluded.total_chapters`
  );

  try {
    for (let index = 0; index < bibleJson.length; index += 1) {
      const book = bibleJson[index];
      const meta = BOOK_META_BY_ABBREV.get(book.abbrev);
      const testament: Testament = meta?.testament ?? (index < 39 ? 'AT' : 'NT');
      const category = meta?.category ?? 'Outros';
      await statement.executeAsync(book.abbrev, book.name, testament, category, book.chapters.length);
    }
  } finally {
    await statement.finalizeAsync();
  }
}

/**
 * Reconstrói o índice FTS5 (`verses_fts`, external content) a partir da tabela
 * `verses`. Retorna `true` se o rebuild foi executado, `false` se FTS5 está
 * indisponível (fallback: busca full-text ficará limitada).
 */
export async function rebuildFtsIndex(db: SQLiteDatabase): Promise<boolean> {
  const hasFts = await hasFtsTable(db);
  if (!hasFts) {
    console.warn('[import] FTS5 indisponível; índice full-text não reconstruído.');
    return false;
  }

  try {
    await db.execAsync("INSERT INTO verses_fts(verses_fts) VALUES('rebuild')");
    console.log('[import] Índice FTS5 reconstruído com sucesso.');
    return true;
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    console.warn('[import] Falha ao reconstruir índice FTS5.', message);
    return false;
  }
}

/** Verifica se a tabela virtual `verses_fts` existe no banco. */
async function hasFtsTable(db: SQLiteDatabase): Promise<boolean> {
  const row = await db.getFirstAsync<{ name: string }>(
    "SELECT name FROM sqlite_master WHERE type = 'table' AND name = 'verses_fts'"
  );
  return row != null;
}

/** Traduções já importadas (derivado de `verses`). */
export async function getImportedTranslations(db: SQLiteDatabase): Promise<string[]> {
  const rows = await db.getAllAsync<{ translation: string }>(
    'SELECT DISTINCT translation FROM verses ORDER BY translation'
  );
  return rows.map((r) => r.translation);
}

/** Quantidade de versículos importados de uma tradução (0 se ainda não baixada). */
export async function getTranslationVerseCount(
  db: SQLiteDatabase,
  translation: string
): Promise<number> {
  const row = await db.getFirstAsync<{ count: number }>(
    'SELECT COUNT(*) AS count FROM verses WHERE translation = ?',
    translation
  );
  return row?.count ?? 0;
}

export const IMPORT_CONSTANTS = { INSERT_CHUNK_SIZE } as const;
