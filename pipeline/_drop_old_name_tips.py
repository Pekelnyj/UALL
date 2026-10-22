# -*- coding: utf-8 -*-
"""Прибирає з uiTooltips підказки зі СТАРОЮ назвою аддона (WoWUkraine).

Це рядки пам'яті зі списку аддонів, зібрані ще до перейменування на UALL:
«(84.22 MB) WoWUkraine». Тек із такими іменами більше немає, а точне число
мегабайтів однаково ніколи не повториться — ключ мертвий, і єдине, що він
робить, — показує гравцеві стару назву.

Запуск: python _drop_old_name_tips.py [--apply]
Далі:   python generate_db.py
"""
import io
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))

dropped = []
for sec in ("uiTooltips", "uiMisc"):
    d = tr.get(sec)
    if not isinstance(d, dict):
        continue
    for k in [k for k in d if "WoWUkraine" in k or "WoWUkraine" in str(d[k])]:
        dropped.append((sec, k, d[k]))
        if APPLY:
            del d[k]

for sec, k, v in dropped:
    print(f"{sec}: «{k}» -> «{v}»")
print(f"прибрано: {len(dropped)}")

if not APPLY:
    print("ЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print("translations.json записано")
