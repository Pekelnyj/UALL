"""Витяг валют (CurrencyTypes.db2) із wago.tools — без ключів і без гри.

CurrencyTypes містить назву (Name_lang) і опис (Description_lang) валюти.
Валюти показуються у вікнах нагород квестів, гаманці, тултіпах.

Результат: data/source/currencies.json
    {currencyID: {"name": {"en","de","fr"}, "description": {"en","de","fr"}?}}

Використання:
    python extract_currencies.py
"""

import csv
import io
import json

import requests

from common import DATA_DIR

SOURCE_PATH = DATA_DIR / "source" / "currencies.json"
CACHE_DIR = DATA_DIR / "wago"
LOCALES = {"enUS": "en", "deDE": "de", "frFR": "fr"}


def download_csv(table: str, locale: str) -> str:
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    cache_path = CACHE_DIR / f"{table}.{locale}.latest.csv"
    if cache_path.exists():
        print(f"  {cache_path.name}: з кешу")
        return cache_path.read_text(encoding="utf-8")
    print(f"  {cache_path.name}: завантажую...")
    resp = requests.get(f"https://wago.tools/db2/{table}/csv",
                        params={"locale": locale}, timeout=300)
    resp.raise_for_status()
    cache_path.write_text(resp.text, encoding="utf-8")
    return resp.text


def parse_locale(text: str):
    reader = csv.DictReader(io.StringIO(text))
    out = {}
    for r in reader:
        name = (r.get("Name_lang") or "").strip()
        if not name:
            continue
        out[int(r["ID"])] = {
            "name": name,
            "description": (r.get("Description_lang") or "").strip(),
        }
    return out


def main():
    per_locale = {}
    for loc, short in LOCALES.items():
        print(f"Локаль {loc}:")
        per_locale[short] = parse_locale(download_csv("CurrencyTypes", loc))

    source = {}
    if SOURCE_PATH.exists():
        source = json.loads(SOURCE_PATH.read_text(encoding="utf-8-sig"))

    count = described = 0
    for cid, en in per_locale["en"].items():
        entry = source.setdefault(str(cid), {})
        entry.setdefault("name", {})["en"] = en["name"]
        if en["description"]:
            entry.setdefault("description", {})["en"] = en["description"]
            described += 1
        for short in ("de", "fr"):
            other = per_locale[short].get(cid)
            if other:
                entry["name"][short] = other["name"]
                if other["description"] and en["description"]:
                    entry.setdefault("description", {})[short] = other["description"]
        count += 1

    SOURCE_PATH.parent.mkdir(parents=True, exist_ok=True)
    SOURCE_PATH.write_text(json.dumps(source, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"Валют: {count} (з описом: {described}) -> {SOURCE_PATH}")


if __name__ == "__main__":
    main()
