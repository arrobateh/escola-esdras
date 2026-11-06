import { Icon } from '../../components/Icon';
import { SafeAreaView } from 'react-native-safe-area-context';
import { colors } from '../../theme/colors';
import { useFocusEffect } from 'expo-router';
import { useCallback, useState } from 'react';
import {
  ActivityIndicator,
  Alert,
  FlatList,
  Modal,
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  View,
} from 'react-native';

import { useAuth } from '../../features/auth';
import { useSync } from '../../features/sync';
import { BOOKS_CATALOG, type Testament } from '../../db/books-catalog';
import {
  getBookProgress,
  getReadChaptersByBook,
  getReadStats,
  markChapterRead,
  resetAllProgress,
  unmarkChapterRead,
  useDatabase,
  type ReadStats,
} from '../../db';

export default function TrackingScreen() {
  const db = useDatabase();
  const { user } = useAuth();
  const { syncNow } = useSync();
  const userId = user?.id ?? '';
  const [stats, setStats] = useState<ReadStats | null>(null);
  const [byBook, setByBook] = useState<Record<string, number[]>>({});
  const [loading, setLoading] = useState(true);
  const [viewMode, setViewMode] = useState<'books' | 'detail'>('books');
  const [category, setCategory] = useState('Todas');
  const [selectedBook, setSelectedBook] = useState<string | null>(null);

  const load = useCallback(async () => {
    if (!userId) return;
    setLoading(true);
    const [s, grouped] = await Promise.all([
      getReadStats(db, userId),
      getReadChaptersByBook(db, userId),
    ]);
    setStats(s);
    setByBook(grouped);
    setLoading(false);
  }, [db, userId]);

  useFocusEffect(
    useCallback(() => {
      load();
    }, [load])
  );

  async function handleReset() {
    if (!userId) return;
    Alert.alert(
      'Tem certeza?',
      'Isso apagará todo o seu progresso de leitura. Esta ação não pode ser desfeita.',
      [
        { text: 'Cancelar', style: 'cancel' },
        {
          text: 'Apagar',
          style: 'destructive',
          onPress: async () => {
            await resetAllProgress(db, userId);
            await load();
            void syncNow();
          },
        },
      ]
    );
  }

  if (loading || stats == null) {
    return (
      <View style={styles.centered}>
        <ActivityIndicator size="large" />
      </View>
    );
  }

  return (
    <SafeAreaView style={styles.container} edges={['top', 'left', 'right']}>
      <View style={styles.pageHeader}>
        <View><Text style={styles.eyebrow}><Icon name="book-bible" color="#d4a373" size={11} /> JORNADA BÍBLICA</Text><Text style={styles.headerTitle}>Progresso Geral</Text></View>
        <Pressable accessibilityRole="button" style={styles.resetAction} onPress={handleReset}><Text style={styles.resetButtonText}><Icon name="rotate-left" color="#fda4af" size={12} /> Resetar</Text></Pressable>
      </View>
      <ScrollView contentContainerStyle={styles.content}>

        {/* Card geral */}
        <View style={styles.card}>
          <View style={styles.heroRow}><View style={{ flex: 1 }}><Text style={styles.cardLabel}>CAPÍTULOS COMPLETADOS</Text>
          <Text style={styles.bigCount}>
            {stats.totalRead} de {stats.totalChapters}
          </Text>
          </View><View style={styles.percentBadge}><Text style={styles.percent}>{stats.percent}%</Text></View></View>
          <View style={styles.track}>
            <View style={[styles.fill, { width: `${stats.percent}%` }]} />
          </View>

        {/* Cards por testamento */}
        <View style={styles.testamentRow}>
          <TestamentCard
            title="Antigo Testamento"
            read={stats.otRead}
            total={stats.otTotal}
            color="#d4a373"
          />
          <TestamentCard
            title="Novo Testamento"
            read={stats.ntRead}
            total={stats.ntTotal}
            color="#99c3a6"
          />
        </View>

        </View>
        <View accessibilityRole="tablist" style={styles.viewSwitcher}>{(['books', 'detail'] as const).map((mode) => <Pressable key={mode} accessibilityRole="tab" accessibilityState={{ selected: viewMode === mode }} onPress={() => setViewMode(mode)} style={[styles.viewButton, viewMode === mode && styles.viewButtonActive]}><Text style={styles.viewButtonText}>{mode === 'books' ? 'Visão por Livros (66)' : 'Visão Detalhada'}</Text></Pressable>)}</View>
        <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={styles.filters}>{['Todas', ...new Set(BOOKS_CATALOG.map((book) => book.category))].map((value) => <Pressable key={value} accessibilityRole="button" accessibilityState={{ selected: category === value }} onPress={() => setCategory(value)} style={[styles.filter, category === value && styles.viewButtonActive]}><Text style={styles.viewButtonText}>{value}</Text></Pressable>)}</ScrollView>
        {/* Lista de livros */}
        <BookList byBook={byBook} onSelectBook={setSelectedBook} category={category} detailed={viewMode === 'detail'} />

      </ScrollView>

      {/* Modal de capítulos do livro */}
      <BookChaptersModal
        visible={selectedBook != null}
        bookAbbrev={selectedBook}
        userId={userId}
        onClose={() => setSelectedBook(null)}
        onChanged={load}
      />
    </SafeAreaView>
  );
}

