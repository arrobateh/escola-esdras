#!/usr/bin/env python3
"""Consulta somente leitura; nunca imprime ou grava a App Key."""
import json,urllib.request,urllib.parse,urllib.error
from pathlib import Path
base=Path(__file__).resolve().parents[1]
key=None
for line in (base/'.env').read_text().splitlines():
 if line.strip().startswith('YOUVERSION_APP_KEY='):
  key=line.split('=',1)[1].strip().strip('\"\'')
if not key:raise SystemExit('YOUVERSION_APP_KEY não encontrada ou vazia.')
def get(path,params=None):
 url='https://api.youversion.com/v1/'+path
 if params:url+='?'+urllib.parse.urlencode(params)
 req=urllib.request.Request(url,headers={'X-YVP-App-Key':key,'Accept':'application/json'})
 try:
  with urllib.request.urlopen(req,timeout=30) as r:return r.status,json.load(r)
 except urllib.error.HTTPError as e:return e.code,None
 except urllib.error.URLError:raise SystemExit('Falha de rede ao consultar YouVersion.')
result={}
for scope in ['authorized','catalog']:
 rows=[];token=None
 while True:
  params={'language_ranges[]':'pt','page_size':99}
  if scope=='catalog':params['all_available']='true'
  if token:params['page_token']=token
  status,data=get('bibles',params)
  if status!=200:
   result[scope]={'status':status};break
  rows.extend(data.get('data',[]));token=data.get('next_page_token')
  if not token:
   result[scope]={'status':status,'versions':[{k:b.get(k) for k in ['id','abbreviation','title','localized_title','language_tag','copyright','organization_id']} for b in rows]};break
  if len(rows)>5000:raise SystemExit('Paginação excedeu o limite de segurança.')
for version in result.get('authorized',{}).get('versions',[]) + result.get('catalog',{}).get('versions',[]):
 status,data=get(f"bibles/{version['id']}/passages/JHN.3.16",{'format':'text'})
 version['passage_test_status']=status
 version['passage_has_content']=bool(data and data.get('content'))
out=Path('/tmp/esdras-youversion-availability.json');out.write_text(json.dumps(result,ensure_ascii=False,indent=2))
for scope,info in result.items():
 print(scope,'HTTP',info['status'],'versões:',len(info.get('versions',[])))
 for b in info.get('versions',[]):print(b['id'],b['abbreviation'],b['localized_title'] or b['title'],'passagem:',b.get('passage_test_status','não testada'))
