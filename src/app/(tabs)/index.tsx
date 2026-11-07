import { ChurchShowcase } from '../../features/churches/ChurchShowcase';
import { Icon } from '../../components/Icon';
import { useFocusEffect, useRouter } from 'expo-router';
import { useCallback, useState } from 'react';
import { ImageBackground, Pressable, ScrollView, Share, StyleSheet, Text, View } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';

import { APP_NAME } from '../../config/constants';
import { useAuth } from '../../features/auth';
import { useSync } from '../../features/sync';

import { readingActivity } from '../../features/home/readingActivity';
import { useDatabase } from '../../db';
import { BOOKS_CATALOG } from '../../db/books-catalog';
import { continuation, dailyVerse, localDay, type DailyVerse } from '../../features/home/content';

export default function HomeScreen() {
  const router = useRouter();
  const db = useDatabase();
  const [daily, setDaily] = useState<DailyVerse | null>(null);
  const [reading, setReading] = useState<Awaited<ReturnType<typeof continuation>>>(null);
  const [activity, setActivity] = useState<Awaited<ReturnType<typeof readingActivity>> | null>(null);
  const [activityError, setActivityError] = useState(false);
  const [contentError, setContentError] = useState(false);
  const { user } = useAuth();
  const { syncing, lastError, lastSyncedAt } = useSync();
  useFocusEffect(useCallback(() => {
    let active = true;
    async function load() {
      if (!user?.id) return;
      try {
        const [verse, next, activity] = await Promise.all([dailyVerse(db, user.id), continuation(db, user.id), readingActivity(db, user.id).catch(() => null)]);
        if (active) { setDaily(verse); setReading(next); setActivity(activity); setActivityError(activity === null); setContentError(false); }
      } catch { if (active) setContentError(true); }
    }
    void load();
    let day = localDay();
    const timer = setInterval(() => { const next = localDay(); if (next !== day) { day = next; void load(); } }, 1000);
    return () => { active = false; clearInterval(timer); };
  }, [db, user]));
  const verse = daily?.text ?? (contentError ? 'Não foi possível carregar o versículo. Tente novamente ao voltar a esta tela.' : 'Carregando versículo…');
  const reference = daily ? `${BOOKS_CATALOG.find((book) => book.abbrev === daily.book)?.name ?? daily.book} ${daily.chapter}:${daily.verse} ${daily.translation.replace('pt_', '').toUpperCase()}` : '';
  const openReading = () => router.navigate(reading ? { pathname: '/biblia', params: { book: reading.book.abbrev, chapter: String(reading.chapter), translation: reading.translation, request: String(Date.now()) } } : '/biblia');
  const fullName = user?.user_metadata?.full_name;
  const name = typeof fullName === 'string' ? fullName.trim().split(/\s+/)[0] : '';
  const hour = new Date().getHours();
  const greeting = hour < 12 ? 'Bom dia' : hour < 18 ? 'Boa tarde' : 'Boa noite';
  const syncLabel = syncing ? 'Sincronizando progresso' : lastError ? 'Sincronização pendente' : lastSyncedAt ? 'Progresso sincronizado' : 'Aguardando sincronização';

  return (
    <SafeAreaView style={styles.screen} edges={['top', 'left', 'right']}>
      <View style={styles.header}>
        <View style={styles.row}>
          <View style={styles.identity}><View style={styles.logo}><Icon name="book-bible" color="#fbbf24" size={20} /></View><Text style={styles.brand}>{APP_NAME}</Text></View>
          <Pressable accessibilityRole="button" accessibilityLabel="Abrir meu perfil" onPress={() => router.navigate('/voce')} style={styles.avatar}>
            <Text style={styles.avatarText}>{(name || 'V').slice(0, 1).toUpperCase()}</Text>
          </Pressable>
        </View>
        <Text accessibilityLiveRegion="polite" style={styles.sync}>{syncLabel}</Text>
      </View>
        <ScrollView contentContainerStyle={styles.content}>
          <View><Text style={styles.title}>{greeting}{name ? `, ${name}` : ''}</Text><Text style={styles.subtitle}>Medite na palavra de Deus hoje</Text></View>
          <View style={styles.streakCard}>
            <View style={styles.streakHeader}>
              <View style={styles.flame}><Icon name="fire" color="#fbbf24" size={22} /></View>
              <View style={styles.streakCopy}><Text style={styles.streakTitle}>{activity ? `${activity.streak} ${activity.streak === 1 ? 'Dia Seguido' : 'Dias Seguidos'}` : activityError || contentError ? 'Histórico indisponível' : 'Carregando histórico…'}</Text><Text style={styles.streakSubtitle}>Conclua o objetivo diário do plano, de segunda a sábado.</Text></View>
            </View>
            {activityError && <Text style={styles.streakSubtitle}>Não foi possível consultar o plano. Volte a esta tela com conexão para atualizar.</Text>}
            <Pressable accessibilityRole="button" onPress={() => router.navigate('/planos')}><Text style={styles.link}>Ver objetivo do plano →</Text></Pressable>
            {activity && <View style={styles.week}>{activity.week.map((day) => <View key={day.date} style={styles.weekDay} accessibilityLabel={`${day.date}: ${day.completed ? 'objetivo do plano concluído' : 'objetivo do plano não concluído'}${day.today ? ', hoje' : ''}`}>
              <Text style={[styles.dayLabel, day.today && styles.todayLabel]}>{day.label}</Text>
              <View style={[styles.dayCircle, day.completed && styles.completedDay, day.today && styles.todayCircle]}><Text style={[styles.dayMark, day.today && styles.todayMark]}>{day.completed ? '✓' : day.today ? 'Hoje' : '·'}</Text></View>
            </View>)}</View>}
          </View>
          <ImageBackground source={{ uri: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80' }} style={styles.verseCard} imageStyle={styles.verseImage}>
            <View style={styles.verseOverlay}>
              <View style={styles.row}><Text style={styles.badge}>VERSÍCULO DO DIA</Text><Text style={styles.reference}>{reference}</Text></View>
              <Text selectable style={styles.verse}>“{verse}”</Text>
              <Pressable accessibilityRole="button" disabled={!daily} onPress={() => { void Share.share({ message: `${verse}\n${reference}` }).catch(() => {}); }} style={styles.share}><Text style={styles.shareText}>Compartilhar versículo ↗</Text></Pressable>
              <Pressable accessibilityRole="button" disabled={!daily} onPress={() => daily && router.navigate({ pathname: '/biblia', params: { book: daily.book, chapter: String(daily.chapter), translation: daily.translation, request: String(Date.now()) } })} style={styles.primaryButton}><Text style={styles.buttonText}>Ler capítulo {daily?.chapter ?? ""} completo →</Text></Pressable>
            </View>
          </ImageBackground>
          <Pressable accessibilityRole="button" onPress={openReading} style={styles.card}>
            <View style={styles.row}><Text style={styles.eyebrow}>▮ CONTINUAR LEITURA</Text>{reading && <Text style={styles.smallBadge}>{reading.book.testament === 'NT' ? 'Novo Testamento' : 'Antigo Testamento'}</Text>}</View>
            <Text style={styles.cardTitle}>{reading ? `${reading.book.name} ${reading.chapter}${reading.lastVerse ? `:1–${reading.lastVerse}` : ''}` : 'Comece sua leitura'}</Text>
            <Text numberOfLines={1} style={styles.description}>{reading?.preview ? `“${reading.preview}”` : contentError ? 'Não foi possível carregar sua leitura.' : 'Abra a Bíblia para ler e acompanhar seu progresso.'}</Text>
            {reading && <><View style={styles.row}><Text style={styles.description}>Progresso do Livro</Text><Text style={styles.eyebrow}>{reading.percent}%</Text></View><View style={styles.progressTrack}><View style={[styles.progressFill, { width: `${reading.percent}%` }]} /></View></>}
            <View style={styles.primaryButton}><Text style={styles.buttonText}>{reading ? '▶ Retomar Leitura' : 'Abrir Bíblia →'}</Text></View>
          </Pressable>
          <Pressable accessibilityRole="button" accessibilityLabel="Abrir hinários" onPress={() => router.push('/hinarios')} style={styles.card}>
            <View style={styles.row}><Icon name="music" size={24} color="#d4a373" /><Text style={styles.eyebrow}>HINÁRIOS</Text><Icon name="chevron-right" /></View>
            <Text style={styles.cardTitle}>Louvores da nossa igreja</Text>
            <Text style={styles.description}>Encontre os hinários por compositor e acompanhe as letras.</Text>
          </Pressable>
          <ChurchShowcase />
        </ScrollView>


    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  streakCard: { backgroundColor: '#262626', borderRadius: 24, padding: 16, borderWidth: 1, borderColor: '#404040', gap: 14 },
  streakHeader: { flexDirection: 'row', alignItems: 'center', gap: 12 },
  flame: { fontSize: 24, backgroundColor: '#443719', padding: 9, borderRadius: 16 },
  streakCopy: { flex: 1, gap: 4 },
  streakTitle: { color: '#fff', fontSize: 16, fontWeight: '800' },
  streakSubtitle: { color: '#a3a3a3', fontSize: 12, lineHeight: 18 },
  week: { flexDirection: 'row', justifyContent: 'space-between', borderTopWidth: 1, borderTopColor: '#404040', paddingTop: 12 },
  weekDay: { alignItems: 'center', gap: 7 },
  dayLabel: { color: '#a3a3a3', fontSize: 12 },
  todayLabel: { color: '#fbbf24', fontWeight: '800' },
  dayCircle: { width: 30, height: 30, borderRadius: 15, borderWidth: 1, borderColor: '#525252', alignItems: 'center', justifyContent: 'center' },
  completedDay: { borderColor: '#34d399', backgroundColor: '#14532d' },
  todayCircle: { borderColor: '#fbbf24', backgroundColor: '#fbbf24' },
  dayMark: { color: '#34d399', fontSize: 14 },
  todayMark: { color: '#171717', fontSize: 10, fontWeight: '800' },
  progressTrack: { height: 6, backgroundColor: '#404040', borderRadius: 3, overflow: 'hidden' },
  progressFill: { height: 6, backgroundColor: '#46855e' },
  screen: { flex: 1, backgroundColor: '#171717' },
  header: { paddingHorizontal: 20, paddingTop: 12, paddingBottom: 14, gap: 12, borderBottomWidth: 1, borderBottomColor: '#303030' },
  row: { flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', gap: 8, flexWrap: 'wrap' },
  identity: { flexDirection: 'row', alignItems: 'center', gap: 10 },
  logo: { color: '#fbbf24', backgroundColor: '#23533e', padding: 7, borderRadius: 12, fontSize: 20 },
  brand: { color: '#fff', fontSize: 16, fontWeight: '800' },
  avatar: { width: 44, height: 44, borderRadius: 22, backgroundColor: '#23533e', alignItems: 'center', justifyContent: 'center', borderWidth: 1, borderColor: '#6aa37e' },
  avatarText: { color: '#e1eee5', fontWeight: '700', fontSize: 18 },
  sync: { color: '#a3b18a', fontSize: 12 },
  content: { padding: 20, gap: 22, paddingBottom: 32 },
  title: { color: '#f5f5f5', fontSize: 23, fontWeight: '800' },
  subtitle: { color: '#a3a3a3', fontSize: 14, marginTop: 5 },
  verseCard: { backgroundColor: '#23533e', borderRadius: 24, overflow: 'hidden', borderWidth: 1, borderColor: '#404040' },
  verseImage: { opacity: 0.35 },
  verseOverlay: { padding: 20, gap: 20, backgroundColor: '#00000055', minHeight: 320, justifyContent: 'space-between' },
  badge: { color: '#fde68a', fontSize: 11, fontWeight: '800', letterSpacing: 1 },
  reference: { color: '#fff', fontSize: 12, fontWeight: '700' },
  verse: { color: '#f5f5f5', fontFamily: 'serif', fontSize: 22, lineHeight: 34, fontStyle: 'italic', borderLeftWidth: 3, borderLeftColor: '#6aa37e', paddingLeft: 14 },
  share: { minHeight: 44, alignItems: 'center', justifyContent: 'center', borderTopWidth: 1, borderTopColor: '#ffffff33' },
  shareText: { color: '#e1eee5', fontSize: 14, fontWeight: '600' },
  primaryButton: { backgroundColor: '#2d6a4f', borderRadius: 16, minHeight: 48, padding: 14, alignItems: 'center', justifyContent: 'center' },
  buttonText: { color: '#fff', fontWeight: '800', fontSize: 14 },
  card: { backgroundColor: '#262626', padding: 20, borderRadius: 24, borderWidth: 1, borderColor: '#46855e', gap: 10 },
  eyebrow: { color: '#99c3a6', fontSize: 12, fontWeight: '800', letterSpacing: 1 },
  cardTitle: { color: '#fff', fontSize: 18, fontWeight: '800' },
  description: { color: '#a3a3a3', fontSize: 14, lineHeight: 22 },
  link: { color: '#99c3a6', fontSize: 14, fontWeight: '700', marginTop: 4 },
  sectionTitle: { color: '#d4d4d4', fontWeight: '800', fontSize: 12, letterSpacing: 1 },
  smallBadge: { color: '#99c3a6', fontSize: 11, backgroundColor: '#132a13', padding: 7, borderRadius: 8 },
  churchCard: { padding: 20, gap: 10, borderRadius: 24, backgroundColor: '#202b24', borderWidth: 1, borderColor: '#3a4b3f' },
  churchIcon: { color: '#d4a373', fontSize: 36 },
  backdrop: { flex: 1, backgroundColor: '#000000bb', justifyContent: 'center', padding: 24 },
  modal: { backgroundColor: '#171717', padding: 24, borderRadius: 28, gap: 18, borderWidth: 1, borderColor: '#404040', width: '100%', maxWidth: 430, alignSelf: 'center' },
});
