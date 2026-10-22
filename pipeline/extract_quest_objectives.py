"""Витяг рядків цілей квестів (QuestObjective.db2) для перекладених квестів.

Рядок цілі — те, що гравець бачить у трекері та журналі з лічильником:
"Crates discarded" (гра сама домальовує ": 2/3").

Беремо лише цілі квестів, які вже є в data/translations.json (1131 шт.),
щоб перекладати тільки потрібне.

Результат: data/source/quest_objectives.json
    { "<questID>": [ {"id": <objectiveID>, "order": N, "en": "..."}, ... ] }

Використання:
    python extract_quest_objectives.py
"""

import csv
import io
import json

import requests

from common import DATA_DIR

OUT = DATA_DIR / "source" / "quest_objectives.json"
CACHE_DIR = DATA_DIR / "wago"


def download_csv(table: str, locale: str = "enUS") -> str:
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


def main():
    translations = json.loads(
        (DATA_DIR / "translations.json").read_text(encoding="utf-8"))
    our_quests = {int(k) for k in translations.get("quests", {})}
    print(f"Квестів у базі перекладів: {len(our_quests)}")

    reader = csv.DictReader(io.StringIO(download_csv("QuestObjective")))
    cols = {c.lower(): c for c in reader.fieldnames}
    desc_col = cols.get("description_lang")
    quest_col = cols.get("questid")
    order_col = cols.get("orderindex")
    if not (desc_col and quest_col):
        raise SystemExit(f"Не знайшов колонки. Є: {reader.fieldnames}")

    result = {}
    total_rows = 0
    for r in reader:
        total_rows += 1
        try:
            quest_id = int(r[quest_col])
        except (ValueError, TypeError):
            continue
        if quest_id not in our_quests:
            continue
        desc = (r.get(desc_col) or "").strip()
        if not desc:
            continue  # цілі без тексту (принеси предмет тощо)
        result.setdefault(str(quest_id), []).append({
            "id": int(r["ID"]),
            "order": int(r.get(order_col) or 0),
            "en": desc,
        })

    for objs in result.values():
        objs.sort(key=lambda o: o["order"])

    n_lines = sum(len(v) for v in result.values())
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(result, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    print(f"Рядків у QuestObjective всього: {total_rows}")
    print(f"Наших квестів із текстовими цілями: {len(result)}")
    print(f"Рядків цілей до перекладу: {n_lines} -> {OUT}")


if __name__ == "__main__":
    main()
