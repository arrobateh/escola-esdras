/**
 * Catálogo canônico dos 66 livros da Bíblia protestante.
 *
 * Os campos `abbrev`, `name` e `total_chapters` foram derivados diretamente do
 * dataset oficial (repositório `thiagobodruk/bible`, arquivo `json/pt_ara.json`),
 * garantindo que os `abbrev` batem exatamente com os slugs usados no JSON.
 * `testament` e `category` foram mapeados a partir do nome do livro.
 *
 * Total: 66 livros (39 no AT, 27 no NT) e 1.189 capítulos.
 */

export type Testament = 'AT' | 'NT';

export interface BookCatalogEntry {
  /** Slug canônico do livro (mesmo padrão do dataset), ex.: "gn", "1co". */
  abbrev: string;
  /** Nome do livro em português. */
  name: string;
  testament: Testament;
  category: string;
  total_chapters: number;
}

export const CATEGORY = {
  PENTATEUCO: 'Pentateuco',
  HISTORICOS: 'Históricos',
  POETICOS: 'Poéticos',
  PROFETAS_MAIORES: 'Profetas Maiores',
  PROFETAS_MENORES: 'Profetas Menores',
  EVANGELHOS: 'Evangelhos',
  HISTORIA: 'História',
  EPISTOLAS_PAULINAS: 'Epístolas Paulinas',
  EPISTOLAS_GERAIS: 'Epístolas Gerais',
  APOCALIPSE: 'Apocalipse',
} as const;

