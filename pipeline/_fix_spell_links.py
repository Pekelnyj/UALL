# -*- coding: utf-8 -*-
"""Підставити український переклад у лінки |Hspell:ID|h[Назва]|h.

Опис здібності боса — українське речення, всередині якого гра лишає лінк на
закляття. Назву в дужках ми перекладаємо ОКРЕМО (секція spells, ключ = ID),
але в самі описи вона не підставлялася — тож у журналі підземель речення
виглядає так: «Мор'загі використовує [Dark Whispers], щоб опанувати групу».

Тут не переклад, а підстановка: беремо назву з spells за ТИМ САМИМ ID.
Де ID у spells немає — не чіпаємо, такі закляття лишаються на переклад.

Запуск: python _fix_spell_links.py [--apply]
Далі:   python generate_db.py
"""
import io
import json
import re
import sys
from collections import Counter

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
spells = tr.get("spells") or {}

LINK = re.compile(r"(\|Hspell:(\d+)\|h\[)([^\]]+)(\]\|h)")
CYR = re.compile(r"[А-Яа-яІіЇїЄєҐґ]")
LAT = re.compile(r"[A-Za-z]{3,}")


def ua_of(v):
    if isinstance(v, str):
        return v
    return v.get("ua") if isinstance(v, dict) else None


rows, subs, left = Counter(), Counter(), Counter()
examples = []
for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    for k, v in list(d.items()):
        s = v if isinstance(v, str) else None
        if not s or not CYR.search(s) or "|Hspell:" not in s:
            continue
        changed = [0]

        def rep(m):
            name = m.group(3)
            if not LAT.search(name) or CYR.search(name):
                return m.group(0)
            ua = ua_of(spells.get(m.group(2)))
            if not ua:
                left[sec] += 1
                return m.group(0)
            changed[0] += 1
            subs[sec] += 1
            return m.group(1) + ua + m.group(4)

        new = LINK.sub(rep, s)
        if changed[0]:
            rows[sec] += 1
            if len(examples) < 6:
                examples.append((sec, str(k)[:38], s[:78], new[:78]))
            if APPLY:
                d[k] = new

print(f"рядків, де є що підставити: {sum(rows.values())} -> {dict(rows)}")
print(f"підстановок усього: {sum(subs.values())}")
print(f"лінків без перекладу (лишаємо як є): {sum(left.values())}\n")
for sec, k, old, new in examples:
    print(f"  [{sec}] {k}")
    print(f"      -  {old}")
    print(f"      +  {new}")

if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print("\ntranslations.json записано")
