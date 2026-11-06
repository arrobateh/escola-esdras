import AsyncStorage from '@react-native-async-storage/async-storage';
import { useEffect, useState } from 'react';
import { ActivityIndicator, Modal, Pressable, ScrollView, StyleSheet, Text, TextInput, View } from 'react-native';
import { useAuth } from '../auth';
import { supabase } from '../../lib/supabase';
import { colors } from '../../theme/colors';

export function ChurchWelcome() {
  const { user } = useAuth();
  const [visible, setVisible] = useState(false);
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<{ id: string; name: string }[]>([]);
  const [selected, setSelected] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);
  const [resultQuery, setResultQuery] = useState('');
  useEffect(() => {
    let active = true;
    async function load() {
      if (!user?.id || !supabase) return;
      const seen = await AsyncStorage.getItem(`church-welcome:${user.id}`);
      if (seen) return;
      const { data, error } = await supabase.from('profiles').select('church_name').eq('id', user.id).maybeSingle();
      if (!error && active && !(data as { church_name: string | null } | null)?.church_name) setVisible(true);
    }
    void load().catch(() => {});
    return () => { active = false; };
  }, [user]);
  useEffect(() => {
    if (!visible || selected || query.trim().length < 3) return;
    let active = true;
    const timer = setTimeout(() => {
      void (async () => {
        if (!supabase) return;
        const term = query.trim().replace(/[%_\\]/g, '');
        if (term.length < 3) return;
        const { data, error } = await supabase.from('churches').select('id, name').ilike('name', `%${term}%`).order('name').limit(15);
        if (active) { setResults(data ?? []); setResultQuery(query); setError(error ? 'Não foi possível buscar igrejas. Tente novamente ou escolha depois.' : null); }
      })();
    }, 250);
    return () => { active = false; clearTimeout(timer); };
  }, [query, selected, visible]);
  async function finish(save: boolean) {
    if (!user?.id || busy) return;
    setBusy(true); setError(null);
    try {
      if (save) {
        if (!supabase || !selected) return;
        const { data, error } = await supabase.from('profiles').update({ church_name: selected } as never).eq('id', user.id).select('id').single();
        if (error || !data) throw new Error('Não foi possível salvar sua igreja. Tente novamente.');
      }
      await AsyncStorage.setItem(`church-welcome:${user.id}`, 'seen');
      setVisible(false);
    } catch (error) { setError(error instanceof Error ? error.message : 'Não foi possível continuar.'); }
    finally { setBusy(false); }
  }
  return <Modal visible={visible} transparent animationType="fade" onRequestClose={() => { void finish(false); }}><View style={styles.backdrop}><View style={styles.card}><ScrollView keyboardShouldPersistTaps="handled" contentContainerStyle={styles.content}>
    <Text style={styles.title}>Bem-vindo à Escola de Esdras!</Text><Text style={styles.text}>Qual é a sua igreja? Você também pode escolher depois na tela Você.</Text>
    <TextInput accessibilityLabel="Pesquisar sua igreja" placeholder="Digite pelo menos 3 caracteres" placeholderTextColor={colors.muted} editable={!busy} value={query} onChangeText={(text) => { setQuery(text); setSelected(null); setResults([]); setResultQuery(''); setError(null); }} style={styles.input} />
    {!selected && query.trim().length >= 3 && resultQuery === query && results.map((church) => <Pressable accessibilityRole="button" key={church.id} style={styles.input} onPress={() => { setSelected(church.name); setQuery(church.name); }}><Text style={styles.text}>{church.name}</Text></Pressable>)}
    {!selected && resultQuery === query && query.trim().length >= 3 && !results.length && !error && <Text style={styles.text}>Nenhuma igreja encontrada.</Text>}
    {error && <Text accessibilityRole="alert" style={styles.error}>{error}</Text>}
    <Pressable accessibilityRole="button" disabled={!selected || busy} onPress={() => { void finish(true); }} style={[styles.button, (!selected || busy) && { opacity: 0.5 }]}>{busy ? <ActivityIndicator color={colors.text} /> : <Text style={styles.text}>Confirmar igreja</Text>}</Pressable>
    <Pressable accessibilityRole="button" disabled={busy} onPress={() => { void finish(false); }} style={styles.later}><Text style={styles.text}>Escolher depois</Text></Pressable>
  </ScrollView></View></View></Modal>;
}
const styles = StyleSheet.create({ backdrop: { flex: 1, backgroundColor: '#000000bb', padding: 24, justifyContent: 'center' }, card: { backgroundColor: colors.background, borderRadius: 24, borderWidth: 1, borderColor: colors.border, maxHeight: '85%', maxWidth: 440, width: '100%', alignSelf: 'center' }, content: { padding: 22, gap: 16 }, title: { color: colors.text, fontSize: 22, fontWeight: '800' }, text: { color: colors.text, fontSize: 14, lineHeight: 22 }, input: { color: colors.text, borderWidth: 1, borderColor: colors.border, backgroundColor: colors.surface, padding: 14, borderRadius: 14 }, button: { backgroundColor: colors.primary, padding: 14, minHeight: 48, alignItems: 'center', borderRadius: 14 }, later: { minHeight: 44, justifyContent: 'center', alignItems: 'center' }, error: { color: colors.danger } });
