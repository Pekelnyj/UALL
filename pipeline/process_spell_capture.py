"""Додає зібрані в грі закляття (CaptureDB.spellCapture) у source/spells.json.

Збір записує лише spellID; назви беремо з кешу SpellName.db2 (en/de/fr).
Опис додасть extract_spell_descriptions.py (запусти його після цього).

Позначаємо talent=true і skillLine="Captured" — щоб prep_spell_batches /
prep_desc_batches підхопили їх як звичайні закляття на переклад.

Використання:
    python process_spell_capture.py
    python extract_spell_descriptions.py   # потім — додасть описи
"""

import csv
import glob
import json
import re
import sys

from common import DATA_DIR

SV = sys.argv[1] if len(sys.argv) > 1 else (
    r"F:\Battlenet\World of Warcraft\_retail_\WTF\Account"
    r"\129089678#1\SavedVariables\WoWUkraine.lua")
SOURCE = DATA_DIR / "source" / "spells.json"
LOCALES = {"enUS": "en", "deDE": "de", "frFR": "fr"}


def captured_ids():
    raw = open(SV, encoding="utf-8", errors="replace").read()
    i = raw.find('["spellCapture"]')
    if i < 0:
        return []
    j = raw.find("{", i)
    depth, k = 0, j
    while k < len(raw):
        if raw[k] == "{":
            depth += 1
        elif raw[k] == "}":
            depth -= 1
            if depth == 0:
                break
        k += 1
    return [int(x) for x in re.findall(r"\[(\d+)\]", raw[j:k + 1])]


def names_for(ids):
    out = {short: {} for short in LOCALES.values()}
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


def main():
    ids = set(captured_ids())
    if not ids:
        print("spellCapture порожній або не знайдено.")
        return
    source = json.loads(SOURCE.read_text(encoding="utf-8-sig"))
    names = names_for(ids)

    added = 0
    for sid in sorted(ids):
        en = names["en"].get(sid)
        if not en:
            continue
        key = str(sid)
        entry = source.setdefault(key, {})
        nm = entry.setdefault("name", {})
        nm.setdefault("en", en)
        for short in ("de", "fr"):
            if names[short].get(sid):
                nm.setdefault(short, names[short][sid])
        entry.setdefault("talent", True)        # щоб prep-скрипти підхопили
        entry.setdefault("skillLine", "Captured")
        if key not in source or "description" not in entry:
            added += 1

    SOURCE.write_text(json.dumps(source, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"Зібраних заклять у source: {len(ids)} | додано/оновлено: {added}")
    print("Тепер: python extract_spell_descriptions.py")


if __name__ == "__main__":
    main()
