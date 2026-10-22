"""Витяг назв класових заклять (скілів) із wago.tools — без ключів і без гри.

Ланцюжок таблиць:
    SkillLine.db2        -> класові лінії вмінь (CategoryID = 7)
    SkillLineAbility.db2 -> spellID кожної лінії
    SpellName.db2        -> назви заклять per locale (en/de/fr)

Результат: data/source/spells.json  {spellID: {"name": {"en","de","fr"}, "skillLine": "Warrior"}}

Використання:
    python extract_spells.py             # класові закляття
    python extract_spells.py --ids-file ..\\data\\my_spell_ids.txt   # довільний список
"""

import argparse
import csv
import io
import json
from pathlib import Path

import requests

from common import DATA_DIR

SOURCE_PATH = DATA_DIR / "source" / "spells.json"
CACHE_DIR = DATA_DIR / "wago"

LOCALES = {"enUS": "en", "deDE": "de", "frFR": "fr"}
CLASS_CATEGORY_ID = 7  # SkillLine.CategoryID класових ліній


def download_csv(table: str, locale: str | None, build: str | None) -> str:
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    loc = locale or "enUS"
    cache_path = CACHE_DIR / f"{table}.{loc}.{build or 'latest'}.csv"
    if cache_path.exists():
        print(f"  {cache_path.name}: з кешу")
        return cache_path.read_text(encoding="utf-8")
    params = {"locale": loc}
    if build:
        params["build"] = build
    print(f"  {cache_path.name}: завантажую...")
    resp = requests.get(f"https://wago.tools/db2/{table}/csv", params=params, timeout=600)
    resp.raise_for_status()
    cache_path.write_text(resp.text, encoding="utf-8")
    return resp.text


def find_column(fieldnames, *needles):
    for needle in needles:
        for name in fieldnames:
            if needle.lower() == name.lower():
                return name
    for needle in needles:
        for name in fieldnames:
            if needle.lower() in name.lower():
                return name
    raise KeyError(f"Немає колонки {needles}: {fieldnames[:25]}")


def class_skill_lines(build) -> dict[int, str]:
    """SkillLine із CategoryID=7 -> {skillLineID: назва класу (en)}."""
    reader = csv.DictReader(io.StringIO(download_csv("SkillLine", "enUS", build)))
    cat_col = find_column(reader.fieldnames, "CategoryID")
    name_col = find_column(reader.fieldnames, "DisplayName_lang", "DisplayName")
    return {
        int(r["ID"]): (r.get(name_col) or "").strip()
        for r in reader
        if r.get(cat_col) and int(r[cat_col]) == CLASS_CATEGORY_ID
    }


def spells_of_lines(line_ids: set[int], build) -> dict[int, int]:
    """SkillLineAbility -> {spellID: skillLineID}."""
    reader = csv.DictReader(io.StringIO(download_csv("SkillLineAbility", "enUS", build)))
    line_col = find_column(reader.fieldnames, "SkillLine")
    spell_col = find_column(reader.fieldnames, "Spell")
    out = {}
    for r in reader:
        try:
            line = int(r.get(line_col) or 0)
            spell = int(r.get(spell_col) or 0)
        except ValueError:
            continue
        if line in line_ids and spell > 0:
            out[spell] = line
    return out


def spell_names(locale: str, wanted: set[int], build) -> dict[int, str]:
    reader = csv.DictReader(io.StringIO(download_csv("SpellName", locale, build)))
    name_col = find_column(reader.fieldnames, "Name_lang", "Name")
    out = {}
    for r in reader:
        try:
            sid = int(r["ID"])
        except (KeyError, ValueError):
            continue
        if sid in wanted:
            name = (r.get(name_col) or "").strip()
            if name:
                out[sid] = name
    return out


def main():
    ap = argparse.ArgumentParser(description="Витяг назв заклять із wago.tools")
    ap.add_argument("--build", help="білд клієнта (типово останній)")
    ap.add_argument("--ids-file", help="довільний список spellID замість класових")
    args = ap.parse_args()

    if args.ids_file:
        wanted = {int(x) for x in Path(args.ids_file).read_text(encoding="utf-8-sig").split()
                  if x.strip().isdigit()}
        spell_to_line = {sid: 0 for sid in wanted}
        line_names = {}
        print(f"Зі списку: {len(wanted)} spellID")
    else:
        line_names = class_skill_lines(args.build)
        print(f"Класових ліній: {len(line_names)} ({', '.join(sorted(line_names.values()))})")
        spell_to_line = spells_of_lines(set(line_names), args.build)
        wanted = set(spell_to_line)
        print(f"Класових заклять: {len(wanted)}")

    names = {short: spell_names(loc, wanted, args.build) for loc, short in LOCALES.items()}

    source = {}
    if SOURCE_PATH.exists():
        source = json.loads(SOURCE_PATH.read_text(encoding="utf-8-sig"))

    added = 0
    for sid in sorted(wanted):
        en = names["en"].get(sid)
        if not en:
            continue
        entry = source.setdefault(str(sid), {})
        entry.setdefault("name", {})
        for short in LOCALES.values():
            val = names[short].get(sid)
            if val:
                entry["name"][short] = val
        line = line_names.get(spell_to_line.get(sid, 0))
        if line:
            entry["skillLine"] = line
        added += 1

    SOURCE_PATH.parent.mkdir(parents=True, exist_ok=True)
    SOURCE_PATH.write_text(json.dumps(source, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"Заклять із назвами: {added}. Усього в базі джерел: {len(source)}")
    print(f"-> {SOURCE_PATH}")


if __name__ == "__main__":
    main()
