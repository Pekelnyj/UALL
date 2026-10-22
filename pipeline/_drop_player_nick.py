# -*- coding: utf-8 -*-
"""Зняти рядки з ніком ГРАВЦЯ (ім'я — аргументом; типово <нік>).

Доказ прямий і не залежить від датамайну: у зборах є системний рядок
«<нік>-AzjolNerub has left the instance group.» — формат «Ім'я-Реалм»
гра пише лише для персонажів гравців [[guild-names-never-translate]].

Нік довго лишався невидимим через кругову ваду: список ігрових слів
будувався з ключів бази, а там лежав сам витік — тож протекле ім'я
оголошувало себе ігровим словом. Полагоджено порогом частоти в
playernames._game_words().

broadcast — майстер у Broadcast.lua, тому рядки знімаємо ЦІЛИМИ РЯДКАМИ
файлу, без regex по вмісту [[never-regex-edit-broadcast-lua]].

Запуск: python _drop_kalikari.py [<Нік>] [--apply]
Далі:   python _sync_broadcast_master.py && python generate_db.py
"""
import io
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
NICK = next((a for a in sys.argv[1:] if not a.startswith("--")), "<нік>")
DB = DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua"
P = DATA_DIR / "translations.json"
LINE = re.compile(r'^\s*\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)",?\s*$')
RX = re.compile(r"\b" + NICK + r"\b")


def un(s):
    s = s.replace("\\\\", "\x00")
    s = (s.replace('\\"', '"').replace("\\n", "\n")
          .replace("\\r", "\r").replace("\\t", "\t"))
    return s.replace("\x00", "\\")


lines = DB.read_text(encoding="utf-8").split("\n")
hit = {}
for i, ln in enumerate(lines):
    m = LINE.match(ln)
    if m and RX.search(un(m.group(1))):
        hit[i] = (un(m.group(1)), un(m.group(2)))
print(f"Broadcast.lua: {len(hit)}")
for i, (k, v) in hit.items():
    print(f"  {k[:60]}\n      -> {v[:60]}")

tr = json.loads(P.read_text(encoding="utf-8-sig"))
jhit = []
for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    for k in list(d):
        if isinstance(k, str) and RX.search(k):
            jhit.append((sec, k))
print(f"translations.json: {len(jhit)} -> {[s for s, _ in jhit]}")

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
