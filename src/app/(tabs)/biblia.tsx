import { Icon } from '../../components/Icon';
import { planCalendar } from '../../features/plans/calendar';
import { useFocusEffect, useLocalSearchParams } from 'expo-router';
import { useCallback, useEffect, useRef, useState, type ComponentRef } from 'react';
import {
  ActivityIndicator,
  FlatList,
  Modal,
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  TextInput,
  Platform,
  View,
} from 'react-native';

import { SafeAreaView } from 'react-native-safe-area-context';
import { BOOKS_CATALOG, type Testament } from '../../db/books-catalog';
import {
  searchVerses,
  type SearchResult,
  getChapterVerses,
  getImportedTranslations,
  getTranslationBySlug,
  getTranslationUrl,
  getTranslationVerseCount,
  downloadBibleJson,
  importTranslation,
  TRANSLATIONS,
  type ImportProgress,
  type TranslationStatus,
  type Verse,
} from '../../features/bible';
import { useAuth } from '../../features/auth';
import { fetchPlans, fetchUserPlanProgress, setPlanDayStatus } from '../../features/plans';
import {
  useDatabase,
} from '../../db';

const MIN_FONT_SIZE = 14;
const MAX_FONT_SIZE = 24;
const FONT_STEP = 2;

interface TranslationState {
  status: TranslationStatus;
  progress: ImportProgress | null;
  verseCount: number | null;
  error: string | null;
}

const INITIAL_STATE: TranslationState = {
  status: 'not-downloaded',
  progress: null,
  verseCount: null,
  error: null,
};

