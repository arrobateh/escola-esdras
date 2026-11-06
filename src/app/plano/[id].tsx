import { Icon } from '../../components/Icon';
import { planCalendar, calendarMessage, previousPlanDays } from '../../features/plans/calendar';
import { SafeAreaView } from 'react-native-safe-area-context';
import { colors } from '../../theme/colors';
import { useFocusEffect, useLocalSearchParams, useRouter } from 'expo-router';
import { useCallback, useState } from 'react';
import {
  ActivityIndicator,
  ImageBackground,
  Modal,
  FlatList,
  TextInput,
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  View,
} from 'react-native';

import { BOOKS_CATALOG } from '../../db/books-catalog';
import { useAuth } from '../../features/auth';
import {
  fetchPlans,
  fetchUserPlanProgress,
  setPlanDayStatus,
  completePlanDays,
  type PlanDayContent,
  type PlanDayProgress,
  type PlanWithContents,
} from '../../features/plans';

export default function PlanDetailScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const router = useRouter();
  const { user } = useAuth();
  const userId = user?.id ?? '';

  const [plan, setPlan] = useState<PlanWithContents | null>(null);
  const [progress, setProgress] = useState<PlanDayProgress[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [rangeStart, setRangeStart] = useState('1');
  const [rangeEnd, setRangeEnd] = useState('');
  const [rangeReview, setRangeReview] = useState<number[] | null>(null);
  const [bulkBusy, setBulkBusy] = useState(false);
  const [bulkMessage, setBulkMessage] = useState<string | null>(null);
  const [historyVisible, setHistoryVisible] = useState(false);
  const [updateError, setUpdateError] = useState<string | null>(null);
  const [updatingDay, setUpdatingDay] = useState<number | null>(null);

  useFocusEffect(useCallback(() => {
    let cancelled = false;

    async function load() {
      if (!userId || !id) return;
      setLoading(true);
      setError(null);
      try {
        const plans = await fetchPlans();
        const found = plans.find((p) => p.id === id) ?? null;
        if (!cancelled) {
          if (!found) {
            setError('Plano não encontrado.');
          } else {
            setPlan(found);
            const userProgress = await fetchUserPlanProgress(id, userId);
            setProgress(userProgress);
          }
        }
      } catch (err) {
        const message = err instanceof Error ? err.message : 'Erro ao carregar o plano.';
        if (!cancelled) setError(message);
      } finally {
        if (!cancelled) setLoading(false);
      }
    }

    load();
    return () => {
      cancelled = true;
    };
  }, [id, userId]));

  async function toggleDay(dayNumber: number, historical = false) {
    if (!userId || !plan || updatingDay != null || bulkBusy) return;
    const allowed = historical
      ? previousPlanDays(plan.start_date, plan.duration_days).some((entry) => entry.day === dayNumber)
      : planCalendar(plan.start_date, plan.duration_days).day === dayNumber;
    if (!allowed) return;

    const isCompleted = isDayCompleted(dayNumber);
    const nextStatus = isCompleted ? 'PENDING' : 'COMPLETED';

    setUpdateError(null);
    setUpdatingDay(dayNumber);
    try {
      await setPlanDayStatus(plan.id, userId, dayNumber, nextStatus);
      const updated = await fetchUserPlanProgress(plan.id, userId);
      setProgress(updated);
    } catch (err) {
      const message = err instanceof Error ? err.message : 'Erro ao atualizar o progresso.';
      setUpdateError(message);
    } finally {
      setUpdatingDay(null);
    }
  }

  function reviewRange() {
    if (!plan || bulkBusy || updatingDay !== null) return;
    setUpdateError(null); setBulkMessage(null); setRangeReview(null);
    const start = Number(rangeStart), end = Number(rangeEnd);
    const allowed = previousPlanDays(plan.start_date, plan.duration_days);
    const last = allowed[0]?.day ?? 0;
    if (!/^\d+$/.test(rangeStart) || !/^\d+$/.test(rangeEnd) || start < 1 || end < start || end > last) {
      setUpdateError(`Informe um intervalo entre 1 e ${last}, com início menor ou igual ao fim.`); return;
    }
    const days = allowed.filter((entry) => entry.day >= start && entry.day <= end && !isDayCompleted(entry.day) && contentsForDay(entry.day).length > 0).map((entry) => entry.day);
    if (!days.length) { setBulkMessage('Todos os dias deste intervalo já estão concluídos ou não possuem leituras.'); return; }
    setRangeReview(days);
  }

  async function confirmRange() {
    if (!plan || !userId || !rangeReview || bulkBusy || updatingDay !== null) return;
    setBulkBusy(true); setUpdateError(null); setBulkMessage(null);
    try {
      const allowed = new Set(previousPlanDays(plan.start_date, plan.duration_days).map((entry) => entry.day));
      if (rangeReview.some((day) => !allowed.has(day))) throw new Error('O calendário mudou. Selecione novamente o intervalo.');
      await completePlanDays(plan.id, userId, rangeReview);
      setProgress(await fetchUserPlanProgress(plan.id, userId));
      setBulkMessage('Intervalo registrado. Os dias já concluídos foram preservados.');
      setRangeReview(null);
    } catch (error) { setUpdateError(error instanceof Error ? error.message : 'Não foi possível salvar o intervalo. Tente novamente.'); }
    finally { setBulkBusy(false); }
  }

  function isDayCompleted(dayNumber: number): boolean {
    return progress.some((p) => p.day_number === dayNumber && p.status === 'COMPLETED');
  }

  function contentsForDay(dayNumber: number): PlanDayContent[] {
    return (plan?.contents ?? [])
      .filter((c) => c.day_number === dayNumber)
      .sort((a, b) => a.sort_order - b.sort_order);
  }

  const completedDays = progress.filter((p) => p.status === 'COMPLETED').length;
  const totalDays = plan?.duration_days ?? 0;
  const today = new Date();
  const calendar = planCalendar(plan?.start_date, totalDays, today);
  const currentDay = calendar.day;
  const sunday = calendar.status === 'sunday';
  const previousDays = previousPlanDays(plan?.start_date, totalDays, today);
  const dailyContents = currentDay ? contentsForDay(currentDay) : [];

  if (loading) {
    return (
      <View style={styles.centered}>
        <ActivityIndicator size="large" />
      </View>
    );
  }

  if (error || !plan) {
    return (
      <View style={styles.centered}>
        <Text style={styles.error}>{error ?? 'Plano não encontrado.'}</Text>
        <Pressable style={styles.retryButton} onPress={() => router.back()}>
          <Text style={styles.retryButtonText}>Voltar</Text>
        </Pressable>
      </View>
    );
  }

  return (
    <SafeAreaView style={styles.screen} edges={['top', 'left', 'right']}>
      <View style={styles.pageHeader}>
        <Pressable accessibilityRole="button" accessibilityLabel="Voltar para planos" onPress={() => router.back()}><Text style={styles.backButton}>‹ Planos</Text></Pressable>
        <Text style={styles.eyebrow}>PLANO DE LEITURA</Text><Text style={styles.title}>{plan.title}</Text>
      </View>
      <ScrollView contentContainerStyle={styles.content}>
        <ImageBackground source={plan.cover_image_url ? { uri: plan.cover_image_url } : undefined} style={styles.cover} imageStyle={styles.coverImage}>
          <View style={styles.coverOverlay}><Text style={styles.coverLabel}>Sua jornada na Palavra</Text><Text style={styles.coverTitle}>{plan.title}</Text>{plan.description && <Text numberOfLines={3} style={styles.coverDescription}>{plan.description}</Text>}</View>
        </ImageBackground>
        <View style={styles.row}><Text style={styles.dayTitle}>Dias do plano</Text><Text style={styles.description}>{totalDays} dias no total</Text></View>
        <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={styles.dayStrip}>
          {Array.from({ length: Math.min(7, totalDays) }, (_, index) => {
            const first = Math.max(1, Math.min((currentDay ?? totalDays) - 2, totalDays - 6));
            const day = first + index;
            return <View key={day} style={[styles.dayChip, day === currentDay && !sunday && styles.todayChip]}><Text style={styles.dayTitle}>{day}</Text><Text style={styles.chipLabel}>{isDayCompleted(day) ? '✓ Lido' : day === currentDay && !sunday ? 'Hoje' : 'Pendente'}</Text></View>;
          })}
        </ScrollView>
        <Pressable accessibilityRole="button" onPress={() => { setUpdateError(null); setHistoryVisible(true); }} style={styles.historyButton}><Icon name="clock-rotate-left" /><Text style={styles.confirmText}>Dias anteriores ({previousDays.length})</Text></Pressable>
        {updateError && !historyVisible && <Text accessibilityRole="alert" style={styles.error}>{updateError}</Text>}
        <View style={styles.row}><Text style={styles.dayTitle}>Leitura bíblica do dia</Text><Text style={styles.description}>{calendar.today.split('-').reverse().slice(0, 2).join('/')}</Text></View>
        {calendar.status !== 'active' ? <Text style={styles.empty}>{calendarMessage(calendar.status)}</Text> : currentDay ? <>
          <Text style={styles.description}>Dia {currentDay} do plano • {completedDays} dias concluídos</Text>
          {dailyContents.length === 0 && <Text style={styles.empty}>Nenhuma leitura cadastrada para este dia.</Text>}
          {dailyContents.map((content) => <Pressable key={content.id} accessibilityRole="button" style={styles.readingCard} onPress={() => router.navigate({ pathname: '/biblia', params: { book: content.book_abbrev, chapter: String(content.chapter), request: String(Date.now()) } })}>
            <View style={styles.readingIcon}><Icon name="book-open" size={20} /></View><View style={styles.readingCopy}><Text style={styles.dayTitle}>{formatChapterReference(content)}</Text><Text style={styles.description}>{content.start_verse != null ? 'Leitura do trecho indicado' : 'Leitura do capítulo completo'}</Text></View><Icon name="chevron-right" />
          </Pressable>)}
          {dailyContents.length > 0 && <Pressable accessibilityRole="button" disabled={updatingDay !== null || bulkBusy} style={[styles.confirmButton, isDayCompleted(currentDay) && styles.undoButton]} onPress={() => { void toggleDay(currentDay); }}>{updatingDay !== null ? <ActivityIndicator color={colors.text} /> : <Text style={styles.confirmText}>{isDayCompleted(currentDay) ? 'Desfazer desafio concluído' : '✓ Confirmar desafio concluído'}</Text>}</Pressable>}
        </> : <Text style={styles.empty}>✓ Você concluiu todas as leituras deste plano!</Text>}
      </ScrollView>
      <Modal visible={historyVisible} transparent animationType="slide" onRequestClose={() => setHistoryVisible(false)}>
        <View style={styles.backdrop}><View style={styles.historyModal}>
          <View style={styles.historyHeader}><Text style={styles.title}>Dias anteriores</Text><Pressable accessibilityRole="button" accessibilityLabel="Fechar dias anteriores" onPress={() => setHistoryVisible(false)} style={styles.close}><Icon name="xmark" /></Pressable></View>
          <Text style={styles.historyHint}>Registre os objetivos anteriores já cumpridos. A leitura de hoje permanece a mesma.</Text>
          {updateError && <Text accessibilityRole="alert" style={styles.error}>{updateError}</Text>}
          <FlatList ListHeaderComponent={previousDays.length > 0 ? <View style={styles.historyCard}>
            <Text style={styles.dayTitle}>Concluir um intervalo</Text><Text style={styles.description}>Selecione pelos números dos dias do plano (1 a {previousDays[0].day}).</Text>
            <View style={styles.row}><TextInput accessibilityLabel="Dia inicial" placeholder="Do dia" placeholderTextColor={colors.muted} keyboardType="number-pad" editable={!bulkBusy && updatingDay === null} value={rangeStart} onChangeText={(value) => { setRangeStart(value); setRangeReview(null); }} style={styles.rangeInput} /><TextInput accessibilityLabel="Dia final" placeholder="Até o dia" placeholderTextColor={colors.muted} keyboardType="number-pad" editable={!bulkBusy && updatingDay === null} value={rangeEnd} onChangeText={(value) => { setRangeEnd(value); setRangeReview(null); }} style={styles.rangeInput} /></View>
            {rangeReview ? <><Text style={styles.description}>Confirmar a conclusão de {rangeReview.length} dias pendentes entre os dias {rangeStart} e {rangeEnd}? Isso não altera a leitura de hoje.</Text><Pressable accessibilityRole="button" disabled={bulkBusy || updatingDay !== null} onPress={() => { void confirmRange(); }} style={styles.confirmButton}>{bulkBusy ? <ActivityIndicator color={colors.text} /> : <Text style={styles.confirmText}>Confirmar {rangeReview.length} dias</Text>}</Pressable><Pressable accessibilityRole="button" disabled={bulkBusy} onPress={() => setRangeReview(null)} style={styles.close}><Text style={styles.description}>Cancelar</Text></Pressable></> : <Pressable accessibilityRole="button" disabled={bulkBusy || updatingDay !== null} onPress={reviewRange} style={styles.confirmButton}><Text style={styles.confirmText}>Revisar intervalo</Text></Pressable>}
            {bulkMessage && <Text accessibilityLiveRegion="polite" style={styles.description}>{bulkMessage}</Text>}
          </View> : undefined} data={previousDays} keyExtractor={(item) => String(item.day)} contentContainerStyle={styles.content} ListEmptyComponent={<Text style={styles.empty}>Não há dias anteriores disponíveis.</Text>} renderItem={({ item }) => {
            const contents = contentsForDay(item.day);
            const completed = isDayCompleted(item.day);
            return <View style={styles.historyCard}><View style={styles.row}><Text style={styles.dayTitle}>Dia {item.day}</Text><Text style={styles.description}>{item.date.split('-').reverse().join('/')}</Text></View>
              {contents.map((content) => <Pressable key={content.id} accessibilityRole="button" onPress={() => { setHistoryVisible(false); router.navigate({ pathname: '/biblia', params: { book: content.book_abbrev, chapter: String(content.chapter), request: String(Date.now()) } }); }} style={styles.historyReference}><Text style={styles.backButton}>{formatChapterReference(content)} ›</Text></Pressable>)}
              <Pressable accessibilityRole="button" disabled={updatingDay !== null || bulkBusy || contents.length === 0} style={[styles.confirmButton, completed && styles.undoButton]} onPress={() => { void toggleDay(item.day, true); }}>{updatingDay === item.day ? <ActivityIndicator color={colors.text} /> : <Text style={styles.confirmText}>{completed ? 'Desfazer conclusão' : '✓ Marcar como concluído'}</Text>}</Pressable>
            </View>;
          }} />
        </View></View>
      </Modal>
    </SafeAreaView>
  );
}

