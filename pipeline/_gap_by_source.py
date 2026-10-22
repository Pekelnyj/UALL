# -*- coding: utf-8 -*-
"""Чесний обмір прогалин: скільки в кожному джерелі англійського БЕЗ українського.

Навіщо окремий скрипт. `_audit_remaining.py` рахував ID проти НАЗВ і показував
35 820 «неперекладених» предметів, коли їх було 0 [[no-overclaiming-coverage]].
Тут ключ береться такий, ЯКИМ ЙОГО ТРИМАЄ БАЗА, а він у різних секцій різний:

  • itemNames, gameObjects — ключ це АНГЛІЙСЬКА НАЗВА;
  • npcNames, spells, achievements, recipes — ключ це ID;
  • значення буває рядком або словником ({name:…} / {title:…}).

Плутанина саме тут і давала фальшиві тисячі «неперекладеного».

Запуск: python _gap_by_source.py [--show N]  (N прикладів того, що лишилось)
"""
import json
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

SHOW = 0
if "--show" in sys.argv:
    SHOW = int(sys.argv[sys.argv.index("--show") + 1])

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))


def load(name):
    p = DATA_DIR / "source" / name
    if not p.exists():
        return {}
    try:
        return json.loads(p.read_text(encoding="utf-8-sig"))
    except Exception:
        return {}


def en_of(v, fields):
    if isinstance(v, str):
        return v
    if not isinstance(v, dict):
        return None
    for f in fields:
        x = v.get(f)
        if isinstance(x, dict):
            x = x.get("en")
        if isinstance(x, str) and x.strip():
            return x
    return None


def ua_of(v, fields):
    if isinstance(v, str):
        return v if v.strip() else None
    if isinstance(v, dict):
        for f in fields:
            x = v.get(f)
            if isinstance(x, str) and x.strip():
                return x
    return None


# (мітка, джерело, секція, поля-англ., поля-укр., ключ: "id" або "en")
SPEC = [
    ("Предмети: назви", "items.json", "itemNames", ("name",), ("name",), "en"),
    ("Об'єкти світу", "gameobjects.json", "gameObjects", ("name",), ("name",), "en"),
    ("Закляття: назви", "spells.json", "spells", ("name",), ("name",), "id"),
    ("Істоти: імена", "creatures.json", "npcNames", ("name",), ("name",), "id"),
    ("Досягнення", "achievements.json", "achievements", ("title",), ("title",), "id"),
    ("Досягнення: описи", "achievements.json", "achievements", ("desc",), ("desc",), "id"),
    ("Рецепти", "api_recipes.json", "recipes", ("name",), ("name",), "id"),
    ("Улюбленці", "api_pets.json", "pets", ("name",), ("name",), "id"),
    ("Маунти", "api_mounts.json", "mounts", ("name",), ("name",), "id"),
    ("Титули", "api_titles.json", "titles", ("name",), ("name",), "id"),
    ("Валюти", "currencies.json", "currencies", ("name",), ("name",), "id"),
]

print(f"{'категорія':<22}{'у джерелі':>10}{'є переклад':>12}{'ЛИШИЛОСЬ':>10}")
print("-" * 56)
gaps = {}
for label, src, sec, enf, uaf, mode in SPEC:
    d = load(src)
    if not isinstance(d, dict) or not d:
        continue
    t = tr.get(sec) or {}
    total = done = 0
    miss = []
    for key, v in d.items():
        en = en_of(v, enf)
        if not en:
            continue
        total += 1
        hit = t.get(en) if mode == "en" else t.get(str(key))
        if ua_of(hit, uaf):
            done += 1
        elif len(miss) < 2000:
            miss.append(en)
    gaps[label] = miss
    print(f"{label:<22}{total:>10}{done:>12}{total - done:>10}")

if SHOW:
    for label, miss in gaps.items():
        if miss:
            print(f"\n--- {label}: приклади ({len(miss)}) ---")
            for m in miss[:SHOW]:
                print("   ", m[:90])
