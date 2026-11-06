import type { SQLiteDatabase } from 'expo-sqlite';

import { BOOKS_CATALOG } from './books-catalog';

/**
 * Estado de sincronização de um registro de `chapter_progress`.
 * - `PENDING`        : leitura nova (ou re-marcada) ainda não enviada.
 * - `SYNCED`         : igual ao Supabase.
 * - `PENDING_DELETE` : tombstone local — o capítulo foi desmarcado e o DELETE
 *                      precisa ser propagado ao Supabase.
 */
export type SyncStatus = 'PENDING' | 'SYNCED' | 'PENDING_DELETE';

export interface ChapterProgressRow {
  user_id: string;
  book_abbrev: string;
  chapter_number: number;
  read_at: string | null;
  updated_at: string | null;
  sync_status: SyncStatus;
}

export interface ReadChapter {
  bookAbbrev: string;
  chapterNumber: number;
}

export interface ReadStats {
  totalRead: number;
  totalChapters: number;
  otRead: number;
  otTotal: number;
  ntRead: number;
  ntTotal: number;
  percent: number;
}

export interface BookProgress {
  read: number[];
  total: number;
}

function nowIso(): string {
  return new Date().toISOString();
}

const TESTAMENT_TOTALS = {
  AT: BOOKS_CATALOG.filter((b) => b.testament === 'AT').reduce((sum, b) => sum + b.total_chapters, 0),
  NT: BOOKS_CATALOG.filter((b) => b.testament === 'NT').reduce((sum, b) => sum + b.total_chapters, 0),
} as const;

/**
 * Marca um capítulo como lido para o usuário informado.
 * Usa INSERT OR REPLACE (upsert) pela PK composta.
 * Se o capítulo estava desmarcado (tombstone), o upsert sobrescreve o status
 * para 'PENDING' e renova `read_at`/`updated_at`.
 */
export async function markChapterRead(
  db: SQLiteDatabase,
  userId: string,
  bookAbbrev: string,
  chapterNumber: number
): Promise<void> {
  const timestamp = nowIso();
  await db.runAsync(
    `INSERT INTO chapter_progress
       (user_id, book_abbrev, chapter_number, read_at, updated_at, sync_status)
     VALUES (?, ?, ?, ?, ?, ?)
     ON CONFLICT(user_id, book_abbrev, chapter_number) DO UPDATE SET
       read_at = excluded.read_at,
       updated_at = excluded.updated_at,
       sync_status = excluded.sync_status`,
    userId,
    bookAbbrev,
    chapterNumber,
    timestamp,
    timestamp,
    'PENDING'
  );
}

/**
 * Desmarca um capítulo (remove a leitura).
 *
 * Mecanismo de deleção: em vez de apagar a linha, gravamos um TOMBSTONE local
 * (`sync_status = 'PENDING_DELETE'`) com `updated_at` = instante da desmarcação.
 * Assim:
 *   - a desmarcação é propagada como DELETE ao Supabase quando online;
 *   - `isChapterRead`/`getReadStats`/etc. ignoram tombstones (capítulo some da
 *     lista de lidos imediatamente);
 *   - a reexecução do sync é idempotente (o tombstone é removido só após o
 *     DELETE remoto ser confirmado).
 */
export async function unmarkChapterRead(
  db: SQLiteDatabase,
  userId: string,
  bookAbbrev: string,
  chapterNumber: number
): Promise<void> {
  const timestamp = nowIso();
  await db.runAsync(
    `INSERT INTO chapter_progress
       (user_id, book_abbrev, chapter_number, read_at, updated_at, sync_status)
     VALUES (?, ?, ?, NULL, ?, 'PENDING_DELETE')
     ON CONFLICT(user_id, book_abbrev, chapter_number) DO UPDATE SET
       read_at = NULL,
       updated_at = excluded.updated_at,
       sync_status = excluded.sync_status`,
    userId,
    bookAbbrev,
    chapterNumber,
    timestamp
  );
}

/**
 * Verifica se um capítulo específico está marcado como lido.
 * Tombstones (`PENDING_DELETE`) NÃO contam como lido.
 */
export async function isChapterRead(
  db: SQLiteDatabase,
  userId: string,
  bookAbbrev: string,
  chapterNumber: number
): Promise<boolean> {
  const row = await db.getFirstAsync<{ count: number }>(
    `SELECT COUNT(*) AS count FROM chapter_progress
     WHERE user_id = ? AND book_abbrev = ? AND chapter_number = ?
       AND sync_status != 'PENDING_DELETE'`,
    userId,
    bookAbbrev,
    chapterNumber
  );
  return (row?.count ?? 0) > 0;
}

/**
 * Retorna a lista de capítulos marcados como lidos (ignora tombstones).
 */
