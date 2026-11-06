import type { BibleJson } from './types';

/**
 * Faz o download de uma tradução bíblica (JSON) e faz o parse.
 *
 * Tenta reportar progresso granular usando `response.body` (quando suportado
 * pelo runtime). Caso contrário, cai para `response.text()` e reporta o
 * progresso como concluído de uma vez. Erros de rede e de HTTP são convertidos
 * em mensagens amigáveis em pt-BR.
 */
export async function downloadBibleJson(
  url: string,
  onProgress?: (received: number, total: number) => void
): Promise<BibleJson> {
  let response: Response;
  try {
    response = await fetch(url);
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    throw new Error(`Falha de rede ao baixar a tradução: ${message}`);
  }

  if (!response.ok) {
    throw new Error(`Servidor respondeu HTTP ${response.status} ao baixar a tradução.`);
  }

  const contentLength = Number(response.headers.get('content-length')) || 0;
  const body = response.body;
  const canStream = typeof body?.getReader === 'function' && typeof TextDecoder !== 'undefined';
  const reader = canStream && body ? body.getReader() : null;

  if (!reader) {
    // Runtime sem suporte a streaming de resposta: lê tudo de uma vez.
    const text = await response.text();
    onProgress?.(text.length, contentLength || text.length);
    return parseBibleJson(text);
  }

  const chunks: Uint8Array[] = [];
  let received = 0;
  const decoder = new TextDecoder('utf-8');

  for (;;) {
    const { done, value } = await reader.read();
    if (done) break;
    if (value) {
      chunks.push(value);
      received += value.byteLength;
      onProgress?.(received, contentLength);
    }
  }

  const text =
    chunks.map((chunk) => decoder.decode(chunk, { stream: true })).join('') + decoder.decode();
  return parseBibleJson(text);
}

/** Converte o texto JSON bruto no formato tipado, com validação mínima. */
function parseBibleJson(text: string): BibleJson {
  let data: unknown;
  try {
    data = JSON.parse(text);
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    throw new Error(`Resposta do servidor não é um JSON válido: ${message}`);
  }

  if (!Array.isArray(data)) {
    throw new Error('Estrutura inesperada: esperava um array de livros no JSON da tradução.');
  }

  return data as BibleJson;
}
