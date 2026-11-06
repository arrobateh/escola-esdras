#!/usr/bin/env python3
import concurrent.futures,csv,html,json,re,time,urllib.request
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];OUT=ROOT/'docs/catalogo-regioes';CACHE=OUT/'source';CACHE.mkdir(parents=True,exist_ok=True)
BASE='https://imobrart.org'
def fetch(url):
 path=CACHE/(url.rstrip('/').split('/')[-1]+'.html')
 if path.exists():return path.read_text()
 for attempt in range(3):
  try:
   req=urllib.request.Request(url,headers={'User-Agent':'EscolaEsdrasCatalog/1.0 (public church directory inventory)'})
   with urllib.request.urlopen(req,timeout=40) as r:data=r.read().decode('utf-8')
   path.write_text(data);return data
  except Exception:
   if attempt==2:raise
   time.sleep(2)
def one(pattern,text):
 m=re.search(pattern,text,re.S);return html.unescape(m.group(1)).strip() if m else None
def clean(text):return ' '.join(html.unescape(re.sub('<[^>]*>',' ',text or '')).split())
index=fetch(BASE+'/igrejas-em-regioes/')
urls=set(re.findall(r'https://imobrart.org/regioes/[^"\s<>]+/',index))
churches=json.loads((ROOT/'docs/catalogo-igrejas/igrejas.json').read_text());by_url={c['source_url']:c for c in churches}
def extract(url):
 raw=fetch(url);num=int(re.search(r'/(\d+)a-regiao/',url).group(1))
 about=one(r'<section class="fleft100 sobre-home">(.*?)</section>',raw) or ''
 leaders=one(r'<section class="fleft100 diretoria-home diretoria-regiao">(.*?)</section>',raw) or ''
 section=one(r'<section class="fleft100 igrejas-home">(.*?)</section>',raw) or ''
 members=[]
 for block in section.split('<div class="box-igreja">')[1:]:
  block=block.split('</div>',1)[0]
  link=one(r'href="(https://imobrart.org/igrejas/[^"#]+/)"',block)
  if link:members.append({'name':clean(one(r'<h3>(.*?)</h3>',block)),'church_source_url':link,'catalog_match':link in by_url})
 board=[]
 for block in leaders.split('<div class="box-igreja">')[1:]:
  block=block.split('</div>',1)[0]
  board.append({'role':clean(one(r'<span class="tex">\s*<span>(.*?)</span>',block)),'name':clean(one(r'<h3>(.*?)</h3>',block)),'church_text':clean(one(r'<small>(.*?)</small>',block)) or None,'photo_url':one(r'<img[^>]+(?:data-src|src)="([^"]+)"',block)})
 return {'number':num,'name':f'{num}ª Região','source_url':url,'description':clean(one(r'<p\b[^>]*>(.*?)</p>',about)) or None,'photo_url':one(r'<img[^>]+src="([^"]+)"',about),'leadership':board,'churches':members,'retrieved_at':'2026-11-05'}
with concurrent.futures.ThreadPoolExecutor(max_workers=3) as pool:regions=sorted(pool.map(extract,urls),key=lambda r:r['number'])
links=[{'region_number':r['number'],'region_name':r['name'],'region_source_url':r['source_url'],**c} for r in regions for c in r['churches']]
(OUT/'regioes.json').write_text(json.dumps(regions,ensure_ascii=False,indent=2)+'\n')
with (OUT/'igrejas-por-regiao.csv').open('w') as f:
 w=csv.DictWriter(f,fieldnames=list(links[0]));w.writeheader();w.writerows(links)
assigned={c['church_source_url'] for c in links}
multiples={u:[l['region_number'] for l in links if l['church_source_url']==u] for u in assigned if sum(l['church_source_url']==u for l in links)>1}
summary={'regions':len(regions),'memberships':len(links),'unique_churches':len(assigned),'per_region':{r['name']:len(r['churches']) for r in regions},'unmatched':[l for l in links if not l['catalog_match']],'without_region':[{'name':c['name'],'source_url':c['source_url']} for c in churches if c['source_url'] not in assigned],'multiple_regions':multiples}
(OUT/'summary.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2)+'\n');print(json.dumps(summary,ensure_ascii=False))
