import AsyncStorage from '@react-native-async-storage/async-storage';
import { useFocusEffect } from 'expo-router';
import { useCallback, useState } from 'react';
import { ActivityIndicator, Image, Linking, Modal, Pressable, ScrollView, StyleSheet, Text, TextInput, View } from 'react-native';
import { Icon } from '../../components/Icon';
import { supabase } from '../../lib/supabase';
import { colors } from '../../theme/colors';
import { churchDate } from '../plans/calendar';

interface Church {
  id: string; name: string; address?: string | null; pastor_name?: string | null; photo_url?: string | null;
  contact?: string | null; services_text?: string | null; organization_date_text?: string | null;
  latitude?: number | null; longitude?: number | null; maps_url?: string | null; source_url?: string | null;
  source_metadata?: { address_complement?: string; social_links?: { url: string; label: string }[] } | null;
}
const cacheKey = 'churches:catalog:v1';
function hash(value: string) { let result = 2166136261; for (const char of value) result = Math.imul(result ^ char.charCodeAt(0), 16777619); return result >>> 0; }
export function dailyChurch<T extends { id: string }>(churches: T[], date: string): T | null {
  if (!churches.length) return null;
  const ordered = [...churches].sort((a, b) => hash(a.id) - hash(b.id) || a.id.localeCompare(b.id));
  const day = Math.floor(Date.parse(`${date}T00:00:00Z`) / 86400000);
  return ordered[((day % ordered.length) + ordered.length) % ordered.length];
}
function ChurchPhoto({ uri, large = false }: { uri?: string | null; large?: boolean }) {
  const [failed, setFailed] = useState(false);
  return uri && !failed ? <Image source={{ uri }} accessibilityLabel="Foto da igreja" onError={() => setFailed(true)} style={[styles.photo, large && styles.largePhoto]} /> : <View style={[styles.photo, styles.fallback, large && styles.largePhoto]}><Icon name="church" size={32} color={colors.gold} /><Text style={styles.muted}>Foto não disponível</Text></View>;
}
export function ChurchShowcase() {
  const [version, setVersion] = useState(0);
  return <ChurchShowcaseContent key={version} onRetry={() => setVersion((value) => value + 1)} />;
}
function ChurchShowcaseContent({ onRetry }: { onRetry: () => void }) {
  const [churches, setChurches] = useState<Church[]>([]);
  const [loading, setLoading] = useState(true);
  const [notice, setNotice] = useState<string | null>(null);
  const [visible, setVisible] = useState(false);
  const [selected, setSelected] = useState<Church | null>(null);
  const [query, setQuery] = useState('');
  const [today, setToday] = useState(churchDate());
  const [linkError, setLinkError] = useState<string | null>(null);
  useFocusEffect(useCallback(() => {
    let active = true;
    async function load() {
      setLoading(true);
      try {
        const cached = await AsyncStorage.getItem(cacheKey);
        if (cached && active) setChurches(JSON.parse(cached) as Church[]);
      } catch { /* Cache indisponível não impede a consulta. */ }
      try {
        if (!supabase) throw new Error('Supabase não configurado');
        const { data, error } = await supabase.from('churches').select('*').order('name').limit(1000);
        if (error) throw error;
        const rows = data as Church[];
        if (active) { setChurches(rows); setNotice(null); }
        await AsyncStorage.setItem(cacheKey, JSON.stringify(rows)).catch(() => {});
      } catch { if (active) setNotice('Não foi possível atualizar as igrejas. Exibindo os dados salvos, quando disponíveis.'); }
      finally { if (active) setLoading(false); }
    }
    void load();
    const timer = setInterval(() => setToday(churchDate()), 30000);
    setToday(churchDate());
    return () => { active = false; clearInterval(timer); };
  }, []));
  const featured = dailyChurch(churches, today);
  const normalized = (value: string) => value.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase();
  const filtered = churches.filter((church) => normalized(church.name).includes(normalized(query)));
  function show(church: Church) { setSelected(church); setLinkError(null); setVisible(true); }
  async function open(url: string) {
    setLinkError(null);
    try {
      if (!/^https?:\/\//i.test(url)) throw new Error('Link inválido');
      await Linking.openURL(url);
    } catch { setLinkError('Não foi possível abrir o link. Tente novamente.'); }
  }
  const coordinates = selected && typeof selected.latitude === 'number' && typeof selected.longitude === 'number' ? `${selected.latitude},${selected.longitude}` : null;
  const maps = selected?.maps_url || (coordinates ? `https://www.google.com/maps/search/?api=1&query=${coordinates}` : selected?.address ? `https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(selected.address)}` : null);
  return <>
    <View style={styles.heading}><Text style={styles.section}>IGREJA EM DESTAQUE</Text><Pressable accessibilityRole="button" onPress={() => { setSelected(null); setQuery(''); setLinkError(null); setVisible(true); }} style={styles.catalogButton}><Text style={styles.accent}>Conheça nossas igrejas</Text></Pressable></View>
    {notice && <Text style={styles.muted}>{notice}</Text>}
    {featured ? <Pressable accessibilityRole="button" accessibilityLabel={`Conhecer a igreja em ${featured.name}`} style={styles.card} onPress={() => show(featured)}><ChurchPhoto key={featured.photo_url ?? featured.id} uri={featured.photo_url} large /><View style={styles.cardContent}><Text style={styles.accent}>CONHEÇA HOJE</Text><Text style={styles.title}>Igreja em {featured.name}</Text>{featured.pastor_name && <Text style={styles.muted}>Pastor: {featured.pastor_name}</Text>}<Text style={styles.accent}>Conhecer a igreja →</Text></View></Pressable> : <View style={styles.cardContent}>{loading ? <ActivityIndicator color={colors.accent} /> : <Text style={styles.muted}>Nenhuma igreja disponível.</Text>}</View>}
    {notice && <Pressable accessibilityRole="button" onPress={onRetry} style={styles.catalogButton}><Text style={styles.accent}>Tentar novamente</Text></Pressable>}
    <Modal visible={visible} transparent animationType="slide" onRequestClose={() => { if (selected) setSelected(null); else setVisible(false); }}>
      <View style={styles.backdrop}><View style={styles.modal}>
        <View style={styles.modalHeader}><Text style={[styles.title, { flex: 1 }]}>{selected ? selected.name : 'Nossas igrejas'}</Text><Pressable accessibilityRole="button" accessibilityLabel="Fechar" style={styles.close} onPress={() => setVisible(false)}><Icon name="xmark" /></Pressable></View>
        <ScrollView keyboardShouldPersistTaps="handled" contentContainerStyle={styles.modalContent}>
          {selected ? <>
            <Pressable accessibilityRole="button" onPress={() => setSelected(null)} style={styles.catalogButton}><Text style={styles.accent}>‹ Todas as igrejas</Text></Pressable>
            <ChurchPhoto key={selected.id} uri={selected.photo_url} large />
            <Detail label="Pastor presidente" value={selected.pastor_name} /><Detail label="Endereço" value={selected.address} /><Detail label="Complemento" value={selected.source_metadata?.address_complement} /><Detail label="Contato" value={selected.contact} /><Detail label="Cultos e atividades" value={selected.services_text} /><Detail label="Data de organização" value={selected.organization_date_text} />
            {maps ? <Pressable accessibilityRole="link" style={styles.mapButton} onPress={() => { void open(maps); }}><Text style={styles.buttonText}><Icon name="map-location-dot" color={colors.text} /> Abrir no Google Maps</Text></Pressable> : <Text style={styles.muted}>Localização não informada.</Text>}
            {coordinates ? <Pressable accessibilityRole="link" style={styles.mapButton} onPress={() => { void open(`https://waze.com/ul?ll=${coordinates}&navigate=yes`); }}><Text style={styles.buttonText}>Abrir no Waze</Text></Pressable> : <Text style={styles.muted}>Waze indisponível: coordenadas não cadastradas.</Text>}
            {selected.source_metadata?.social_links?.map((link) => <Pressable accessibilityRole="link" key={link.url} style={styles.catalogButton} onPress={() => { void open(link.url); }}><Text style={styles.accent}>{link.label} ↗</Text></Pressable>)}
            {selected.source_url && <Pressable accessibilityRole="link" style={styles.catalogButton} onPress={() => { void open(selected.source_url!); }}><Text style={styles.accent}>Página da igreja no site da congregação ↗</Text></Pressable>}
            {linkError && <Text accessibilityRole="alert" style={styles.error}>{linkError}</Text>}
          </> : <>
            <TextInput accessibilityLabel="Pesquisar igreja no catálogo" value={query} onChangeText={setQuery} placeholder="Pesquisar igreja" placeholderTextColor={colors.muted} style={styles.input} />
            <Text style={styles.muted}>{filtered.length} igrejas</Text>
            <View style={styles.grid}>{filtered.map((church) => <Pressable accessibilityRole="button" accessibilityLabel={`Ver informações de ${church.name}`} key={church.id} style={styles.tile} onPress={() => show(church)}><ChurchPhoto key={church.photo_url ?? church.id} uri={church.photo_url} /><Text style={styles.tileName}>{church.name}</Text></Pressable>)}</View>
            {!filtered.length && <Text style={styles.muted}>{loading ? 'Carregando igrejas…' : 'Nenhuma igreja encontrada.'}</Text>}
          </>}
        </ScrollView>
      </View></View>
    </Modal>
  </>;
}
function Detail({ label, value }: { label: string; value?: string | null }) { return value ? <View style={{ gap: 5 }}><Text style={styles.accent}>{label}</Text><Text selectable style={styles.body}>{value}</Text></View> : null; }
const styles = StyleSheet.create({
  heading: { flexDirection: 'row', flexWrap: 'wrap', justifyContent: 'space-between', alignItems: 'center', gap: 8 },
  section: { color: colors.text, fontWeight: '800', fontSize: 12, letterSpacing: 1 },
  catalogButton: { minHeight: 44, justifyContent: 'center', paddingVertical: 8 },
  accent: { color: colors.accent, fontSize: 12, fontWeight: '700' },
  muted: { color: colors.muted, fontSize: 12, lineHeight: 20 },
  title: { color: colors.text, fontSize: 19, fontWeight: '800' },
  body: { color: colors.text, fontSize: 14, lineHeight: 23 },
  card: { backgroundColor: colors.surface, borderRadius: 24, borderWidth: 1, borderColor: colors.border, overflow: 'hidden' },
  cardContent: { padding: 18, gap: 10 },
  photo: { width: '100%', height: 110, backgroundColor: colors.inset },
  largePhoto: { height: 180, borderRadius: 16 },
  fallback: { alignItems: 'center', justifyContent: 'center', gap: 8 },
  backdrop: { flex: 1, justifyContent: 'center', padding: 16, backgroundColor: '#000000bb' },
  modal: { height: '90%', maxWidth: 520, width: '100%', alignSelf: 'center', backgroundColor: colors.background, borderRadius: 26, overflow: 'hidden', borderWidth: 1, borderColor: colors.border },
  modalHeader: { padding: 16, flexDirection: 'row', alignItems: 'center', gap: 12, borderBottomWidth: 1, borderBottomColor: colors.border },
  close: { minWidth: 44, minHeight: 44, alignItems: 'center', justifyContent: 'center' },
  modalContent: { padding: 16, gap: 18, paddingBottom: 30 },
  input: { padding: 14, borderRadius: 14, borderWidth: 1, borderColor: colors.border, color: colors.text, backgroundColor: colors.surface },
  grid: { flexDirection: 'row', flexWrap: 'wrap', gap: 12 },
  tile: { width: '47%', flexGrow: 1, maxWidth: '49%', backgroundColor: colors.surface, borderRadius: 16, overflow: 'hidden', borderWidth: 1, borderColor: colors.border },
  tileName: { padding: 12, fontSize: 14, fontWeight: '700', color: colors.text },
  mapButton: { minHeight: 48, padding: 14, alignItems: 'center', justifyContent: 'center', backgroundColor: colors.primary, borderRadius: 14 },
  buttonText: { color: colors.text, fontWeight: '700', fontSize: 14 },
  error: { color: colors.danger, lineHeight: 22 },
});
