/**
 * Feature "Bíblia" — conteúdo textual e importação sob demanda (Fase 1).
 * A UI real de navegação/leitura virá na Fase 2.
 */

export { TRANSLATIONS, getBibleBaseUrl, getTranslationUrl, getTranslationBySlug } from './catalog';
export type { TranslationCatalogEntry } from './catalog';

export { downloadBibleJson } from './download';

export {
  importTranslation,
  rebuildFtsIndex,
  getImportedTranslations,
  getTranslationVerseCount,
  IMPORT_CONSTANTS,
} from './importer';

export { searchVerses } from './search';
export type { SearchResult } from './search';

export { getChapterVerses } from './reader';
export type { Verse } from './reader';

export { useReadingDwell } from './useReadingDwell';

export type {
  BibleBookJson,
  BibleJson,
  TranslationStatus,
  ImportProgress,
  ImportResult,
} from './types';
