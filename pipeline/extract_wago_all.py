"""Витяг УСЬОГО локалізовного тексту з DB2 через wago.tools.

Список таблиць — pipeline/loc_tables.txt (267 шт., згенеровано з WoWDBDefs:
ті, що мають locstring-колонки). Для кожної таблиці качає з wago en/de/fr CSV,
бере всі колонки *_lang і складає {id: {column: {en, de, fr}}}.

Дамп -> data/wago_all/<Table>.json (gitignored, регенеровне).
EN — джерело перекладу; DE/FR — контекст (рід, неоднозначності).

    python extract_wago_all.py                  # усі таблиці зі списку
    python extract_wago_all.py --only ItemSparse,Spell,CinematicSubtitle
    python extract_wago_all.py --build 12.0.7.68256
"""
import csv
import io
import json
import sys
from pathlib import Path

from common import DATA_DIR
from extract_wago import download_csv

LIST = Path(__file__).resolve().parent / "loc_tables.txt"
OUT_DIR = DATA_DIR / "wago_all"
EXTRA_LOCALES = (("deDE", "de"), ("frFR", "fr"))


def lang_cols(fieldnames):
    return [c for c in (fieldnames or []) if c.endswith("_lang")]


def ingest(text, cols, short, data):
    reader = csv.DictReader(io.StringIO(text))
    fields = reader.fieldnames or []
    id_col = "ID" if "ID" in fields else (fields[0] if fields else None)
    if not id_col:
        return
    for row in reader:
        rid = (row.get(id_col) or "").strip()
        if not rid:
            continue
        for c in cols:
            v = (row.get(c) or "").strip()
            if v:
                data.setdefault(rid, {}).setdefault(c, {})[short] = v


def extract_table(table, build):
    try:
        en_text = download_csv(table, "enUS", build)
    except Exception as e:
        return None, f"нема enUS ({type(e).__name__})"
    cols = lang_cols(csv.DictReader(io.StringIO(en_text)).fieldnames)
    if not cols:
        return None, "нема *_lang колонок"
    data = {}
    ingest(en_text, cols, "en", data)
    for loc, short in EXTRA_LOCALES:
        try:
            ingest(download_csv(table, loc, build), cols, short, data)
        except Exception:
            pass  # de/fr — опційні, не зривають таблицю
    return data, f"{len(data)} записів | колонки: {', '.join(cols)}"


def main():
    argv = sys.argv[1:]
    build = argv[argv.index("--build") + 1] if "--build" in argv else None
    only = set(argv[argv.index("--only") + 1].split(",")) if "--only" in argv else None

    tables = [t.strip() for t in LIST.read_text(encoding="utf-8").split() if t.strip()]
    if only:
        tables = [t for t in tables if t in only]
    OUT_DIR.mkdir(parents=True, exist_ok=True)

    ok = total = 0
    for i, table in enumerate(tables, 1):
        data, msg = extract_table(table, build)
        if data:
            (OUT_DIR / f"{table}.json").write_text(
                json.dumps(data, ensure_ascii=False), encoding="utf-8")
            ok += 1
            total += len(data)
            print(f"[{i}/{len(tables)}] {table}: {msg}")
        else:
            print(f"[{i}/{len(tables)}] {table}: — {msg}")
    print(f"\nГотово: {ok}/{len(tables)} таблиць із текстом, {total} записів -> {OUT_DIR}")


if __name__ == "__main__":
    main()
