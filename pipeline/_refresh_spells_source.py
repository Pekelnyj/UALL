# -*- coding: utf-8 -*-
"""Долити в data/source/spells.json ID заклять свіжого білда (лише назви).

НАВІЩО. generate_db.generate_spells розносить переклад на ВСІ spellID з тією
самою англійською назвою, але список ID бере з цього джерела. У джерелі було
21 768 ID проти 416 194 у клієнті 12.1.5 — тобто 68 175 ID, чия назва в нас
ПЕРЕКЛАДЕНА, у грі лишалися англійськими (14.10). Це та сама вада, що з
предметами: оновлювати треба не лише переклад, а й джерело.

Доливаємо ТІЛЬКИ name.en для відсутніх ID. Опис/skillLine/de/fr не чіпаємо:
вони потрібні перекладачеві, їх тягне extract_wago за потреби, а тут завдання
одне — дати генераторові повний список ID на кожну назву.

Запуск: python _refresh_spells_source.py --csv <SpellName.csv> [--apply]
"""
import csv
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
csv.field_size_limit(20_000_000)
from common import DATA_DIR

APPLY = "--apply" in sys.argv
CSV = Path(sys.argv[sys.argv.index("--csv") + 1]) if "--csv" in sys.argv else None
P = DATA_DIR / "source" / "spells.json"

src = json.loads(P.read_text(encoding="utf-8-sig"))
db2 = {}
with open(CSV, encoding="utf-8", newline="") as f:
    rd = csv.DictReader(f)
    col = next(x for x in rd.fieldnames if x.startswith("Name_lang"))
    for r in rd:
        n = (r.get(col) or "").strip()
        if n:
            db2[r["ID"]] = n

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
ua = tr.get("spells") or {}
en_done = set()
for sid in ua:
    e = ((src.get(str(sid)) or {}).get("name") or {}).get("en") or db2.get(str(sid))
    if e:
        en_done.add(e)

added = 0
for sid, name in db2.items():
    if sid in src:
        continue
    # ЛИШЕ ті ID, чия назва в нас уже перекладена: решта 300+ тисяч службових
    # заклять роздула б і джерело, і згенерований Spells.lua без жодної користі
    if name not in en_done:
        continue
    src[sid] = {"name": {"en": name}}
    added += 1

print(f"spells.json: було {len(src) - added} | додано {added} | стане {len(src)}")
if not APPLY:
    print("ЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
P.write_text(json.dumps(src, ensure_ascii=False, indent=1), encoding="utf-8")
print("spells.json записано")
