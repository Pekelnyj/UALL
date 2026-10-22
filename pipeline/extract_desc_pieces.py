# -*- coding: utf-8 -*-
"""Усі АБЗАЦИ-частини описів cat=11: збираємо всі $@spelldesc-цілі (база+суфікси),
резолвимо їх текст (en/de/fr), + самі базові тексти. Кожна частина = окремий profDesc-ключ."""
import requests, csv, io, json, sys, re
sys.stdout.reconfigure(encoding="utf-8")
B="12.0.7.68235"; ROOT="g:/Claude Code/WoWUkraine"
def fetch(tbl,loc="enUS"):
    r=requests.get(f"https://wago.tools/db2/{tbl}/csv",params={"locale":loc,"build":B},timeout=600)
    r.raise_for_status(); return list(csv.DictReader(io.StringIO(r.text)))
sl=fetch("SkillLine"); prof_lines={r["ID"] for r in sl if r.get("CategoryID")=="11"}
sla=fetch("SkillLineAbility")
lc=next(c for c in sla[0] if c.lower()=="skillline"); sc=next(c for c in sla[0] if c.lower()=="spell")
prof_spells={r.get(sc) for r in sla if r.get(lc) in prof_lines and r.get(sc)}
def dm(loc):
    rows=fetch("Spell",loc); dcol=next(c for c in rows[0] if "Description_lang" in c)
    return {r["ID"]:(r.get(dcol) or "") for r in rows}
en=dm("enUS"); de=dm("deDE"); fr=dm("frFR")
TOK=re.compile(r"\$@spelldesc(\d+)")
REF=re.compile(r"^\s*\$@spelldesc(\d+)\s*$")
def resolve(sid,m,hops=3):
    d=m.get(sid,"")
    for _ in range(hops):
        mm=REF.match(d or "")
        if not mm: break
        d=m.get(mm.group(1),"")
    return d
# зібрати всі ЧАСТИНИ: для кожного cat=11 спелу — його розкладені абзаци через резолв кожного токена
tr=json.load(open(ROOT+"/data/translations.json",encoding="utf-8-sig"))
existing=set(tr.get("profDesc",{}).keys())
pieces={}  # en_piece -> {en,de,fr}
def pieces_of(sid,m):
    raw=m.get(sid,"")
    # розбити на абзаци; кожен абзац може бути токеном або текстом
    parts=re.split(r"\r\n\r\n|\n\n",raw)
    out=[]
    for p in parts:
        p=p.strip()
        if not p: continue
        mm=REF.match(p)
        if mm: p=resolve(mm.group(1),m).strip()
        out.append(p)
    return out
for sid in prof_spells:
    raw=en.get(sid,"")
    if "$@spelldesc" not in raw: continue
    ep=pieces_of(sid,en); dp=pieces_of(sid,de); fp=pieces_of(sid,fr)
    for i,pe in enumerate(ep):
        key=pe.replace("\r","")
        if not pe or len(pe)<25 or key in existing or key in pieces: continue
        if not re.search(r"[A-Za-z]{4,}",re.sub(r"\$\S+"," ",key)): continue
        pieces[key]={"en":pe,"de":(dp[i] if i<len(dp) else None) or None,"fr":(fp[i] if i<len(fp) else None) or None}
print("НОВИХ абзаців-частин (не в profDesc):",len(pieces))
out=list(pieces.values())
json.dump(out,open(ROOT+"/data/wago_bulk/_desc_pieces_new.json","w",encoding="utf-8"),ensure_ascii=False,indent=1)
for x in out[:20]: print("   ",repr(x["en"])[:85])
