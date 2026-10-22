# -*- coding: utf-8 -*-
"""Розповсюдити переклад назви закляття на ВСІ spellID з тією самою назвою.

Одна назва в WoW має десятки ID (ранги, класові копії, версії доповнень).
prep_spells.py дедупить чергу за унікальною назвою, тож перекладається лише
один ID, а решта лишається «неперекладеною» і щоразу повертається в чергу —
кожен прохід підтягує тільки один ID. Тут закриваємо всі за раз.

Беремо переклад лише коли він однозначний: якщо різні ID з тією самою назвою
перекладені по-різному, це розбіжність — її має вирішити людина, не скрипт.

Запуск: python _propagate_spell_names.py [--apply]
"""
import io
import json
import re
import sys
from collections import defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
ts = tr.setdefault("spells", {})
src = json.loads((DATA_DIR / "source" / "spells.json").read_text(encoding="utf-8-sig"))


def norm(s):
    return re.sub(r"\s+", " ", s).strip()


by_name = defaultdict(set)
name_of = {}
for sid, v in src.items():
    nm = v.get("name") if isinstance(v.get("name"), dict) else None
    en = nm.get("en") if nm else None
    if not en:
        continue
    name_of[str(sid)] = norm(en)
    ua = ts.get(str(sid))
    if isinstance(ua, str) and ua.strip():
        by_name[norm(en)].add(ua)

add, conflict = 0, 0
conflicts = []
for sid, en in name_of.items():
    if ts.get(sid):
        continue
    cand = by_name.get(en)
    if not cand:
        continue
    if len(cand) > 1:
        conflict += 1
        if len(conflicts) < 8:
            conflicts.append((en, sorted(cand)[:3]))
        continue
    if APPLY:
        ts[sid] = next(iter(cand))
    add += 1

print(f"ID, яким можна поширити переклад: {add} | розбіжних назв: {conflict}")
for en, us in conflicts:
    print(f"  ? {en[:40]:<42}-> {' | '.join(u[:24] for u in us)}")
if not APPLY:
    print("\n(звіт; щоб застосувати — --apply)")
    sys.exit()
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print(f"translations.spells: {len(ts)}")
