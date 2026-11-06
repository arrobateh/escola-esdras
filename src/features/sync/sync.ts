import type { SQLiteDatabase } from 'expo-sqlite';

import {
  applyRemoteDelete,
  applyRemoteRead,
  getAllProgressRows,
  getPendingProgress,
  removePendingDelete,
  setProgressSynced,
  type ChapterProgressRow,
} from '../../db/progress';
import { supabase } from '../../lib/supabase';

/**
 * Serviço de sincronização do progresso de leitura (`chapter_progress`) entre o
 * SQLite local e o Supabase.
 *
 * Estratégia: LWW (last-writer-wins) comparando timestamps `updated_at`
 * (leitura) e `deleted_at` (tombstone de desmarcação).
 *
 * Ordem do `syncProgress`: PULL (mesclar) → PUSH (enviar). Justificativa em
 * `syncProgress` abaixo.
 */

export interface SyncCounters {
  pushedReads: number;
  pushedDeletes: number;
  pulledReads: number;
  pulledDeletes: number;
}

export interface SyncResult extends SyncCounters {
  ok: boolean;
  /** `true` quando já havia um sync em andamento para este usuário. */
  skipped: boolean;
  /** Motivo de falha (quando `ok` é falso). */
  reason?: string;
}

interface RemoteReadRow {
  user_id: string;
  book_abbrev: string;
  chapter_number: number;
  read_at: string | null;
  updated_at: string | null;
}

interface RemoteDeletionRow {
  user_id: string;
  book_abbrev: string;
  chapter_number: number;
  deleted_at: string | null;
}

/** Guarda de concorrência: evita dois syncs simultâneos para o mesmo usuário. */
const runningUsers = new Set<string>();

/**
 * Converte um timestamp (ISO string) em milissegundos para comparação LWW.
 * `Date.parse` normaliza os formatos do Supabase ("...+00:00") e do SQLite
 * ("...Z") que, comparados como string, poderiam divergir.
 */
function toTimestamp(value: string | null | undefined): number {
  if (!value) return 0;
  const parsed = Date.parse(value);
  return Number.isNaN(parsed) ? 0 : parsed;
}

function chapterKey(bookAbbrev: string, chapterNumber: number): string {
  return `${bookAbbrev}:${chapterNumber}`;
}

/**
 * Busca o estado remoto (leituras + tombstones) do Supabase e mescla no banco
 * local aplicando LWW.
 *
 * Para cada chave presente no remoto, calcula o evento mais recente
 * (read com maior `updated_at`, ou delete com maior `deleted_at`). Se o evento
 * remoto for mais recente que o local (ou não houver local), aplica no local
 * com `sync_status = 'SYNCED'` (read) ou apaga a linha (delete). Caso contrário
 * mantém o local (que será enviado no push).
 */
export async function pullProgress(db: SQLiteDatabase, userId: string): Promise<SyncCounters> {
  const client = supabase;
  if (!client) throw new Error('Supabase não configurado.');

  const { data: reads, error: readsError } = await client
    .from('chapter_progress')
    .select('*')
    .eq('user_id', userId)
    .returns<RemoteReadRow[]>();

  if (readsError) throw new Error(readsError.message);

  const { data: deletions, error: deletionsError } = await client
    .from('chapter_progress_deletions')
    .select('*')
    .eq('user_id', userId)
    .returns<RemoteDeletionRow[]>();

  if (deletionsError) throw new Error(deletionsError.message);

  // Mapa do evento remoto mais recente por chave.
  type RemoteEvent =
    | { kind: 'read'; at: number; readAt: string | null; updatedAt: string; book: string; chapter: number }
    | { kind: 'delete'; at: number; book: string; chapter: number };

  const remoteEvents = new Map<string, RemoteEvent>();

  for (const r of reads ?? []) {
    const key = chapterKey(r.book_abbrev, r.chapter_number);
    const at = toTimestamp(r.updated_at);
    const existing = remoteEvents.get(key);
    if (!existing || at > existing.at) {
      remoteEvents.set(key, {
        kind: 'read',
        at,
        readAt: r.read_at,
        updatedAt: r.updated_at ?? new Date().toISOString(),
        book: r.book_abbrev,
        chapter: r.chapter_number,
      });
    }
  }

  for (const d of deletions ?? []) {
    const key = chapterKey(d.book_abbrev, d.chapter_number);
    const at = toTimestamp(d.deleted_at);
    const existing = remoteEvents.get(key);
    if (!existing || at > existing.at) {
      remoteEvents.set(key, { kind: 'delete', at, book: d.book_abbrev, chapter: d.chapter_number });
    }
  }

  // Mapa local por chave (inclui tombstones) para a comparação LWW.
  const localRows = await getAllProgressRows(db, userId);
  const localByKey = new Map<string, ChapterProgressRow>();
  for (const row of localRows) {
    localByKey.set(chapterKey(row.book_abbrev, row.chapter_number), row);
  }

  const counters: SyncCounters = {
    pushedReads: 0,
    pushedDeletes: 0,
    pulledReads: 0,
    pulledDeletes: 0,
  };

  for (const [key, event] of remoteEvents) {
    const local = localByKey.get(key);
    if (local && toTimestamp(local.updated_at) > event.at) {
      // Local é mais recente: mantém (será enviado no push).
      continue;
    }

    if (event.kind === 'read') {
      await applyRemoteRead(db, userId, event.book, event.chapter, event.readAt, event.updatedAt);
      counters.pulledReads += 1;
    } else {
      await applyRemoteDelete(db, userId, event.book, event.chapter);
      counters.pulledDeletes += 1;
    }
  }

  return counters;
}

