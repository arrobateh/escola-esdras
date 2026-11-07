#!/usr/bin/env python3
"""Gera uma transação: importa rascunhos e publica só transcrições conferidas.

Não acessa o Supabase. Letras já revisadas/publicadas no banco são preservadas.
"""
import argparse
import json
from pathlib import Path
import uuid

from prepare_import import generate, literal


def build(catalog, reviewed):
    if reviewed['hymnal_id'] != catalog['hymnal_id']:
        raise ValueError('Edições diferentes')
    if reviewed['source_pages'] != catalog['source_pages']:
        raise ValueError('Fontes diferentes')
    by_number = {item['number']: item for item in catalog['hymns']}
    checked = []
    for item in reviewed['hymns']:
        if item['number'] not in by_number or item.get('review_status') != 'reviewed':
            raise ValueError('Revisão sem vínculo ou não conferida')
        if not isinstance(item.get('lyrics'), str) or not item['lyrics'].strip():
            raise ValueError('Letra conferida vazia')
        checked.append({**item, 'review_status': 'draft'})
    # Aproveita as validações de unicidade, páginas e escape do importador.
    generate({**reviewed, 'hymns': checked})
    sql = generate(catalog)
    sql = sql[:sql.rfind('commit;')]
    edition = catalog['hymnal_id']
    for item in checked:
        key = str(uuid.uuid5(uuid.NAMESPACE_URL, f'escola-esdras/hymnals/{edition}/{item["number"]}'))
        sql += (
            '\n-- Letra transcrita e conferida visualmente no PDF.\n'
            f'update public.hymns set title = {literal(item["title"])}, '
            f'lyrics = {literal(item["lyrics"])}, reviewed_at = now(), review_status = \'published\' '
            f'where id = {literal(key)} and review_status = \'draft\';\n'
        )
    sql += f'\nupdate public.hymnals set published = true where id = {literal(edition)};\ncommit;\n'
    sql += (
        '\n-- Resultado esperado em banco vazio: 325 vínculos, 10 publicados, 315 rascunhos.\n'
        'select h.title, h.published, v.review_status, count(*) as quantidade\n'
        'from public.hymnals h join public.hymnal_hymns hh on hh.hymnal_id = h.id\n'
        'join public.hymns v on v.id = hh.hymn_id\n'
        f'where h.id = {literal(edition)} group by h.id, h.title, h.published, v.review_status;\n'
    )
    return sql.replace('-- Gerado localmente; somente rascunhos. Requer migration_hymnals.sql.',
        '-- Importa catálogo em rascunho e publica SOMENTE o lote conferido. Requer migration_hymnals.sql.')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source', type=Path)
    parser.add_argument('output', type=Path)
    args = parser.parse_args()
    catalog = json.loads((args.source / 'catalog.draft.json').read_text())
    reviewed = json.loads((args.source / 'reviewed.json').read_text())
    args.output.write_text(build(catalog, reviewed), encoding='utf-8')


if __name__ == '__main__':
    main()
