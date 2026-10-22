# -*- coding: utf-8 -*-
import requests, csv, io, json, sys, re
sys.stdout.reconfigure(encoding="utf-8")
B="12.1.0.68301"; ROOT="g:/Claude Code/WoWUkraine"
def fetch(tbl,loc="enUS"):
    for _ in range(3):
        r=requests.get(f"https://wago.tools/db2/{tbl}/csv",params={"locale":loc,"build":B},timeout=600)
        if r.status_code==200: return list(csv.DictReader(io.StringIO(r.text)))
    return None
iss=fetch("ItemSetSpell")
if iss is None: print("ItemSetSpell fail"); sys.exit()
scol=next((c for c in iss[0] if c.lower() in ('spellid','spell')),None)
spellids={r[scol] for r in iss if r.get(scol) and r[scol]!='0'}
print("bonus-spellID (12.1.0):",len(spellids))
def dm(loc):
    rows=fetch("Spell",loc); dcol=next(c for c in rows[0] if "Description_lang" in c)
    return {r["ID"]:(r.get(dcol) or "") for r in rows}
en=dm("enUS"); de=dm("deDE"); fr=dm("frFR")
tr=json.load(open(ROOT+"/data/translations.json",encoding="utf-8-sig"))
existing=set(tr.get("setBonus",{}).keys())|set(tr.get("descTemplates",{}).keys())|set(tr.get("profDesc",{}).keys())
new=[]; seen=set(); fv=False
for sid in spellids:
    d=(en.get(sid) or "").strip()
    if not d or len(d)<6: continue
    key=d.replace("\r","")
    if "Final Verdict applies Expurgation" in d: fv=True; print("FINAL VERDICT found sid",sid,":",repr(d))
    if key in existing or key in seen: continue
    if not re.search(r"[A-Za-z]{3,}",re.sub(r'\$\S+',' ',key)): continue
    seen.add(key); new.append({"en":d,"de":(de.get(sid) or '').strip() or None,"fr":(fr.get(sid) or '').strip() or None})
print("НОВИХ (12.1.0, не в setBonus):",len(new),"| Final Verdict у білді:",fv)
json.dump(new,open(ROOT+"/data/wago_bulk/_setbonus_1210.json","w",encoding="utf-8"),ensure_ascii=False,indent=1)
for x in new[:12]: print("   ",repr(x["en"])[:80])
