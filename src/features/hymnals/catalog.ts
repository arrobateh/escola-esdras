import { supabase } from '../../lib/supabase';

export interface Composer { id: string; name: string }
export interface Credit { role: string; hymn_composers: Composer | null }
export interface Hymnal { id: string; title: string; edition: string; credited_name: string | null }
export interface CatalogEntry {
  hymnal_id: string;
  hymn_id: string;
  number: number;
  hymnals: Hymnal;
  hymns: { id: string; title: string; hymn_credits: Credit[] };
}
export const UNKNOWN_COMPOSER = 'unknown';
export function normalizeSearch(value: string) {
  return value.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLocaleLowerCase('pt-BR').trim();
}
export function byComposer(entries: CatalogEntry[], composer?: string) {
  if (!composer) return entries;
  return entries.filter(({ hymns }) => composer === UNKNOWN_COMPOSER
    ? !hymns.hymn_credits.some((credit) => credit.hymn_composers)
    : hymns.hymn_credits.some((credit) => credit.hymn_composers?.id === composer));
}
export function creditLabel(entry: CatalogEntry) {
  const names = [...new Set(entry.hymns.hymn_credits.flatMap((credit) => credit.hymn_composers ? [credit.hymn_composers.name] : []))];
  return names.length ? names.join(' • ') : 'Autoria não confirmada';
}

/** Metadata only: lyrics are fetched when the reader opens. Explicit publication
 * filters also apply to administrators, whose RLS permits access to drafts. */
export async function fetchCatalog(): Promise<CatalogEntry[]> {
  if (!supabase) throw new Error('Catálogo indisponível');
  const entries: CatalogEntry[] = [];
  for (let offset = 0; ; offset += 500) {
    const { data, error } = await supabase.from('hymnal_hymns').select(
      'hymnal_id,hymn_id,number,hymnals!inner(id,title,edition,credited_name,published),hymns!inner(id,title,review_status,hymn_credits(role,hymn_composers(id,name)))'
    ).eq('hymnals.published', true).eq('hymns.review_status', 'published')
      .order('hymnal_id').order('number').range(offset, offset + 499);
    if (error) throw error;
    const page = data as unknown as CatalogEntry[];
    entries.push(...page);
    if (page.length < 500) break;
  }
  return entries;
}

export async function fetchLyrics(id: string): Promise<string | null> {
  if (!supabase) throw new Error('Letra indisponível');
  const { data, error } = await supabase.from('hymns').select('lyrics')
    .eq('id', id).eq('review_status', 'published').maybeSingle();
  if (error) throw error;
  return (data as { lyrics: string | null } | null)?.lyrics ?? null;
}
