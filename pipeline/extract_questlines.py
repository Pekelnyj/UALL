"""Витяг ЛІНІЙОК квестів (questlines) із wago.tools.

Лінійка — це сюжетний ланцюжок з кількох етапів. Перекладати треба лінійкою
і по порядку: так зберігається наскрізний контекст (персонажі, інтрига,
відсилки до попередніх етапів), який губиться при перекладі квестів поодинці.

Таблиці:
    QuestLineXQuest.db2 -> QuestID, QuestLineID, OrderIndex
    QuestLine.db2       -> назва лінійки (en/de/fr)

Результат: data/questlines.json
    {questLineID: {"name": {...}, "quests": [questID у порядку OrderIndex]}}

Використання:
    python extract_questlines.py
"""

import csv
import io
import json

import requests

from common import DATA_DIR

CACHE_DIR = DATA_DIR / "wago"
OUT_PATH = DATA_DIR / "questlines.json"

LOCALES = {"enUS": "en", "deDE": "de", "frFR": "fr"}


def download_csv(table: str, locale: str, build=None) -> str:
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    cache_path = CACHE_DIR / f"{table}.{locale}.{build or 'latest'}.csv"
    if cache_path.exists():
        return cache_path.read_text(encoding="utf-8")
    print(f"  Завантажую {cache_path.name}...")
    params = {"locale": locale}
    if build:
        params["build"] = build
    resp = requests.get(f"https://wago.tools/db2/{table}/csv", params=params, timeout=300)
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
    raise KeyError(f"Немає колонки {needles}: {fieldnames[:20]}")


def main():
    # 1. Зв'язки квест -> лінійка (+ порядок).
    reader = csv.DictReader(io.StringIO(download_csv("QuestLineXQuest", "enUS")))
    line_col = find_column(reader.fieldnames, "QuestLineID")
    quest_col = find_column(reader.fieldnames, "QuestID")
    order_col = find_column(reader.fieldnames, "OrderIndex")
    lines: dict[int, list[tuple[int, int]]] = {}
    for r in reader:
        try:
            lines.setdefault(int(r[line_col]), []).append(
                (int(r.get(order_col) or 0), int(r[quest_col])))
        except ValueError:
            continue

    # 2. Назви лінійок per locale.
    names: dict[str, dict[int, str]] = {}
    for loc, short in LOCALES.items():
        reader = csv.DictReader(io.StringIO(download_csv("QuestLine", loc)))
        name_col = find_column(reader.fieldnames, "Name_lang", "Name")
        names[short] = {}
        for r in reader:
            val = (r.get(name_col) or "").strip()
            if val:
                try:
                    names[short][int(r["ID"])] = val
                except (KeyError, ValueError):
                    continue

    out = {}
    for line_id, pairs in lines.items():
        quests = [qid for _, qid in sorted(pairs)]
        entry = {"quests": quests}
        name = {short: names[short].get(line_id) for short in LOCALES.values()
                if names[short].get(line_id)}
        if name:
            entry["name"] = name
        out[str(line_id)] = entry

    OUT_PATH.write_text(json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
    total_q = sum(len(e["quests"]) for e in out.values())
    print(f"Лінійок: {len(out)} | квестів у лінійках: {total_q}")
    print(f"-> {OUT_PATH}")


if __name__ == "__main__":
    main()
