import * as SQLite from 'expo-sqlite';

import {
  CREATE_BOOKS_TABLE,
  CREATE_CHAPTER_PROGRESS_TABLE,
  CREATE_PLAN_DAY_CONTENTS_TABLE,
  CREATE_READING_PLANS_TABLE,
  CREATE_USER_PLAN_PROGRESS_TABLE,
  CREATE_VERSES_FTS,
  CREATE_VERSES_TABLE,
  PRAGMAS,
} from './schema';

const DATABASE_NAME = 'escola_esdras.db';
const DATABASE_VERSION = 4;

let fts5Supported: boolean | null = null;

export function isFts5Supported(): boolean | null {
  return fts5Supported;
}

/**
 * Abre o banco de dados local e executa as migrations de forma idempotente.
 * Retorna a instância do banco já pronta para uso.
 */
export async function openDatabase(): Promise<SQLite.SQLiteDatabase> {
  const db = await SQLite.openDatabaseAsync(DATABASE_NAME);
  await runMigrations(db);
  return db;
}

async function runMigrations(db: SQLite.SQLiteDatabase): Promise<void> {
  const result = await db.getFirstAsync<{ user_version: number }>('PRAGMA user_version');
  const currentVersion = result?.user_version ?? 0;

  if (currentVersion >= DATABASE_VERSION) {
    return;
  }

  // Ajustes de performance e integridade referencial DEVEM rodar fora de transação.
  await db.execAsync(PRAGMAS);

  await db.withTransactionAsync(async () => {
    // Tabelas principais (sempre criadas)
    await db.execAsync(CREATE_BOOKS_TABLE);
    await db.execAsync(CREATE_VERSES_TABLE);
    await db.execAsync(CREATE_CHAPTER_PROGRESS_TABLE);
    await db.execAsync(CREATE_READING_PLANS_TABLE);
    await db.execAsync(CREATE_PLAN_DAY_CONTENTS_TABLE);
    await db.execAsync(CREATE_USER_PLAN_PROGRESS_TABLE);

    // A atividade semanal vem exclusivamente dos dias concluídos do plano.
    // Remove a captura antiga por capítulo sem apagar dados legados.
    await db.execAsync(`
      DROP TRIGGER IF EXISTS reading_activity_insert;
      DROP TRIGGER IF EXISTS reading_activity_update;
    `);

    await db.execAsync(`CREATE TABLE IF NOT EXISTS app_usage (
      user_id TEXT NOT NULL, day TEXT NOT NULL, milliseconds INTEGER NOT NULL DEFAULT 0,
      PRIMARY KEY(user_id, day)
    );`);

    // FTS5: tente criar; se não for suportado, não quebre a inicialização.
    try {
      await db.execAsync(CREATE_VERSES_FTS);
      fts5Supported = true;
      console.log('[migrate] FTS5 disponível e tabela verses_fts criada.');
    } catch (error) {
      fts5Supported = false;
      const message = error instanceof Error ? error.message : String(error);
      console.warn('[migrate] FTS5 não disponível nesta build. Busca full-text será limitada.', message);
    }
  });

  // Só marca a versão depois que a transação de migrations foi concluída com sucesso.
  await db.execAsync(`PRAGMA user_version = ${DATABASE_VERSION}`);
}
