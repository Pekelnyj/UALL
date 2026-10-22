# -*- coding: utf-8 -*-
"""Зняти ключі з КИРИЛИЦЕЮ: англійський ігровий текст її не містить ніколи.

Отже кирилиця в ключі прийшла з підстановки, і буває вона двох ґатунків:

  1. НІК ГРАВЦЯ з кириличного реалму — «The Boon of Alacrity has been
     acquired by Дрелис!». Латинські відсіви такий нік не бачать зовсім
     [[guild-names-never-translate]].

  2. ПЕТЛЯ ЗБОРУ — ключ уже українською, бо збирач прочитав НАШ ЖЕ вивід і
     записав його як «новий англійський рядок»: «Прощавай» -> «Прощавай»,
     «Навчи мене Травництва.» -> те саме. Такий ключ не зматчить нічого
     справжнього (гра шле англійську) і лише роздуває базу.

Обидва ґатунки безпечно знімати: перший — витік, другий — самопосилання.

Запуск: python _drop_cyrillic_keys.py [--apply]
Далі:   python _sync_broadcast_master.py && python generate_db.py
"""
import io
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
DB = DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua"
TR = DATA_DIR / "translations.json"
CYR = re.compile(r"[А-Яа-яЁёІіЇїЄєҐґЪъЫыЭэ]")
LINE = re.compile(r'^\s*\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)",?\s*$')


def un(s):
    s = s.replace("\\\\", "\x00")
    s = (s.replace('\\"', '"').replace("\\n", "\n")
          .replace("\\r", "\r").replace("\\t", "\t"))
    return s.replace("\x00", "\\")


tr = json.loads(TR.read_text(encoding="utf-8-sig"))

# broadcast — майстер у Lua, знімаємо цілими рядками
lines = DB.read_text(encoding="utf-8").split("\n")
bdrop = {}
for i, ln in enumerate(lines):
    m = LINE.match(ln)
    if m:
        k = un(m.group(1))
        if CYR.search(k):
            bdrop[i] = (k, un(m.group(2)))
print(f"broadcast: {len(bdrop)}")
for i, (k, v) in bdrop.items():
    kind = "петля збору" if k == v else "нік/підстановка"
    print(f"  [{kind}] {k[:62]}")
    print(f"       -> {v[:62]}")

sdrop = {}
for sec, d in tr.items():
    if not isinstance(d, dict) or sec == "broadcast":
        continue
    hit = [k for k in d if isinstance(k, str) and CYR.search(k)]
    if hit:
        sdrop[sec] = hit
        print(f"\n{sec}: {len(hit)}")
        for k in hit:
            v = d[k]
            ua = v if isinstance(v, str) else (v.get("ua") if isinstance(v, dict) else "")
            kind = "петля збору" if k == ua else "нік/підстановка"
            print(f"  [{kind}] {k[:60]}")
            if k != ua:
                print(f"       -> {(ua or '')[:60]}")

tot = len(bdrop) + sum(len(v) for v in sdrop.values())
print(f"\nразом на зняття: {tot}")
if not APPLY:
    print("ЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)

out = "\n".join(ln for i, ln in enumerate(lines) if i not in bdrop)
if out.count("{") != out.count("}"):
    sys.exit("ДИСБАЛАНС дужок — не записую")
io.open(DB, "w", encoding="utf-8", newline="\n").write(out)
for sec, hit in sdrop.items():
    for k in hit:
        tr[sec].pop(k, None)
io.open(TR, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print(f"знято: broadcast {len(bdrop)}, інші {sum(len(v) for v in sdrop.values())}")
