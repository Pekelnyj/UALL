"""Витяг предметів Midnight із wago.tools (ItemSparse.db2) — без ключів і без гри.

ItemSparse містить назву (Display_lang), художній опис-«флейвор»
(Description_lang) і поле ExpansionID — фільтруємо Midnight (11).

Результат: data/source/items.json
    {itemID: {"name": {"en","de","fr"}, "flavor": {"en","de","fr"}?}}

Використання:
    python extract_items.py            # Midnight (ExpansionID=11)
    python extract_items.py --exp 10   # інше доповнення
"""

import argparse
import csv
import io
import json

import requests

from common import DATA_DIR

SOURCE_PATH = DATA_DIR / "source" / "items.json"
CACHE_DIR = DATA_DIR / "wago"

LOCALES = {"enUS": "en", "deDE": "de", "frFR": "fr"}
MIDNIGHT = 11


def download_csv(table: str, locale: str, build=None) -> str:
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    cache_path = CACHE_DIR / f"{table}.{locale}.{build or 'latest'}.csv"
    if cache_path.exists():
        print(f"  {cache_path.name}: з кешу")
        return cache_path.read_text(encoding="utf-8")
    print(f"  {cache_path.name}: завантажую (велика таблиця, зачекайте)...")
    params = {"locale": locale}
    if build:
        params["build"] = build
    resp = requests.get(f"https://wago.tools/db2/{table}/csv", params=params, timeout=900)
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
    raise KeyError(f"Немає колонки {needles}: {fieldnames[:30]}")


def parse_locale(text: str, expansion: int | None):
    reader = csv.DictReader(io.StringIO(text))
    name_col = find_column(reader.fieldnames, "Display_lang")
    flavor_col = find_column(reader.fieldnames, "Description_lang")
    exp_col = find_column(reader.fieldnames, "ExpansionID")
    out = {}
    for r in reader:
        if expansion is not None:
            try:
                if int(r.get(exp_col) or -1) != expansion:
                    continue
            except ValueError:
                continue
        name = (r.get(name_col) or "").strip()
        if not name:
            continue
        out[int(r["ID"])] = {
            "name": name,
            "flavor": (r.get(flavor_col) or "").strip(),
        }
    return out


def main():
    ap = argparse.ArgumentParser(description="Витяг предметів із wago.tools")
    ap.add_argument("--exp", default=str(MIDNIGHT),
                    help="ExpansionID (11 = Midnight) або 'all' для всіх доповнень")
    ap.add_argument("--build", help="білд клієнта")
    args = ap.parse_args()

    exp_filter = None if str(args.exp).lower() == "all" else int(args.exp)

    per_locale = {}
    for loc, short in LOCALES.items():
        print(f"Локаль {loc}:")
        # фільтр по доповненню робимо лише по enUS-рядках (ExpansionID однаковий)
        per_locale[short] = parse_locale(download_csv("ItemSparse", loc, args.build),
                                         exp_filter)

    source = {}
    if SOURCE_PATH.exists():
        source = json.loads(SOURCE_PATH.read_text(encoding="utf-8-sig"))

    added = flavored = 0
    for iid, en in per_locale["en"].items():
        entry = source.setdefault(str(iid), {})
        entry.setdefault("name", {})["en"] = en["name"]
        if en["flavor"]:
            entry.setdefault("flavor", {})["en"] = en["flavor"]
            flavored += 1
        for short in ("de", "fr"):
            other = per_locale[short].get(iid)
            if other:
                entry["name"][short] = other["name"]
                if other["flavor"] and en["flavor"]:
                    entry.setdefault("flavor", {})[short] = other["flavor"]
        added += 1

    SOURCE_PATH.parent.mkdir(parents=True, exist_ok=True)
    SOURCE_PATH.write_text(json.dumps(source, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"Предметів (ExpansionID={args.exp}): {added}, з флейвором: {flavored}")
    print(f"-> {SOURCE_PATH}")


if __name__ == "__main__":
    main()
