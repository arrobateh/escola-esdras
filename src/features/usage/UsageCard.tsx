import { Icon } from '../../components/Icon';
import { useFocusEffect } from 'expo-router';
import { useCallback, useState } from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { useDatabase } from '../../db';
import { useAuth } from '../auth';
import { churchDate } from '../plans/calendar';
import { colors } from '../../theme/colors';

export function UsageCard() {
  const db = useDatabase();
  const { user } = useAuth();
  const [usage, setUsage] = useState<Record<string, number>>({});
  const [error, setError] = useState(false);
  const today = churchDate();
  const monday = new Date(`${today}T12:00:00Z`);
  monday.setUTCDate(monday.getUTCDate() - (monday.getUTCDay() + 6) % 7);
  const days = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'].map((label, index) => { const date = new Date(monday); date.setUTCDate(date.getUTCDate() + index); return { label, day: date.toISOString().slice(0, 10) }; });
  useFocusEffect(useCallback(() => {
    let active = true;
    async function load() {
      if (!user?.id) return;
      try {
        const rows = await db.getAllAsync<{ day: string; milliseconds: number }>('SELECT day, milliseconds FROM app_usage WHERE user_id = ?', user.id);
        if (active) { setUsage(Object.fromEntries(rows.map((row) => [row.day, row.milliseconds]))); setError(false); }
      } catch { if (active) setError(true); }
    }
    void load(); const timer = setInterval(() => { void load(); }, 11000);
    return () => { active = false; clearInterval(timer); };
  }, [db, user]));
  const total = days.reduce((sum, day) => sum + (usage[day.day] ?? 0), 0);
  const max = Math.max(20 * 60000, ...days.map((day) => usage[day.day] ?? 0));
  const achieved = days.filter((day) => (usage[day.day] ?? 0) >= 20 * 60000).length;
  return <View style={styles.card}><View style={styles.header}><View><Text style={styles.title}><Icon name="chart-column" size={12} /> Ritmo da Semana</Text><Text style={styles.muted}>Meta: 20 min diários no aplicativo</Text></View><Text style={styles.badge}>Meta batida {achieved}/7 dias</Text></View>
    {error ? <Text style={styles.muted}>Tempo de uso indisponível.</Text> : <><View style={styles.chart}>{days.map(({ day, label }) => { const ms = usage[day] ?? 0; return <View key={day} style={styles.column} accessibilityLabel={`${label}: ${Math.floor(ms / 60000)} minutos de uso`}><Text style={styles.value}>{Math.floor(ms / 60000)}m</Text><View style={[styles.bar, { height: Math.max(3, ms / max * 95), backgroundColor: day === today ? '#f59e0b' : ms >= 1200000 ? colors.primary : '#525252' }]} /><Text style={[styles.value, day === today && { color: '#fbbf24' }]}>{day === today ? 'Hoje' : label}</Text></View>; })}</View><View style={styles.header}><Text style={styles.muted}>● Meta diária atingida</Text><Text style={styles.title}>Total: {Math.floor(total / 3600000)}h {Math.floor(total / 60000) % 60}m</Text></View></>}
  </View>;
}
const styles = StyleSheet.create({ card: { backgroundColor: colors.surface, padding: 18, borderRadius: 24, borderWidth: 1, borderColor: colors.border, gap: 16 }, header: { flexDirection: 'row', flexWrap: 'wrap', justifyContent: 'space-between', gap: 8 }, title: { color: colors.text, fontSize: 12, fontWeight: '700' }, muted: { color: colors.muted, fontSize: 10 }, badge: { color: colors.accent, backgroundColor: colors.inset, padding: 6, borderRadius: 12, fontSize: 10 }, chart: { flexDirection: 'row', gap: 6, height: 140, alignItems: 'flex-end', borderBottomWidth: 1, borderBottomColor: colors.border, paddingBottom: 10 }, column: { flex: 1, alignItems: 'center', gap: 6 }, value: { color: colors.muted, fontSize: 10 }, bar: { width: '80%', borderTopLeftRadius: 8, borderTopRightRadius: 8 } });