export default function BibleScreen() {
  const params = useLocalSearchParams<{ book?: string; chapter?: string; translation?: string; request?: string }>();
  const db = useDatabase();
  const { user } = useAuth();
  const userId = user?.id ?? '';

  const [translationSlug, setTranslationSlug] = useState<string>(TRANSLATIONS[0].slug);
  const [bookAbbrev, setBookAbbrev] = useState<string>('gn');
  const [chapter, setChapter] = useState<number>(1);
  const [fontSize, setFontSize] = useState<number>(18);
  const [verses, setVerses] = useState<Verse[]>([]);
  const [loadingVerses, setLoadingVerses] = useState(false);
  const [states, setStates] = useState<Record<string, TranslationState>>({});
  const readerRef = useRef<ComponentRef<typeof ScrollView>>(null);
  const [tools, setTools] = useState<'translation' | 'font' | 'search' | null>(null);
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<SearchResult[]>([]);
  const [searching, setSearching] = useState(false);
  const [searchError, setSearchError] = useState<string | null>(null);
  const [hasSearched, setHasSearched] = useState(false);
  const [challengeCompleted, setChallengeCompleted] = useState(false);
  const [challengeVisible, setChallengeVisible] = useState(false);
  const [challengeBusy, setChallengeBusy] = useState(false);
  const [challengeError, setChallengeError] = useState<string | null>(null);
  const [challengeSuccess, setChallengeSuccess] = useState<string | null>(null);
  const [challenges, setChallenges] = useState<{ planId: string; title: string; day: number; references: string; doneToday: boolean }[]>([]);
  const [pickerVisible, setPickerVisible] = useState(false);
  const [pickerStep, setPickerStep] = useState<'book' | 'chapter'>('book');

  const requestKey = JSON.stringify([params.book, params.chapter, params.translation, params.request]);
  const [appliedRequest, setAppliedRequest] = useState<string | null>(null);
  // Ajusta a seleção apenas quando chega uma nova solicitação de navegação.
  if (appliedRequest !== requestKey) {
    setAppliedRequest(requestKey);
    const requestedBook = BOOKS_CATALOG.find((book) => book.abbrev === params.book);
    const requestedChapter = Number(params.chapter);
    if (requestedBook && Number.isInteger(requestedChapter) && requestedChapter >= 1 && requestedChapter <= requestedBook.total_chapters) {
      setBookAbbrev(requestedBook.abbrev);
      setChapter(requestedChapter);
    }
    if (TRANSLATIONS.some((translation) => translation.slug === params.translation)) {
      setTranslationSlug(params.translation!);
    }
  }

  const currentBook = BOOKS_CATALOG.find((b) => b.abbrev === bookAbbrev)!;

  const chapterKey = `${userId}:${translationSlug}:${bookAbbrev}:${chapter}`;

  // Carrega estado das traduções ao focar a tela.
  useFocusEffect(
    useCallback(() => {
      let cancelled = false;
      async function load() {
        const imported = await getImportedTranslations(db);
        const next: Record<string, TranslationState> = {};
        for (const slug of imported) {
          const count = await getTranslationVerseCount(db, slug);
          next[slug] = { status: 'ready', verseCount: count, progress: null, error: null };
        }
        if (!cancelled) setStates(next);
      }
      load();
      return () => {
        cancelled = true;
      };
    }, [db])
  );

  // Carrega os versículos quando livro, capítulo ou tradução mudam.
  useEffect(() => {
    let cancelled = false;
    async function load() {
      if (!userId) return;
      setLoadingVerses(true);
      const rows = await getChapterVerses(db, translationSlug, bookAbbrev, chapter);
      if (!cancelled) {
        readerRef.current?.scrollTo({ y: 0, animated: false });
        setVerses(rows);
        setLoadingVerses(false);
      }
    }
    load();
    return () => {
      cancelled = true;
    };
  }, [db, translationSlug, bookAbbrev, chapter, userId]);

  const updateState = useCallback((slug: string, patch: Partial<TranslationState>) => {
    setStates((prev) => ({
      ...prev,
      [slug]: { ...(prev[slug] ?? INITIAL_STATE), ...patch },
    }));
  }, []);

  const busy = Object.values(states).some(
    (s) => s.status === 'downloading' || s.status === 'importing'
  );

  async function handleDownload(slug: string) {
    if (busy) return;
    updateState(slug, { status: 'downloading', error: null, progress: null });

    try {
      const url = getTranslationUrl(slug);
      const bibleJson = await downloadBibleJson(url, (received, total) => {
        updateState(slug, {
          progress: {
            phase: 'download',
            processed: received,
            total,
            ratio: total > 0 ? received / total : 0,
          },
        });
      });

      updateState(slug, { status: 'importing' });

      const result = await importTranslation(db, slug, bibleJson, (progress) => {
        updateState(slug, { progress });
      });

      updateState(slug, {
        status: 'ready',
        verseCount: result.versesImported,
        progress: null,
        error: null,
      });
    } catch (err) {
      const message = err instanceof Error ? err.message : String(err);
      updateState(slug, { status: 'error', error: message, progress: null });
    }
  }

  useFocusEffect(useCallback(() => {
    let active = true;
    async function refreshChallengeStatus() {
      if (!userId) return;
      try {
        const plans = await fetchPlans();
        const progress = await Promise.all(plans.map((plan) => fetchUserPlanProgress(plan.id, userId)));
        const completed = plans.some((plan, index) => {
          const scheduled = planCalendar(plan.start_date, plan.duration_days).day;
          return scheduled !== null && progress[index].some((day) => day.day_number === scheduled && day.status === 'COMPLETED');
        });
        if (active) setChallengeCompleted(completed);
      } catch {
        // Sem confirmação remota, não afirmar que o desafio está concluído.
        if (active) setChallengeCompleted(false);
      }
    }
    void refreshChallengeStatus();
    return () => { active = false; };
  }, [userId]));

  async function runSearch() {
    if (searching || !query.trim()) return;
    setSearching(true);
    setSearchError(null);
    setHasSearched(true);
    try { setResults(await searchVerses(db, `"${query.trim().replace(/"/g, '""')}"`)); }
    catch { setResults([]); setSearchError('Não foi possível pesquisar. Tente novamente.'); }
    finally { setSearching(false); }
  }

  async function openChallenge() {
    if (!userId || challengeBusy) return;
    setChallengeVisible(true);
    setChallengeBusy(true);
    setChallengeError(null);
    setChallengeSuccess(null);
    setChallenges([]);
    try {
      const plans = await fetchPlans();
      const options = await Promise.all(plans.map(async (plan) => {
        const progress = await fetchUserPlanProgress(plan.id, userId);
        const day = planCalendar(plan.start_date, plan.duration_days).day;
        if (!day) return null;
        const contents = plan.contents.filter((content) => content.day_number === day).sort((a, b) => a.sort_order - b.sort_order);
        if (!contents.length) return null;
        const references = contents.map((content) => {
          const name = BOOKS_CATALOG.find((book) => book.abbrev === content.book_abbrev)?.name ?? content.book_abbrev;
          return `${name} ${content.chapter}${content.start_verse ? `:${content.start_verse}–${content.end_verse ?? ''}` : ''}`;
        }).join(' • ');
        return { planId: plan.id, title: plan.title, day, references, doneToday: progress.some((entry) => entry.day_number === day && entry.status === 'COMPLETED') };
      }));
      setChallenges(options.filter((option): option is NonNullable<typeof option> => option !== null));
      setChallengeCompleted(options.some((option) => option?.doneToday));
    } catch (error) {
      setChallengeError(error instanceof Error ? error.message : 'Não foi possível carregar o desafio.');
    } finally { setChallengeBusy(false); }
  }

  async function completeChallenge(planId: string, day: number, undo = false) {
    if (!userId || challengeBusy) return;
    setChallengeBusy(true);
    setChallengeError(null);
    setChallengeSuccess(null);
    try {
      const plan = (await fetchPlans()).find((entry) => entry.id === planId);
      if (!plan || planCalendar(plan.start_date, plan.duration_days).day !== day) throw new Error('O calendário mudou. Feche e abra o desafio para atualizar.');
      await setPlanDayStatus(planId, userId, day, undo ? 'PENDING' : 'COMPLETED');
      setChallenges((options) => options.map((option) => option.planId === planId ? { ...option, doneToday: !undo } : option));
      setChallengeCompleted(!undo || challenges.some((option) => option.planId !== planId && option.doneToday));
      setChallengeSuccess(undo ? 'Conclusão desfeita. O desafio está pendente novamente.' : '✓ Desafio concluído! O objetivo do plano foi registrado.');
    } catch (error) {
      setChallengeError(error instanceof Error ? error.message : 'Não foi possível atualizar o desafio.');
    } finally { setChallengeBusy(false); }
  }

  function previousChapter() {
    if (chapter > 1) {
      setChapter(chapter - 1);
    }
  }

  function nextChapter() {
    if (chapter < currentBook.total_chapters) {
      setChapter(chapter + 1);
    }
  }

  function increaseFont() {
    setFontSize((s) => Math.min(s + FONT_STEP, MAX_FONT_SIZE));
  }

  function decreaseFont() {
    setFontSize((s) => Math.max(s - FONT_STEP, MIN_FONT_SIZE));
  }

  function openBookPicker() {
    setPickerStep('book');
    setPickerVisible(true);
  }

  function selectBook(abbrev: string) {
    setBookAbbrev(abbrev);
    setChapter(1);
    setPickerStep('chapter');
  }

  function selectChapter(ch: number) {
    setChapter(ch);
    setPickerVisible(false);
    setPickerStep('book');
  }

  function closePicker() {
    setPickerVisible(false);
    setPickerStep('book');
  }

  const translationState = states[translationSlug] ?? INITIAL_STATE;
  const translationReady = translationState.status === 'ready';


  return (
    <SafeAreaView style={styles.container} edges={['top', 'left', 'right']}>
      {/* Topo */}
      <View style={styles.header}>
        <View style={styles.topControls}>
          <View style={styles.headerSelectors}>
          <Pressable accessibilityRole="button" accessibilityLabel={`Escolher livro e capítulo, ${currentBook.name} ${chapter}`} style={styles.referenceButton} onPress={openBookPicker}>
            <Icon name="book-bookmark" size={12} /><Text numberOfLines={1} ellipsizeMode="tail" style={styles.bookLabel}>{currentBook.name} {chapter}</Text><Icon name="chevron-down" size={10} color="#a3a3a3" />
          </Pressable>
          <Pressable accessibilityRole="button" accessibilityLabel="Escolher tradução" style={[styles.headerPill, styles.versionControl]} onPress={() => setTools('translation')}><Text numberOfLines={1} maxFontSizeMultiplier={1.3} style={styles.versionLabel}>{translationSlug.replace('pt_', '').toUpperCase()}</Text><Icon name="chevron-down" size={10} color="#a3a3a3" /></Pressable>
          </View>
          <View style={styles.headerActions}>
          <Pressable accessibilityRole="button" accessibilityLabel="Ajustar tamanho da fonte" style={styles.headerPill} onPress={() => setTools('font')}><Icon name="font" size={15} color="#d4d4d4" /></Pressable>
          <Pressable accessibilityRole="button" accessibilityLabel="Pesquisar na Bíblia" style={styles.headerPill} onPress={() => setTools('search')}><Icon name="magnifying-glass" size={15} color="#d4d4d4" /></Pressable>
          </View>
        </View>

        {!translationReady && (
          <View style={styles.downloadBox}>
            <Text style={styles.downloadText}>
              {translationState.status === 'error'
                ? `Falha: ${translationState.error}`
                : 'Tradução não baixada.'}
            </Text>
            <Pressable
              style={({ pressed }) => [styles.button, pressed && styles.pressed]}
              onPress={() => handleDownload(translationSlug)}
              disabled={busy}
            >
              {translationState.status === 'downloading' ||
              translationState.status === 'importing' ? (
                <ActivityIndicator color="#fff" size="small" />
              ) : (
                <Text style={styles.buttonText}>Baixar</Text>
              )}
            </Pressable>
            {translationState.progress && (
              <Text style={styles.progressLabel}>
                {translationState.progress.phase === 'download'
                  ? `${Math.round((translationState.progress.ratio ?? 0) * 100)}%`
                  : `${(translationState.progress.processed ?? 0).toLocaleString('pt-BR')} / ${(translationState.progress.total ?? 0).toLocaleString('pt-BR')} versículos`}
              </Text>
            )}
          </View>
        )}

      </View>

      {/* Conteúdo */}
      <ScrollView
        key={chapterKey}
        ref={readerRef}
        style={styles.content}
        contentContainerStyle={styles.contentInner}
      >
        <View style={styles.chapterBanner}>
          <Text style={styles.chapterTitle}>Capítulo {chapter}</Text>
        </View>
        {!translationReady ? (
          <Text style={styles.emptyText}>
            Baixe a tradução {getTranslationBySlug(translationSlug)?.label} para começar a ler.
          </Text>
        ) : loadingVerses ? (
          <ActivityIndicator style={styles.loader} />
        ) : verses.length === 0 ? (
          <Text style={styles.emptyText}>Nenhum versículo encontrado para este capítulo.</Text>
        ) : (
          verses.map((v) => (
            <Text selectable key={v.verse} style={[styles.verse, { fontSize, lineHeight: Math.round(fontSize * 1.75) }]}>
              <Text style={styles.verseNumber}>{v.verse} </Text>
              {v.text}
            </Text>
          ))
        )}
      </ScrollView>


      {/* Barra inferior */}
      <View style={styles.footer}>
        <Pressable accessibilityRole="button" accessibilityLabel="Capítulo anterior" disabled={chapter === 1} onPress={previousChapter} style={[styles.navButton, chapter === 1 && styles.disabled]}><Icon name="chevron-left" /></Pressable>
        <View style={styles.readActions}>
        <Pressable accessibilityRole="button" accessibilityLabel={challengeCompleted ? "Desafio concluído, gerenciar conclusão" : "Concluir desafio do dia"} disabled={challengeBusy} onPress={() => { void openChallenge(); }} style={[styles.readButton, challengeCompleted && styles.readButtonActive]}><Text style={[styles.readButtonText, challengeCompleted && styles.readButtonTextActive]}>{challengeCompleted ? '✓ Desafio concluído' : 'Concluir desafio'}</Text></Pressable>
        </View>
        <Pressable accessibilityRole="button" accessibilityLabel="Próximo capítulo" disabled={chapter === currentBook.total_chapters} onPress={nextChapter} style={[styles.navButton, chapter === currentBook.total_chapters && styles.disabled]}><Icon name="chevron-right" /></Pressable>
      </View>

      <Modal visible={tools !== null} transparent animationType="slide" onRequestClose={() => setTools(null)}>
        <View style={styles.modalOverlay}><View style={styles.modalContent}>
          <View style={styles.modalHeader}><Text style={styles.modalTitle}>{tools === 'font' ? 'Ajustes do Leitor' : tools === 'translation' ? 'Tradução da Bíblia' : 'Pesquisa Bíblica'}</Text><Pressable accessibilityRole="button" accessibilityLabel="Fechar" onPress={() => setTools(null)} style={styles.iconButton}><Text style={styles.modalClose}>✕</Text></Pressable></View>
          {tools === 'translation' && <View style={styles.challengeContent}>{TRANSLATIONS.map((translation) => <Pressable key={translation.slug} accessibilityRole="button" accessibilityState={{ selected: translationSlug === translation.slug }} style={[styles.translationOption, translationSlug === translation.slug && styles.translationChipActive]} onPress={() => { setTranslationSlug(translation.slug); setTools(null); }}><Text style={styles.referenceText}>{translation.slug.replace('pt_', '').toUpperCase()} — {translation.label}</Text><Text style={styles.chapterMeta}>{states[translation.slug]?.status === 'ready' ? 'Disponível offline' : 'Download necessário'}</Text></Pressable>)}</View>}
          {tools === 'font' && <View style={styles.challengeContent}><Text style={styles.bodyText}>Tamanho da fonte</Text><View style={styles.fontControls}><Pressable accessibilityRole="button" accessibilityLabel="Diminuir fonte" onPress={decreaseFont} style={styles.iconButton}><Text style={styles.iconButtonText}>− A</Text></Pressable><Text style={styles.fontSizeLabel}>{fontSize}px</Text><Pressable accessibilityRole="button" accessibilityLabel="Aumentar fonte" onPress={increaseFont} style={styles.iconButton}><Text style={styles.iconButtonText}>+ A</Text></Pressable></View></View>}
          {tools === 'search' && <ScrollView keyboardShouldPersistTaps="handled" contentContainerStyle={styles.challengeContent}>
            <Text style={styles.bodyText}>Pesquisar nas traduções baixadas</Text>
            <TextInput accessibilityLabel="Texto para pesquisar" placeholder="Pesquisar uma palavra ou frase" placeholderTextColor="#a3a3a3" value={query} onChangeText={setQuery} style={styles.searchInput} />
            <Pressable accessibilityRole="button" disabled={searching || !query.trim()} style={[styles.readButton, styles.readButtonActive]} onPress={() => { void runSearch(); }}><Text style={styles.readButtonTextActive}>Pesquisar</Text></Pressable>
            {searching && <ActivityIndicator color="#99c3a6" />}{searchError && <Text style={styles.challengeError}>{searchError}</Text>}
            {hasSearched && !searching && !searchError && !results.length && <Text style={styles.bodyText}>Nenhum resultado. Verifique se há uma tradução baixada.</Text>}
            {results.map((result) => <Pressable accessibilityRole="button" key={`${result.translation}-${result.bookAbbrev}-${result.chapter}-${result.verse}`} style={styles.challengeCard} onPress={() => { setBookAbbrev(result.bookAbbrev); setChapter(result.chapter); setTranslationSlug(result.translation); setTools(null); }}><Text style={styles.accentText}>{BOOKS_CATALOG.find((book) => book.abbrev === result.bookAbbrev)?.name} {result.chapter}:{result.verse} {result.translation.replace('pt_', '').toUpperCase()}</Text><Text style={styles.bodyText}>{result.text}</Text></Pressable>)}
          </ScrollView>}
        </View></View>
      </Modal>

      <Modal visible={challengeVisible} transparent animationType="slide" onRequestClose={() => { if (!challengeBusy) setChallengeVisible(false); }}>
        <View style={styles.modalOverlay}><View style={styles.modalContent}>
          <View style={styles.modalHeader}><Text style={styles.modalTitle}>Desafio do dia</Text><Pressable accessibilityRole="button" accessibilityLabel="Fechar desafio" disabled={challengeBusy} onPress={() => setChallengeVisible(false)} style={styles.iconButton}><Text style={styles.bodyText}>✕</Text></Pressable></View>
          <ScrollView contentContainerStyle={styles.challengeContent}>
            {challengeBusy && <ActivityIndicator />}
            {challengeError && <Text accessibilityRole="alert" style={styles.challengeError}>{challengeError}</Text>}
            {challengeSuccess && <Text style={styles.bodyText} accessibilityLiveRegion="polite">{challengeSuccess}</Text>}
            <>
              <Text style={styles.bodyText}>Confirme que concluiu todas as leituras do objetivo abaixo. O registro dos capítulos lidos é feito na tela Rastreamento.</Text>
              {!challengeBusy && !challengeError && challenges.length === 0 && <Text style={styles.bodyText}>Nenhum desafio programado para hoje. Verifique a data de início do plano; domingos não têm desafio.</Text>}
              {challenges.map((challenge) => <View key={challenge.planId} style={styles.challengeCard}>
                <Text style={styles.modalTitle}>{challenge.title} — Dia {challenge.day}</Text>
                <Text style={styles.bodyText}>{challenge.references}</Text>
                <Pressable accessibilityRole="button" disabled={challengeBusy} style={[styles.readButton, styles.readButtonActive, challenge.doneToday && styles.undoChallengeButton]} onPress={() => { void completeChallenge(challenge.planId, challenge.day, challenge.doneToday); }}><Text style={styles.readButtonTextActive}>{challenge.doneToday ? 'Desfazer desafio concluído' : '✓ Confirmar desafio concluído'}</Text></Pressable>
              </View>)}
              {challengeError && <Pressable accessibilityRole="button" disabled={challengeBusy} onPress={() => { void openChallenge(); }} style={styles.readButton}><Text style={styles.bodyText}>Tentar novamente</Text></Pressable>}
            </>
          </ScrollView>
        </View></View>
      </Modal>

      {/* Modal de seleção */}
      <Modal visible={pickerVisible} animationType="slide" transparent onRequestClose={closePicker}>
        <View style={styles.modalOverlay}>
          <View style={styles.modalContent}>
            <View style={styles.modalHeader}>
              <Text style={styles.modalTitle}>
                {pickerStep === 'book' ? 'Escolha o livro' : `${currentBook.name} — capítulo`}
              </Text>
              <Pressable onPress={closePicker}>
                <Text style={styles.modalClose}>✕</Text>
              </Pressable>
            </View>

            {pickerStep === 'book' ? (
              <BookPicker onSelect={selectBook} />
            ) : (
              <ChapterPicker total={currentBook.total_chapters} onSelect={selectChapter} />
            )}
          </View>
        </View>
      </Modal>
    </SafeAreaView>
  );
}

