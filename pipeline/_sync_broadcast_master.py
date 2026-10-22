# -*- coding: utf-8 -*-
"""Пересинхронізувати translations.broadcast ← Broadcast.lua (МАЙСТЕР).
Broadcast.lua ведеться через _inject_broadcast і має 8406 пар, а translations.json
broadcast відстав (27) — через що live-екстрактор хибно показував уже перекладене
«новим». Робимо translations.broadcast точним дзеркалом Lua."""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

DB = DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua"
lua = DB.read_text(encoding="utf-8")
pairs = re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', lua)


def un(s):
    # зворотне до esc(): обережний порядок, \\ останнім через плейсхолдер
    s = s.replace("\\\\", "\x00")
    s = (s.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r")
          .replace("\\t", "\t"))
    return s.replace("\x00", "\\")


bcast = {}
for k, v in pairs:
    bcast[un(k)] = un(v)

P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
old = len(tr.get("broadcast", {}))
tr["broadcast"] = bcast
P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")

# roundtrip-перевірка на кириличному прикладі
cyr = [(un(k), un(v)) for k, v in pairs if re.search(r"[А-Яа-яЇї]", v)]
print(f"пар у Lua: {len(pairs)} | translations.broadcast: {old} -> {len(bcast)}")
print("roundtrip-приклад:")
ek, ev = cyr[len(cyr) // 2]
print("  EN:", repr(ek[:60]))
print("  UA:", repr(ev[:60]))
