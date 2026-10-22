# -*- coding: utf-8 -*-
"""Оновити ФЕЙК-рядки в editor.db (де ua==en — англ.-дубль, не правка перекладача)
до справжнього перекладу з пакета бази. БЕЗПЕЧНО: чіпає лише рядки, де ua дослівно = en
(тобто переклад НІКОЛИ не робився), і лише якщо пакет має кириличний ua.

Запуск (на сервері):
    python editor/refresh_fakes.py /tmp/base_package.jsonl.gz [--dry]
"""
import gzip
import json
import re
import sqlite3
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
HERE = Path(__file__).resolve().parent
DB = HERE / "editor.db"
CYR = re.compile(r"[А-Яа-яІЇЄҐіїєґ]")


def opener(p):
    return gzip.open(p, "rt", encoding="utf-8") if str(p).endswith(".gz") else open(p, encoding="utf-8")


def main():
    args = sys.argv[1:]
    dry = "--dry" in args
    pkg = next((a for a in args if not a.startswith("--")), None)
    if not pkg or not Path(pkg).exists():
        raise SystemExit("вкажи шлях до base_package.jsonl[.gz]")

    # пакет: (section, key, field) -> ua
    master = {}
    with opener(pkg) as fh:
        for line in fh:
            line = line.strip()
            if not line:
                continue
            r = json.loads(line)
            if r.get("s") == "_meta":
                continue
            ua = r.get("ua")
            if ua and CYR.search(ua):
                master[(r.get("s"), r.get("k"), r.get("f"))] = ua

    con = sqlite3.connect(DB)
    con.execute("PRAGMA busy_timeout=8000")
    cur = con.cursor()
    # таблиця рядків: section,item_key,field,en,ua (перевіримо реальну схему)
    cols = [c[1] for c in cur.execute("PRAGMA table_info(strings)")]
    if not cols:
        # можлива інша назва таблиці
        tbls = [t[0] for t in cur.execute("SELECT name FROM sqlite_master WHERE type='table'")]
        raise SystemExit(f"нема таблиці strings; є: {tbls}")
    rows = cur.execute("SELECT rowid, section, item_key, field, en, ua FROM strings WHERE ua = en").fetchall()
    upd = 0
    samples = []
    for rid, sec, key, field, en, ua in rows:
        nu = master.get((sec, key, field))
        if nu and nu != ua:
            if not dry:
                cur.execute("UPDATE strings SET ua=? WHERE rowid=?", (nu, rid))
            upd += 1
            if len(samples) < 8:
                samples.append(f"{sec}/{(key or '')[:30]}: {en[:25]} -> {nu[:30]}")
    if not dry:
        con.commit()
    con.close()
    print(f"Фейк-рядків (ua==en) усього: {len(rows)} | {'оновили б' if dry else 'оновлено'}: {upd}")
    for s in samples:
        print("  ", s)


if __name__ == "__main__":
    main()
