"""Батчі досягнень для перекладу. Читає wago-CSV (en/de/fr), будує
source/achievements.json і батчі неперекладених.

Вхід:  data/wago/Achievement.{enUS,deDE,frFR}.latest.csv
Вихід: data/source/achievements.json {id: {title,desc:{en,de,fr}}}
       data/batches/achievements/batch_NN.json
Дедуп проти data/translations.json["achievements"].

Використання: python prep_achievement_batches.py
"""

import csv
import json
from common import DATA_DIR

WAGO = DATA_DIR / "wago"
OUT_SRC = DATA_DIR / "source" / "achievements.json"
BATCH_DIR = DATA_DIR / "batches" / "achievements"
BATCH_SIZE = 40


def load(locale):
    path = WAGO / f"Achievement.{locale}.latest.csv"
    out = {}
    with open(path, encoding="utf-8") as f:
        for row in csv.DictReader(f):
            out[row["ID"]] = (row.get("Title_lang") or "",
                              row.get("Description_lang") or "")
    return out


def main():
    en, de, fr = load("enUS"), load("deDE"), load("frFR")
    src = {}
    for aid, (t_en, d_en) in en.items():
        if not t_en.strip():
            continue
        entry = {"title": {"en": t_en}}
        if d_en.strip():
            entry["desc"] = {"en": d_en}
        for loc, data in (("de", de), ("fr", fr)):
            t, d = data.get(aid, ("", ""))
            if t.strip():
                entry["title"][loc] = t
            if d.strip() and "desc" in entry:
                entry["desc"][loc] = d
        src[aid] = entry

    OUT_SRC.parent.mkdir(parents=True, exist_ok=True)
    OUT_SRC.write_text(json.dumps(src, ensure_ascii=False, indent=1),
                       encoding="utf-8")

    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8"))
    done = set(tr.get("achievements", {}))

    todo = [{"id": aid, **e} for aid, e in src.items() if aid not in done]
    todo.sort(key=lambda x: int(x["id"]))

    BATCH_DIR.mkdir(parents=True, exist_ok=True)
    for old in BATCH_DIR.glob("batch_*.json"):
        old.unlink()
    n = 0
    for i in range(0, len(todo), BATCH_SIZE):
        n += 1
        (BATCH_DIR / f"batch_{n:03d}.json").write_text(
            json.dumps(todo[i:i + BATCH_SIZE], ensure_ascii=False, indent=1),
            encoding="utf-8")

    print(f"Досягнень у джерелі: {len(src)} | до перекладу: {len(todo)} | "
          f"батчів по {BATCH_SIZE}: {n}")


if __name__ == "__main__":
    main()
