# -*- coding: utf-8 -*-
"""Звести поодинокі викиди до канону (28.08).

Сюди входить ЛИШЕ те, де доказ однозначний: домінанта переважає в рази або
форму диктує правило глосарія. Близькі рахунки (Войдшторм 214:43, Керістраза
проти правила дев'ятки) — не тут: це вирок, а не виправлення.

Рядки broadcast чіпаємо через _update_broadcast_values.py, бо майстер там —
Broadcast.lua [[never-regex-edit-broadcast-lua]]; решта секцій — у JSON.

Запуск: python _fix_canon_0828.py [--apply]
"""
import io
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))

# (що шукаємо, на що міняємо, чим доведено)
RULES = [
    (r"Шал'атат", "Ксал'атат", "Ксал'атат 333 : 1"),
    (r"Кітікс", "Кіт'ікс", "Кіт'ікс 8 : 1"),
    (r"Сабеліан", "Сабелліан", "Сабелліан 43 : 4"),
    (r"Ормарок", "Орморок", "Орморок 7 : 3, EN Ormorok"),
    (r"Деревотворець", "Древотворець", "домінанта епітета"),
    (r"Деревотворця", "Древотворця", "домінанта епітета"),
    (r"Мор'захі", "Мор'загі", "канон h->г"),
    (r"Знавіснілий блукачик Порожнечі", "Знавісніле поріддя Порожнечі",
     "поріддя 42 : 1"),
    (r"породження Порожнечі", "поріддя Порожнечі", "поріддя 42 : 2"),
    (r"Зали Відображень", "Зали Відображення", "3 : 1"),
    (r"Слаґзом", "Слаґґсом", "описка: одна ґ"),
    # Децимус: у базі 122 проти 14 з коротким коренем «Децим». Відмінки
    # міняємо явно, щоб не зіпсувати відмінювання.
    (r"Децимом\b", "Децимусом", "Децимус 122 : 14"),
    (r"Децима\b", "Децимуса", "Децимус 122 : 14"),
    (r"Децим\b", "Децимус", "Децимус 122 : 14"),
]
COMPILED = [(re.compile(a), b, why) for a, b, why in RULES]

changes, bcast = [], {}
for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    for k, v in list(d.items()):
        s = v if isinstance(v, str) else None
        if not s:
            continue
        new = s
        used = []
        for rx, rep, why in COMPILED:
            if rx.search(new):
                new = rx.sub(rep, new)
                used.append(why)
        if new != s:
            changes.append((sec, k, s, new, used[0]))
            if sec == "broadcast":
                bcast[k] = new
            elif APPLY:
                d[k] = new

print(f"рядків на зміну: {len(changes)} (з них broadcast: {len(bcast)})\n")
for sec, k, old, new, why in changes:
    print(f"  [{sec}] {str(k)[:44]}   ({why})")
    print(f"      -  {old[:80]}")
    print(f"      +  {new[:80]}")

if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)

io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
out = DATA_DIR / "tester_new" / "canon_0828.json"
out.parent.mkdir(parents=True, exist_ok=True)
io.open(out, "w", encoding="utf-8", newline="\n").write(
    json.dumps(bcast, ensure_ascii=False, indent=1))
print(f"\ntranslations.json записано (без broadcast).")
print(f"broadcast -> {out}")
print("Далі: python _update_broadcast_values.py " + str(out))
