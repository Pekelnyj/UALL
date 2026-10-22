# -*- coding: utf-8 -*-
import requests, csv, io, json, sys, re
sys.stdout.reconfigure(encoding="utf-8")
B="12.0.7.68235"; ROOT="g:/Claude Code/WoWUkraine"
def fetch(tbl,loc="enUS"):
    r=requests.get(f"https://wago.tools/db2/{tbl}/csv",params={"locale":loc,"build":B},timeout=500)
    if r.status_code!=200: return None
    return list(csv.DictReader(io.StringIO(r.text)))
iss=fetch("ItemSetSpell")
if iss is None:
    print("ItemSetSpell HTTP fail"); sys.exit()
print("ItemSetSpell cols:",list(iss[0].keys()))
scol=next((c for c in iss[0] if c.lower() in ('spellid','spell')),None)
spellids={r[scol] for r in iss if r.get(scol) and r[scol]!='0'}
print("унікальних bonus-spellID:",len(spellids))
def dm(loc):
    rows=fetch("Spell",loc); dcol=next(c for c in rows[0] if "Description_lang" in c)
    return {r["ID"]:(r.get(dcol) or "") for r in rows}
en=dm("enUS"); de=dm("deDE"); fr=dm("frFR")
tr=json.load(open(ROOT+"/data/translations.json",encoding="utf-8-sig"))
# наявні: descTemplates + spells desc + profDesc + itemSetBonus(новий)
existing=set()
for bk in ('descTemplates','profDesc'):
    existing|=set(tr.get(bk,{}).keys())
new=[]; seen=set()
for sid in spellids:
    d=(en.get(sid) or "").strip()
    if not d or len(d)<6: continue
    key=d.replace("\r","")
    if key in existing or key in seen: continue
    if not re.search(r"[A-Za-z]{3,}",re.sub(r'\$\S+',' ',key)): continue
    seen.add(key); new.append({"en":d,"de":(de.get(sid) or '').strip() or None,"fr":(fr.get(sid) or '').strip() or None})
print("НОВИХ set-bonus описів:",len(new))
json.dump(new,open(ROOT+"/data/wago_bulk/_setbonus_new.json","w",encoding="utf-8"),ensure_ascii=False,indent=1)
for x in new[:15]: print("   ",repr(x["en"])[:80])
