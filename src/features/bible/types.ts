/**
 * Tipos do dataset JSON de traduções bíblicas (repositório `thiagobodruk/bible`).
 */

/** Um livro bíblico conforme aparece no JSON de tradução. */
export interface BibleBookJson {
  /** Slug canônico em minúsculas (ex.: "gn", "1co"). */
  abbrev: string;
  /** Nome do livro em português. */
  name: string;
  /** Capítulos; cada capítulo é um array de versículos (1-indexado). */
  chapters: string[][];
}

/** Uma tradução completa (array de livros). */
export type BibleJson = BibleBookJson[];

/** Estado de disponibilidade de uma tradução na UI. */
export type TranslationStatus = 'not-downloaded' | 'downloading' | 'importing' | 'ready' | 'error';

/** Progresso normalizado de um download/importação (0..1). */
export interface ImportProgress {
  /** Fase atual do fluxo. */
  phase: 'download' | 'import' | 'fts';
  /** Versículos processados (fase de importação). */
  processed: number;
  /** Total de versículos (fase de importação) ou bytes (fase de download). */
  total: number;
  /** Fração concluída (0..1). */
  ratio: number;
}

/** Resultado consolidado de uma importação. */
export interface ImportResult {
  translation: string;
  versesImported: number;
  booksImported: number;
  ftsRebuilt: boolean;
}
