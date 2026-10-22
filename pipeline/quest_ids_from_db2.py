"""Витягти ПОВНИЙ список квест-ID із DB2 (QuestV2, через wago) у файл.

Дає вичерпний перелік усіх квестів гри (поточних + історичних), щоб згодувати
його extract_quests.py для повного API-проходу (title+description по кожному ID).

    python quest_ids_from_db2.py            # -> data/quest_ids_all.txt
"""
import csv
import io
import sys

from common import DATA_DIR
from extract_wago import download_csv

OUT = DATA_DIR / "quest_ids_all.txt"


def main():
    build = None
    if "--build" in sys.argv:
        i = sys.argv.index("--build")
        build = sys.argv[i + 1] if i + 1 < len(sys.argv) else None

    text = download_csv("QuestV2", "enUS", build)   # бере з кешу, якщо вже качали
    reader = csv.DictReader(io.StringIO(text))
    ids = sorted({int(r["ID"]) for r in reader if (r.get("ID") or "").strip().isdigit()})

    OUT.write_text("\n".join(map(str, ids)), encoding="utf-8")
    print(f"Квест-ID у DB2: {len(ids)}  (мін {ids[0]}, макс {ids[-1]})")
    print(f"-> {OUT}")
    print("Далі: python extract_quests.py --ids-file ../data/quest_ids_all.txt")


if __name__ == "__main__":
    main()
