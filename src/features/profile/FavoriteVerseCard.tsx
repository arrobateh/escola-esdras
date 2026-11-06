import AsyncStorage from '@react-native-async-storage/async-storage';
import { useFocusEffect } from 'expo-router';
import { useCallback, useState } from 'react';
import { ActivityIndicator, Modal, Pressable, ScrollView, StyleSheet, Text, TextInput, View } from 'react-native';
import { Icon } from '../../components/Icon';
import { useDatabase } from '../../db';
import { BOOKS_CATALOG } from '../../db/books-catalog';
import { useAuth } from '../auth';
import { searchVerses, type SearchResult } from '../bible';
import { colors } from '../../theme/colors';

const reference = (verse: SearchResult) => `${BOOKS_CATALOG.find((book) => book.abbrev === verse.bookAbbrev)?.name ?? verse.bookAbbrev} ${verse.chapter}:${verse.verse} ${verse.translation.replace('pt_', '').toUpperCase()}`;
const normalize = (value: string) => value.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase().trim();
export function FavoriteVerseCard() {
  const db = useDatabase();
  const { user } = useAuth();
  const [favorite, setFavorite] = useState<SearchResult | null>(null);
  const [visible, setVisible] = useState(false);
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<SearchResult[]>([]);
  const [busy, setBusy] = useState(false);
  const [searched, setSearched] = useState(false);
  const [error, setError] = useState<string | null>(null);
  useFocusEffect(useCallback(() => {
    let active = true;
    if (user?.id) void AsyncStorage.getItem(`favorite-verse:${user.id}`).then((value) => {
      const verse = value ? JSON.parse(value) as SearchResult : null;
      if (active) setFavorite(verse);
    }).catch(() => { if (active) setError('Não foi possível carregar o versículo salvo.'); });
    return () => { active = false; };
  }, [user]));
  async function search() {
    if (!query.trim() || busy) return;
    setBusy(true); setError(null); setSearched(true);
    try {
      const ref = query.trim().match(/^(.+?)\s+(\d+)\s*:\s*(\d+)$/);
      if (ref) {
        const book = BOOKS_CATALOG.find((item) => normalize(item.name) === normalize(ref[1]) || normalize(item.abbrev) === normalize(ref[1]));
        setResults(book ? await db.getAllAsync<SearchResult>('SELECT translation, book_abbrev AS bookAbbrev, chapter, verse, text FROM verses WHERE book_abbrev = ? AND chapter = ? AND verse = ? ORDER BY translation', book.abbrev, Number(ref[2]), Number(ref[3])) : []);
      } else setResults(await searchVerses(db, `"${query.trim().replace(/"/g, '""')}"`, 40));
    } catch { setResults([]); setError('Não foi possível pesquisar. Tente novamente.'); }
    finally { setBusy(false); }
  }
  async function choose(verse: SearchResult) {
    if (!user?.id || busy) return;
    setBusy(true); setError(null);
    try { await AsyncStorage.setItem(`favorite-verse:${user.id}`, JSON.stringify(verse)); setFavorite(verse); setVisible(false); }
    catch { setError('Não foi possível salvar sua escolha. Tente novamente.'); }
    finally { setBusy(false); }
  }
  return <>
    <View style={styles.card}><View style={styles.header}><Text style={styles.label}>VERSÍCULO FAVORITO</Text><Pressable accessibilityRole="button" accessibilityLabel="Pesquisar e escolher versículo favorito" style={styles.edit} onPress={() => { setVisible(true); setQuery(''); setResults([]); setSearched(false); setError(null); }}><Icon name="magnifying-glass" size={14} /></Pressable></View>
      {favorite ? <><Text selectable style={styles.quote}>“{favorite.text}”</Text><Text style={styles.reference}>{reference(favorite)}</Text></> : <Text style={styles.muted}>Escolha um versículo que inspire sua caminhada.</Text>}
    </View>
    <Modal visible={visible} transparent animationType="slide" onRequestClose={() => { if (!busy) setVisible(false); }}><View style={styles.backdrop}><View style={styles.modal}><ScrollView keyboardShouldPersistTaps="handled" contentContainerStyle={styles.content}>
      <Text style={styles.title}>Escolher versículo favorito</Text><Text style={styles.muted}>Pesquise um trecho ou referência, como Salmos 119:105. A busca usa as traduções baixadas na tela Bíblia.</Text>
      <TextInput accessibilityLabel="Pesquisar versículo por texto ou referência" placeholder="Palavra, trecho ou Salmos 119:105" placeholderTextColor={colors.muted} value={query} editable={!busy} onChangeText={setQuery} onSubmitEditing={() => { void search(); }} style={styles.input} />
      <Pressable accessibilityRole="button" disabled={busy || !query.trim()} style={styles.button} onPress={() => { void search(); }}><Text style={styles.buttonText}>Pesquisar</Text></Pressable>
      {busy && <ActivityIndicator color={colors.accent} />}{error && <Text accessibilityRole="alert" style={styles.error}>{error}</Text>}
      {searched && !busy && !error && !results.length && <Text style={styles.muted}>Nenhum versículo encontrado. Verifique o termo e se há uma tradução baixada.</Text>}
      {results.map((verse) => <Pressable accessibilityRole="button" accessibilityLabel={`Selecionar ${reference(verse)}`} disabled={busy} key={reference(verse)} style={styles.result} onPress={() => { void choose(verse); }}><Text style={styles.reference}>{reference(verse)}</Text><Text style={styles.quote}>{verse.text}</Text><Text style={styles.reference}>Selecionar este versículo</Text></Pressable>)}
      <Pressable accessibilityRole="button" disabled={busy} style={styles.edit} onPress={() => setVisible(false)}><Text style={styles.muted}>Cancelar</Text></Pressable>
    </ScrollView></View></View></Modal>
  </>;
}
const styles = StyleSheet.create({ card: { backgroundColor: colors.background, borderRadius: 16, padding: 14, borderLeftWidth: 3, borderLeftColor: colors.primary, gap: 10 }, header: { flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between' }, label: { color: colors.muted, fontSize: 11, fontWeight: '700' }, edit: { minHeight: 44, minWidth: 44, alignItems: 'center', justifyContent: 'center' }, quote: { color: colors.text, fontSize: 14, lineHeight: 24, fontStyle: 'italic' }, reference: { color: colors.accent, fontSize: 13, fontWeight: '600', paddingVertical: 4 }, muted: { color: colors.muted, fontSize: 13, lineHeight: 21 }, backdrop: { flex: 1, backgroundColor: '#000000bb', padding: 20, justifyContent: 'center' }, modal: { backgroundColor: colors.background, borderRadius: 24, maxHeight: '85%', maxWidth: 440, width: '100%', alignSelf: 'center' }, content: { padding: 20, gap: 16 }, title: { color: colors.text, fontSize: 19, fontWeight: '800' }, input: { color: colors.text, padding: 14, borderWidth: 1, borderColor: colors.border, borderRadius: 14, backgroundColor: colors.surface }, button: { minHeight: 48, padding: 14, backgroundColor: colors.primary, borderRadius: 14, alignItems: 'center' }, buttonText: { color: colors.text, fontWeight: '700' }, result: { padding: 14, gap: 8, backgroundColor: colors.surface, borderRadius: 16 }, error: { color: colors.danger } });
