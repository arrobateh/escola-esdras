// Exercises metadata filtering and publication queries without a remote account.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const ts = require('typescript');
const fs = require('node:fs');
const vm = require('node:vm');
const path = require('node:path');
const calls = [];
let responses = [];
const client = { from(table) {
  calls.push(['from', table]);
  const query = {};
  for (const method of ['select', 'eq', 'order']) query[method] = (...args) => { calls.push([method, ...args]); return query; };
  query.range = async (...args) => { calls.push(['range', ...args]); return responses.shift(); };
  query.maybeSingle = async () => responses.shift();
  return query;
} };
const compiled = ts.transpileModule(fs.readFileSync(path.join(__dirname, '../../src/features/hymnals/catalog.ts'), 'utf8'), {
  compilerOptions: { module: ts.ModuleKind.CommonJS, target: ts.ScriptTarget.ES2022 },
}).outputText;
const exported = {};
vm.runInNewContext(compiled, { exports: exported, require: () => ({ supabase: client }) });
const makeEntry = (credits) => ({ hymns: { hymn_credits: credits } });

test('search ignores accents and composer filtering preserves collaborations and unknown credits', () => {
  assert.equal(exported.normalizeSearch('  MÁRCIO  '), 'marcio');
  const known = makeEntry([{ role: 'lyrics', hymn_composers: { id: 'a', name: 'Autor' } }, { role: 'music', hymn_composers: { id: 'b', name: 'Músico' } }]);
  const unknown = makeEntry([]);
  assert.equal(exported.byComposer([known, unknown], 'b')[0], known);
  assert.equal(exported.byComposer([known, unknown], exported.UNKNOWN_COMPOSER)[0], unknown);
  assert.equal(exported.creditLabel(unknown), 'Autoria não confirmada');
});

test('catalog paginates metadata and excludes drafts and unpublished editions explicitly', async () => {
  calls.length = 0;
  responses = [{ data: Array(500).fill({}), error: null }, { data: [{}], error: null }];
  assert.equal((await exported.fetchCatalog()).length, 501);
  assert.ok(calls.some((call) => JSON.stringify(call) === '["eq","hymnals.published",true]'));
  assert.ok(calls.some((call) => JSON.stringify(call) === '["eq","hymns.review_status","published"]'));
  assert.ok(calls.some((call) => JSON.stringify(call) === '["range",500,999]'));
  assert.ok(calls.filter((call) => call[0] === 'select').every((call) => !call[1].includes('lyrics')));
});

test('reader distinguishes missing lyrics from query failure', async () => {
  responses = [{ data: null, error: null }];
  assert.equal(await exported.fetchLyrics('id'), null);
  responses = [{ data: null, error: new Error('offline') }];
  await assert.rejects(exported.fetchLyrics('id'), /offline/);
});