function TestamentCard({
  title,
  read,
  total,
  color,
}: {
  title: string;
  read: number;
  total: number;
  color: string;
}) {
  const percent = total > 0 ? Math.round((read / total) * 100) : 0;
  return (
    <View style={styles.testamentCard}>
      <Text style={styles.testamentTitle}>{title}</Text>
      <Text style={[styles.testamentCount, { color }]}>
        {read} de {total}
      </Text>
      <Text style={styles.testamentPercent}>{percent}%</Text>
      <View style={styles.track}>
        <View style={[styles.fill, { width: `${percent}%`, backgroundColor: color }]} />
      </View>
    </View>
  );
}

interface GroupedCategory {
  category: string;
  books: { abbrev: string; name: string; total: number }[];
}

interface GroupedTestament {
  testament: Testament;
  title: string;
  categories: GroupedCategory[];
}

function BookList({
  byBook,
  onSelectBook,
  category,
  detailed,
}: {
  byBook: Record<string, number[]>;
  category: string;
  detailed: boolean;
  onSelectBook: (abbrev: string) => void;
}) {
  const grouped = groupBooks().map((testament) => ({ ...testament, categories: testament.categories.filter((item) => category === 'Todas' || item.category === category) })).filter((testament) => testament.categories.length > 0);

  return (
    <View style={styles.bookList}>
      {grouped.map((testament) => (
        <View key={testament.testament}>
          <Text style={styles.testamentSectionTitle}>{testament.title}</Text>
          {testament.categories.map((cat) => (
            <View key={cat.category}>
              <Text style={styles.categorySectionTitle}>{cat.category}</Text>
              {cat.books.map((book) => {
                const read = byBook[book.abbrev]?.length ?? 0;
                const percent = book.total > 0 ? Math.round((read / book.total) * 100) : 0;
                return (
                  <View key={book.abbrev}>
                  <Pressable
                    accessibilityRole="button"
                    accessibilityLabel={`${book.name}, ${percent}% concluído, editar capítulos`}
                    key={book.abbrev}
                    style={({ pressed }) => [styles.bookRow, pressed && styles.pressed]}
                    onPress={() => onSelectBook(book.abbrev)}
                  >
                    <View style={styles.bookRowHeader}>
                      <Text style={styles.bookName}>{book.name}</Text>
                      <Text style={styles.bookCount}>
                        {percent}%
                      </Text>
                    </View>
                    <Text style={styles.bookCount}>{read} de {book.total} capítulos concluídos</Text>
                    <View style={styles.track}>
                      <View style={[styles.fill, { width: `${percent}%` }]} />
                    </View>
                    {detailed && <View style={styles.inlineChapters}>{Array.from({ length: book.total }, (_, index) => index + 1).map((chapter) => <View key={chapter} style={[styles.inlineChapter, byBook[book.abbrev]?.includes(chapter) && styles.chapterItemRead]}><Text style={styles.chapterItemText}>{chapter}</Text></View>)}</View>}
                  </Pressable>
                  </View>
                );
              })}
            </View>
          ))}
        </View>
      ))}
    </View>
  );
}

function groupBooks(): GroupedTestament[] {
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
    map.get(key)!.books.push({ abbrev: book.abbrev, name: book.name, total: book.total_chapters });
  }

  return [
    { testament: 'AT', title: 'Antigo Testamento', categories: at },
    { testament: 'NT', title: 'Novo Testamento', categories: nt },
  ];
}

