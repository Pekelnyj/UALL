"""Витяг «спелів-сиріт»: на них посилаються описи ($@spellname123,
$@spelldesc123), але їх немає в джерелі (не таланти і не класові скіли).
Приклад: Concentration Aura — базова аура поза деревом талантів.

Використовує кешовані CSV (SpellName, Spell) — мережа не потрібна.
Додає в data/source/spells.json з позначкою "referenced": true.

Використання:
    python extract_referenced.py
"""

import csv
import io
import json
import re

from common import DATA_DIR

SOURCE_PATH = DATA_DIR / "source" / "spells.json"
CACHE_DIR = DATA_DIR / "wago"
LOCALES = {"enUS": "en", "deDE": "de", "frFR": "fr"}

REF_RE = re.compile(r"\$@spell(?:name|desc|icon)(\d+)")


def main():
    source = json.loads(SOURCE_PATH.read_text(encoding="utf-8-sig"))

    referenced = set()
    for e in source.values():
        en = (e.get("description") or {}).get("en")
        if en:
            referenced.update(int(m) for m in REF_RE.findall(en))
    missing = {sid for sid in referenced if str(sid) not in source}
    print(f"Посилань на спели: {len(referenced)}, з них відсутніх у джерелі: {len(missing)}")
    if not missing:
        return

    csv.field_size_limit(10_000_000)
    names = {short: {} for short in LOCALES.values()}
    descs = {short: {} for short in LOCALES.values()}
    for loc, short in LOCALES.items():
        text = (CACHE_DIR / f"SpellName.{loc}.latest.csv").read_text(encoding="utf-8")
        for r in csv.DictReader(io.StringIO(text)):
            try:
                sid = int(r["ID"])
            except (KeyError, ValueError):
                continue
            if sid in missing:
                val = (r.get("Name_lang") or "").strip()
                if val:
                    names[short][sid] = val
        text = (CACHE_DIR / f"Spell.{loc}.latest.csv").read_text(encoding="utf-8")
        for r in csv.DictReader(io.StringIO(text)):
            try:
                sid = int(r["ID"])
            except (KeyError, ValueError):
                continue
            if sid in missing:
                val = (r.get("Description_lang") or "").strip()
                if val:
                    descs[short][sid] = val

    added = 0
    for sid in sorted(missing):
        en = names["en"].get(sid)
        if not en:
            continue
        entry = source.setdefault(str(sid), {})
        entry["referenced"] = True
        entry.setdefault("name", {})
        for short in LOCALES.values():
            if names[short].get(sid):
                entry["name"].setdefault(short, names[short][sid])
        if descs["en"].get(sid):
            d = entry.setdefault("description", {})
            for short in LOCALES.values():
                if descs[short].get(sid):
                    d.setdefault(short, descs[short][sid])
            t = entry["description"]["en"]
            entry["descComplexity"] = ("complex"
                                       if ("$?" in t or REF_RE.sub("", t).find("$@") >= 0
                                           or "$|" in t)
                                       else "simple")
        added += 1

    SOURCE_PATH.write_text(json.dumps(source, ensure_ascii=False, indent=2),
                           encoding="utf-8")
    print(f"Додано спелів-сиріт: {added}")
    for sid in sorted(missing)[:15]:
        print(f"  {sid}: {names['en'].get(sid, '?')}")


if __name__ == "__main__":
    main()
