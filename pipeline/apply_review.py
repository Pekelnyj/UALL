"""Застосовує зміни рев'ю до translations.json (квести).

Вхід: JSON-файл [{"id","field":"title"|"desc"|"objectives","before","after"}].
Безпека: міняє лише якщо поточне значення == before (інакше пропускає й звітує).
Після застосування НЕ генерує — виклич generate_db.py окремо.
"""
import json
import sys
from pathlib import Path

from common import DATA_DIR

TR = DATA_DIR / "translations.json"
FIELD = {"title": "title", "desc": "description", "objectives": "objectives"}


def main(changes_path):
    tr = json.loads(TR.read_text(encoding="utf-8"))
    quests = tr["quests"]
    changes = json.loads(Path(changes_path).read_text(encoding="utf-8-sig"))

    applied = skipped = 0
    for c in changes:
        qid = str(c["id"])
        f = FIELD.get(c["field"])
        if not f or qid not in quests:
            skipped += 1
            continue
        cur = quests[qid].get(f, "")
        before, after = c["before"], c["after"]
        if cur == before:                      # повний збіг поля
            quests[qid][f] = after
            applied += 1
        elif cur.count(before) == 1:           # однозначний підрядок
            quests[qid][f] = cur.replace(before, after)
            applied += 1
        else:
            skipped += 1
            why = "не знайдено" if before not in cur else "неоднозначний підрядок"
            print(f"  ПРОПУСК {qid}/{c['field']}: {why}")
            continue

    TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"Застосовано: {applied} | пропущено: {skipped}")


if __name__ == "__main__":
    main(sys.argv[1])
