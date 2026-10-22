"""Витяг клієнтських текстів квестів із wago.tools — без ключів і без гри.

wago.tools віддає CSV-експорт DB2-таблиць клієнта WoW per locale:
    https://wago.tools/db2/{Table}/csv?locale=enUS[&build=12.0.x.xxxxx]

Що тут видобувається (це ВСЕ, що є у клієнтських файлах для квестів):
    QuestV2CliTask.db2  -> назви квестів  (QuestTitle_lang)
    QuestObjective.db2  -> цілі квестів   (Description_lang, по QuestID)

Опис квесту, тексти прогресу/здачі — серверні: їх дає extract_quests.py
(Blizzard API, поле description) і збір аддоном у грі (progress/completion).

Використання:
    python extract_wago.py                  # останній білд, en+de+fr, усі квести
    python extract_wago.py --ids 87000-90000
    python extract_wago.py --build 12.0.7.67808
Результат зливається в data/source/quests.json (тільки поля title/objectives;
наявні description не чіпаються).
"""

import argparse
import csv
import io
import json
import sys

import requests

from common import DATA_DIR

SOURCE_PATH = DATA_DIR / "source" / "quests.json"
CACHE_DIR = DATA_DIR / "wago"

CSV_URL = "https://wago.tools/db2/{table}/csv"

# Локаль wago -> короткий код у data/source/quests.json
LOCALES = {"enUS": "en", "deDE": "de", "frFR": "fr"}


def download_csv(table: str, locale: str, build: str | None) -> str:
    """Тягне CSV таблиці; кешує на диску, щоб не качати повторно."""
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
    resp = requests.get(CSV_URL.format(table=table), params=params, timeout=300)
    resp.raise_for_status()
    text = resp.text
    cache_path.write_text(text, encoding="utf-8")
    return text


def find_column(fieldnames: list[str], *needles: str) -> str:
    """Знаходить колонку за підрядком назви (схеми DB2 інколи змінюються)."""
    for needle in needles:
        for name in fieldnames:
            if needle.lower() in name.lower():
                return name
    raise KeyError(f"Не знайдено колонку {needles} серед: {fieldnames[:20]}")


def parse_titles(text: str) -> dict[int, str]:
    reader = csv.DictReader(io.StringIO(text))
    id_col = "ID"
    title_col = find_column(reader.fieldnames, "QuestTitle")
    out = {}
    for row in reader:
        title = (row.get(title_col) or "").strip()
        if title:
            out[int(row[id_col])] = title
    return out


def parse_objectives(text: str) -> dict[int, str]:
    """QuestObjective: кілька рядків на квест -> зліплюємо за OrderIndex."""
    reader = csv.DictReader(io.StringIO(text))
    quest_col = find_column(reader.fieldnames, "QuestID")
    desc_col = find_column(reader.fieldnames, "Description")
    order_col = find_column(reader.fieldnames, "OrderIndex")
    per_quest: dict[int, list[tuple[int, str]]] = {}
    for row in reader:
        desc = (row.get(desc_col) or "").strip()
        if not desc:
            continue
        try:
            order = int(row.get(order_col) or 0)
        except ValueError:
            order = 0
        per_quest.setdefault(int(row[quest_col]), []).append((order, desc))
    return {
        qid: "\n".join(d for _, d in sorted(items))
        for qid, items in per_quest.items()
    }


def parse_ids(spec: str) -> set[int]:
    ids: set[int] = set()
    for part in spec.split(","):
        part = part.strip()
        if "-" in part:
            lo, hi = part.split("-", 1)
            ids.update(range(int(lo), int(hi) + 1))
        elif part:
            ids.add(int(part))
    return ids


def main():
    ap = argparse.ArgumentParser(description="Витяг клієнтських текстів із wago.tools")
    ap.add_argument("--build", help="білд клієнта, напр. 12.0.7.67808 (типово останній)")
    ap.add_argument("--ids", help="обмежити квестами: 87000-90000,84321 (типово всі)")
    ap.add_argument("--ids-file", help="файл із questID по одному на рядок "
                                       "(напр. data/midnight_ids.txt від discover_midnight.py)")
    args = ap.parse_args()

    id_filter: set[int] | None = None
    if args.ids:
        id_filter = parse_ids(args.ids)
    if args.ids_file:
        from pathlib import Path
        file_ids = {
            int(line) for line in Path(args.ids_file).read_text(encoding="utf-8-sig").split()
            if line.strip().isdigit()
        }
        id_filter = file_ids if id_filter is None else (id_filter | file_ids)

    titles: dict[str, dict[int, str]] = {}
    objectives: dict[str, dict[int, str]] = {}
    for wago_locale, short in LOCALES.items():
        print(f"Локаль {wago_locale}:")
        titles[short] = parse_titles(download_csv("QuestV2CliTask", wago_locale, args.build))
        objectives[short] = parse_objectives(download_csv("QuestObjective", wago_locale, args.build))

    source = {}
    if SOURCE_PATH.exists():
        source = json.loads(SOURCE_PATH.read_text(encoding="utf-8-sig"))

    quest_ids = set(titles["en"]) | set(objectives["en"])
    if id_filter is not None:
        quest_ids &= id_filter

    added = 0
    for qid in sorted(quest_ids):
        key = str(qid)
        entry = source.setdefault(key, {})
        for short in LOCALES.values():
            title = titles[short].get(qid)
            if title:
                entry.setdefault("title", {})[short] = title
            objective = objectives[short].get(qid)
            if objective:
                entry.setdefault("objectives", {})[short] = objective
        added += 1

    SOURCE_PATH.parent.mkdir(parents=True, exist_ok=True)
    SOURCE_PATH.write_text(json.dumps(source, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"\nОброблено квестів: {added}. Усього в базі джерел: {len(source)}")
    print(f"-> {SOURCE_PATH}")
    print("Описи квестів (серверні) добираються extract_quests.py або збором у грі.")


if __name__ == "__main__":
    sys.exit(main())
