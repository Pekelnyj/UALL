# -*- coding: utf-8 -*-
"""Додає в source/spells.json спели, на які вказують $@spelldesc/$@spellname із
зібраних абілок (captured_spells.json), але яких немає в джерелі. Назви з DB2-кешу.
Потім: extract_spell_descriptions.py -> prep_captured_spells.py -> переклад.
"""
import sys, json, re, csv, glob
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

LOCALES = {"enUS": "en", "deDE": "de", "frFR": "fr"}
SOURCE = DATA_DIR / "source" / "spells.json"

source = json.loads(SOURCE.read_text(encoding="utf-8-sig"))

# referenced ID з усіх descTemplate-джерел: captured + наявні описи source
refs = set()
cap = json.loads((DATA_DIR / "captured_spells.json").read_text(encoding="utf-8-sig"))
for e in cap:
    for nnn in re.findall(r'\$@spell(?:desc|name)(\d+)', e.get("desc_en", "")):
        refs.add(int(nnn))
# також зі вже наявних шаблонів у source (опис абілок), на 1 рівень
for v in source.values():
    if isinstance(v, dict):
        d = v.get("description")
        de = d.get("en") if isinstance(d, dict) else d
        if de:
            for nnn in re.findall(r'\$@spell(?:desc|name)(\d+)', de):
                refs.add(int(nnn))

missing = [i for i in refs if str(i) not in source]
# + спели в source без англ.назви (додані extract_encounter_spells заглушками)
for k, v in source.items():
    if isinstance(v, dict) and v.get("skillLine") == "Captured":
        nm = v.get("name") or {}
        if not (nm.get("en") if isinstance(nm, dict) else nm):
            missing.append(int(k))
missing = sorted(set(missing))
print(f"referenced усього: {len(refs)} | без назви/в source бракує: {len(missing)}")


def names_for(ids):
    out = {short: {} for short in LOCALES.values()}
    ids = set(ids)
    for loc, short in LOCALES.items():
        paths = glob.glob(str(DATA_DIR / "wago" / f"SpellName.{loc}*.csv"))
        if not paths:
            continue
        with open(paths[0], encoding="utf-8") as f:
            for r in csv.DictReader(f):
                try:
                    sid = int(r["ID"])
                except (KeyError, ValueError):
                    continue
                if sid in ids:
                    nm = (r.get("Name_lang") or "").strip()
                    if nm:
                        out[short][sid] = nm
    return out


names = names_for(missing)
added = 0
for sid in missing:
    en = names["en"].get(sid)
    if not en:
        continue
    e = source.setdefault(str(sid), {})
    nm = e.setdefault("name", {})
    nm.setdefault("en", en)
    for short in ("de", "fr"):
        if names[short].get(sid):
            nm.setdefault(short, names[short][sid])
    e.setdefault("talent", True)
    e.setdefault("skillLine", "Captured")
    added += 1

SOURCE.write_text(json.dumps(source, ensure_ascii=False, indent=2), encoding="utf-8")
print(f"Додано referenced у source: {added}")
print("Далі: extract_spell_descriptions.py -> prep_captured_spells.py")
