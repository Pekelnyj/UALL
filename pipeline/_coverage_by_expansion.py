# -*- coding: utf-8 -*-
"""Покриття перекладом по ДОПОВНЕННЯХ: де найбільше дірок.

Доба визначається за діапазоном ID — у Blizzard вони зростають монотонно.
Це евристика, а не поле в даних: межі взято за першими завданнями кожного
доповнення. Для вибору, куди слати наступну хвилю, її досить; у сам
переклад вона не потрапляє.

Дивимося три шари, бо гравець бачить їх по-різному:
  • ГІЛКИ — заголовок над групою завдань у журналі й на мапі;
  • ІСТОТИ — напис над мобом, неймплейт, трекер;
  • ОБ'ЄКТИ СВІТУ — скрині, двері, вивіски.

Запуск: python _coverage_by_expansion.py
"""
import json
import re
import sys
from collections import defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

# (назва, нижня межа questID, нижня межа creatureID, нижня межа gameobjectID)
ERAS = [
    ("Класика", 0, 0, 0),
    ("Палаючий похід", 9000, 16000, 180000),
    ("Гнів Короля-ліча", 11000, 23000, 190000),
    ("Катаклізм", 24000, 36000, 200000),
    ("Пандарія", 29000, 50000, 210000),
    ("Дренор", 33000, 70000, 230000),
    ("Легіон", 38000, 90000, 240000),
    ("Битва за Азерот", 47000, 120000, 270000),
    ("Тіні", 55000, 155000, 340000),
    ("Політ Драконів", 65000, 180000, 370000),
    ("Війна Всередині", 75000, 205000, 410000),
    ("Опівніч", 83000, 240000, 470000),
]

DEV = re.compile(r"[\[(]?\b(?:DNT|PH|TEST|UNUSED|DEPRECATED)\b[\])]?"
                 r"|\bDO ?NOT ?USE\b|\bPlaceholder\b|^\d+\.\d|^\W*$", re.I)


def era_of(i, idx):
    name = ERAS[0][0]
    for e in ERAS:
        if i >= e[idx]:
            name = e[0]
    return name


def ua_of(v):
    if isinstance(v, str):
        return v
    if isinstance(v, dict):
        for f in ("name", "title", "text"):
            x = v.get(f)
            if isinstance(x, str) and x.strip():
                return x
    return ""


tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))


def load(p):
    f = DATA_DIR / p
    return json.loads(f.read_text(encoding="utf-8-sig")) if f.exists() else {}


stats = defaultdict(lambda: defaultdict(lambda: [0, 0]))   # доба -> шар -> [є, всього]

# --- гілки: добу беремо за НАЙМЕНШИМ questID гілки ---------------------------
ql = load("questlines.json")
tql = tr.get("questLines", {})
for v in ql.values():
    nm = v.get("name") if isinstance(v, dict) else None
    en = nm.get("en") if isinstance(nm, dict) else None
    quests = [q for q in (v.get("quests") or []) if isinstance(q, int)]
    if not en or not quests or DEV.search(en):
        continue
    e = era_of(min(quests), 1)
    s = stats[e]["гілки"]
    s[1] += 1
    if tql.get(en):
        s[0] += 1

# --- істоти ------------------------------------------------------------------
tn = tr.get("npcNames", {})
for cid, v in load("source/creatures.json").items():
    if not cid.isdigit():
        continue
    nm = v.get("name") if isinstance(v, dict) else None
    en = nm.get("en") if isinstance(nm, dict) else None
    if not en or DEV.search(en):
        continue
    s = stats[era_of(int(cid), 2)]["істоти"]
    s[1] += 1
    if ua_of(tn.get(cid)):
        s[0] += 1

# --- об'єкти світу (ключ = англійська назва) ---------------------------------
tg = tr.get("gameObjects", {})
seen = set()
for gid, v in load("source/gameobjects.json").items():
    if not gid.isdigit():
        continue
    nm = v.get("name") if isinstance(v, dict) else None
    en = nm.get("en") if isinstance(nm, dict) else None
    if not en or en in seen or DEV.search(en):
        continue
    seen.add(en)
    s = stats[era_of(int(gid), 3)]["об'єкти"]
    s[1] += 1
    if ua_of(tg.get(en)):
        s[0] += 1

LAYERS = ["гілки", "істоти", "об'єкти"]
print(f"{'доповнення':<20}" + "".join(f"{l:>22}" for l in LAYERS))
print("-" * 86)
order = [e[0] for e in ERAS]
worst = []
for e in order:
    if e not in stats:
        continue
    row = f"{e:<20}"
    for l in LAYERS:
        done, tot = stats[e][l]
        if not tot:
            row += f"{'—':>22}"
            continue
        pct = 100 * done / tot
        row += f"{done:>7}/{tot:<6}{pct:>5.0f}%  "
        if tot - done:
            worst.append((tot - done, e, l, pct))
    print(row)

print("\nНАЙБІЛЬШІ ДІРКИ (скільки рядків бракує):")
for n, e, l, pct in sorted(worst, reverse=True)[:12]:
    print(f"   {n:>6}  {e} / {l}  ({pct:.0f}% покрито)")
