import AsyncStorage from '@react-native-async-storage/async-storage';
import { useLocalSearchParams, useRouter } from 'expo-router';
import { useEffect, useRef, useState, type ComponentRef, type ReactNode } from 'react';
import { ActivityIndicator, FlatList, Pressable, ScrollView, StyleSheet, Text, TextInput, View } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Icon } from '../../components/Icon';
import { colors } from '../../theme/colors';
import { useCatalog } from './CatalogProvider';
import { byComposer, creditLabel, fetchLyrics, normalizeSearch, UNKNOWN_COMPOSER, type Composer } from './catalog';

function first(value: string | string[] | undefined) { return Array.isArray(value) ? value[0] : value; }
function Frame({ title, subtitle, children }: { title: string; subtitle?: string; children: ReactNode }) {
  const router = useRouter();
  return <SafeAreaView style={styles.screen}>
    <View style={styles.header}>
      <Pressable accessibilityRole="button" accessibilityLabel="Voltar" style={styles.iconButton} onPress={() => router.canGoBack() ? router.back() : router.replace('/')}><Icon name="arrow-left" size={20} color={colors.text} /></Pressable>
      <View style={styles.flex}><Text style={styles.title}>{title}</Text>{subtitle && <Text style={styles.muted}>{subtitle}</Text>}</View>
      <Icon name="music" size={22} color={colors.gold} />
    </View>
    {children}
  </SafeAreaView>;
}
function Notice({ title, text, retry }: { title: string; text: string; retry?: () => void }) {
  return <View style={styles.notice}><Icon name="book-open" size={32} color={colors.gold} /><Text style={styles.cardTitle}>{title}</Text><Text style={styles.noticeText}>{text}</Text>{retry && <Pressable accessibilityRole="button" onPress={retry} style={styles.button}><Text style={styles.buttonText}>Tentar novamente</Text></Pressable>}</View>;
}
function Status({ children }: { children: ReactNode }) {
  const { loading, error, reload, entries } = useCatalog();
  if (loading) return <View style={styles.notice}><ActivityIndicator color={colors.accent} /><Text style={styles.muted}>Carregando hinários…</Text></View>;
  if (error) return <Notice title="Não foi possível carregar" text="Verifique sua conexão e tente novamente." retry={reload} />;
  if (!entries.length) return <Notice title="Hinários em preparação" text="Estamos preparando as letras dos nossos hinários. Assim que estiverem disponíveis, você poderá encontrá-las aqui." retry={reload} />;
  return <>{children}</>;
}
function Search({ value, onChange, placeholder }: { value: string; onChange: (value: string) => void; placeholder: string }) {
  return <View style={styles.search}><Icon name="magnifying-glass" color={colors.muted} /><TextInput accessibilityLabel={placeholder} value={value} onChangeText={onChange} placeholder={placeholder} placeholderTextColor={colors.muted} style={styles.input} autoCapitalize="none" autoCorrect={false} />{value.length > 0 && <Pressable accessibilityRole="button" accessibilityLabel="Limpar pesquisa" style={styles.clear} onPress={() => onChange('')}><Icon name="xmark" color={colors.muted} /></Pressable>}</View>;
}

export function ComposersScreen() {
  const router = useRouter();
  const { entries, reload } = useCatalog();
  const [query, setQuery] = useState('');
  const composers = new Map<string, Composer>();
  for (const entry of entries) for (const credit of entry.hymns.hymn_credits) {
    if (credit.hymn_composers) composers.set(credit.hymn_composers.id, credit.hymn_composers);
  }
  const choices = [...composers.values()].sort((a, b) => a.name.localeCompare(b.name, 'pt-BR'));
  if (byComposer(entries, UNKNOWN_COMPOSER).length) choices.push({ id: UNKNOWN_COMPOSER, name: 'Autoria não confirmada' });
  const filtered = choices.filter((composer) => normalizeSearch(composer.name).includes(normalizeSearch(query)));
  return <Frame title="Hinários" subtitle="Louvores para acompanhar sua caminhada">
    <Status><FlatList data={filtered} keyExtractor={(item) => item.id} numColumns={2} columnWrapperStyle={styles.grid} contentContainerStyle={styles.content} onRefresh={reload} refreshing={false}
      ListHeaderComponent={<View style={styles.section}>
        <View style={styles.hero}><View style={styles.emblem}><Icon name="music" size={30} color={colors.gold} /></View><Text style={styles.heroTitle}>Cantai ao Senhor</Text><Text style={styles.muted}>Encontre os hinos por compositor ou explore os hinários.</Text></View>
        <Pressable accessibilityRole="button" style={styles.cardRow} onPress={() => router.push('/hinarios/colecoes')}><Icon name="book-open" size={23} /><View style={styles.flex}><Text style={styles.cardTitle}>Todos os hinários</Text><Text style={styles.muted}>Explorar o catálogo</Text></View><Icon name="chevron-right" /></Pressable>
        <Text style={styles.sectionTitle}>Por compositor</Text><Search value={query} onChange={setQuery} placeholder="Pesquisar compositor" />
      </View>}
      ListEmptyComponent={<Notice title="Nenhum resultado" text="Tente pesquisar outro nome." />}
      renderItem={({ item }) => <Pressable accessibilityRole="button" style={styles.gridCard} onPress={() => router.push({ pathname: '/hinarios/colecoes', params: { composer: item.id } })}>
        <View style={styles.emblem}><Icon name={item.id === UNKNOWN_COMPOSER ? 'music' : 'user'} size={24} color={colors.gold} /></View><Text style={styles.cardTitle}>{item.name}</Text><Text style={styles.muted}>{new Set(byComposer(entries, item.id).map((entry) => entry.hymn_id)).size} hinos</Text>
      </Pressable>} />
    </Status>
  </Frame>;
}

