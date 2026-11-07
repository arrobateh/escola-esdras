#!/usr/bin/env python3
"""OCR por página para revisão, sem publicar nem presumir limites dos hinos.

Requer Poppler (pdfinfo/pdftoppm), Tesseract com idioma por, Pillow e numpy.
Não envia o PDF a serviços externos. Retoma páginas já extraídas.
"""
import argparse
from concurrent.futures import ThreadPoolExecutor
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import tempfile

import numpy as np
from PIL import Image, ImageOps


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('pdf', type=Path)
    parser.add_argument('output', type=Path)
    parser.add_argument('--tesseract', default='tesseract')
    parser.add_argument('--workers', type=int, default=3)
    args = parser.parse_args()
    info = subprocess.check_output(['pdfinfo', str(args.pdf)], text=True)
    pages = int(re.search(r'^Pages:\s+(\d+)', info, re.M)[1])
    digest = hashlib.sha256(args.pdf.read_bytes()).hexdigest()
    args.output.mkdir(parents=True, exist_ok=True)
    manifest = args.output / 'source.json'
    if manifest.exists() and json.loads(manifest.read_text())['sha256'] != digest:
        raise ValueError('A pasta contém extração de outro PDF. Use outra pasta.')
    manifest.write_text(json.dumps({
        'sha256': digest, 'pages': pages, 'review_status': 'draft',
        'language': 'por', 'dpi': 250,
        'note': 'OCR automático. Conferir títulos, letras e continuações no PDF.',
    }, ensure_ascii=False, indent=2) + '\n')

    def extract(page):
        target = args.output / f'page-{page:03d}.txt'
        if target.exists():
            return
        with tempfile.TemporaryDirectory() as tmp:
            prefix = str(Path(tmp) / 'page')
            subprocess.run(['pdftoppm', '-f', str(page), '-l', str(page),
                            '-r', '250', '-singlefile', '-png', str(args.pdf), prefix],
                           check=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE)
            image = ImageOps.grayscale(Image.open(prefix + '.png'))
            # A inclinação é estimada na região central para ignorar bordas do scanner.
            small = image.resize((600, round(image.height * 600 / image.width)))
            sample = small.crop((60, 40, 540, small.height - 40))
            def score(angle):
                pixels = np.asarray(sample.rotate(angle, fillcolor=255)) < 140
                return float(np.var(pixels.sum(axis=1)))
            angle = max(np.arange(-5, 5.01, 0.25), key=score)
            image = image.rotate(float(angle), resample=Image.Resampling.BICUBIC,
                                 expand=True, fillcolor=255)
            prepared = str(Path(tmp) / 'prepared.png')
            image.save(prepared)
            env = dict(os.environ, OMP_THREAD_LIMIT='1')
            result = subprocess.run([args.tesseract, prepared, 'stdout', '-l', 'por',
                                     '--psm', '3'], check=True, capture_output=True,
                                    text=True, env=env)
            # Atomic replacement: an interrupted page is reprocessed on resume.
            pending = target.with_suffix('.pending')
            pending.write_text(result.stdout, encoding='utf-8')
            pending.replace(target)
        print(f'{page}/{pages}', flush=True)

    with ThreadPoolExecutor(max_workers=max(1, args.workers)) as pool:
        list(pool.map(extract, range(1, pages + 1)))
    text = '\n\n'.join(f'## Página PDF {p}\n\n' +
                       (args.output / f'page-{p:03d}.txt').read_text()
                       for p in range(1, pages + 1))
    (args.output / 'review.md').write_text(
        '# Extração automática — revisão pendente\n\n' + text, encoding='utf-8')


if __name__ == '__main__':
    main()
