"""Швидка статистика бази перекладів."""
import json
import io

from common import DATA_DIR

t = json.load(io.open(DATA_DIR / "translations.json", encoding="utf-8-sig"))
q = t.get("quests", {})
s = t.get("spells", {})
desc = sum(1 for v in q.values() if v.get("description"))
obj = sum(1 for v in q.values() if v.get("objectives"))
words = 0
for v in q.values():
    for f in ("title", "description", "objectives", "progress", "completion"):
        if v.get(f):
            words += len(v[f].split())
words += sum(len(x.split()) for x in s.values())
print(f"Перекладено: квестів={len(q)} (описів={desc}, цілей={obj}), спелів={len(s)}, слів={words}")

src_s = json.load(io.open(DATA_DIR / "source" / "spells.json", encoding="utf-8-sig"))
src_i = json.load(io.open(DATA_DIR / "source" / "items.json", encoding="utf-8-sig"))
talents = sum(1 for v in src_s.values() if v.get("talent"))
flavored = sum(1 for v in src_i.values() if v.get("flavor"))
print(f"Джерела: спелів={len(src_s)} (з них талантів={talents}), предметів={len(src_i)} (з флейвором={flavored})")