/**
 * Resolve o nome do livro (em português) a partir do `book_abbrev`.
 */
function resolveBookName(bookAbbrev: string): string {
  return BOOKS_CATALOG.find((b) => b.abbrev === bookAbbrev)?.name ?? bookAbbrev.toUpperCase();
}

/**
 * Formata uma única referência de capítulo/parte.
 * - Capítulo inteiro: "Gênesis 1".
 * - Parte do Salmos 119: "Salmos 119:1–30".
 */
function formatChapterReference(content: PlanDayContent): string {
  const bookName = resolveBookName(content.book_abbrev);

  if (content.start_verse != null && content.end_verse != null) {
    return `${bookName} ${content.chapter}:${content.start_verse}–${content.end_verse}`;
  }

  return `${bookName} ${content.chapter}`;
}

const styles = StyleSheet.create({
  rangeInput: { flex: 1, minWidth: 90, padding: 14, borderRadius: 14, borderWidth: 1, borderColor: colors.border, color: colors.text, backgroundColor: colors.background },
  historyButton: { flexDirection: 'row', alignItems: 'center', justifyContent: 'center', gap: 10, padding: 14, minHeight: 48, backgroundColor: colors.surface, borderWidth: 1, borderColor: colors.border, borderRadius: 16 },
  backdrop: { flex: 1, backgroundColor: '#000000bb', padding: 16, justifyContent: 'center' },
  historyModal: { height: '90%', width: '100%', maxWidth: 500, alignSelf: 'center', backgroundColor: colors.background, borderRadius: 24, overflow: 'hidden' },
  historyHeader: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', padding: 18 },
  close: { width: 44, height: 44, justifyContent: 'center', alignItems: 'center' },
  historyHint: { color: colors.muted, paddingHorizontal: 20, lineHeight: 21 },
  historyCard: { padding: 16, borderRadius: 20, backgroundColor: colors.surface, borderWidth: 1, borderColor: colors.border, gap: 10 },
  historyReference: { minHeight: 44, justifyContent: 'center' },
  screen: { flex: 1, backgroundColor: colors.background },
  centered: { flex: 1, backgroundColor: colors.background, padding: 24, justifyContent: 'center', alignItems: 'center' },
  pageHeader: { padding: 20, borderBottomWidth: 1, borderBottomColor: colors.border, gap: 6 },
  backButton: { color: colors.accent, paddingVertical: 8, fontSize: 14 },
  eyebrow: { color: colors.accent, fontSize: 11, fontWeight: '800', letterSpacing: 1 },
  title: { color: colors.text, fontSize: 22, fontWeight: '800' },
  content: { padding: 20, gap: 16, paddingBottom: 40 },
  cover: { backgroundColor: colors.primary, borderRadius: 24, overflow: 'hidden', minHeight: 170, borderWidth: 1, borderColor: colors.border },
  coverImage: { opacity: 0.55 },
  coverOverlay: { flex: 1, justifyContent: 'flex-end', padding: 20, gap: 8, backgroundColor: '#00000044' },
  coverLabel: { color: colors.accent, fontSize: 12, fontWeight: '700' },
  coverTitle: { color: colors.text, fontSize: 21, fontWeight: '800' },
  coverDescription: { color: colors.text, fontSize: 13, lineHeight: 20 },
  row: { flexDirection: 'row', flexWrap: 'wrap', alignItems: 'center', justifyContent: 'space-between', gap: 8 },
  dayTitle: { color: colors.text, fontSize: 15, fontWeight: '700' },
  description: { color: colors.muted, fontSize: 12, lineHeight: 20 },
  dayStrip: { gap: 8 },
  dayChip: { width: 64, minHeight: 70, padding: 10, gap: 6, borderRadius: 16, borderWidth: 1, borderColor: colors.border, backgroundColor: colors.surface, justifyContent: 'center', alignItems: 'center' },
  todayChip: { backgroundColor: colors.primary, borderColor: colors.accent, borderWidth: 2 },
  chipLabel: { color: colors.accent, fontSize: 10 },
  readingCard: { backgroundColor: colors.surface, borderRadius: 20, padding: 16, borderWidth: 1, borderColor: colors.border, flexDirection: 'row', alignItems: 'center', gap: 12 },
  readingIcon: { width: 44, height: 44, borderRadius: 14, backgroundColor: colors.primary, alignItems: 'center', justifyContent: 'center' },
  readingIconText: { color: colors.accent, fontSize: 22 },
  readingCopy: { flex: 1, gap: 5 },
  arrow: { color: colors.accent, fontSize: 28 },
  confirmButton: { backgroundColor: colors.primary, borderRadius: 16, minHeight: 48, padding: 14, alignItems: 'center', justifyContent: 'center' },
  undoButton: { backgroundColor: '#b91c1c' },
  confirmText: { color: colors.text, fontSize: 14, fontWeight: '700' },
  empty: { color: colors.muted, lineHeight: 24, padding: 20, borderRadius: 20, backgroundColor: colors.surface },
  error: { color: colors.danger, marginBottom: 16, textAlign: 'center' },
  retryButton: { backgroundColor: colors.primary, borderRadius: 14, padding: 14 },
  retryButtonText: { color: colors.text },
});