function BookChaptersModal({
  visible,
  bookAbbrev,
  userId,
  onClose,
  onChanged,
}: {
  visible: boolean;
  bookAbbrev: string | null;
  userId: string;
  onClose: () => void;
  onChanged: () => void;
}) {
  const db = useDatabase();
  const { syncNow } = useSync();
  const [progress, setProgress] = useState<{ read: number[]; total: number } | null>(null);

  useFocusEffect(
    useCallback(() => {
      if (!bookAbbrev || !userId) {
        setProgress(null);
        return;
      }
      let cancelled = false;
      getBookProgress(db, userId, bookAbbrev).then((p) => {
        if (!cancelled) setProgress(p);
      });
      return () => {
        cancelled = true;
      };
    }, [bookAbbrev, db, userId])
  );

  if (!bookAbbrev || !userId) return null;
  const book = BOOKS_CATALOG.find((b) => b.abbrev === bookAbbrev);
  if (!book) return null;
  const abbrev = bookAbbrev;

  const readSet = new Set(progress?.read ?? []);
  const chapters = Array.from({ length: book.total_chapters }, (_, i) => i + 1);

  async function toggle(chapter: number) {
    if (readSet.has(chapter)) {
      await unmarkChapterRead(db, userId, abbrev, chapter);
    } else {
      await markChapterRead(db, userId, abbrev, chapter);
    }
    const updated = await getBookProgress(db, userId, abbrev);
    setProgress(updated);
    onChanged();
    void syncNow();
  }

  return (
    <Modal visible={visible} animationType="slide" transparent onRequestClose={onClose}>
      <View style={styles.modalOverlay}>
        <View style={styles.modalContent}>
          <View style={styles.modalHeader}>
            <View><Text style={styles.modalTitle}>{book.name}</Text><Text style={styles.bookCount}>{progress ? `${Math.round(progress.read.length / progress.total * 100)}% concluído` : 'Carregando…'}</Text></View>
            <Pressable onPress={onClose}>
              <Text style={styles.modalClose}>✕</Text>
            </Pressable>
          </View>

          <Text style={styles.modalHint}>Toque em um capítulo para marcar ou desmarcar a leitura.</Text>
          {progress == null ? (
            <ActivityIndicator style={styles.modalLoader} />
          ) : (
            <FlatList
              data={chapters}
              numColumns={5}
              keyExtractor={(item) => String(item)}
              renderItem={({ item }) => {
                const read = readSet.has(item);
                return (
                  <Pressable
                    accessibilityRole="button"
                    accessibilityLabel={`Capítulo ${item}, ${read ? 'lido' : 'não lido'}`}
                    accessibilityState={{ selected: read }}
                    style={[styles.chapterItem, read && styles.chapterItemRead]}
                    onPress={() => toggle(item)}
                  >
                    <Text style={[styles.chapterItemText, read && styles.chapterItemTextRead]}>
                      {item}
                    </Text>
                  </Pressable>
                );
              }}
              contentContainerStyle={styles.chapterList}
            />
          )}
        </View>
      </View>
    </Modal>
  );
}

