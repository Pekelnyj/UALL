# -*- coding: utf-8 -*-
import requests, csv, io, json, sys
sys.stdout.reconfigure(encoding="utf-8")
B="12.1.0.68301"; ROOT="g:/Claude Code/WoWUkraine"
def fetch(tbl,**p):
    p.setdefault("build",B)
    for _ in range(3):
        r=requests.get(f"https://wago.tools/db2/{tbl}/csv",params=p,timeout=400)
        if r.status_code==200: return list(csv.DictReader(io.StringIO(r.text)))
    return None
iset=fetch("ItemSet")
idcols=[c for c in iset[0] if c.lower().startswith("itemid")]
ids=set()
for r in iset:
    for c in idcols:
        v=r.get(c)
        if v and v!='0': ids.add(v)
print("piece IDs:",len(ids))
isn=fetch("ItemSearchName")
if isn is None: print("ItemSearchName fail"); sys.exit()
ncol=next((c for c in isn[0] if "Display_lang" in c or c=="Display_lang"),None)
print("ItemSearchName cols name:",ncol,"rows:",len(isn))
id2en={r["ID"]:(r.get(ncol) or "").strip() for r in isn if r["ID"] in ids}
print("матчнуто ID->EN:",len(id2en))
tr=json.load(open(ROOT+"/data/translations.json",encoding="utf-8-sig"))
inm=tr.get("itemNames",{})
def ua(en):
    v=inm.get(en); return v.get("name") if isinstance(v,dict) else (v if isinstance(v,str) else None)
setpieces={}; miss=0
for i,en in id2en.items():
    if not en: continue
    u=ua(en)
    if u and u!=en: setpieces[en]=u
    elif en: miss+=1
print("setPieces (EN->UA):",len(setpieces),"| без UA:",miss)
json.dump(setpieces,open(ROOT+"/data/wago_bulk/_setpieces.json","w",encoding="utf-8"),ensure_ascii=False,indent=1)
for k in list(setpieces)[:8]: print("  ",repr(k),"->",repr(setpieces[k])[:40])
# перевірка наших цільових
for t in ("Omission of Light","Occlusion of Void"):
    print("  TARGET",t,"->",setpieces.get(t))
