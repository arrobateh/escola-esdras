#!/usr/bin/env python3
"""Separa OCR usando limites auditáveis; nunca publica letras automaticamente."""
import argparse
import json
from pathlib import Path
import re


def segment(source):
    boundaries = json.loads((source / 'boundaries.json').read_text())['boundaries']
    pages = {p: (source / 'ocr' / f'page-{p:03d}.txt').read_text().splitlines()
             for p in range(3, 161)}
    # A digitalização intercala trechos de 134 e 139. Não anexar uma letra à outra.
    exceptions = {
        134: [(65, 38, len(pages[65])), (66, 0, 16), (67, 0, 12)],
        139: [(66, 17, len(pages[66])), (69, 0, 21)],
        138: [(68, 45, len(pages[68]))],
    }
    rows = []
    seen = set()
    for index, head in enumerate(boundaries):
        number = head['number']
        if number in seen:
            raise ValueError(f'Número duplicado: {number}')
        seen.add(number)
        next_head = boundaries[index + 1] if index + 1 < len(boundaries) else None
        spans = []
        for page in range(head['page'], (next_head['page'] if next_head else 160) + 1):
            start = head['body_line'] if page == head['page'] else 0
            end = next_head['line'] if next_head and page == next_head['page'] else len(pages[page])
            if start < end:
                spans.append((page, start, end))
        spans = exceptions.get(number, spans)
        chunks = []
        for page, start, end in spans:
            if not 0 <= start < end <= len(pages[page]):
                raise ValueError(f'Limite inválido: {number}, página {page}')
            chunks.append('\n'.join(pages[page][start:end]).strip())
        lyrics = '\n\n'.join(filter(None, chunks))
        if number == 329:
            lyrics = re.split(r'(?im)^\s*FIM\.?\s*$', lyrics)[0].strip()
        if not lyrics:
            raise ValueError(f'Hino sem extração: {number}')
        rows.append({
            'number': number, 'title': head['title'], 'lyrics': lyrics,
            'page_start': min(p for p, _, _ in spans),
            'page_end': max(p for p, _, _ in spans), 'review_status': 'draft',
            'source_segments': [{'page': p, 'line_start': a, 'line_end_exclusive': b}
                                for p, a, b in spans],
            'review_notes': 'OCR com erros: conferir a letra inteira, título, limites e estrofes no PDF.',
        })
    return {
        'hymnal_id': 'inspiracoes-9-2019', 'source_pages': 160,
        'missing_source_numbers': sorted(set(range(1, 330)) - seen),
        'note': '325 entradas identificadas. A fonte salta 232→237. Letras não revisadas.',
        'hymns': sorted(rows, key=lambda row: row['number']),
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source', type=Path)
    args = parser.parse_args()
    catalog = segment(args.source)
    (args.source / 'catalog.draft.json').write_text(
        json.dumps(catalog, ensure_ascii=False, indent=2) + '\n')


if __name__ == '__main__':
    main()
