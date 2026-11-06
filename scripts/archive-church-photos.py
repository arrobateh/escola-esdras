#!/usr/bin/env python3
import concurrent.futures,json,urllib.request,urllib.parse
from pathlib import Path
root=Path(__file__).resolve().parents[2];out=root/'docs/catalogo-igrejas';folder=out/'photos';folder.mkdir(exist_ok=True)
rows=json.loads((out/'igrejas.json').read_text())
def download(row):
 url=row['photo_url'];slug=row['source_url'].rstrip('/').split('/')[-1]
 ext=Path(urllib.parse.urlparse(url).path).suffix.lower();path=folder/(slug+ext)
 try:
  if not path.exists():
   with urllib.request.urlopen(urllib.request.Request(url, headers={'User-Agent':'EscolaEsdrasCatalog/1.0 (public church directory inventory)'}),timeout=40) as r:
    if not r.headers.get('Content-Type','').startswith('image/'):raise ValueError('Resposta não é imagem')
    path.write_bytes(r.read())
  return {'source_url':row['source_url'],'photo_url':url,'file':str(path.relative_to(out)),'bytes':path.stat().st_size}
 except Exception as e:return {'source_url':row['source_url'],'photo_url':url,'error':str(e)}
with concurrent.futures.ThreadPoolExecutor(max_workers=3) as pool:manifest=list(pool.map(download,[r for r in rows if r['photo_url']]))
(out/'photos-manifest.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n')
print('Fotos arquivadas:',sum('file' in r for r in manifest),'Falhas:',sum('error' in r for r in manifest))
