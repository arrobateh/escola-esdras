import { createContext, useContext, useEffect, useState, type ReactNode } from 'react';
import { useAuth } from '../auth';
import { fetchCatalog, type CatalogEntry } from './catalog';

interface CatalogState { entries: CatalogEntry[]; loading: boolean; error: boolean; reload: () => void }
const Context = createContext<CatalogState | null>(null);
export function CatalogProvider({ children }: { children: ReactNode }) {
  const { user } = useAuth();
  const [request, setRequest] = useState(0);
  const key = `${user?.id ?? ''}:${request}`;
  const [result, setResult] = useState<{ key: string; entries: CatalogEntry[]; error: boolean } | null>(null);
  useEffect(() => {
    let active = true;
    if (!user?.id) return;
    void fetchCatalog().then((entries) => { if (active) setResult({ key, entries, error: false }); })
      .catch(() => { if (active) setResult({ key, entries: [], error: true }); });
    return () => { active = false; };
  }, [key, user?.id]);
  const entries = result?.key === key ? result.entries : [];
  const loading = !!user?.id && result?.key !== key;
  const error = result?.key === key && result.error;
  return <Context.Provider value={{ entries, loading, error, reload: () => setRequest((value) => value + 1) }}>{children}</Context.Provider>;
}
export function useCatalog() {
  const state = useContext(Context);
  if (!state) throw new Error('CatalogProvider ausente');
  return state;
}
