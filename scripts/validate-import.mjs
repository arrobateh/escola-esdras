/**
 * Script de validação local da importação bíblica (Fase 1).
 *
 * Simula, fora do app (em Node, usando o módulo nativo `node:sqlite`), o mesmo
 * fluxo de importação em lote usado no app e reporta os números reais:
 * livros, capítulos, versículos e uma consulta FTS5 de teste.
 *
 * Uso:
 *   node scripts/validate-import.mjs [slug] [caminho-json-opcional]
 *
 * Exemplos:
 *   node scripts/validate-import.mjs                      # baixa pt_ara.json
 *   node scripts/validate-import.mjs pt_arc               # baixa pt_arc.json
 *   node scripts/validate-import.mjs pt_ara /tmp/pt_ara.json
 *
 * Não é executado no app (não depende do expo-sqlite).
 */

import { DatabaseSync } from 'node:sqlite';
import { readFileSync } from 'node:fs';

const SLUG = process.argv[2] ?? 'pt_ara';
const JSON_PATH = process.argv[3] ?? null;
const BASE_URL = 'https://raw.githubusercontent.com/thiagobodruk/bible/master/json/';
const INSERT_CHUNK_SIZE = 100;

async function loadBibleJson() {
  if (JSON_PATH) {
    return JSON.parse(readFileSync(JSON_PATH, 'utf8'));
  }
  const url = `${BASE_URL}${SLUG}.json`;
  console.log(`Baixando ${url} ...`);
  const res = await fetch(url);
  if (!res.ok) {
    throw new Error(`HTTP ${res.status} ao baixar ${url}`);
  }
  return res.json();
}

function createSchema(db) {
  db.exec(`
    PRAGMA journal_mode = WAL;
    CREATE TABLE books (
      abbrev TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      testament TEXT NOT NULL,
      category TEXT NOT NULL,
      total_chapters INTEGER NOT NULL
    );
    CREATE TABLE verses (
      translation TEXT NOT NULL,
      book_abbrev TEXT NOT NULL,
      chapter INTEGER NOT NULL,
      verse INTEGER NOT NULL,
      text TEXT NOT NULL,
      PRIMARY KEY (translation, book_abbrev, chapter, verse)
    );
    CREATE VIRTUAL TABLE verses_fts USING fts5(
      book_abbrev, chapter, verse, text, content='verses'
    );
  `);
}

function importTranslation(db, slug, bibleJson) {
  let totalVerses = 0;
  for (const book of bibleJson) {
    for (const chapter of book.chapters) totalVerses += chapter.length;
  }

  db.exec('BEGIN');
  try {
    const upsertBook = db.prepare(
      `INSERT INTO books (abbrev, name, testament, category, total_chapters)
       VALUES (?, ?, ?, ?, ?)
       ON CONFLICT(abbrev) DO UPDATE SET
         name = excluded.name, testament = excluded.testament,
         category = excluded.category, total_chapters = excluded.total_chapters`
    );

    for (let i = 0; i < bibleJson.length; i++) {
      const book = bibleJson[i];
      const testament = i < 39 ? 'AT' : 'NT';
      upsertBook.run(book.abbrev, book.name, testament, 'cat', book.chapters.length);
    }

    db.prepare('DELETE FROM verses WHERE translation = ?').run(slug);

    const buffer = [];
    const flush = () => {
      if (buffer.length === 0) return;
      const values = [];
      const params = [];
      for (let i = 0; i < buffer.length; i++) {
        const r = buffer[i];
        values.push('(?, ?, ?, ?, ?)');
        params.push(slug, r.bookAbbrev, r.chapter, r.verse, r.text);
      }
      db.prepare(
        `INSERT INTO verses (translation, book_abbrev, chapter, verse, text) VALUES ${values.join(',')}`
      ).run(...params);
      buffer.length = 0;
    };

    for (const book of bibleJson) {
      for (let ci = 0; ci < book.chapters.length; ci++) {
        const chapterVerses = book.chapters[ci];
        for (let vi = 0; vi < chapterVerses.length; vi++) {
          buffer.push({ bookAbbrev: book.abbrev, chapter: ci + 1, verse: vi + 1, text: chapterVerses[vi] });
          if (buffer.length >= INSERT_CHUNK_SIZE) flush();
        }
      }
    }
    flush();

    db.exec('COMMIT');
  } catch (err) {
    db.exec('ROLLBACK');
    throw err;
  }

  // Reconstrução do FTS5 (external content).
  db.exec("INSERT INTO verses_fts(verses_fts) VALUES('rebuild')");

  return totalVerses;
}

async function main() {
  const bibleJson = await loadBibleJson();

  const totalChapters = bibleJson.reduce((sum, b) => sum + b.chapters.length, 0);
  const totalVerses = bibleJson.reduce(
    (sum, b) => sum + b.chapters.reduce((s, c) => s + c.length, 0),
    0
  );
  const atBooks = bibleJson.slice(0, 39);
  const ntBooks = bibleJson.slice(39);
  const atChapters = atBooks.reduce((sum, b) => sum + b.chapters.length, 0);
  const ntChapters = ntBooks.reduce((sum, b) => sum + b.chapters.length, 0);

  console.log('\n=== Catálogo derivado do dataset ===');
  console.log(`Slug: ${SLUG}`);
  console.log(`Livros: ${bibleJson.length} (AT: ${atBooks.length}, NT: ${ntBooks.length})`);
  console.log(`Capítulos: ${totalChapters} (AT: ${atChapters}, NT: ${ntChapters})`);
  console.log(`Versículos: ${totalVerses}`);

  const db = new DatabaseSync(':memory:');
  createSchema(db);

  console.log('\n=== Importação (1ª vez) ===');
  const imported = importTranslation(db, SLUG, bibleJson);
  console.log(`Versículos importados: ${imported}`);

  const verseCount = db.prepare('SELECT COUNT(*) AS c FROM verses').get().c;
  const distinctBooks = db.prepare('SELECT COUNT(DISTINCT book_abbrev) AS c FROM verses').get().c;
  console.log(`Linhas em "verses": ${verseCount}`);
  console.log(`Livros distintos em "verses": ${distinctBooks}`);

  console.log('\n=== Idempotência (2ª importação) ===');
  importTranslation(db, SLUG, bibleJson);
  const verseCountAfter = db.prepare('SELECT COUNT(*) AS c FROM verses').get().c;
  console.log(`Linhas em "verses" após reimportar: ${verseCountAfter} (deve ser igual a ${verseCount})`);

  console.log('\n=== Teste FTS5 ===');
  for (const term of ['espírito', 'terra', 'amor']) {
    const rows = db
      .prepare(
        `SELECT v.book_abbrev AS b, v.chapter AS c, v.verse AS vv, v.text AS t
         FROM verses_fts f JOIN verses v ON v.rowid = f.rowid
         WHERE verses_fts MATCH ? LIMIT 3`
      )
      .all(term);
    console.log(`MATCH "${term}" -> ${rows.length >= 1 ? rows.length + ' resultados (exibindo até 3)' : 'sem resultados'}`);
    for (const r of rows) {
      console.log(`   ${r.b} ${r.c}:${r.vv} — ${r.t}`);
    }
  }

  console.log('\nConcluído.');
}

main().catch((err) => {
  console.error('Falha na validação:', err);
  process.exit(1);
});