const styles = StyleSheet.create({
  pageHeader: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', padding: 20, gap: 12, borderBottomWidth: 1, borderBottomColor: colors.border },
  eyebrow: { color: colors.gold, fontSize: 11, letterSpacing: 1, fontWeight: '800', marginBottom: 4 },
  headerTitle: { color: colors.text, fontSize: 21, fontWeight: '800' },
  resetAction: { backgroundColor: colors.dangerSurface, borderRadius: 14, minHeight: 44, paddingHorizontal: 12, justifyContent: 'center' },
  heroRow: { flexDirection: 'row', gap: 12, alignItems: 'center' },
  percentBadge: { width: 72, height: 72, borderRadius: 36, borderWidth: 3, borderColor: colors.accent, backgroundColor: colors.background, justifyContent: 'center', alignItems: 'center' },
  viewSwitcher: { flexDirection: 'row', backgroundColor: colors.surface, padding: 4, borderRadius: 18, gap: 4 },
  viewButton: { flex: 1, minHeight: 44, justifyContent: 'center', alignItems: 'center', borderRadius: 14, padding: 8 },
  viewButtonActive: { backgroundColor: colors.primary },
  viewButtonText: { color: colors.text, fontSize: 12, fontWeight: '700' },
  filters: { gap: 8, paddingVertical: 14 },
  filter: { borderRadius: 22, minHeight: 44, paddingHorizontal: 14, justifyContent: 'center', backgroundColor: colors.surface, borderWidth: 1, borderColor: colors.border },
  inlineChapters: { flexDirection: 'row', flexWrap: 'wrap', gap: 6, marginTop: 12 },
  inlineChapter: { width: 32, height: 32, borderRadius: 8, alignItems: 'center', justifyContent: 'center', backgroundColor: colors.border },
  modalHint: { color: colors.muted, paddingHorizontal: 20, paddingVertical: 12, lineHeight: 21 },
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },
  centered: {
    backgroundColor: colors.background,
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  content: {
    padding: 20,
    paddingBottom: 40,
  },
  title: {
    color: colors.text,
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 16,
  },
  card: {
    backgroundColor: colors.surface,
    borderRadius: 24,
    padding: 16,
    marginBottom: 12,
    borderWidth: 1,
    borderColor: colors.border,
  },
  cardLabel: {
    fontSize: 13,
    color: colors.muted,
    marginBottom: 4,
  },
  bigCount: {
    fontSize: 32,
    fontWeight: 'bold',
    color: colors.accent,
  },
  percent: {
    fontSize: 16,
    color: colors.muted,
    marginTop: 4,
  },
  track: {
    height: 10,
    backgroundColor: colors.border,
    borderRadius: 5,
    marginTop: 10,
    overflow: 'hidden',
  },
  fill: {
    height: '100%',
    backgroundColor: colors.primary,
    borderRadius: 5,
  },
  testamentRow: {
    marginTop: 16,
    flexDirection: 'row',
    gap: 12,
    marginBottom: 16,
  },
  testamentCard: {
    flex: 1,
    backgroundColor: colors.background,
    borderRadius: 24,
    padding: 14,
    borderWidth: 1,
    borderColor: colors.border,
  },
  testamentTitle: {
    fontSize: 13,
    fontWeight: '600',
    color: colors.text,
    marginBottom: 6,
  },
  testamentCount: {
    fontSize: 20,
    fontWeight: 'bold',
  },
  testamentPercent: {
    fontSize: 14,
    color: colors.muted,
    marginTop: 2,
  },
  bookList: {
    marginTop: 8,
  },
  testamentSectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginTop: 16,
    marginBottom: 8,
    color: colors.text,
  },
  categorySectionTitle: {
    fontSize: 14,
    fontWeight: '600',
    color: colors.muted,
    marginTop: 10,
    marginBottom: 6,
  },
  bookRow: {
    backgroundColor: colors.surface,
    borderRadius: 18,
    padding: 12,
    marginBottom: 8,
    borderWidth: 1,
    borderColor: colors.border,
  },
  bookRowHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    flexWrap: 'wrap',
    gap: 8,
    marginBottom: 6,
  },
  bookName: {
    fontSize: 15,
    fontWeight: '600',
    color: colors.text,
  },
  bookCount: {
    fontSize: 13,
    color: colors.muted,
  },
  resetButton: {
    marginTop: 20,
    backgroundColor: colors.dangerSurface,
    borderRadius: 18,
    paddingVertical: 14,
    alignItems: 'center',
    borderWidth: 1,
    borderColor: colors.dangerSurface,
  },
  resetButtonText: {
    color: colors.danger,
    fontWeight: 'bold',
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
    backgroundColor: colors.background,
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
    borderBottomColor: colors.border,
  },
  modalTitle: {
    color: colors.text,
    fontSize: 18,
    fontWeight: 'bold',
  },
  modalClose: {
    fontSize: 20,
    color: colors.muted,
    padding: 4,
  },
  modalLoader: {
    marginVertical: 32,
  },
  chapterList: {
    padding: 16,
  },
  chapterItem: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    margin: 4,
    paddingVertical: 14,
    backgroundColor: colors.surface,
    borderRadius: 14,
    minWidth: '16%',
  },
  chapterItemRead: {
    backgroundColor: colors.primary,
  },
  chapterItemText: {
    fontSize: 15,
    fontWeight: '600',
    color: colors.text,
  },
  chapterItemTextRead: {
    color: colors.text,
  },
});
