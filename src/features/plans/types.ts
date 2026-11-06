/**
 * Tipos da feature Planos de Leitura (Fase 3c).
 * Dados lidos do Supabase; persistência de progresso em `user_plan_progress`.
 */

export interface Plan {
  id: string;
  title: string;
  description: string | null;
  duration_days: number;
  start_date: string | null;
  cover_image_url: string | null;
  created_at: string | null;
  updated_at: string | null;
}

export interface PlanDayContent {
  id: string;
  plan_id: string;
  /** Dia do plano (agrupa os capítulos lidos no dia). */
  day_number: number;
  /** Ordem do capítulo dentro do dia (1..N). */
  sort_order: number;
  /** Slug do livro no padrão do catálogo (ex.: "gn", "sl"). */
  book_abbrev: string;
  /** Número do capítulo. */
  chapter: number;
  /** NULL = capítulo inteiro; usados apenas nas partes do Salmos 119. */
  start_verse: number | null;
  end_verse: number | null;
}

export interface PlanWithContents extends Plan {
  contents: PlanDayContent[];
}

export interface PlanDayProgress {
  plan_id: string;
  day_number: number;
  status: 'PENDING' | 'COMPLETED';
  completed_at: string | null;
  updated_at: string | null;
}

export type PlanDayStatus = 'PENDING' | 'COMPLETED';