export function CollectionsScreen() {
  const params = useLocalSearchParams<{ composer?: string }>();
  const composer = first(params.composer);
  const { entries, reload } = useCatalog();
  const router = useRouter();
  const filtered = byComposer(entries, composer);
  const collections = [...new Map(filtered.map((entry) => [entry.hymnal_id, entry.hymnals])).values()];
  const name = composer === UNKNOWN_COMPOSER ? 'Autoria não confirmada' : filtered.flatMap((entry) => entry.hymns.hymn_credits).find((credit) => credit.hymn_composers?.id === composer)?.hymn_composers?.name;
  return <Frame title="Nossos hinários" subtitle={name ?? 'Escolha uma edição'}><Status>
    <FlatList data={collections} keyExtractor={(item) => item.id} contentContainerStyle={styles.content} onRefresh={reload} refreshing={false}
      ListEmptyComponent={<Notice title="Nenhum hinário disponível" text="Ainda não há hinos publicados para esta seleção." />}
      renderItem={({ item }) => <Pressable accessibilityRole="button" style={styles.collectionCard} onPress={() => router.push({ pathname: '/hinarios/[id]', params: { id: item.id, ...(composer ? { composer } : {}) } })}>
        <View style={styles.cover}><Icon name="book-open" size={44} color={colors.gold} /><Text style={styles.coverTitle}>{item.title}</Text><Text style={styles.coverEdition}>{item.edition}</Text></View>
        <View style={styles.cardBody}><Text style={styles.cardTitle}>{item.title}</Text>{item.credited_name && <Text style={styles.muted}>Crédito da edição: {item.credited_name}</Text>}<View style={styles.row}><Text style={styles.muted}>{filtered.filter((entry) => entry.hymnal_id === item.id).length} hinos disponíveis</Text><Icon name="arrow-right" /></View></View>
      </Pressable>} />
  </Status></Frame>;
}

export function HymnListScreen() {
  const params = useLocalSearchParams<{ id: string; composer?: string }>();
  const id = first(params.id);
  const composer = first(params.composer);
  const { entries, reload } = useCatalog();
  const router = useRouter();
  const [query, setQuery] = useState('');
  const selected = byComposer(entries, composer).filter((entry) => entry.hymnal_id === id).sort((a, b) => a.number - b.number);
  const normalized = normalizeSearch(query);
  const filtered = selected.filter((entry) => normalizeSearch(entry.hymns.title).includes(normalized) || String(entry.number) === normalized.replace(/^0+/, ''));
  return <Frame title={selected[0]?.hymnals.title ?? 'Hinos'} subtitle={selected[0]?.hymnals.edition}><Status>
    <FlatList data={filtered} keyExtractor={(item) => item.hymn_id} contentContainerStyle={styles.content} onRefresh={reload} refreshing={false} keyboardShouldPersistTaps="handled"
      ListHeaderComponent={<View style={styles.section}><Text style={styles.muted}>{selected.length} hinos disponíveis</Text><Search value={query} onChange={setQuery} placeholder="Pesquisar número ou título" /></View>}
      ListEmptyComponent={<Notice title={query ? 'Nenhum resultado' : 'Nenhum hino disponível'} text={query ? 'Tente outro número ou título.' : 'As letras desta seleção ainda não estão disponíveis.'} />}
      renderItem={({ item }) => <Pressable accessibilityRole="button" style={styles.cardRow} onPress={() => router.push({ pathname: '/hinarios/[id]/[hymn]', params: { id: item.hymnal_id, hymn: item.hymn_id, ...(composer ? { composer } : {}) } })}>
        <View style={styles.number}><Text style={styles.numberText}>{String(item.number).padStart(2, '0')}</Text></View><View style={styles.flex}><Text style={styles.cardTitle}>{item.hymns.title}</Text><Text style={styles.muted}>{creditLabel(item)}</Text></View><Icon name="chevron-right" />
      </Pressable>} />
  </Status></Frame>;
}

