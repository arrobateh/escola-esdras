import { fetchPlanDashboard } from '../../features/plans/dashboard';
import { aboutParagraphs } from '../../features/profile/about';
import { FavoriteVerseCard } from '../../features/profile/FavoriteVerseCard';
import { Icon } from '../../components/Icon';
import { UsageCard } from '../../features/usage/UsageCard';
import { useFocusEffect } from 'expo-router';
import { useCallback, useEffect, useState } from 'react';
import { ActivityIndicator, Modal, Pressable, ScrollView, StyleSheet, Text, TextInput, View } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';

import { useDatabase, type ReadStats } from '../../db';
import { useAuth } from '../../features/auth';
import { readingActivity } from '../../features/home/readingActivity';
import { useSync } from '../../features/sync';
import { supabase } from '../../lib/supabase';
import { colors } from '../../theme/colors';

interface Profile { full_name: string | null; church_name: string | null; created_at: string | null }
export default function YouScreen() {
  const { user, signOut } = useAuth();
  const db = useDatabase();
  const { syncing, lastError, lastSyncedAt, syncNow } = useSync();
  const [profile, setProfile] = useState<Profile | null>(null);
  const [stats, setStats] = useState<ReadStats | null>(null);
  const [booksCompleted, setBooksCompleted] = useState<number | null>(null);
  const [activity, setActivity] = useState<Awaited<ReturnType<typeof readingActivity>> | null>(null);
  const [notice, setNotice] = useState<string | null>(null);
  const [edit, setEdit] = useState(false);
  const [nameInput, setNameInput] = useState('');
  const [churchInput, setChurchInput] = useState('');
  const [churches, setChurches] = useState<{ id: string; name: string }[]>([]);
  const [searchedChurchTerm, setSearchedChurchTerm] = useState('');
  const [churchError, setChurchError] = useState<string | null>(null);
  const [selectedChurch, setSelectedChurch] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);
  const [saveError, setSaveError] = useState<string | null>(null);
  const [leaving, setLeaving] = useState(false);
  const [settingsPage, setSettingsPage] = useState<'settings' | 'about' | null>(null);
  const metadataName = user?.user_metadata?.full_name;
  const name = profile?.full_name || (typeof metadataName === 'string' ? metadataName : '') || 'Seu perfil';

  useFocusEffect(useCallback(() => {
    let active = true;
    async function load() {
      if (!user?.id) return;
      const results = await Promise.allSettled([
        fetchPlanDashboard(user.id), readingActivity(db, user.id),
        (async () => {
          if (!supabase) throw new Error('Sem conexão configurada');
          const { data, error } = await supabase.from('profiles').select('full_name, church_name, created_at').eq('id', user.id).single();
          if (error) throw error;
          return data as Profile;
        })(),
      ]);
      if (!active) return;
      const [summary, history, account] = results;
      setStats(summary.status === 'fulfilled' ? summary.value : null);
      setBooksCompleted(summary.status === 'fulfilled' ? summary.value.booksCompleted : null);
      setActivity(history.status === 'fulfilled' ? history.value : null);
      if (account.status === 'fulfilled') setProfile(account.value);
      setNotice(results.some((result) => result.status === 'rejected') ? 'Algumas informações estão indisponíveis. Volte a esta tela com conexão para atualizar.' : null);
    }
    void load();
    return () => { active = false; };
  }, [db, user]));

  useEffect(() => {
    const term = churchInput.trim().replace(/[%_\\]/g, '');
    if (!edit || term.length < 3 || selectedChurch !== null) return;
    let active = true;
    const timer = setTimeout(() => {
      void (async () => {
        if (!supabase) return;
        const term = churchInput.trim().replace(/[%_\\]/g, '');
        const { data, error } = await supabase.from('churches').select('id, name').ilike('name', `%${term}%`).order('name').limit(15);
        if (active) { setSearchedChurchTerm(churchInput); setChurches(error ? [] : data ?? []); setChurchError(error ? 'Cadastro de igrejas indisponível. Verifique se a migração foi aplicada.' : null); }
      })();
    }, 250);
    return () => { active = false; clearTimeout(timer); };
  }, [edit, churchInput, selectedChurch]);

  async function save() {
    if (!user?.id || !supabase || saving) return;
    if (!nameInput.trim()) { setSaveError('Informe seu nome.'); return; }
    setSaving(true); setSaveError(null);
    try {
      const church = churchInput.trim() || null;
      const churchChanged = church !== (profile?.church_name || null);
      if (churchChanged && church && selectedChurch !== churchInput) { setSaveError('Selecione uma igreja nos resultados da busca ou deixe o campo vazio.'); return; }
      // Perfis existentes usam as policies SELECT/UPDATE já presentes no projeto.
      // Alterar apenas o nome não depende da migração de igrejas ou de uma RPC.
      const changes = churchChanged
        ? { full_name: nameInput.trim(), church_name: church }
        : { full_name: nameInput.trim() };
      const result = await supabase.from('profiles').update(changes as never).eq('id', user.id).select('full_name, church_name, created_at').maybeSingle();
      if (result.error) throw result.error;
      let data = result.data as Profile | null;
      if (!data) {
        // Instalações antigas podem ter usuários sem linha de perfil.
        const created = await supabase.rpc('save_own_profile', { profile_name: nameInput.trim(), profile_church: church } as never).single();
        if (created.error) {
          if (created.error.code === 'PGRST202') throw new Error('Seu perfil ainda não foi criado. O administrador precisa aplicar migration_profile_churches.sql no Supabase.');
          throw created.error;
        }
        data = created.data as Profile | null;
      }
      if (!data) throw new Error('O servidor não retornou o perfil salvo.');
      setProfile(data); setEdit(false);
    } catch (error) {
      const detail = error && typeof error === 'object' && 'message' in error ? String(error.message) : 'Tente novamente.';
      setSaveError(`Não foi possível salvar: ${detail}`);
    }
    finally { setSaving(false); }
  }

  async function logout() {
    if (leaving) return;
    setLeaving(true);
    try { await signOut(); }
    catch { setNotice('Não foi possível sair da conta. Tente novamente.'); }
    finally { setLeaving(false); }
  }

  return <SafeAreaView style={styles.screen} edges={['top', 'left', 'right']}>
    <View style={styles.header}><Text style={styles.eyebrow}>SEU PERFIL</Text><View style={styles.row}>
      <Pressable accessibilityRole="button" accessibilityLabel="Sincronizar progresso" disabled={syncing} onPress={() => { void syncNow(); }} style={styles.iconButton}><Icon name="cloud-arrow-up" /></Pressable>
      <Pressable accessibilityRole="button" accessibilityLabel="Configurações" onPress={() => setSettingsPage('settings')} style={styles.iconButton}><Icon name="gear" /></Pressable>
    </View></View>
    <ScrollView contentContainerStyle={styles.content}>
      {notice && <Text accessibilityRole="alert" style={styles.muted}>{notice}</Text>}
      <View style={styles.card}>
        <View style={styles.row}><View style={styles.avatar}><Text style={styles.avatarText}>{name.slice(0, 1).toUpperCase()}</Text></View><View style={styles.identity}><Text style={styles.name}>{name}</Text><Text style={styles.accent}>⌂ {profile?.church_name || 'Igreja não informada'}</Text>{profile?.created_at && <Text style={styles.small}>Membro desde {new Date(profile.created_at).toLocaleDateString('pt-BR', { month: '2-digit', year: 'numeric' })}</Text>}</View><Pressable accessibilityRole="button" accessibilityLabel="Editar perfil" style={styles.iconButton} onPress={() => { setNameInput(name); setChurchInput(profile?.church_name ?? ''); setSelectedChurch(profile?.church_name ?? null); setSaveError(null); setEdit(true); }}><Icon name="pen" size={13} /></Pressable></View>
        <FavoriteVerseCard />
      </View>
      <View style={styles.row}><Icon name="chart-line" /><Text style={styles.section}>DASHBOARD DE LEITURA</Text></View>
      <Text style={styles.small}>{syncing ? 'Sincronizando progresso…' : lastError ? 'Sincronização pendente' : lastSyncedAt ? `Última sincronização: ${new Date(lastSyncedAt).toLocaleString('pt-BR')}` : 'Aguardando sincronização'}</Text>
      <Text style={styles.small}>Capítulos e livros contabilizados pelos desafios concluídos do plano.</Text>
      <View style={styles.grid}>
        <Metric progress={activity ? (activity.bestStreak > 0 ? activity.streak / activity.bestStreak * 100 : 0) : undefined} progressLabel="Sequência atual em relação à melhor sequência" icon="fire" gold best={activity?.bestStreak} title="Ofensiva ativa" value={activity ? String(activity.streak) : '—'} detail="dias de desafio seguidos" />
        <Metric progress={stats ? stats.totalRead / stats.totalChapters * 100 : undefined} icon="book-open" title="Capítulos lidos" value={stats ? String(stats.totalRead) : '—'} detail={stats ? `de ${stats.totalChapters} capítulos` : 'Indisponível'} />
        <Metric progress={stats?.percent} icon="chart-pie" title="Bíblia concluída" value={stats ? `${stats.percent}%` : '—'} detail="Conforme desafios concluídos" />
        <Metric progress={booksCompleted === null ? undefined : booksCompleted / 66 * 100} icon="book-bookmark" gold title="Livros concluídos" value={booksCompleted === null ? '—' : String(booksCompleted)} detail="de 66 livros" />
      </View>
      <UsageCard />
      <View style={styles.card}><Text style={styles.small}>Conta conectada</Text><Text selectable style={styles.muted}>{user?.email ?? '—'}</Text></View>
      <Pressable accessibilityRole="button" disabled={leaving} onPress={() => { void logout(); }} style={styles.logout}>{leaving ? <ActivityIndicator color={colors.text} /> : <Text style={styles.danger}>Sair da conta</Text>}</Pressable>
    </ScrollView>
    <Modal visible={edit} transparent animationType="slide" onRequestClose={() => { if (!saving) setEdit(false); }}><View style={styles.backdrop}><View style={styles.modal}><ScrollView keyboardShouldPersistTaps="handled" contentContainerStyle={styles.modalInner}>
      <Text style={styles.name}>Editar perfil</Text><Text style={styles.muted}>Nome completo</Text><TextInput accessibilityLabel="Nome completo" value={nameInput} onChangeText={setNameInput} editable={!saving} maxLength={150} style={styles.input} />
      <Text style={styles.muted}>Pesquisar igreja</Text><TextInput placeholder="Digite pelo menos 3 caracteres" placeholderTextColor={colors.muted} accessibilityLabel="Pesquisar igreja" value={churchInput} onChangeText={(text) => { setChurchInput(text); setSelectedChurch(null); setChurches([]); setChurchError(null); setSearchedChurchTerm(''); }} editable={!saving} maxLength={200} style={styles.input} />
      {selectedChurch === null && churchInput.trim().length >= 3 && churchError && <Text style={styles.danger}>{churchError}</Text>}
      {selectedChurch === null && churchInput.trim().length >= 3 && searchedChurchTerm === churchInput && !churchError && churches.length === 0 && <Text style={styles.muted}>Nenhuma igreja encontrada. O administrador precisa cadastrar as igrejas.</Text>}
      {selectedChurch === null && churchInput.trim().length >= 3 && searchedChurchTerm === churchInput && churches.map((church) => <Pressable accessibilityRole="button" key={church.id} style={styles.input} onPress={() => { setChurchInput(church.name); setSelectedChurch(church.name); }}><Text style={styles.accent}>{selectedChurch === church.name ? '✓ ' : ''}{church.name}</Text></Pressable>)}
      {saveError && <Text accessibilityRole="alert" style={styles.danger}>{saveError}</Text>}
      <Pressable accessibilityRole="button" disabled={saving} onPress={() => { void save(); }} style={styles.save}>{saving ? <ActivityIndicator color={colors.text} /> : <Text style={styles.buttonText}>Salvar alterações</Text>}</Pressable>
      <Pressable accessibilityRole="button" disabled={saving} onPress={() => setEdit(false)} style={styles.iconButton}><Text style={styles.muted}>Cancelar</Text></Pressable>
    </ScrollView></View></View></Modal>
    <Modal visible={settingsPage !== null} transparent animationType="slide" onRequestClose={() => setSettingsPage(settingsPage === 'about' ? 'settings' : null)}>
      <View style={styles.backdrop}><View style={styles.modal}>
        <View style={styles.settingsHeader}><Text style={styles.name}>{settingsPage === 'about' ? 'Sobre' : 'Configurações'}</Text><Pressable accessibilityRole="button" accessibilityLabel="Fechar configurações" onPress={() => setSettingsPage(null)} style={styles.iconButton}><Icon name="xmark" /></Pressable></View>
        <ScrollView contentContainerStyle={styles.modalInner}>
          {settingsPage === 'settings' ? <Pressable accessibilityRole="button" onPress={() => setSettingsPage('about')} style={styles.collection}><Icon name="circle-info" /><View style={styles.identity}><Text style={styles.name}>Sobre</Text><Text style={styles.muted}>Conheça o propósito da Escola de Esdras</Text></View><Icon name="chevron-right" size={12} /></Pressable> : <>
            <Pressable accessibilityRole="button" onPress={() => setSettingsPage('settings')} style={styles.aboutBack}><Icon name="chevron-left" size={12} /><Text style={styles.accent}>Configurações</Text></Pressable>
            {aboutParagraphs.map((paragraph, index) => <Text selectable key={index} style={index === 0 ? styles.aboutVerse : styles.aboutParagraph}>{paragraph}</Text>)}
          </>}
        </ScrollView>
      </View></View>
    </Modal>
  </SafeAreaView>;
}
function Metric({ title, value, detail, icon, gold = false, best, progress, progressLabel }: { title: string; value: string; detail: string; icon: Parameters<typeof Icon>[0]['name']; gold?: boolean; best?: number; progress?: number; progressLabel?: string }) {
  return <View style={styles.metric}><View style={styles.metricHeader}><Text style={[styles.small, { flex: 1 }]}>{title.toUpperCase()}</Text><View style={[styles.metricIcon, gold && styles.goldIcon]}><Icon name={icon} size={14} color={gold ? '#fbbf24' : '#34d399'} /></View></View><Text style={styles.metricValue}>{value}</Text><Text style={styles.muted}>{detail}</Text>{best !== undefined && <Text style={styles.best}>Melhor: {best}d</Text>}{progress !== undefined && <View accessibilityRole="progressbar" accessibilityLabel={progressLabel ?? title} accessibilityValue={{ min: 0, max: 100, now: Math.round(Math.max(0, Math.min(100, progress))) }} style={styles.progressTrack}><View style={[styles.progressFill, { width: `${Math.max(0, Math.min(100, progress))}%`, backgroundColor: gold ? '#fbbf24' : '#34d399' }]} /></View>}</View>;
}
const styles = StyleSheet.create({
  settingsHeader: { padding: 18, flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', borderBottomWidth: 1, borderBottomColor: colors.border },
  aboutBack: { flexDirection: 'row', alignItems: 'center', gap: 8, minHeight: 44 },
  aboutVerse: { color: colors.accent, fontSize: 15, lineHeight: 26, fontStyle: 'italic', padding: 16, borderRadius: 16, backgroundColor: colors.surface },
  aboutParagraph: { color: colors.text, fontSize: 14, lineHeight: 25 },
  screen: { flex: 1, backgroundColor: colors.background },
  header: { paddingHorizontal: 20, paddingVertical: 12, flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', borderBottomWidth: 1, borderBottomColor: colors.border },
  content: { padding: 20, paddingBottom: 36, gap: 16 },
  row: { flexDirection: 'row', alignItems: 'center', gap: 12 },
  eyebrow: { color: colors.accent, fontSize: 12, letterSpacing: 1, fontWeight: '800' },
  section: { color: colors.text, fontSize: 12, fontWeight: '800', letterSpacing: 1, marginTop: 8 },
  card: { backgroundColor: colors.surface, padding: 18, borderRadius: 24, borderWidth: 1, borderColor: colors.border, gap: 14 },
  avatar: { width: 64, height: 64, borderRadius: 32, backgroundColor: colors.primary, borderWidth: 2, borderColor: colors.accent, alignItems: 'center', justifyContent: 'center' },
  avatarText: { color: colors.text, fontSize: 28, fontWeight: '800' },
  identity: { flex: 1, gap: 6 },
  name: { color: colors.text, fontSize: 16, fontWeight: '800' },
  accent: { color: colors.accent, fontSize: 13, fontWeight: '600' },
  muted: { color: colors.muted, fontSize: 13, lineHeight: 20 },
  small: { color: colors.muted, fontSize: 11, lineHeight: 17 },
  motto: { backgroundColor: colors.background, borderRadius: 16, padding: 14, borderLeftWidth: 3, borderLeftColor: colors.primary, gap: 10 },
  quote: { color: colors.text, fontSize: 14, fontStyle: 'italic', lineHeight: 24 },
  grid: { flexDirection: 'row', flexWrap: 'wrap', gap: 12 },
  metricHeader: { flexDirection: 'row', alignItems: 'center', gap: 6 },
  metricIcon: { width: 28, height: 28, borderRadius: 9, backgroundColor: '#164e3b', justifyContent: 'center', alignItems: 'center' },
  goldIcon: { backgroundColor: '#493914' },
  best: { color: '#fbbf24', backgroundColor: '#493014', alignSelf: 'flex-start', paddingHorizontal: 7, paddingVertical: 3, borderRadius: 5, fontSize: 11, fontWeight: '700' },
  metric: { flexGrow: 1, flexBasis: '45%', padding: 16, gap: 8, borderRadius: 20, backgroundColor: colors.surface, borderWidth: 1, borderColor: colors.border },
  progressTrack: { height: 5, borderRadius: 3, backgroundColor: colors.border, overflow: 'hidden', marginTop: 'auto' },
  progressFill: { height: '100%', borderRadius: 3 },
  metricValue: { color: colors.text, fontSize: 28, fontWeight: '800' },
  week: { flexDirection: 'row', justifyContent: 'space-between', gap: 6 },
  day: { alignItems: 'center', gap: 8 },
  dayDot: { width: 32, height: 32, borderRadius: 16, borderWidth: 1, borderColor: colors.border, justifyContent: 'center', alignItems: 'center' },
  done: { backgroundColor: colors.primary, borderColor: colors.accent },
  today: { borderColor: colors.gold, borderWidth: 2 },
  collection: { flexDirection: 'row', alignItems: 'center', gap: 12, backgroundColor: colors.surface, padding: 18, borderRadius: 20, borderWidth: 1, borderColor: colors.border },
  iconButton: { minWidth: 44, minHeight: 44, padding: 10, alignItems: 'center', justifyContent: 'center', borderRadius: 22, backgroundColor: colors.inset },
  logout: { padding: 16, alignItems: 'center', borderRadius: 16, backgroundColor: colors.dangerSurface },
  danger: { color: colors.danger, fontSize: 14, fontWeight: '600' },
  backdrop: { flex: 1, backgroundColor: '#000000bb', justifyContent: 'center', padding: 20 },
  modal: { backgroundColor: colors.background, borderRadius: 24, borderWidth: 1, borderColor: colors.border, maxHeight: '85%', width: '100%', maxWidth: 440, alignSelf: 'center' },
  modalInner: { padding: 22, gap: 14 },
  input: { backgroundColor: colors.surface, color: colors.text, borderRadius: 14, padding: 14, borderWidth: 1, borderColor: colors.border },
  save: { padding: 14, minHeight: 48, alignItems: 'center', justifyContent: 'center', backgroundColor: colors.primary, borderRadius: 14 },
  buttonText: { color: colors.text, fontWeight: '700' },
});
