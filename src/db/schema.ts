// Schema SQL consolidado para o app Escola de Esdras (Fase 0)
// Mantido idempotente com "IF NOT EXISTS" para poder ser reexecutado.

export const CREATE_BOOKS_TABLE = `
CREATE TABLE IF NOT EXISTS books (
  abbrev         TEXT PRIMARY KEY,
  name           TEXT NOT NULL,
  testament      TEXT NOT NULL CHECK(testament IN ('AT','NT')),
  category       TEXT NOT NULL,
  total_chapters INTEGER NOT NULL
);
`;

export const CREATE_VERSES_TABLE = `
CREATE TABLE IF NOT EXISTS verses (
  translation    TEXT NOT NULL,
  book_abbrev    TEXT NOT NULL,
  chapter        INTEGER NOT NULL,
  verse          INTEGER NOT NULL,
  text           TEXT NOT NULL,
  PRIMARY KEY (translation, book_abbrev, chapter, verse)
);
`;

export const CREATE_VERSES_FTS = `
CREATE VIRTUAL TABLE IF NOT EXISTS verses_fts USING fts5(
  book_abbrev,
  chapter,
  verse,
  text,
  content='verses'
);
`;

export const CREATE_CHAPTER_PROGRESS_TABLE = `
CREATE TABLE IF NOT EXISTS chapter_progress (
  user_id        TEXT NOT NULL,
  book_abbrev    TEXT NOT NULL,
  chapter_number INTEGER NOT NULL,
  read_at        TEXT,
  updated_at     TEXT,
  sync_status    TEXT NOT NULL DEFAULT 'PENDING',
  PRIMARY KEY (user_id, book_abbrev, chapter_number)
);
`;

export const CREATE_READING_PLANS_TABLE = `
CREATE TABLE IF NOT EXISTS reading_plans (
  id              TEXT PRIMARY KEY,
  title           TEXT NOT NULL,
  description     TEXT,
  duration_days   INTEGER NOT NULL,
  cover_image_url TEXT,
  created_at      TEXT,
  updated_at      TEXT
);
`;

export const CREATE_PLAN_DAY_CONTENTS_TABLE = `
CREATE TABLE IF NOT EXISTS plan_day_contents (
  id          TEXT PRIMARY KEY,
  plan_id     TEXT REFERENCES reading_plans(id) ON DELETE CASCADE,
  day_number  INTEGER NOT NULL,
  sort_order  INTEGER NOT NULL DEFAULT 1,
  book_abbrev TEXT NOT NULL,
  chapter     INTEGER NOT NULL,
  start_verse INTEGER,
  end_verse   INTEGER
);
`;

export const CREATE_USER_PLAN_PROGRESS_TABLE = `
CREATE TABLE IF NOT EXISTS user_plan_progress (
  user_id       TEXT,
  plan_id       TEXT,
  day_number    INTEGER,
  status        TEXT NOT NULL DEFAULT 'PENDING',
  completed_at  TEXT,
  updated_at    TEXT,
  PRIMARY KEY (user_id, plan_id, day_number)
);
`;

export const PRAGMAS = `
PRAGMA journal_mode = WAL;
PRAGMA foreign_keys = ON;
`;
