# -*- coding: utf-8 -*-
"""Зібрати самодостатній «пакет бази» для завантаження на сайт.

Пакет = JSONL: 1-й рядок — заголовок _meta, далі по рядку на запис
{s:section, k:item_key, f:field, en, de, fr, ua}. Містить усе потрібне, тож
серверу НЕ потрібні великі translations.json/source — лише цей файл.

Завантажується в адмінпанелі («Завантажити нову базу») → сервер додає нові рядки
в копію живої editor.db, перевіряє і атомарно підміняє (стара лишається на відкат).

Запуск:
    python editor/build_base_package.py                       # -> data/base_package.jsonl.gz
    python editor/build_base_package.py out.jsonl             # без стиснення
    python editor/build_base_package.py out.jsonl.gz          # зі стисненням (.gz)
"""
import gzip
import json
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from import_db import load, load_sources, iter_rows, DATA

sys.stdout.reconfigure(encoding="utf-8")


def main():
    out = Path(sys.argv[1]) if len(sys.argv) > 1 else (DATA / "base_package.jsonl.gz")
    gz = str(out).endswith(".gz")
    opener = (lambda p: gzip.open(p, "wt", encoding="utf-8")) if gz else (lambda p: open(p, "w", encoding="utf-8"))

    rows = iter_rows(load(DATA / "translations.json"), load_sources())
    n = 0
    with opener(out) as fh:
        fh.write(json.dumps({"_meta": {"format": "wowukraine-base-v1", "created": time.time()}},
                            ensure_ascii=False) + "\n")
        for s, k, f, en, de, fr, ua in rows:
            fh.write(json.dumps({"s": s, "k": k, "f": f, "en": en, "de": de, "fr": fr, "ua": ua},
                                ensure_ascii=False) + "\n")
            n += 1
    size = out.stat().st_size
    print(f"Пакет: {n} рядків -> {out}  ({size/1024/1024:.1f} МБ{', gz' if gz else ''})")
    print("Далі: адмінпанель → «Завантажити нову базу» (або scp на сервер + update_db.py --from-package).")


if __name__ == "__main__":
    main()