export function HymnReaderScreen() {
  const params = useLocalSearchParams<{ id: string; hymn: string; composer?: string }>();
  const id = first(params.id);
  const hymn = first(params.hymn);
  const composer = first(params.composer);
  const router = useRouter();
  const { entries } = useCatalog();
  const selected = byComposer(entries, composer).filter((entry) => entry.hymnal_id === id).sort((a, b) => a.number - b.number);
  const index = selected.findIndex((entry) => entry.hymn_id === hymn);
  const entry = selected[index];
  const [request, setRequest] = useState(0);
  const hymnId = entry?.hymn_id;
  const key = `${hymnId ?? ''}:${request}`;
  const [result, setResult] = useState<{ key: string; lyrics: string | null; error: boolean } | null>(null);
  const loading = !!hymnId && result?.key !== key;
  const error = result?.key === key && result.error;
  const lyrics = result?.key === key ? result.lyrics : null;
  const [fontSize, setFontSize] = useState(20);
  const scroll = useRef<ComponentRef<typeof ScrollView>>(null);
  const fontChanged = useRef(false);
  useEffect(() => {
    void AsyncStorage.getItem('hymnals:font-size').then((saved) => {
      const size = Number(saved);
      if (!fontChanged.current && saved && Number.isFinite(size)) setFontSize(Math.min(32, Math.max(16, size)));
    }).catch(() => {});
  }, []);
  useEffect(() => {
    let active = true;
    scroll.current?.scrollTo({ y: 0, animated: false });
    if (!hymnId) return;
    void fetchLyrics(hymnId).then((lyrics) => { if (active) setResult({ key, lyrics, error: false }); })
      .catch(() => { if (active) setResult({ key, lyrics: null, error: true }); });
    return () => { active = false; };
  }, [hymnId, key]);
  function resize(delta: number) {
    fontChanged.current = true;
    const size = Math.min(32, Math.max(16, fontSize + delta));
    setFontSize(size);
    void AsyncStorage.setItem('hymnals:font-size', String(size)).catch(() => {});
  }
  function navigate(position: number) {
    const target = selected[position];
    if (target) router.replace({ pathname: '/hinarios/[id]/[hymn]', params: { id: target.hymnal_id, hymn: target.hymn_id, ...(composer ? { composer } : {}) } });
  }
  return <Frame title={entry ? `Hino ${entry.number}` : 'Leitura do hino'} subtitle={entry?.hymnals.title}><Status>
    {!entry ? <Notice title="Hino não disponível" text="Esta letra pode ter sido retirada do catálogo. Volte e escolha outro hino." /> : <>
      <View style={styles.tools}><Text style={styles.muted}>Tamanho da letra</Text><View style={styles.row}>
        <Pressable accessibilityRole="button" accessibilityLabel="Diminuir letra" disabled={fontSize <= 16} onPress={() => resize(-2)} style={[styles.iconButton, fontSize <= 16 && styles.disabled]}><Text style={styles.fontControl}>A−</Text></Pressable>
        <Pressable accessibilityRole="button" accessibilityLabel="Aumentar letra" disabled={fontSize >= 32} onPress={() => resize(2)} style={[styles.iconButton, fontSize >= 32 && styles.disabled]}><Text style={styles.fontControl}>A+</Text></Pressable>
      </View></View>
      <ScrollView ref={scroll} contentContainerStyle={styles.reader}>
        <Text style={styles.eyebrow}>HINO {String(entry.number).padStart(2, '0')}</Text><Text style={styles.lyricTitle}>{entry.hymns.title}</Text><Text style={styles.muted}>{creditLabel(entry)}</Text>
        {loading ? <ActivityIndicator color={colors.accent} style={styles.lyricLoading} /> : error ? <Notice title="Não foi possível carregar a letra" text="Verifique sua conexão e tente novamente." retry={() => setRequest((value) => value + 1)} /> : lyrics ? <Text selectable style={[styles.lyrics, { fontSize, lineHeight: fontSize * 1.6 }]}>{lyrics}</Text> : <Notice title="Letra não disponível" text="Volte ao catálogo e tente novamente." />}
        <Text style={styles.source}>{entry.hymnals.title} • {entry.hymnals.edition}</Text>
      </ScrollView>
      <View style={styles.navigation}>
        <Pressable accessibilityRole="button" accessibilityLabel="Hino anterior" disabled={index <= 0} onPress={() => navigate(index - 1)} style={[styles.navButton, index <= 0 && styles.disabled]}><Icon name="arrow-left" /><Text style={styles.buttonText}>Anterior</Text></Pressable>
        <Text style={styles.muted}>{index + 1} de {selected.length}</Text>
        <Pressable accessibilityRole="button" accessibilityLabel="Próximo hino" disabled={index >= selected.length - 1} onPress={() => navigate(index + 1)} style={[styles.navButton, index >= selected.length - 1 && styles.disabled]}><Text style={styles.buttonText}>Próximo</Text><Icon name="arrow-right" /></Pressable>
      </View>
    </>}
  </Status></Frame>;
}