export async function getReadChapters(
  db: SQLiteDatabase,
  userId: string
): Promise<ReadChapter[]> {
  const rows = await db.getAllAsync<{ book_abbrev: string; chapter_number: number }>(
    `SELECT book_abbrev, chapter_number FROM chapter_progress
     WHERE user_id = ? AND sync_status != 'PENDING_DELETE'
     ORDER BY book_abbrev, chapter_number`,
    userId
  );
  return rows.map((r) => ({ bookAbbrev: r.book_abbrev, chapterNumber: r.chapter_number }));
}

/**
 * Retorna a quantidade total de capítulos lidos (ignora tombstones).
 */
export async function getReadChapterCount(db: SQLiteDatabase, userId: string): Promise<number> {
  const row = await db.getFirstAsync<{ count: number }>(
    `SELECT COUNT(*) AS count FROM chapter_progress
     WHERE user_id = ? AND sync_status != 'PENDING_DELETE'`,
    userId
  );
  return row?.count ?? 0;
}

/**
 * Retorna estatísticas consolidadas de leitura (geral + AT + NT).
 */
export async function getReadStats(db: SQLiteDatabase, userId: string): Promise<ReadStats> {
  const rows = await db.getAllAsync<{ book_abbrev: string; chapter_number: number }>(
    `SELECT book_abbrev, chapter_number FROM chapter_progress
     WHERE user_id = ? AND sync_status != 'PENDING_DELETE'`,
    userId
  );

  const readSet = new Set(rows.map((r) => `${r.book_abbrev}:${r.chapter_number}`));

  let otRead = 0;
  let ntRead = 0;
  for (const book of BOOKS_CATALOG) {
    for (let ch = 1; ch <= book.total_chapters; ch += 1) {
      if (readSet.has(`${book.abbrev}:${ch}`)) {
        if (book.testament === 'AT') otRead += 1;
        else ntRead += 1;
      }
    }
  }

  const totalRead = otRead + ntRead;
  const totalChapters = TESTAMENT_TOTALS.AT + TESTAMENT_TOTALS.NT;

  return {
    totalRead,
    totalChapters,
    otRead,
    otTotal: TESTAMENT_TOTALS.AT,
    ntRead,
    ntTotal: TESTAMENT_TOTALS.NT,
    percent: totalChapters > 0 ? Math.round((totalRead / totalChapters) * 100) : 0,
  };
}

/**
 * Retorna o progresso de um livro específico (capítulos lidos + total).
 */
export async function getBookProgress(
  db: SQLiteDatabase,
  userId: string,
  bookAbbrev: string
): Promise<BookProgress> {
  const book = BOOKS_CATALOG.find((b) => b.abbrev === bookAbbrev);
  if (!book) {
    return { read: [], total: 0 };
  }

  const rows = await db.getAllAsync<{ chapter_number: number }>(
    `SELECT chapter_number FROM chapter_progress
     WHERE user_id = ? AND book_abbrev = ? AND sync_status != 'PENDING_DELETE'
     ORDER BY chapter_number`,
    userId,
    bookAbbrev
  );

  return {
    read: rows.map((r) => r.chapter_number),
    total: book.total_chapters,
  };
}

/**
 * Agrupa todos os capítulos lidos por livro.
 */
export async function getReadChaptersByBook(
  db: SQLiteDatabase,
  userId: string
): Promise<Record<string, number[]>> {
  const rows = await db.getAllAsync<{ book_abbrev: string; chapter_number: number }>(
    `SELECT book_abbrev, chapter_number FROM chapter_progress
     WHERE user_id = ? AND sync_status != 'PENDING_DELETE'
     ORDER BY book_abbrev, chapter_number`,
    userId
  );

  const grouped: Record<string, number[]> = {};
  for (const r of rows) {
    if (!grouped[r.book_abbrev]) {
      grouped[r.book_abbrev] = [];
    }
    grouped[r.book_abbrev].push(r.chapter_number);
  }
  return grouped;
}

/**
 * Apaga todo o progresso do usuário informado.
 *
 * Assim como `unmarkChapterRead`, usa tombstones (`PENDING_DELETE`) em vez de
 * apagar as linhas, para que a limpeza seja propagada ao Supabase no próximo
 * sync (e para que um pull antigo não "ressurecione" as leituras). Capítulos já
 * desmarcados (tombstones existentes) são mantidos como estão.
 */
export async function resetAllProgress(db: SQLiteDatabase, userId: string): Promise<void> {
  await db.runAsync(
    `UPDATE chapter_progress
     SET read_at = NULL,
         updated_at = ?,
         sync_status = 'PENDING_DELETE'
     WHERE user_id = ? AND sync_status != 'PENDING_DELETE'`,
    nowIso(),
    userId
  );
}

/** ID temporário usado antes da autenticação (mantido apenas para migração). */
const PROVISIONAL_USER_ID = 'local-user';

