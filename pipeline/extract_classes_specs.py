"""Витяг назв класів і спеціалізацій en/de/fr (з родовими формами).

ChrClasses.db2        -> Name_lang (чол.) + Name_female_lang (жін.)
ChrSpecialization.db2 -> Name_lang + FemaleName_lang, ClassID, роль

Німецька і французька версії дають рід прикметників (Heilig/Sacré...)
— критично для коректного перекладу назв спеків типу Holy.

Результат: data/source/classes_specs.json

Використання:
    python extract_classes_specs.py
"""

import csv
import io
import json

import requests

from common import DATA_DIR

OUT = DATA_DIR / "source" / "classes_specs.json"
CACHE_DIR = DATA_DIR / "wago"
LOCALES = {"enUS": "en", "deDE": "de", "frFR": "fr"}


def download_csv(table: str, locale: str) -> str:
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    cache_path = CACHE_DIR / f"{table}.{locale}.latest.csv"
    if cache_path.exists():
        return cache_path.read_text(encoding="utf-8")
    print(f"  Завантажую {cache_path.name}...")
    resp = requests.get(f"https://wago.tools/db2/{table}/csv",
                        params={"locale": locale}, timeout=300)
    resp.raise_for_status()
    cache_path.write_text(resp.text, encoding="utf-8")
    return resp.text


def col(fieldnames, *needles):
    for needle in needles:
        for name in fieldnames:
            if needle.lower() == name.lower():
                return name
    for needle in needles:
        for name in fieldnames:
            if needle.lower() in name.lower():
                return name
    return None


def main():
    classes = {}
    for loc, short in LOCALES.items():
        reader = csv.DictReader(io.StringIO(download_csv("ChrClasses", loc)))
        male_col = col(reader.fieldnames, "Name_lang")
        female_col = col(reader.fieldnames, "Name_female_lang", "NameFemale_lang")
        for r in reader:
            try:
                cid = int(r["ID"])
            except (KeyError, ValueError):
                continue
            e = classes.setdefault(cid, {"male": {}, "female": {}})
            if r.get(male_col):
                e["male"][short] = r[male_col].strip()
            if female_col and r.get(female_col):
                e["female"][short] = r[female_col].strip()

    specs = {}
    for loc, short in LOCALES.items():
        reader = csv.DictReader(io.StringIO(download_csv("ChrSpecialization", loc)))
        name_col = col(reader.fieldnames, "Name_lang")
        fem_col = col(reader.fieldnames, "FemaleName_lang")
        class_col = col(reader.fieldnames, "ClassID")
        for r in reader:
            try:
                sid = int(r["ID"])
                class_id = int(r.get(class_col) or 0)
            except (KeyError, ValueError):
                continue
            if class_id <= 0:
                continue
            e = specs.setdefault(sid, {"classID": class_id, "male": {}, "female": {}})
            if r.get(name_col):
                e["male"][short] = r[name_col].strip()
            if fem_col and r.get(fem_col):
                e["female"][short] = r[fem_col].strip()

    specs = {k: v for k, v in specs.items() if v["male"].get("en")}
    OUT.write_text(json.dumps({"classes": classes, "specs": specs},
                              ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"Класів: {len(classes)}, спеків: {len(specs)} -> {OUT}")

    for sid, e in sorted(specs.items()):
        cls = classes.get(e["classID"], {}).get("male", {}).get("en", "?")
        print(f"  [{cls}] {e['male'].get('en')} | de: {e['male'].get('de')}"
              f"{' / ж: ' + e['female']['de'] if e['female'].get('de') else ''}"
              f" | fr: {e['male'].get('fr')}"
              f"{' / ж: ' + e['female']['fr'] if e['female'].get('fr') else ''}")


if __name__ == "__main__":
    main()
