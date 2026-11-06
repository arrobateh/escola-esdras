import { SafeAreaView } from 'react-native-safe-area-context';
import { colors } from '../../theme/colors';
import { useFocusEffect, router } from 'expo-router';
import { useCallback, useState } from 'react';
import {
  ActivityIndicator,
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  View,
} from 'react-native';

import { useAuth } from '../../features/auth';
import { fetchPlans, fetchUserPlanProgress, type PlanWithContents } from '../../features/plans';

interface PlanWithProgress extends PlanWithContents {
  completedDays: number;
}

export default function PlansScreen() {
  const { user } = useAuth();
  const userId = user?.id ?? '';

  const [plans, setPlans] = useState<PlanWithProgress[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const load = useCallback(async () => {
    if (!userId) return;
    setLoading(true);
    setError(null);
    try {
      const fetchedPlans = await fetchPlans();
      const enriched = await Promise.all(
        fetchedPlans.map(async (plan) => {
          const progress = await fetchUserPlanProgress(plan.id, userId);
          const completedDays = progress.filter((p) => p.status === 'COMPLETED').length;
          return { ...plan, completedDays };
        })
      );
      setPlans(enriched);
    } catch (err) {
      const message = err instanceof Error ? err.message : 'Erro ao carregar planos.';
      setError(message);
    } finally {
      setLoading(false);
    }
  }, [userId]);

  useFocusEffect(
    useCallback(() => {
      load();
    }, [load])
  );

  if (loading) {
    return (
      <View style={styles.centered}>
        <ActivityIndicator size="large" />
      </View>
    );
  }

  if (error) {
    return (
      <View style={styles.centered}>
        <Text style={styles.error}>{error}</Text>
        <Pressable style={styles.retryButton} onPress={load}>
          <Text style={styles.retryButtonText}>Tentar novamente</Text>
        </Pressable>
      </View>
    );
  }

  if (plans.length === 0) {
    return (
      <View style={styles.centered}>
        <Text style={styles.emptyTitle}>Nenhum plano disponível ainda.</Text>
        <Text style={styles.emptySubtitle}>Volte em breve para conferir novos planos de leitura.</Text>
      </View>
    );
  }

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: colors.background }} edges={['top', 'left', 'right']}><ScrollView contentContainerStyle={styles.content}>
      <Text style={styles.title}>Planos de Leitura</Text>
      {plans.map((plan) => (
        <Pressable
          key={plan.id}
          style={({ pressed }) => [styles.card, pressed && styles.pressed]}
          onPress={() => router.push(`/plano/${plan.id}`)}
        >
          <Text style={styles.cardTitle}>{plan.title}</Text>
          {plan.description ? (
            <Text style={styles.cardDescription} numberOfLines={2}>
              {plan.description}
            </Text>
          ) : null}
          <View style={styles.cardFooter}>
            <Text style={styles.cardDuration}>{plan.duration_days} dias</Text>
            <Text style={styles.cardProgress}>
              {plan.completedDays} de {plan.duration_days} concluídos
            </Text>
          </View>
          <View style={styles.track}>
            <View
              style={[
                styles.fill,
                {
                  width: `${plan.duration_days > 0 ? (plan.completedDays / plan.duration_days) * 100 : 0}%`,
                },
              ]}
            />
          </View>
        </Pressable>
      ))}
    </ScrollView></SafeAreaView>
  );
}

const styles = StyleSheet.create({
  centered: {
    backgroundColor: colors.background,
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 24,
  },
  content: {
    padding: 16,
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
  cardTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: colors.text,
  },
  cardDescription: {
    fontSize: 14,
    color: colors.muted,
    marginTop: 6,
  },
  cardFooter: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginTop: 12,
  },
  cardDuration: {
    fontSize: 13,
    color: colors.muted,
    fontWeight: '500',
  },
  cardProgress: {
    fontSize: 13,
    color: colors.accent,
    fontWeight: '600',
  },
  track: {
    height: 8,
    backgroundColor: colors.border,
    borderRadius: 4,
    marginTop: 10,
    overflow: 'hidden',
  },
  fill: {
    height: '100%',
    backgroundColor: colors.primary,
    borderRadius: 4,
  },
  error: {
    color: colors.danger,
    textAlign: 'center',
    marginBottom: 16,
  },
  retryButton: {
    backgroundColor: colors.primary,
    borderRadius: 14,
    paddingVertical: 10,
    paddingHorizontal: 18,
  },
  retryButtonText: {
    color: colors.text,
    fontWeight: '600',
  },
  emptyTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: colors.text,
  },
  emptySubtitle: {
    fontSize: 14,
    color: colors.muted,
    marginTop: 8,
    textAlign: 'center',
  },
  pressed: {
    opacity: 0.7,
  },
});
