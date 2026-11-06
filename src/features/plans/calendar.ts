/** Calendário compartilhado da igreja, independente do fuso do aparelho. */
export function churchDate(now = new Date()): string {
  const parts = new Intl.DateTimeFormat('en-US', { timeZone: 'America/Sao_Paulo', year: 'numeric', month: '2-digit', day: '2-digit' }).formatToParts(now);
  const get = (type: string) => parts.find((part) => part.type === type)!.value;
  return `${get('year')}-${get('month')}-${get('day')}`;
}
export function planCalendar(startDate: string | null | undefined, duration: number, now = new Date()) {
  const today = churchDate(now);
  const idle = (status: 'unconfigured' | 'upcoming' | 'sunday' | 'finished') => ({ status, day: null, today } as const);
  if (!startDate || !/^\d{4}-\d{2}-\d{2}$/.test(startDate)) return idle('unconfigured');
  const start = new Date(`${startDate}T00:00:00Z`);
  if (!Number.isFinite(start.getTime()) || start.toISOString().slice(0, 10) !== startDate) return idle('unconfigured');
  const end = new Date(`${today}T00:00:00Z`);
  const elapsed = Math.floor((end.getTime() - start.getTime()) / 86400000);
  if (elapsed < 0) return idle('upcoming');
  const count = elapsed + 1;
  let days = Math.floor(count / 7) * 6;
  for (let i = 0; i < count % 7; i++) if ((start.getUTCDay() + i) % 7 !== 0) days++;
  if (days > duration || (end.getUTCDay() === 0 && days >= duration)) return idle('finished');
  if (end.getUTCDay() === 0) return idle('sunday');
  return { status: 'active', day: days, today } as const;
}
export function calendarMessage(status: ReturnType<typeof planCalendar>['status']) {
  switch (status) {
    case 'unconfigured': return 'A data de início deste plano ainda não foi configurada pelo administrador.';
    case 'upcoming': return 'Este plano ainda não começou.';
    case 'sunday': return 'Domingo não tem desafio programado. Retome seu plano na segunda-feira.';
    case 'finished': return 'O calendário deste plano terminou.';
    default: return '';
  }
}

/** Dias programados estritamente anteriores a hoje, inclusive aos domingos. */
export function previousPlanDays(startDate: string | null | undefined, duration: number, now = new Date()) {
  const calendar = planCalendar(startDate, duration, now);
  if (calendar.status === 'unconfigured' || calendar.status === 'upcoming' || !startDate) return [];
  const result: { day: number; date: string }[] = [];
  const cursor = new Date(`${startDate}T00:00:00Z`);
  let day = 0;
  while (cursor.toISOString().slice(0, 10) < calendar.today && day < duration) {
    if (cursor.getUTCDay() !== 0) result.push({ day: ++day, date: cursor.toISOString().slice(0, 10) });
    cursor.setUTCDate(cursor.getUTCDate() + 1);
  }
  return result.reverse();
}