function BookPicker({ onSelect }: { onSelect: (abbrev: string) => void }) {
  const grouped = groupBooksByTestament();

  return (
    <FlatList
      data={grouped}
      keyExtractor={(item) => item.testament}
      renderItem={({ item }) => (
        <View>
          <Text style={styles.groupTitle}>{item.testament === 'AT' ? 'Antigo Testamento' : 'Novo Testamento'}</Text>
          {item.categories.map((cat) => (
            <View key={cat.category}>
              <Text style={styles.categoryTitle}>{cat.category}</Text>
              <View style={styles.bookGrid}>
                {cat.books.map((book) => (
                  <Pressable
                    key={book.abbrev}
                    style={styles.bookItem}
                    onPress={() => onSelect(book.abbrev)}
                  >
                    <Text style={styles.bookItemText}>{book.name}</Text>
                  </Pressable>
                ))}
              </View>
            </View>
          ))}
        </View>
      )}
      contentContainerStyle={styles.pickerList}
    />
  );
}

function ChapterPicker({
  total,
  onSelect,
}: {
  total: number;
  onSelect: (chapter: number) => void;
}) {
  const chapters = Array.from({ length: total }, (_, i) => i + 1);
  return (
    <FlatList
      data={chapters}
      numColumns={5}
      keyExtractor={(item) => String(item)}
      renderItem={({ item }) => (
        <Pressable style={styles.chapterItem} onPress={() => onSelect(item)}>
          <Text style={styles.chapterItemText}>{item}</Text>
        </Pressable>
      )}
      contentContainerStyle={styles.pickerList}
    />
  );
}

