#!/usr/bin/env python3
"""Valida o catálogo revisável e gera SQL de importação em rascunho.

Não conecta ao banco e não publica conteúdo. IDs determinísticos permitem
reexecutar a importação sem duplicar hinos ou sobrescrever letras já revisadas.
"""
import argparse
import json
from pathlib import Path
import uuid


def literal(value):
    if value is None:
        return 'NULL'
    if not isinstance(value, str) or '\x00' in value:
        raise ValueError('Texto inválido')
    # E-string independente de standard_conforming_strings.
    return "E'" + value.replace('\\', '\\\\').replace("'", "''") + "'"


def generate(catalog):
    edition = catalog['hymnal_id']
    pages = catalog['source_pages']
    if not isinstance(edition, str) or not edition.strip():
        raise ValueError('hymnal_id obrigatório')
    if type(pages) is not int or pages < 1:
        raise ValueError('source_pages inválido')
    rows = []
    numbers = set()
    for item in catalog['hymns']:
        number = item['number']
        start, end = item['page_start'], item['page_end']
        if type(number) is not int or number < 1 or number in numbers:
            raise ValueError('Número inválido ou duplicado')
        numbers.add(number)
        if type(start) is not int or type(end) is not int or not 1 <= start <= end <= pages:
            raise ValueError('Intervalo de páginas inválido')
        title = item['title']
        if not isinstance(title, str) or not title.strip():
            raise ValueError('Título obrigatório')
        if item.get('review_status', 'draft') != 'draft':
            raise ValueError('Esta ferramenta importa somente rascunhos')
        key = str(uuid.uuid5(uuid.NAMESPACE_URL, f'escola-esdras/hymnals/{edition}/{number}'))
        rows.append(
            f'insert into public.hymns (id, title, lyrics) values '
            f'({literal(key)}, {literal(title)}, {literal(item.get("lyrics"))}) '
            'on conflict (id) do nothing;\n'
            'insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) '
            f'values ({literal(edition)}, {literal(key)}, {number}, {start}, {end}) '
            'on conflict (hymnal_id, number) do nothing;'
        )
    return '-- Gerado localmente; somente rascunhos. Requer migration_hymnals.sql.\n' + \
        'begin;\n' + '\n'.join(rows) + '\ncommit;\n'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('catalog', type=Path)
    parser.add_argument('output', type=Path)
    args = parser.parse_args()
    result = generate(json.loads(args.catalog.read_text(encoding='utf-8')))
    args.output.write_text(result, encoding='utf-8')


if __name__ == '__main__':
    main()
