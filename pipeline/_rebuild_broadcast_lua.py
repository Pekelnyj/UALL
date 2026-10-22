# -*- coding: utf-8 -*-
"""Повністю перезібрати Broadcast.lua з translations.broadcast.

НАВІЩО. Broadcast.lua — МАЙСТЕР: generate_db.py його не створює, його ведуть
лише _inject_broadcast (дописує) і _update_broadcast_values (править). Тому,
якщо файл зник, звичайна генерація баз його не поверне.

15.10 клієнт CurseForge, ставлячи публічну збірку, пройшов КРІЗЬ dev-junction і
знищив усю теку addon/UALL/Database/ [[curseforge-overwrites-junctions]]. Решта
файлів відновлюється з generate_db, а цей — звідси: translations.broadcast на
той момент був точним дзеркалом Lua (його робить _sync_broadcast_master), тож
дані цілі, бракувало лише способу записати їх назад.

Екранування та формат — ті самі, що в _inject_broadcast, інакше наступний
інжект не впізнає наявні ключі.

Запуск: python _rebuild_broadcast_lua.py [--apply]
"""
import io
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
DB = DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua"
HEADER = ("-- WoWUkraine: переклади реплік/субтитрів (BroadcastText).\n"
          "-- ЦЕЙ ФАЙЛ ГЕНЕРУЄТЬСЯ АВТОМАТИЧНО — не редагуйте вручну.\n"
          "-- Ключ — англійський текст репліки (як показує гра), значення — українська.\n"
          "\nlocal _, ns = ...\n\nns.broadcast = {\n")

_COMBINING = re.compile("[\u0300-\u036f]")   # наголоси — тофу в кінематик-шрифті


def esc(s):
    s = _COMBINING.sub("", s)
    return (s.replace("\\", "\\\\").replace('"', '\\"')
             .replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t"))


tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
bc = tr.get("broadcast") or {}
was = 0
if DB.exists():
    was = len(re.findall(r'(?m)^\s*\["', DB.read_text(encoding="utf-8")))
print(f"у файлі зараз: {was} | у базі: {len(bc)}")

lines = [HEADER]
for en in sorted(bc):
    ua = bc[en]
    if isinstance(ua, str) and ua.strip():
        lines.append(f'    ["{esc(en)}"] = "{esc(ua)}",\n')
lines.append("}\n")
body = "".join(lines)
print(f"буде записано пар: {len(lines) - 2} | баланс {{}}: "
      + ("OK" if body.count("{") == body.count("}") else "ДИСБАЛАНС"))
if not APPLY:
    print("ЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
io.open(DB, "w", encoding="utf-8", newline="\n").write(body)
print(f"{DB} записано")
