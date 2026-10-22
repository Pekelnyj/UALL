"""Злиття знахідок де-русифікації імен + застосування по базі квестів.

Вхід:  data/batches/derussify/out_NN.json  {"names":[{en,wrong,translit,kind}]}
Дія:   1) агрегувати, дедуп по `wrong`, конфлікти -> найчастіший `translit`
       2) карту wrong->translit зберегти в data/review/name_map.json (огляд)
       3) застосувати по translations.json[quests] заміною ОСНОВИ
          (Штормоград -> Стормвінд конвертує і відмінки: Штормограді->Стормвінді)
       4) generate_db.py

Безпека: міняємо лише довгі (>=5) власні форми, wrong != translit.
Ідемпотентний. Друкує карту для контролю людиною.
"""

import json
import re
import subprocess
import sys
from collections import Counter, defaultdict

from common import DATA_DIR

BATCH_DIR = DATA_DIR / "batches" / "derussify"
MAP_PATH = DATA_DIR / "review" / "name_map.json"


def main():
    # 1) агрегувати
    votes = defaultdict(Counter)   # wrong -> Counter(translit)
    meta = {}                      # wrong -> (en, kind)
    for p in sorted(BATCH_DIR.glob("out_*.json")):
        try:
            data = json.loads(p.read_text(encoding="utf-8-sig"))
        except json.JSONDecodeError:
            continue
        for item in data.get("names", []):
            wrong = (item.get("wrong") or "").strip()
            translit = (item.get("translit") or "").strip()
            if len(wrong) < 5 or not translit or wrong == translit:
                continue
            if not wrong[0].isupper():
                continue  # лише власні назви (з великої)
            votes[wrong][translit] += 1
            meta[wrong] = (item.get("en", ""), item.get("kind", ""))

    # Явні помилки агента — НЕ застосовувати; ручні узгодження.
    EXCLUDE = {"Дерилокшин"}  # wrong не відповідає en (галюцинація)
    OVERRIDE = {"Святопад": "Геловфолл"}  # Hallowfall — одна форма

    # 2) карта (конфлікт -> найчастіший варіант) + en для прицільності
    name_map, en_of = {}, {}
    for wrong, c in votes.items():
        if wrong in EXCLUDE:
            continue
        name_map[wrong] = OVERRIDE.get(wrong, c.most_common(1)[0][0])
        en_of[wrong] = meta[wrong][0]

    MAP_PATH.parent.mkdir(parents=True, exist_ok=True)
    review = [{"wrong": w, "translit": name_map[w], "en": en_of[w],
               "kind": meta[w][1]} for w in sorted(name_map)]
    MAP_PATH.write_text(json.dumps(review, ensure_ascii=False, indent=1),
                        encoding="utf-8")

    # 3) ПРИЦІЛЬНЕ застосування: заміна wrong->translit лише в тих квестах,
    #    де англійський оригінал реально містить цю назву (en). Це не дає
    #    зіпсувати звичайні слова (Зоря, Прихисток) в інших квестах.
    src = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8"))
    p = DATA_DIR / "translations.json"
    t = json.loads(p.read_text(encoding="utf-8"))
    order = sorted(name_map, key=len, reverse=True)
    applied = 0
    for qid, q in t["quests"].items():
        s = src.get(qid, {})
        en_blob = " ".join(
            (v.get("en", "") if isinstance(v, dict) else "")
            for v in s.values()).lower()
        for f in list(q):
            if not isinstance(q[f], str):
                continue
            txt = q[f]
            for wrong in order:
                en_name = (en_of[wrong] or "").lower().strip(". ")
                if wrong in txt and en_name and en_name in en_blob:
                    txt = txt.replace(wrong, name_map[wrong])
                    applied += 1
            q[f] = txt
    p.write_text(json.dumps(t, ensure_ascii=False, indent=1), encoding="utf-8")

    print(f"Унікальних назв у карті: {len(name_map)} | замін у тексті: {applied}")
    print(f"Карта -> {MAP_PATH}")
    for w in sorted(name_map):
        print(f"  {w} -> {name_map[w]}  ({meta[w][0]}, {meta[w][1]})")

    r = subprocess.run([sys.executable, "-X", "utf8", "generate_db.py"],
                       cwd=str(DATA_DIR.parent / "pipeline"),
                       capture_output=True, text=True, encoding="utf-8")
    if r.returncode != 0:
        print("ПОМИЛКА generate_db:", r.stderr[:300])


if __name__ == "__main__":
    main()
