"""Злиття перекладених зібраних квестових полів у translations.json.

Вхід: data/batches/captured/out_NN.json [{id, field, ua}]
Дія:  quests[id][field] = ua (лише якщо поля ще нема — не затираємо),
      потім generate_db.py перегенерує Quests.lua.
Ідемпотентний.
"""

import json
import subprocess
import sys

from common import DATA_DIR

BATCH_DIR = DATA_DIR / "batches" / "captured"
FIELDS = ("title", "description", "objectives", "progress", "completion")


def main():
    p = DATA_DIR / "translations.json"
    t = json.loads(p.read_text(encoding="utf-8"))
    quests = t.setdefault("quests", {})

    merged, skipped = 0, 0
    for path in sorted(BATCH_DIR.glob("out_*.json")):
        for item in json.loads(path.read_text(encoding="utf-8-sig")):
            qid = str(item.get("id", ""))
            field = item.get("field", "")
            ua = (item.get("ua") or "").strip()
            if not qid or field not in FIELDS or not ua:
                skipped += 1
                continue
            entry = quests.setdefault(qid, {})
            if entry.get(field):
                skipped += 1  # вже є — не чіпаємо
            else:
                entry[field] = ua.replace("\r\n", "\n")
                merged += 1

    p.write_text(json.dumps(t, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"Злито полів: {merged} | пропущено: {skipped} | квестів у базі: {len(quests)}")

    r = subprocess.run([sys.executable, "-X", "utf8", "generate_db.py"],
                       cwd=str(DATA_DIR.parent / "pipeline"),
                       capture_output=True, text=True, encoding="utf-8")
    print(r.stdout.strip().splitlines()[-1] if r.stdout else "")
    if r.returncode != 0:
        print("ПОМИЛКА generate_db:", r.stderr[:300])


if __name__ == "__main__":
    main()