interface GroupedCategory {
  category: string;
  books: { abbrev: string; name: string }[];
}

interface GroupedTestament {
  testament: Testament;
  categories: GroupedCategory[];
}

function groupBooksByTestament(): GroupedTestament[] {
  const at: GroupedCategory[] = [];
  const nt: GroupedCategory[] = [];
  const map = new Map<string, GroupedCategory>();

  for (const book of BOOKS_CATALOG) {
    const key = `${book.testament}|${book.category}`;
    if (!map.has(key)) {
      const entry: GroupedCategory = { category: book.category, books: [] };
      map.set(key, entry);
      if (book.testament === 'AT') at.push(entry);
      else nt.push(entry);
    }
    map.get(key)!.books.push({ abbrev: book.abbrev, name: book.name });
  }

  return [
    { testament: 'AT', categories: at },
    { testament: 'NT', categories: nt },
  ];
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#171717',
  },
  topControls: { flexDirection: 'row', gap: 16, alignItems: 'center', justifyContent: 'space-between' },
  headerSelectors: { flexDirection: 'row', gap: 8, alignItems: 'center', flexShrink: 1, minWidth: 0 },
  headerActions: { flexDirection: 'row', gap: 8, alignItems: 'center', flexShrink: 0 },
  headerPill: { width: 44, height: 44, flexShrink: 0, borderRadius: 22, backgroundColor: '#262626', flexDirection: 'row', alignItems: 'center', justifyContent: 'center', borderWidth: 1, borderColor: '#404040' },
  versionControl: { width: 68, gap: 4 },
  versionLabel: { color: '#99c3a6', fontSize: 12, fontWeight: '700' },
  bookLabel: { flexShrink: 1, color: '#f5f5f5', fontSize: 13, fontWeight: '700' },
  headerChevron: { color: '#a3a3a3', fontSize: 14 },
  headerIcon: { color: '#e5e5e5', fontSize: 16, fontWeight: '700' },
  searchIcon: { color: '#e5e5e5', fontSize: 25, lineHeight: 30 },
  accentText: { color: '#99c3a6', fontWeight: '700' },
  bodyText: { color: '#d4d4d4', lineHeight: 23 },
  disabled: { opacity: 0.3 },
  chapterBanner: { alignItems: 'center', gap: 10, paddingBottom: 22, marginBottom: 16, borderBottomWidth: 1, borderBottomColor: '#303030' },
  chapterTitle: { fontFamily: Platform.OS === 'ios' ? 'Georgia' : 'serif', fontSize: 28, fontWeight: '700', color: '#fff' },
  chapterMeta: { color: '#a3a3a3', fontSize: 12, lineHeight: 19, textAlign: 'center' },
  translationOption: { padding: 16, gap: 6, borderRadius: 16, backgroundColor: '#262626' },
  searchInput: { color: '#fff', borderWidth: 1, borderColor: '#404040', borderRadius: 14, padding: 14, backgroundColor: '#262626' },
  header: {
    paddingTop: 12,
    paddingHorizontal: 12,
    paddingBottom: 8,
    borderBottomWidth: 1,
    borderBottomColor: '#303030',
    backgroundColor: '#171717',
  },
  translationRow: {
    flexDirection: 'row',
    gap: 8,
    marginBottom: 8,
  },
  translationChip: {
    flex: 1,
    paddingVertical: 8,
    borderRadius: 14,
    backgroundColor: '#262626',
    alignItems: 'center',
  },
  translationChipActive: {
    backgroundColor: '#2d6a4f',
  },
  translationChipReady: {
    borderWidth: 1,
    borderColor: '#2d6a4f',
  },
  translationChipText: {
    fontSize: 12,
    fontWeight: '600',
    color: '#a3a3a3',
  },
  translationChipTextActive: {
    color: '#ffffff',
  },
  downloadBox: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 10,
    marginBottom: 8,
  },
  downloadText: {
    flex: 1,
    fontSize: 13,
    color: '#a3a3a3',
  },
  button: {
    backgroundColor: '#2d6a4f',
    borderRadius: 14,
    paddingVertical: 8,
    paddingHorizontal: 14,
  },
  buttonText: {
    color: '#ffffff',
    fontWeight: '600',
  },
  progressLabel: {
    fontSize: 12,
    color: '#a3a3a3',
    minWidth: 80,
    textAlign: 'right',
  },
  controls: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginTop: 4,
  },
  navButton: {
    minWidth: 44,
    minHeight: 48,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: '#262626',
    borderRadius: 14,
  },
  navButtonText: {
    fontSize: 30,
    color: '#99c3a6',
  },
  referenceButton: {
    flexShrink: 1,
    minWidth: 0,
    height: 44,
    flexDirection: 'row',
    gap: 6,
    backgroundColor: '#262626',
    borderRadius: 22,
    borderWidth: 1,
    borderColor: '#404040',
    paddingHorizontal: 12,
    alignItems: 'center',
    justifyContent: 'center',
  },
  referenceText: {
    color: '#f5f5f5',
    fontSize: 13,
    fontWeight: 'bold',
  },
  content: {
    flex: 1,
  },
  contentInner: {
    padding: 20,
    paddingBottom: 32,
    gap: 8,
  },
  verse: {
    fontFamily: Platform.OS === 'ios' ? 'Georgia' : 'serif',
    lineHeight: 28,
    marginBottom: 12,
    color: '#e5e5e5',
  },
  verseNumber: {
    fontSize: 12,
    fontFamily: Platform.OS === 'ios' ? 'System' : 'sans-serif',
    fontWeight: 'bold',
    color: '#2d6a4f',
  },
  loader: {
    marginTop: 32,
  },
  emptyText: {
    textAlign: 'center',
    color: '#a3a3a3',
    marginTop: 32,
  },
  dwellBanner: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 14,
    paddingVertical: 10,
    backgroundColor: '#132a13',
    borderTopWidth: 1,
    borderTopColor: '#23533e',
  },
  dwellText: {
    fontSize: 14,
    color: '#99c3a6',
    fontWeight: '600',
  },
  dwellButton: {
    backgroundColor: '#2d6a4f',
    borderRadius: 14,
    paddingVertical: 8,
    paddingHorizontal: 14,
  },
  dwellButtonText: {
    color: '#ffffff',
    fontWeight: '600',
    fontSize: 13,
  },
  readActions: { flex: 1, flexDirection: 'row', flexWrap: 'wrap', justifyContent: 'center', gap: 8 },
  challengeContent: { padding: 16, gap: 16 },
  challengeCard: { padding: 16, gap: 12, borderWidth: 1, borderColor: '#404040', borderRadius: 12 },
  challengeError: { color: '#b91c1c' },
  footer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 10,
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 12,
    paddingVertical: 10,
    borderTopWidth: 1,
    borderTopColor: '#303030',
    backgroundColor: '#171717',
  },
  fontControls: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 10,
  },
  iconButton: {
    padding: 8,
    backgroundColor: '#262626',
    borderRadius: 6,
  },
  iconButtonText: {
    fontWeight: 'bold',
    color: '#e5e5e5',
  },
  fontSizeLabel: {
    fontSize: 13,
    color: '#a3a3a3',
    minWidth: 36,
    textAlign: 'center',
  },
  readButton: {
    minHeight: 44,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#262626',
    paddingVertical: 10,
    paddingHorizontal: 18,
    borderRadius: 14,
  },
  undoChallengeButton: {
    backgroundColor: '#b91c1c',
  },
  readButtonActive: {
    backgroundColor: '#2d6a4f',
  },
  readButtonText: {
    fontWeight: '600',
    color: '#e5e5e5',
  },
  readButtonTextActive: {
    color: '#ffffff',
  },
  pressed: {
    opacity: 0.7,
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.4)',
    justifyContent: 'flex-end',
  },
  modalContent: {
    backgroundColor: '#171717',
    borderTopLeftRadius: 28,
    borderTopRightRadius: 28,
    maxHeight: '80%',
    paddingBottom: 24,
  },
  modalHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#303030',
  },
  modalTitle: {
    color: '#f5f5f5',
    fontSize: 18,
    fontWeight: 'bold',
  },
  modalClose: {
    fontSize: 20,
    color: '#a3a3a3',
    padding: 4,
  },
  pickerList: {
    padding: 16,
  },
  groupTitle: {
    color: '#f5f5f5',
    fontSize: 18,
    fontWeight: 'bold',
    marginTop: 16,
    marginBottom: 8,
  },
  categoryTitle: {
    fontSize: 14,
    fontWeight: '600',
    color: '#a3a3a3',
    marginTop: 10,
    marginBottom: 6,
  },
  bookGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  bookItem: {
    backgroundColor: '#262626',
    borderRadius: 14,
    paddingVertical: 8,
    paddingHorizontal: 10,
  },
  bookItemText: {
    fontSize: 13,
    color: '#e5e5e5',
  },
  chapterItem: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    margin: 4,
    paddingVertical: 12,
    backgroundColor: '#262626',
    borderRadius: 14,
    minWidth: '16%',
  },
  chapterItemText: {
    color: '#f5f5f5',
    fontSize: 15,
    fontWeight: '600',
  },
});