/**
 * Migra registros do usuário provisório para o usuário real após o login.
 * Idempotente: pode ser chamada múltiplas vezes sem duplicar.
 */
export async function migrateProvisionalProgress(
  db: SQLiteDatabase,
  realUserId: string
): Promise<number> {
  const result = await db.runAsync(
    `UPDATE chapter_progress
     SET user_id = ?
     WHERE user_id = ?`,
    realUserId,
    PROVISIONAL_USER_ID
  );
  return result.changes ?? 0;
}

// ----------------------------------------------------------------------------
// Helpers usados pelo serviço de sync (`src/features/sync`).
// ----------------------------------------------------------------------------

/**
 * Retorna os registros locais que precisam ser enviados ao Supabase
 * (`PENDING` = leitura nova; `PENDING_DELETE` = desmarcação a propagar).
 */
export async function getPendingProgress(
  db: SQLiteDatabase,
  userId: string
): Promise<ChapterProgressRow[]> {
  return db.getAllAsync<ChapterProgressRow>(
    `SELECT user_id, book_abbrev, chapter_number, read_at, updated_at, sync_status
     FROM chapter_progress
     WHERE user_id = ? AND sync_status IN ('PENDING', 'PENDING_DELETE')
     ORDER BY updated_at ASC`,
    userId
  );
}

/**
 * Retorna TODOS os registros locais (lidos, sincronizados e tombstones) para a
 * mesclagem LWW durante o pull.
 */
export async function getAllProgressRows(
  db: SQLiteDatabase,
  userId: string
): Promise<ChapterProgressRow[]> {
  return db.getAllAsync<ChapterProgressRow>(
    `SELECT user_id, book_abbrev, chapter_number, read_at, updated_at, sync_status
     FROM chapter_progress
     WHERE user_id = ?`,
    userId
  );
}

/**
 * Marca um registro como `SYNCED` após o push confirmado no Supabase.
 * Só atualiza se ainda estiver `PENDING` (protege contra uma desmarcação que
 * tenha ocorrido em paralelo durante o push).
 */
export async function setProgressSynced(
  db: SQLiteDatabase,
  userId: string,
  bookAbbrev: string,
  chapterNumber: number
): Promise<void> {
  await db.runAsync(
    `UPDATE chapter_progress
     SET sync_status = 'SYNCED'
     WHERE user_id = ? AND book_abbrev = ? AND chapter_number = ?
       AND sync_status = 'PENDING'`,
    userId,
    bookAbbrev,
    chapterNumber
  );
}

/**
 * Remove o tombstone local após o DELETE ter sido propagado ao Supabase.
 * Só remove se ainda estiver `PENDING_DELETE` (protege contra uma re-marcação
 * que tenha ocorrido em paralelo).
 */
export async function removePendingDelete(
  db: SQLiteDatabase,
  userId: string,
  bookAbbrev: string,
  chapterNumber: number
): Promise<void> {
  await db.runAsync(
    `DELETE FROM chapter_progress
     WHERE user_id = ? AND book_abbrev = ? AND chapter_number = ?
       AND sync_status = 'PENDING_DELETE'`,
    userId,
    bookAbbrev,
    chapterNumber
  );
}

/**
 * Aplica um registro remoto de leitura (pull) no banco local, marcando como
 * `SYNCED`. Usado quando o `updated_at` remoto é mais recente que o local
 * (ou quando não há registro local).
 */
export async function applyRemoteRead(
  db: SQLiteDatabase,
  userId: string,
  bookAbbrev: string,
  chapterNumber: number,
  readAt: string | null,
  updatedAt: string
): Promise<void> {
  await db.runAsync(
    `INSERT INTO chapter_progress
       (user_id, book_abbrev, chapter_number, read_at, updated_at, sync_status)
     VALUES (?, ?, ?, ?, ?, 'SYNCED')
     ON CONFLICT(user_id, book_abbrev, chapter_number) DO UPDATE SET
       read_at = excluded.read_at,
       updated_at = excluded.updated_at,
       sync_status = excluded.sync_status`,
    userId,
    bookAbbrev,
    chapterNumber,
    readAt,
    updatedAt
  );
}

/**
 * Aplica uma desmarcação remota (tombstone) no banco local: apaga a linha
 * (leitura ou tombstone local) do capítulo. Usado quando o `deleted_at` remoto
 * é mais recente que o local (ou quando não há registro local).
 */
export async function applyRemoteDelete(
  db: SQLiteDatabase,
  userId: string,
  bookAbbrev: string,
  chapterNumber: number
): Promise<void> {
  await db.runAsync(
    'DELETE FROM chapter_progress WHERE user_id = ? AND book_abbrev = ? AND chapter_number = ?',
    userId,
    bookAbbrev,
    chapterNumber
  );
}
