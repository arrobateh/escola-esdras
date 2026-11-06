#!/usr/bin/env python3
"""Extrai apenas páginas públicas do catálogo, com cache e rastreabilidade."""
import concurrent.futures, csv, html, json, re, time, urllib.request
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'docs/catalogo-igrejas'; CACHE=OUT/'source';CACHE.mkdir(parents=True,exist_ok=True)
BASE='https://imobrart.org'
def fetch(url):
 key=re.sub('[^a-zA-Z0-9-]','_',url.removeprefix(BASE)).strip('_') or 'index'
 path=CACHE/(key+'.html')
 if path.exists():return path.read_text()
 for attempt in range(3):
  try:
   req=urllib.request.Request(url,headers={'User-Agent':'EscolaEsdrasCatalog/1.0 (public church directory inventory)'})
   with urllib.request.urlopen(req,timeout=40) as response: data=response.read().decode('utf-8')
   path.write_text(data);return data
  except Exception:
   if attempt==2:raise
   time.sleep(2)
def clean(text):
 text=re.sub(r'<(?:br|/li|/p|/ul)\s*/?>','\n',text,flags=re.I)
 return '\n'.join(' '.join(line.split()) for line in html.unescape(re.sub('<[^>]+>','',text)).splitlines() if line.strip()).strip()
def one(pattern,text):
 m=re.search(pattern,text,re.S);return html.unescape(m.group(1)).strip() if m else None
first=fetch(BASE+'/nossas-igrejas/')
pages={BASE+'/nossas-igrejas/'}|set(re.findall(r'https://imobrart.org/nossas-igrejas/page/\d+/',first))
# Paginação conhecida no site: percorre também links descobertos nas próximas páginas.
records={};processed=set();markers={}
while pages-processed:
 url=sorted(pages-processed)[0];raw=fetch(url);processed.add(url)
 pages.update(re.findall(r'https://imobrart.org/nossas-igrejas/page/\d+/',raw))
 match=re.search(r'var mapa_vars = (.*?);',raw,re.S)
 if match:
  for marker in json.loads(match.group(1)).get('marcadores',[]): markers[marker['titulo']]=marker
 for block in raw.split('<div class="box-igreja">')[1:]:
  block=block.split('</div>',1)[0]
  link=one(r'href="([^"]+/igrejas/[^"#]+/)"',block)
  if not link:continue
  name=clean(one(r'<h3>(.*?)</h3>',block) or '')
  image=one(r'<img[^>]+(?:data-src|src)="([^"]+)"',block)
  address=one(r'<h3>.*?</h3>\s*<span>(.*?)</span>',block)
  records[link]={'name':name,'address':clean(address) if address else None,'photo_url':image if image and '/uploads/' in image else None,'source_url':link,'listing_url':url}
def detail(item):
 url,record=item;raw=fetch(url)
 main=one(r'<section class="fleft100 sobre-home">(.*?)</section>',raw) or ''
 social=one(r'<ul class="share-regs">(.*?)</ul>',raw) or ''
 record['photo_url']=one(r'<figure[^>]*>.*?<img[^>]+src="([^"]+)"',main) or record['photo_url']
 if record['photo_url'] and '/uploads/' not in record['photo_url']:record['photo_url']=None
 fields=re.findall(r'<span class="pastorPresidente">(.*?)</span>',main,re.S)
 record.update(pastor_name=None,contact=None)
 for field in fields:
  label=clean(field)
  if label.startswith('Pastor Presidente:'):record['pastor_name']=label.removeprefix('Pastor Presidente:').strip()
  elif label.startswith('Contato:'):record['contact']=label.removeprefix('Contato:').strip()
 schedule=one(r'<span class="dias-cultos">(.*?)</span>',main)
 record['services_text']=clean(schedule) if schedule else None
 record['organization_date_text']=clean(one(r'<span class="dataOrganizacao">(.*?)</span>',main) or '').removeprefix('Data da organização:').strip() or None
 record['social_links']=[{'url':html.unescape(u),'label':clean(label)} for u,label in re.findall(r'<a[^>]+href="([^"]+)"[^>]*title="([^"]+)"',social)]
 record['maps_url']=one(r'href="([^"]+)"[^>]*>Ver mapa</a>',main)
 marker=markers.get(record['name'],{})
 record['address']=record['address'] or marker.get('endereco') or None
 record['address_complement']=marker.get('complemento') or None
 record['latitude']=marker.get('lat');record['longitude']=marker.get('lng')
 record['maps_url']=record['maps_url'] or marker.get('link_maps')
 record['source_detail_text']=clean(main)
 record['retrieved_at']='2026-11-05'
 return record
with concurrent.futures.ThreadPoolExecutor(max_workers=3) as pool: data=list(pool.map(detail,records.items()))
data.sort(key=lambda record:record['name'].casefold())
(OUT/'igrejas.json').write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n')
fields=list(data[0])
with (OUT/'igrejas.csv').open('w') as f:
 writer=csv.DictWriter(f,fieldnames=fields);writer.writeheader()
 for row in data:writer.writerow({k:json.dumps(v,ensure_ascii=False) if isinstance(v,(dict,list)) else v for k,v in row.items()})
summary={'total':len(data),'listing_pages':sorted(processed),'with_photo':sum(bool(r['photo_url']) for r in data),'with_address':sum(bool(r['address']) for r in data),'with_pastor':sum(bool(r['pastor_name']) for r in data),'with_contact':sum(bool(r['contact']) for r in data),'with_schedule':sum(bool(r['services_text']) for r in data),'with_coordinates':sum(r['latitude'] is not None and r['longitude'] is not None for r in data)}
(OUT/'summary.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2)+'\n')
print(json.dumps(summary,ensure_ascii=False))
