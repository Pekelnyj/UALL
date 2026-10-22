# -*- coding: utf-8 -*-
"""Виправлення помилкового описового «Пекельний Крик» -> транслітерація «Хеллскрім»
(Hellscream, прізвище; глосарій §10). Усі 52 контексти підтверджено = персонаж.
Відмінки прикметник+іменник зводяться до відмінків Хеллскрім (чол., приголосна основа).
Працює рекурсивно по всіх секціях translations.json.
"""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
P = r"g:/Claude Code/WoWUkraine/data/translations.json"
tr = json.load(open(P, encoding="utf-8-sig"))

# довші/специфічніші форми ПЕРШІ; кожна = повна двослівна фраза -> відмінок Хеллскрім
PAIRS = [
    ("Пекельного Крику", "Хеллскріма"),    # род.
    ("Пекельного Крика", "Хеллскріма"),     # род. (варіант)
    ("Пекельному Крикові", "Хеллскріму"),   # дав.
    ("Пекельному Крику", "Хеллскріму"),     # дав.
    ("Пекельним Криком", "Хеллскрімом"),    # оруд.
    ("Пекельнім Криком", "Хеллскрімом"),    # оруд. (варіант)
    ("Пекельнім Крику", "Хеллскрімі"),      # місц.
    ("Пекельний Крик", "Хеллскрім"),        # наз./знах.
]
cnt = {a: 0 for a, _ in PAIRS}

def fix(s):
    for a, b in PAIRS:
        if a in s:
            cnt[a] += s.count(a)
            s = s.replace(a, b)
    return s

def walk(o):
    if isinstance(o, str): return fix(o)
    if isinstance(o, dict): return {k: walk(v) for k, v in o.items()}
    if isinstance(o, list): return [walk(v) for v in o]
    return o

tr = walk(tr)
json.dump(tr, open(P, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("Заміни Пекельний Крик -> Хеллскрім (translations.json):")
for a, _ in PAIRS:
    if cnt[a]: print(f"  {a!r}: {cnt[a]}")
print("разом:", sum(cnt.values()))

# контроль залишків
left = 0
def scan(o):
    global left
    if isinstance(o, str): left += len(re.findall(r"Пекельн\w* Крик\w*", o))
    elif isinstance(o, dict):
        for v in o.values(): scan(v)
    elif isinstance(o, list):
        for v in o: scan(v)
scan(tr)
print("залишків «Пекельн* Крик*» у translations.json:", left)
