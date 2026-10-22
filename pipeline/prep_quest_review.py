"""Готує батчі для РЕВ'Ю узгодженості «назва ↔ опис» квестів.

Кожен запис: id, en_title, en_desc, ua_title, ua_desc, de_title, fr_title.
Агент звіряє, чи укр. назва відповідає змісту опису (типова помилка —
назва перекладена в короткому контексті без опису).

data/batches/review/batch_NNN.json
"""
import argparse
import json
import math

from common import DATA_DIR

SRC = DATA_DIR / "source" / "quests.json"
TR = DATA_DIR / "translations.json"
OUT = DATA_DIR / "batches" / "review"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--min", type=int, default=0)
    ap.add_argument("--max", type=int, default=10**9)
    ap.add_argument("--size", type=int, default=25)
    args = ap.parse_args()

    src = json.loads(SRC.read_text(encoding="utf-8"))
    tr = json.loads(TR.read_text(encoding="utf-8")).get("quests", {})

    todo = []
    for qid, v in src.items():
        if not (args.min <= int(qid) < args.max):
            continue
        u = tr.get(qid)
        if not u:
            continue
        en_t = (v.get("title") or {}).get("en", "")
        en_d = (v.get("description") or {}).get("en", "")
        ua_t = u.get("title", "")
        ua_d = u.get("description", "")
        # рев'ю має сенс лише коли є і назва, і опис (обидвома мовами)
        if not (en_t and en_d and ua_t and ua_d):
            continue
        todo.append({
            "id": qid,
            "en_title": en_t, "en_desc": en_d,
            "ua_title": ua_t, "ua_desc": ua_d,
            "de_title": (v.get("title") or {}).get("de", ""),
            "fr_title": (v.get("title") or {}).get("fr", ""),
        })

    todo.sort(key=lambda x: int(x["id"]))
    OUT.mkdir(parents=True, exist_ok=True)
    for f in OUT.glob("batch_*.json"):
        f.unlink()

    n = args.size
    nb = math.ceil(len(todo) / n)
    for i in range(nb):
        chunk = todo[i * n:(i + 1) * n]
        (OUT / f"batch_{i+1:03d}.json").write_text(
            json.dumps(chunk, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"До рев'ю: {len(todo)} квестів | батчів по {n}: {nb}")


if __name__ == "__main__":
    main()