export const BOOKS_CATALOG: readonly BookCatalogEntry[] = [
  // ----------------------------- Antigo Testamento -----------------------------
  { abbrev: 'gn', name: 'Gênesis', testament: 'AT', category: CATEGORY.PENTATEUCO, total_chapters: 50 },
  { abbrev: 'ex', name: 'Êxodo', testament: 'AT', category: CATEGORY.PENTATEUCO, total_chapters: 40 },
  { abbrev: 'lv', name: 'Levítico', testament: 'AT', category: CATEGORY.PENTATEUCO, total_chapters: 27 },
  { abbrev: 'nm', name: 'Números', testament: 'AT', category: CATEGORY.PENTATEUCO, total_chapters: 36 },
  { abbrev: 'dt', name: 'Deuteronômio', testament: 'AT', category: CATEGORY.PENTATEUCO, total_chapters: 34 },

  { abbrev: 'js', name: 'Josué', testament: 'AT', category: CATEGORY.HISTORICOS, total_chapters: 24 },
  { abbrev: 'jz', name: 'Juízes', testament: 'AT', category: CATEGORY.HISTORICOS, total_chapters: 21 },
  { abbrev: 'rt', name: 'Rute', testament: 'AT', category: CATEGORY.HISTORICOS, total_chapters: 4 },
  { abbrev: '1sm', name: '1 Samuel', testament: 'AT', category: CATEGORY.HISTORICOS, total_chapters: 31 },
  { abbrev: '2sm', name: '2 Samuel', testament: 'AT', category: CATEGORY.HISTORICOS, total_chapters: 24 },
  { abbrev: '1rs', name: '1 Reis', testament: 'AT', category: CATEGORY.HISTORICOS, total_chapters: 22 },
  { abbrev: '2rs', name: '2 Reis', testament: 'AT', category: CATEGORY.HISTORICOS, total_chapters: 25 },
  { abbrev: '1cr', name: '1 Crônicas', testament: 'AT', category: CATEGORY.HISTORICOS, total_chapters: 29 },
  { abbrev: '2cr', name: '2 Crônicas', testament: 'AT', category: CATEGORY.HISTORICOS, total_chapters: 36 },
  { abbrev: 'ed', name: 'Esdras', testament: 'AT', category: CATEGORY.HISTORICOS, total_chapters: 10 },
  { abbrev: 'ne', name: 'Neemias', testament: 'AT', category: CATEGORY.HISTORICOS, total_chapters: 13 },
  { abbrev: 'et', name: 'Ester', testament: 'AT', category: CATEGORY.HISTORICOS, total_chapters: 10 },

  { abbrev: 'jó', name: 'Jó', testament: 'AT', category: CATEGORY.POETICOS, total_chapters: 42 },
  { abbrev: 'sl', name: 'Salmos', testament: 'AT', category: CATEGORY.POETICOS, total_chapters: 150 },
  { abbrev: 'pv', name: 'Provérbios', testament: 'AT', category: CATEGORY.POETICOS, total_chapters: 31 },
  { abbrev: 'ec', name: 'Eclesiastes', testament: 'AT', category: CATEGORY.POETICOS, total_chapters: 12 },
  { abbrev: 'ct', name: 'Cântico', testament: 'AT', category: CATEGORY.POETICOS, total_chapters: 8 },

  { abbrev: 'is', name: 'Isaías', testament: 'AT', category: CATEGORY.PROFETAS_MAIORES, total_chapters: 66 },
  { abbrev: 'jr', name: 'Jeremias', testament: 'AT', category: CATEGORY.PROFETAS_MAIORES, total_chapters: 52 },
  { abbrev: 'lm', name: 'Lamentações', testament: 'AT', category: CATEGORY.PROFETAS_MAIORES, total_chapters: 5 },
  { abbrev: 'ez', name: 'Ezequiel', testament: 'AT', category: CATEGORY.PROFETAS_MAIORES, total_chapters: 48 },
  { abbrev: 'dn', name: 'Daniel', testament: 'AT', category: CATEGORY.PROFETAS_MAIORES, total_chapters: 12 },

  { abbrev: 'os', name: 'Oseias', testament: 'AT', category: CATEGORY.PROFETAS_MENORES, total_chapters: 14 },
  { abbrev: 'jl', name: 'Joel', testament: 'AT', category: CATEGORY.PROFETAS_MENORES, total_chapters: 3 },
  { abbrev: 'am', name: 'Amós', testament: 'AT', category: CATEGORY.PROFETAS_MENORES, total_chapters: 9 },
  { abbrev: 'ob', name: 'Obadias', testament: 'AT', category: CATEGORY.PROFETAS_MENORES, total_chapters: 1 },
  { abbrev: 'jn', name: 'Jonas', testament: 'AT', category: CATEGORY.PROFETAS_MENORES, total_chapters: 4 },
  { abbrev: 'mq', name: 'Miqueias', testament: 'AT', category: CATEGORY.PROFETAS_MENORES, total_chapters: 7 },
  { abbrev: 'na', name: 'Naum', testament: 'AT', category: CATEGORY.PROFETAS_MENORES, total_chapters: 3 },
  { abbrev: 'hc', name: 'Habacuque', testament: 'AT', category: CATEGORY.PROFETAS_MENORES, total_chapters: 3 },
  { abbrev: 'sf', name: 'Sofonias', testament: 'AT', category: CATEGORY.PROFETAS_MENORES, total_chapters: 3 },
  { abbrev: 'ag', name: 'Ageu', testament: 'AT', category: CATEGORY.PROFETAS_MENORES, total_chapters: 2 },
  { abbrev: 'zc', name: 'Zacarias', testament: 'AT', category: CATEGORY.PROFETAS_MENORES, total_chapters: 14 },
  { abbrev: 'ml', name: 'Malaquias', testament: 'AT', category: CATEGORY.PROFETAS_MENORES, total_chapters: 4 },

  // ----------------------------- Novo Testamento -----------------------------
  { abbrev: 'mt', name: 'Mateus', testament: 'NT', category: CATEGORY.EVANGELHOS, total_chapters: 28 },
  { abbrev: 'mc', name: 'Marcos', testament: 'NT', category: CATEGORY.EVANGELHOS, total_chapters: 16 },
  { abbrev: 'lc', name: 'Lucas', testament: 'NT', category: CATEGORY.EVANGELHOS, total_chapters: 24 },
  { abbrev: 'jo', name: 'João', testament: 'NT', category: CATEGORY.EVANGELHOS, total_chapters: 21 },

  { abbrev: 'atos', name: 'Atos', testament: 'NT', category: CATEGORY.HISTORIA, total_chapters: 28 },

  { abbrev: 'rm', name: 'Romanos', testament: 'NT', category: CATEGORY.EPISTOLAS_PAULINAS, total_chapters: 16 },
  { abbrev: '1co', name: '1 Coríntios', testament: 'NT', category: CATEGORY.EPISTOLAS_PAULINAS, total_chapters: 16 },
  { abbrev: '2co', name: '2 Coríntios', testament: 'NT', category: CATEGORY.EPISTOLAS_PAULINAS, total_chapters: 13 },
  { abbrev: 'gl', name: 'Gálatas', testament: 'NT', category: CATEGORY.EPISTOLAS_PAULINAS, total_chapters: 6 },
  { abbrev: 'ef', name: 'Efésios', testament: 'NT', category: CATEGORY.EPISTOLAS_PAULINAS, total_chapters: 6 },
  { abbrev: 'fp', name: 'Filipenses', testament: 'NT', category: CATEGORY.EPISTOLAS_PAULINAS, total_chapters: 4 },
  { abbrev: 'cl', name: 'Colossenses', testament: 'NT', category: CATEGORY.EPISTOLAS_PAULINAS, total_chapters: 4 },
  { abbrev: '1ts', name: '1 Tessalonicenses', testament: 'NT', category: CATEGORY.EPISTOLAS_PAULINAS, total_chapters: 5 },
  { abbrev: '2ts', name: '2 Tessalonicenses', testament: 'NT', category: CATEGORY.EPISTOLAS_PAULINAS, total_chapters: 3 },
  { abbrev: '1tm', name: '1 Timóteo', testament: 'NT', category: CATEGORY.EPISTOLAS_PAULINAS, total_chapters: 6 },
  { abbrev: '2tm', name: '2 Timóteo', testament: 'NT', category: CATEGORY.EPISTOLAS_PAULINAS, total_chapters: 4 },
  { abbrev: 'tt', name: 'Tito', testament: 'NT', category: CATEGORY.EPISTOLAS_PAULINAS, total_chapters: 3 },
  { abbrev: 'fm', name: 'Filemom', testament: 'NT', category: CATEGORY.EPISTOLAS_PAULINAS, total_chapters: 1 },

  { abbrev: 'hb', name: 'Hebreus', testament: 'NT', category: CATEGORY.EPISTOLAS_GERAIS, total_chapters: 13 },
  { abbrev: 'tg', name: 'Tiago', testament: 'NT', category: CATEGORY.EPISTOLAS_GERAIS, total_chapters: 5 },
  { abbrev: '1pe', name: '1 Pedro', testament: 'NT', category: CATEGORY.EPISTOLAS_GERAIS, total_chapters: 5 },
  { abbrev: '2pe', name: '2 Pedro', testament: 'NT', category: CATEGORY.EPISTOLAS_GERAIS, total_chapters: 3 },
  { abbrev: '1jo', name: '1 João', testament: 'NT', category: CATEGORY.EPISTOLAS_GERAIS, total_chapters: 5 },
  { abbrev: '2jo', name: '2 João', testament: 'NT', category: CATEGORY.EPISTOLAS_GERAIS, total_chapters: 1 },
  { abbrev: '3jo', name: '3 João', testament: 'NT', category: CATEGORY.EPISTOLAS_GERAIS, total_chapters: 1 },
  { abbrev: 'jd', name: 'Judas', testament: 'NT', category: CATEGORY.EPISTOLAS_GERAIS, total_chapters: 1 },

  { abbrev: 'ap', name: 'Apocalipse', testament: 'NT', category: CATEGORY.APOCALIPSE, total_chapters: 22 },
];

