import { useCallback, useEffect, useRef, useState } from 'react';
import { AppState, type NativeScrollEvent, type NativeSyntheticEvent } from 'react-native';

const DWELL_SECONDS = 45;
const SCROLL_THRESHOLD = 0.7;

interface DwellState {
  /** O usuário permaneceu pelo tempo mínimo no capítulo. */
  dwelledEnough: boolean;
  /** O usuário rolou mais de 70% do conteúdo (ou não há rolagem). */
  scrolledEnough: boolean;
  /** Callback para onScroll do ScrollView. */
  onScroll: (event: NativeSyntheticEvent<NativeScrollEvent>) => void;
  /** Callback para onLayout do ScrollView. */
  onLayout: (event: { nativeEvent: { layout: { width: number; height: number } } }) => void;
  /** Callback para onContentSizeChange do ScrollView. */
  onContentSizeChange: (w: number, h: number) => void;
  /** Reinicia o estado quando o capítulo muda. */
  reset: () => void;
}

/**
 * Hook que mede "dwell time" de leitura de um capítulo.
 *
 * Regras:
 *  - 45s de permanência no capítulo;
 *  - rolagem > 70% do conteúdo (ou conteúdo menor que a viewport);
 *  - o timer é pausado quando o app vai para background (AppState).
 *
 * O hook NÃO marca o capítulo automaticamente; apenas expõe os sinais
 * para que a UI ofereça um CTA de "Marcar como lido".
 */
export function useReadingDwell(): DwellState {
  const [dwelledEnough, setDwelledEnough] = useState(false);
  const [scrolledEnough, setScrolledEnough] = useState(false);

  const viewportHeightRef = useRef(0);
  const contentHeightRef = useRef(0);
  const elapsedRef = useRef(0);
  const lastTickRef = useRef<number | null>(null);
  const timerRef = useRef<ReturnType<typeof setInterval> | null>(null);
  const appStateRef = useRef(AppState.currentState);

  const clearTimer = useCallback(() => {
    if (timerRef.current) {
      clearInterval(timerRef.current);
      timerRef.current = null;
    }
  }, []);

  const startTimer = useCallback(() => {
    clearTimer();
    lastTickRef.current = Date.now();
    timerRef.current = setInterval(() => {
      const now = Date.now();
      const last = lastTickRef.current ?? now;
      elapsedRef.current += now - last;
      lastTickRef.current = now;

      if (elapsedRef.current >= DWELL_SECONDS * 1000) {
        setDwelledEnough(true);
        clearTimer();
      }
    }, 1000);
  }, [clearTimer]);

  const reset = useCallback(() => {
    clearTimer();
    elapsedRef.current = 0;
    lastTickRef.current = null;
    setDwelledEnough(false);
    setScrolledEnough(false);
    viewportHeightRef.current = 0;
    contentHeightRef.current = 0;
    startTimer();
  }, [clearTimer, startTimer]);

  useEffect(() => {
    startTimer();
    return () => {
      clearTimer();
    };
  }, [clearTimer, startTimer]);

  useEffect(() => {
    const subscription = AppState.addEventListener('change', (nextAppState) => {
      const prev = appStateRef.current;
      appStateRef.current = nextAppState;

      if (prev === 'background' && nextAppState === 'active') {
        // Voltou para foreground: retoma o timer.
        startTimer();
      } else if (nextAppState === 'background') {
        // Foi para background: pausa o timer.
        clearTimer();
      }
    });

    return () => {
      subscription.remove();
    };
  }, [clearTimer, startTimer]);

  const checkNoScrollNeeded = useCallback(() => {
    const viewportH = viewportHeightRef.current;
    const contentH = contentHeightRef.current;

    if (viewportH > 0 && contentH > 0 && contentH <= viewportH) {
      setScrolledEnough(true);
    }
  }, []);

  const onLayout = useCallback(
    (event: { nativeEvent: { layout: { width: number; height: number } } }) => {
      viewportHeightRef.current = event.nativeEvent.layout.height;
      checkNoScrollNeeded();
    },
    [checkNoScrollNeeded]
  );

  const onContentSizeChange = useCallback(
    (_: number, height: number) => {
      contentHeightRef.current = height;
      checkNoScrollNeeded();
    },
    [checkNoScrollNeeded]
  );

  const onScroll = useCallback((event: NativeSyntheticEvent<NativeScrollEvent>) => {
    const { contentOffset, contentSize, layoutMeasurement } = event.nativeEvent;
    const scrollY = contentOffset.y;
    const viewportH = layoutMeasurement.height;
    const contentH = contentSize.height;

    viewportHeightRef.current = viewportH;
    contentHeightRef.current = contentH;

    if (contentH <= viewportH) {
      setScrolledEnough(true);
      return;
    }

    const ratio = (scrollY + viewportH) / contentH;
    setScrolledEnough(ratio > SCROLL_THRESHOLD);
  }, []);

  return {
    dwelledEnough,
    scrolledEnough,
    onScroll,
    onLayout,
    onContentSizeChange,
    reset,
  };
}
