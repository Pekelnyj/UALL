# -*- coding: utf-8 -*-
"""Чи 'дублі' broadcast у Broadcast.lua вже мають якісний (кир.) переклад."""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

DB = DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua"
lua = DB.read_text(encoding="utf-8")
keys = re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', lua)
print("усього пар у Broadcast.lua:", len(keys))
lua_map = dict(keys)

bo = json.load(open(DATA_DIR / "tester_new" / "broadcast_out.json", encoding="utf-8"))


def esc(s):
    return (s.replace("\\", "\\\\").replace('"', '\\"')
             .replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t"))


cyr = re.compile(r"[А-Яа-яЇїІіЄєҐґ]")
dup_cyr = dup_nocyr = new = 0
samples = []
for en, ua_new in bo.items():
    k = esc(en)
    if k in lua_map:
        cur = lua_map[k]
        if cyr.search(cur):
            dup_cyr += 1
        else:
            dup_nocyr += 1
            if len(samples) < 6:
                samples.append((en, cur, ua_new))
    else:
        new += 1

print(f"дублів з КИР перекладом: {dup_cyr}")
print(f"дублів БЕЗ кирилиці (англ./порожні): {dup_nocyr}")
print(f"справді нових (нема в Lua): {new}")
print("\n--- приклади дублів БЕЗ кирилиці (треба оновити?) ---")
for en, cur, nw in samples:
    print("EN :", repr(en[:55]))
    print(" Lua:", repr(cur[:55]))
    print(" нов:", repr(nw[:55]))