/** Totais esperados (validação de integridade do catálogo). */
export const CATALOG_TOTALS = {
  books: 66,
  oldTestamentBooks: 39,
  oldTestamentChapters: 929,
  newTestamentBooks: 27,
  newTestamentChapters: 260,
  totalChapters: 1189,
} as const;

/**
 * Valida a consistência do catálogo (quantidade de livros e de capítulos).
 * Útil em testes e como checagem de desenvolvimento.
 */
export function validateCatalog(): { ok: boolean; issues: string[] } {
  const issues: string[] = [];

  if (BOOKS_CATALOG.length !== CATALOG_TOTALS.books) {
    issues.push(`Esperado ${CATALOG_TOTALS.books} livros, encontrado ${BOOKS_CATALOG.length}.`);
  }

  const atBooks = BOOKS_CATALOG.filter((b) => b.testament === 'AT');
  const ntBooks = BOOKS_CATALOG.filter((b) => b.testament === 'NT');
  const atChapters = atBooks.reduce((sum, b) => sum + b.total_chapters, 0);
  const ntChapters = ntBooks.reduce((sum, b) => sum + b.total_chapters, 0);

  if (atBooks.length !== CATALOG_TOTALS.oldTestamentBooks) {
    issues.push(`AT: esperado ${CATALOG_TOTALS.oldTestamentBooks} livros, encontrado ${atBooks.length}.`);
  }
  if (ntBooks.length !== CATALOG_TOTALS.newTestamentBooks) {
    issues.push(`NT: esperado ${CATALOG_TOTALS.newTestamentBooks} livros, encontrado ${ntBooks.length}.`);
  }
  if (atChapters !== CATALOG_TOTALS.oldTestamentChapters) {
    issues.push(`AT: esperado ${CATALOG_TOTALS.oldTestamentChapters} capítulos, encontrado ${atChapters}.`);
  }
  if (ntChapters !== CATALOG_TOTALS.newTestamentChapters) {
    issues.push(`NT: esperado ${CATALOG_TOTALS.newTestamentChapters} capítulos, encontrado ${ntChapters}.`);
  }

  // Checa abreviaturas duplicadas.
  const seen = new Set<string>();
  for (const b of BOOKS_CATALOG) {
    if (seen.has(b.abbrev)) {
      issues.push(`Abbrev duplicado: "${b.abbrev}".`);
    }
    seen.add(b.abbrev);
  }

  return { ok: issues.length === 0, issues };
}
