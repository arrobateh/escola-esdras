import { supabase } from '../../lib/supabase';
import type { Plan, PlanDayContent, PlanDayProgress, PlanDayStatus, PlanWithContents } from './types';

function normalizeError(error: unknown): Error {
  if (error instanceof Error) return error;
  return new Error(String(error));
}

/**
 * Busca todos os planos de leitura e seus conteúdos diários no Supabase.
 */
export async function fetchPlans(): Promise<PlanWithContents[]> {
  if (!supabase) throw new Error('Supabase não configurado.');

  const { data: plans, error: plansError } = await supabase
    .from('reading_plans')
    .select('*')
    .order('created_at', { ascending: false })
    .returns<Plan[]>();

  if (plansError) throw normalizeError(plansError.message);

  const { data: contents, error: contentsError } = await supabase
    .from('plan_day_contents')
    .select('*')
    .order('day_number', { ascending: true })
    .order('sort_order', { ascending: true })
    .returns<PlanDayContent[]>();

  if (contentsError) throw normalizeError(contentsError.message);

  const contentsByPlan = new Map<string, PlanDayContent[]>();
  for (const c of (contents ?? []) as PlanDayContent[]) {
    if (!contentsByPlan.has(c.plan_id)) {
      contentsByPlan.set(c.plan_id, []);
    }
    contentsByPlan.get(c.plan_id)!.push(c);
  }

  return (plans ?? []).map((p) => ({
    ...(p as Plan),
    contents: contentsByPlan.get(p.id) ?? [],
  }));
}

/**
 * Busca o progresso do usuário em um plano específico.
 */
export async function fetchUserPlanProgress(
  planId: string,
  userId: string
): Promise<PlanDayProgress[]> {
  if (!supabase) throw new Error('Supabase não configurado.');

  const { data, error } = await supabase
    .from('user_plan_progress')
    .select('*')
    .eq('plan_id', planId)
    .eq('user_id', userId);

  if (error) throw normalizeError(error.message);
  return (data ?? []) as PlanDayProgress[];
}

/**
 * Atualiza o status de um dia do plano para o usuário.
 *
 * Decisão de implementação:
 * - COMPLETED: upsert com completed_at preenchido.
 * - PENDING: deletamos o registro. Isso mantém a tabela enxuta e reflete
 *   "o usuário ainda não completou este dia" sem precisar de linhas vazias.
 */
export async function setPlanDayStatus(
  planId: string,
  userId: string,
  dayNumber: number,
  status: PlanDayStatus
): Promise<void> {
  if (!supabase) throw new Error('Supabase não configurado.');

  if (status === 'PENDING') {
    const { error } = await supabase
      .from('user_plan_progress')
      .delete()
      .eq('plan_id', planId)
      .eq('user_id', userId)
      .eq('day_number', dayNumber);

    if (error) throw normalizeError(error.message);
    return;
  }

  const now = new Date().toISOString();
  const row = {
    plan_id: planId,
    user_id: userId,
    day_number: dayNumber,
    status: 'COMPLETED',
    completed_at: now,
    updated_at: now,
  };

  const { error } = await supabase.from('user_plan_progress').upsert(row as never, {
    onConflict: 'user_id,plan_id,day_number',
  });

  if (error) throw normalizeError(error.message);
}

/** Conclui em lote sem sobrescrever as datas dos objetivos já concluídos. */
export async function completePlanDays(planId: string, userId: string, days: number[]): Promise<void> {
  if (!supabase) throw new Error('Supabase não configurado.');
  const unique = [...new Set(days)];
  if (!unique.length) return;
  if (unique.some((day) => !Number.isInteger(day) || day < 1)) throw new Error('Intervalo inválido.');
  const now = new Date().toISOString();
  const { error: updateError } = await supabase.from('user_plan_progress')
    .update({ status: 'COMPLETED', completed_at: now, updated_at: now } as never)
    .eq('user_id', userId).eq('plan_id', planId).eq('status', 'PENDING').in('day_number', unique);
  if (updateError) throw normalizeError(updateError.message);
  const rows = unique.map((day) => ({ plan_id: planId, user_id: userId, day_number: day, status: 'COMPLETED', completed_at: now, updated_at: now }));
  const { error } = await supabase.from('user_plan_progress').upsert(rows as never, { onConflict: 'user_id,plan_id,day_number', ignoreDuplicates: true });
  if (error) throw normalizeError(error.message);
}
