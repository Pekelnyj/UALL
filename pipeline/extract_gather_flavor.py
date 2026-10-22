# -*- coding: utf-8 -*-
"""Gathering/base флейвор: cat=11 спели з описом-посиланням $@spelldescN → резолв
базового тексту (en/de/fr). Ось де живе Sanguithorn/Azeroot проза."""
import requests, csv, io, json, sys, re
sys.stdout.reconfigure(encoding="utf-8")
B="12.0.7.68235"; ROOT="g:/Claude Code/WoWUkraine"
def fetch(tbl,loc="enUS"):
    r=requests.get(f"https://wago.tools/db2/{tbl}/csv",params={"locale":loc,"build":B},timeout=600)
    r.raise_for_status(); return list(csv.DictReader(io.StringIO(r.text)))

sl=fetch("SkillLine")
prof_lines={r["ID"] for r in sl if r.get("CategoryID")=="11"}
sla=fetch("SkillLineAbility")
lc=next(c for c in sla[0] if c.lower()=="skillline")
sc=next(c for c in sla[0] if c.lower()=="spell")
prof_spells={r.get(sc) for r in sla if r.get(lc) in prof_lines and r.get(sc)}
print("cat=11 prof_spells:",len(prof_spells))

def descmap(loc):
    rows=fetch("Spell",loc)
    dcol=next(c for c in rows[0] if "Description_lang" in c)
    return {r["ID"]:(r.get(dcol) or "") for r in rows}
en=descmap("enUS"); de=descmap("deDE"); fr=descmap("frFR")

REF=re.compile(r"^\s*\$@spelldesc(\d+)\s*$")
def resolve(sid,m,hops=3):
    d=m.get(sid,"")
    for _ in range(hops):
        mm=REF.match(d or "")
        if not mm: break
        d=m.get(mm.group(1),"")
    return d

tr=json.load(open(ROOT+"/data/translations.json",encoding="utf-8-sig"))
existing=set(tr.get("profDesc",{}).keys())

new=[]; seen=set()
for sid in prof_spells:
    raw=en.get(sid,"")
    if not REF.match(raw or ""):   # тільки ті, чий опис = чисте посилання
        continue
    ed=resolve(sid,en).strip()
    if not ed or len(ed)<40: continue
    key=ed.replace("\r","")
    if key in existing or key in seen: continue
    if not re.search(r"[A-Za-z]{4,}",re.sub(r"\$\S+"," ",key)): continue
    seen.add(key)
    new.append({"en":ed,"de":resolve(sid,de).strip() or None,"fr":resolve(sid,fr).strip() or None})
print("НОВИХ базових флейвор-описів (резолв $@spelldesc):",len(new))
json.dump(new,open(ROOT+"/data/wago_bulk/_gather_ref_new.json","w",encoding="utf-8"),ensure_ascii=False,indent=1)
for x in new[:15]:
    print("  ",repr(x["en"])[:90])
