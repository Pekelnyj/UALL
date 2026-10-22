# -*- coding: utf-8 -*-
"""Оновити значення вже наявних ключів у Broadcast.lua (після QA-фіксів)."""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

_COMBINING = re.compile("[̀-ͯ]")
DB = DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua"
bo = json.load(open(DATA_DIR / "tester_new" / "broadcast_out.json", encoding="utf-8-sig"))
lua = DB.read_text(encoding="utf-8")

def esc(s):
    s = _COMBINING.sub("", s)
    return (s.replace("\\", "\\\\").replace('"', '\\"')
             .replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t"))

upd = 0
for en, ua in bo.items():
    key = '["' + esc(en) + '"]'
    val = '"' + esc(ua) + '"'
    # шукаємо рядок:  ["en"] = "...",
    # ЛЯМБДА обов'язково: строковий replacement інтерпретує \n/\\ у val
    # (template-обробка re.sub) і записав би РЕАЛЬНИЙ перенос у Lua.
    pat = re.compile(re.escape(key) + r'\s*=\s*"(?:[^"\\]|\\.)*"')
    rep = key + " = " + val
    new, n = pat.subn(lambda m: rep, lua, count=1)
    if n and new != lua:
        lua = new; upd += 1
DB.write_text(lua, encoding="utf-8")
print(f"оновлено ключів у Broadcast.lua: {upd}")
print("баланс {}:", "OK" if lua.count("{") == lua.count("}") else "ДИСБАЛАНС")
