/**
 * Catálogo de traduções bíblicas disponíveis para download sob demanda.
 */

export interface TranslationCatalogEntry {
  /** Slug usado no nome do arquivo (ex.: "pt_arc"). */
  slug: string;
  /** Nome de exibição da tradução. */
  label: string;
}

export const TRANSLATIONS: readonly TranslationCatalogEntry[] = [
  { slug: 'pt_arc', label: 'Almeida Revista e Corrigida' },
  { slug: 'pt_ara', label: 'Almeida Revista e Atualizada' },
  { slug: 'pt_naa', label: 'Nova Almeida Atualizada' },
  { slug: 'pt_nvi', label: 'Nova Versão Internacional' },
];

/**
 * Base URL dos arquivos JSON. Pode ser sobrescrita via variável de ambiente
 * `EXPO_PUBLIC_BIBLE_BASE_URL` (útil para apontar para um mirror/cache próprio).
 */
const DEFAULT_BIBLE_BASE_URL = 'https://raw.githubusercontent.com/thiagobodruk/bible/master/json/';

export function getBibleBaseUrl(): string {
  const fromEnv = process.env.EXPO_PUBLIC_BIBLE_BASE_URL;
  return (fromEnv && fromEnv.trim().length > 0 ? fromEnv.trim() : DEFAULT_BIBLE_BASE_URL);
}

/** Garante que a base termina com "/". */
function normalizeBaseUrl(base: string): string {
  return base.endsWith('/') ? base : `${base}/`;
}

/** URL final de download de uma tradução a partir do slug. */
export function getTranslationUrl(slug: string, baseUrl?: string): string {
  const base = normalizeBaseUrl(baseUrl ?? getBibleBaseUrl());
  return `${base}${slug}.json`;
}

export function getTranslationBySlug(slug: string): TranslationCatalogEntry | undefined {
  return TRANSLATIONS.find((t) => t.slug === slug);
}
