# -*- coding: utf-8 -*-
"""Зняти з бази ключі, зібрані з НІМЕЦЬКОГО клієнта.

Збирач бере текст таким, яким його показує гра. Частина тестерів грає не
англійською — і тоді в базу лягає німецький ключ. Такий запис МЕРТВИЙ: у
англійського гравця він не зматчиться ніколи, тож переклад до нього
змарновано, а сам рядок лишається неперекладеним у грі.

12.09 знайдено 23 такі репліки в broadcast, і ще 77 німецьких цілей стояли
в черзі на переклад (агент їх відсіяв сам). Причину залатано фільтром DE
в _prep_objlines_wave.py.

Ознака: умляути/ß або службові слова, яких в англійському тексті гри немає.
«Quest» ознакою бути НЕ може — воно англійське; перша спроба з ним дала
900 фальшивок.

broadcast — майстер у Broadcast.lua, тому рядки знімаємо ЦІЛИМИ РЯДКАМИ
файлу [[never-regex-edit-broadcast-lua]].

Запуск: python _drop_german_keys.py [--apply]
Далі:   python _sync_broadcast_master.py && python generate_db.py
"""
import io
import json
import re
import sys
from collections import Counter

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
DB = DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua"
P = DATA_DIR / "translations.json"
# Ознаки мови беремо зі СПІЛЬНОГО capfilter, а не тримаємо власну копію:
# тут лежав окремий регекс, і коли правило в capfilter розширили на німецьку
# без умляутів, цей скрипт лишився сліпим до «Die Legion wird niemals fallen!».
import capfilter


class _DE:
    @staticmethod
    def search(s):
        return capfilter.is_foreign(s)


DE = _DE
LINE = re.compile(r'^\s*\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)",?\s*$')


def un(s):
    s = s.replace("\\\\", "\x00")
    s = (s.replace('\\"', '"').replace("\\n", "\n")
          .replace("\\r", "\r").replace("\\t", "\t"))
    return s.replace("\x00", "\\")


lines = DB.read_text(encoding="utf-8").split("\n")
hit = {}
for i, ln in enumerate(lines):
    m = LINE.match(ln)
    if m:
        k = un(m.group(1))
        if DE.search(k):
            hit[i] = (k, un(m.group(2)))

tr = json.loads(P.read_text(encoding="utf-8-sig"))
jhit, by_sec = [], Counter()
for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    for k in list(d):
        if isinstance(k, str) and DE.search(k):
            jhit.append((sec, k))
            by_sec[sec] += 1

print(f"Broadcast.lua: {len(hit)}")
for i, (k, v) in list(hit.items())[:8]:
    print(f"  {k[:60]}\n      -> {v[:60]}")
if len(hit) > 8:
    print(f"  … ще {len(hit) - 8}")
print(f"\ntranslations.json: {len(jhit)} -> {dict(by_sec)}")

if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)

out = "\n".join(ln for i, ln in enumerate(lines) if i not in hit)
if out.count("{") != out.count("}"):
    sys.exit("ДИСБАЛАНС дужок — не записую")
io.open(DB, "w", encoding="utf-8", newline="\n").write(out)
for sec, k in jhit:
    tr[sec].pop(k, None)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print(f"\nзнято: Lua {len(hit)}, JSON {len(jhit)}")
