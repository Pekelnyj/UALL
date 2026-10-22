# -*- coding: utf-8 -*-
"""Витяг ОПИСІВ профа-спелів із wago DB2: SkillLine(cat=11) -> SkillLineAbility ->
Spell.Description_lang (en/de/fr). Діф проти наявного profDesc."""
import requests, csv, io, json, sys, re
sys.stdout.reconfigure(encoding="utf-8")
B = "12.0.7.68235"
ROOT = "g:/Claude Code/WoWUkraine"


def fetch(tbl):
    r = requests.get(f"https://wago.tools/db2/{tbl}/csv", params={"locale": "enUS", "build": B}, timeout=400)
    r.raise_for_status()
    return list(csv.DictReader(io.StringIO(r.text)))


def fetch_loc(tbl, loc):
    r = requests.get(f"https://wago.tools/db2/{tbl}/csv", params={"locale": loc, "build": B}, timeout=400)
    r.raise_for_status()
    return list(csv.DictReader(io.StringIO(r.text)))


# 1. профа-лінії (cat=11)
sl = fetch("SkillLine")
prof_lines = {int(r["ID"]) for r in sl if r.get("CategoryID") == "11"}
print("профа-ліній (cat=11):", len(prof_lines))

# 2. spellID кожної лінії
sla = fetch("SkillLineAbility")
lc = next(c for c in sla[0] if c.lower() == "skillline")
sc = next(c for c in sla[0] if c.lower() == "spell")
prof_spells = set()
for r in sla:
    try:
        if int(r.get(lc) or 0) in prof_lines:
            s = int(r.get(sc) or 0)
            if s > 0:
                prof_spells.add(s)
    except ValueError:
        pass
print("профа-спелів:", len(prof_spells))

# 3. описи з Spell.db2 (en/de/fr)
tr = json.load(open(ROOT + "/data/translations.json", encoding="utf-8-sig"))
pd = tr.get("profDesc", {})
existing = set(pd.keys())


def descs(loc):
    out = {}
    rows = fetch_loc("Spell", loc)
    dcol = next((c for c in rows[0] if "Description_lang" in c), None)
    for r in rows:
        try:
            sid = int(r["ID"])
        except (KeyError, ValueError):
            continue
        if sid in prof_spells:
            d = (r.get(dcol) or "").strip()
            if d:
                out[sid] = d
    return out


en = descs("enUS")
de = descs("deDE")
fr = descs("frFR")
print("профа-спелів з описом:", len(en))

# нові (не в profDesc), з реальним текстом
new = []
seen = set()
for sid, d in en.items():
    key = d.replace("\r", "")
    if key in existing or key in seen:
        continue
    if not re.search(r"[A-Za-z]{4,}", re.sub(r"\$\S+", " ", key)):
        continue
    seen.add(key)
    new.append({"en": d, "de": de.get(sid), "fr": fr.get(sid)})
print("НОВИХ описів профи (не в profDesc):", len(new))
json.dump(new, open(ROOT + "/data/wago_bulk/_profdesc_new.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
for x in new[:12]:
    print("  ", repr(x["en"])[:100])
