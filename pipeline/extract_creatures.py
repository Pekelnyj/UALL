"""Витяг імен NPC/монстрів (Creature.db2) з wago.tools — en+de+fr, без ключів і гри.

wago.tools віддає CSV-експорт DB2 per locale:
    https://wago.tools/db2/Creature/csv?locale=enUS

Результат -> data/source/creatures.json у форматі:
    { "<creatureID>": { "name": { "en": ..., "de": ..., "fr": ... } } }
Дедуп за en-іменем (одне ім'я — один запис; беремо найменший ID).

Використання:
    python extract_creatures.py
    python extract_creatures.py --build 12.0.7.67808
"""

import argparse
import csv
import io
import json
import sys

import requests

from common import DATA_DIR

SOURCE_PATH = DATA_DIR / "source" / "creatures.json"
CACHE_DIR = DATA_DIR / "wago"
CSV_URL = "https://wago.tools/db2/{table}/csv"
LOCALES = {"enUS": "en", "deDE": "de", "frFR": "fr"}


def download_csv(table: str, locale: str, build: str | None) -> str:
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    cache_name = f"{table}.{locale}.{build or 'latest'}.csv"
    cache_path = CACHE_DIR / cache_name
    if cache_path.exists():
        print(f"  {cache_name}: з кешу")
        return cache_path.read_text(encoding="utf-8")
    params = {"locale": locale}
    if build:
        params["build"] = build
    print(f"  {cache_name}: завантажую...")
    resp = requests.get(CSV_URL.format(table=table), params=params, timeout=600)
    resp.raise_for_status()
    cache_path.write_text(resp.text, encoding="utf-8")
    return resp.text


def find_name_column(fieldnames: list[str]) -> str:
    # точна назва спершу, потім запасні; уникаємо NameAlt/TitleAlt
    for pref in ("Name_lang", "Name[0]", "Name"):
        for fn in fieldnames:
            if fn == pref:
                return fn
    for fn in fieldnames:
        if fn.lower().startswith("name") and "alt" not in fn.lower():
            return fn
    raise KeyError(f"Не знайдено колонку Name серед: {fieldnames[:25]}")


def parse_names(text: str) -> dict[int, str]:
    reader = csv.DictReader(io.StringIO(text))
    name_col = find_name_column(reader.fieldnames)
    out = {}
    for row in reader:
        name = (row.get(name_col) or "").strip()
        if name:
            out[int(row["ID"])] = name
    return out


def main():
    ap = argparse.ArgumentParser(description="Витяг імен NPC (Creature.db2)")
    ap.add_argument("--build", help="білд клієнта (типово останній)")
    args = ap.parse_args()

    names: dict[str, dict[int, str]] = {}
    for wago_locale, short in LOCALES.items():
        print(f"Локаль {wago_locale}:")
        names[short] = parse_names(download_csv("Creature", wago_locale, args.build))

    # дедуп за en-іменем: одне ім'я -> запис із найменшим ID
    seen_en: dict[str, int] = {}
    for cid, en in sorted(names["en"].items()):
        if en not in seen_en:
            seen_en[en] = cid

    source = {}
    for en, cid in seen_en.items():
        entry = {"en": en}
        de = names["de"].get(cid)
        fr = names["fr"].get(cid)
        if de:
            entry["de"] = de
        if fr:
            entry["fr"] = fr
        source[str(cid)] = {"name": entry}

    SOURCE_PATH.parent.mkdir(parents=True, exist_ok=True)
    SOURCE_PATH.write_text(json.dumps(source, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"\nУнікальних імен NPC: {len(source)} (з {len(names['en'])} рядків Creature.db2)")
    print(f"-> {SOURCE_PATH}")


if __name__ == "__main__":
    sys.exit(main())