const styles = StyleSheet.create({
  screen: { flex: 1, backgroundColor: colors.background },
  header: { flexDirection: 'row', alignItems: 'center', gap: 12, padding: 16, borderBottomWidth: 1, borderBottomColor: colors.border },
  flex: { flex: 1, gap: 5 }, title: { color: colors.text, fontSize: 22, fontWeight: '700' },
  muted: { color: colors.muted, fontSize: 13, lineHeight: 19 },
  content: { padding: 20, gap: 12, paddingBottom: 32, flexGrow: 1 },
  section: { gap: 16, marginBottom: 8 }, sectionTitle: { color: colors.text, fontSize: 18, fontWeight: '700' },
  hero: { padding: 22, borderRadius: 24, backgroundColor: colors.inset, borderWidth: 1, borderColor: colors.border, gap: 12 },
  heroTitle: { fontSize: 25, color: colors.text, fontWeight: '700' },
  emblem: { width: 56, height: 56, borderRadius: 18, backgroundColor: '#383022', alignItems: 'center', justifyContent: 'center' },
  grid: { gap: 12 }, gridCard: { flex: 1, maxWidth: '50%', padding: 16, borderRadius: 20, borderWidth: 1, borderColor: colors.border, backgroundColor: colors.surface, gap: 12 },
  cardTitle: { color: colors.text, fontSize: 16, fontWeight: '700', lineHeight: 23 },
  cardRow: { flexDirection: 'row', alignItems: 'center', gap: 12, padding: 16, borderRadius: 20, borderWidth: 1, borderColor: colors.border, backgroundColor: colors.surface },
  search: { flexDirection: 'row', alignItems: 'center', gap: 12, borderRadius: 16, paddingHorizontal: 14, minHeight: 50, backgroundColor: colors.surface, borderWidth: 1, borderColor: colors.border },
  input: { flex: 1, color: colors.text, fontSize: 15, paddingVertical: 14 }, clear: { padding: 10 },
  notice: { padding: 28, gap: 16, alignItems: 'center', justifyContent: 'center' },
  noticeText: { color: colors.muted, textAlign: 'center', lineHeight: 23 },
  button: { backgroundColor: colors.primary, borderRadius: 14, padding: 14 }, buttonText: { color: colors.text, fontSize: 14, fontWeight: '600' },
  collectionCard: { overflow: 'hidden', borderRadius: 24, borderWidth: 1, borderColor: colors.border, backgroundColor: colors.surface },
  cover: { backgroundColor: '#23372c', minHeight: 200, padding: 24, gap: 18, justifyContent: 'center' },
  coverTitle: { color: colors.text, fontSize: 28, fontWeight: '700' }, coverEdition: { color: colors.accent, fontSize: 14 },
  cardBody: { padding: 18, gap: 12 }, row: { flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', gap: 8 },
  number: { minWidth: 46, minHeight: 46, borderRadius: 14, alignItems: 'center', justifyContent: 'center', backgroundColor: '#23372c', padding: 6 },
  numberText: { color: colors.accent, fontWeight: '700', fontSize: 17 },
  iconButton: { minWidth: 44, minHeight: 44, alignItems: 'center', justifyContent: 'center', backgroundColor: colors.surface, borderRadius: 22 },
  tools: { flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', paddingHorizontal: 20, paddingVertical: 10 }, fontControl: { color: colors.text, fontSize: 19, fontWeight: '600' },
  reader: { padding: 24, paddingBottom: 48, gap: 14 }, eyebrow: { color: colors.gold, fontSize: 12, fontWeight: '700', letterSpacing: 2 },
  lyricTitle: { color: colors.text, fontSize: 27, fontWeight: '700', lineHeight: 35 }, lyrics: { color: colors.text, marginTop: 20 },
  lyricLoading: { marginVertical: 40 }, source: { color: colors.muted, fontSize: 12, marginTop: 30, lineHeight: 18 },
  navigation: { padding: 12, borderTopWidth: 1, borderTopColor: colors.border, flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', gap: 8, flexWrap: 'wrap' },
  navButton: { flexDirection: 'row', alignItems: 'center', justifyContent: 'center', padding: 12, gap: 8, borderRadius: 14, backgroundColor: colors.surface }, disabled: { opacity: 0.35 },
});