/**
 * Envia os registros locais pendentes ao Supabase.
 *
 * - `PENDING`        → upsert em `chapter_progress` e limpeza de um tombstone
 *                      remoto que porventura exista para a mesma chave; marca
 *                      localmente como `SYNCED`.
 * - `PENDING_DELETE` → DELETE em `chapter_progress` + upsert de tombstone em
 *                      `chapter_progress_deletions` (com `deleted_at`); remove o
 *                      tombstone local.
 */
export async function pushPendingProgress(db: SQLiteDatabase, userId: string): Promise<SyncCounters> {
  const client = supabase;
  if (!client) throw new Error('Supabase não configurado.');

  const pending = await getPendingProgress(db, userId);

  const counters: SyncCounters = {
    pushedReads: 0,
    pushedDeletes: 0,
    pulledReads: 0,
    pulledDeletes: 0,
  };

  for (const row of pending) {
    if (row.sync_status === 'PENDING') {
      const { error } = await client.from('chapter_progress').upsert(
        {
          user_id: userId,
          book_abbrev: row.book_abbrev,
          chapter_number: row.chapter_number,
          read_at: row.read_at,
          updated_at: row.updated_at,
        } as never,
        { onConflict: 'user_id,book_abbrev,chapter_number' }
      );
      if (error) throw new Error(error.message);

      // Remove qualquer tombstone remoto pendente para a mesma chave (a leitura
      // mais recente "vence" a desmarcação mais antiga).
      const { error: tombstoneError } = await client
        .from('chapter_progress_deletions')
        .delete()
        .eq('user_id', userId)
        .eq('book_abbrev', row.book_abbrev)
        .eq('chapter_number', row.chapter_number);
      if (tombstoneError) throw new Error(tombstoneError.message);

      await setProgressSynced(db, userId, row.book_abbrev, row.chapter_number);
      counters.pushedReads += 1;
    } else {
      // PENDING_DELETE
      const { error } = await client
        .from('chapter_progress')
        .delete()
        .eq('user_id', userId)
        .eq('book_abbrev', row.book_abbrev)
        .eq('chapter_number', row.chapter_number);
      if (error) throw new Error(error.message);

      const { error: tombstoneError } = await client.from('chapter_progress_deletions').upsert(
        {
          user_id: userId,
          book_abbrev: row.book_abbrev,
          chapter_number: row.chapter_number,
          deleted_at: row.updated_at,
        } as never,
        { onConflict: 'user_id,book_abbrev,chapter_number' }
      );
      if (tombstoneError) throw new Error(tombstoneError.message);

      await removePendingDelete(db, userId, row.book_abbrev, row.chapter_number);
      counters.pushedDeletes += 1;
    }
  }

  return counters;
}

/**
 * Orquestra a sincronização completa: PULL (mesclar) → PUSH (enviar).
 *
 * POR QUE PULL ANTES DE PUSH:
 *   Se enviássemos primeiro, uma alteração local antiga poderia sobrescrever um
 *   dado mais recente vindo de outro aparelho. Fazendo o pull primeiro e
 *   aplicando LWW, descartamos (ou sobrescrevemos) localmente qualquer mudança
 *   local que seja mais antiga que a remota; assim, o push subsequente contém
 *   apenas mudanças genuinamente "vencedoras" do LWW.
 *
 * Nunca lança exceção: falhas de rede/desconhecidas são logadas e devolvidas
 * como `ok: false`, para que a UI não trave. (offline-first: os registros
 * continuam `PENDING`/`PENDING_DELETE` e serão enviados no próximo disparo.)
 */
export async function syncProgress(db: SQLiteDatabase, userId: string): Promise<SyncResult> {
  if (!userId) {
    return { ok: false, skipped: false, reason: 'no-user', pushedReads: 0, pushedDeletes: 0, pulledReads: 0, pulledDeletes: 0 };
  }

  const client = supabase;
  if (!client) {
    return { ok: false, skipped: false, reason: 'not-configured', pushedReads: 0, pushedDeletes: 0, pulledReads: 0, pulledDeletes: 0 };
  }

  if (runningUsers.has(userId)) {
    return { ok: false, skipped: true, reason: 'already-running', pushedReads: 0, pushedDeletes: 0, pulledReads: 0, pulledDeletes: 0 };
  }

  runningUsers.add(userId);
  try {
    const pulled = await pullProgress(db, userId);
    const pushed = await pushPendingProgress(db, userId);
    return {
      ok: true,
      skipped: false,
      pushedReads: pushed.pushedReads,
      pushedDeletes: pushed.pushedDeletes,
      pulledReads: pulled.pulledReads,
      pulledDeletes: pulled.pulledDeletes,
    };
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    console.warn('[sync] Falha ao sincronizar (offline ou erro de rede):', message);
    return { ok: false, skipped: false, reason: 'network', pushedReads: 0, pushedDeletes: 0, pulledReads: 0, pulledDeletes: 0 };
  } finally {
    runningUsers.delete(userId);
  }
}
