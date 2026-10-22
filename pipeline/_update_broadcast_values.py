# -*- coding: utf-8 -*-
"""БЕЗПЕЧНЕ оновлення ЗНАЧЕНЬ broadcast у Broadcast.lua за точним ключем (esc-екранування,
як _inject_broadcast). Для канон-фіксів існуючих реплік — НЕ regex по сирому Lua
[[never-regex-edit-broadcast-lua]]. Вхід: {EN: new_ua}. Також оновлює translations.json.

Запуск: python pipeline/_update_broadcast_values.py <шлях_до_done.json> [<done.json> ...]
"""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
ROOT = "g:/Claude Code/WoWUkraine"
DB = ROOT + "/addon/UALL/Database/Broadcast.lua"
_COMB = re.compile("[̀-ͯ]")


def esc(s):
    s = _COMB.sub("", s)
    return (s.replace("\\", "\\\\").replace('"', '\\"')
             .replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t"))


updates = {}
for p in sys.argv[1:]:
    updates.update(json.load(open(p, encoding="utf-8")))

lua = open(DB, encoding="utf-8").read()
done = 0
miss = 0
for en, new_ua in updates.items():
    if not isinstance(new_ua, str):
        continue
    keypart = '["' + esc(en) + '"] = "'
    idx = lua.find(keypart)
    if idx < 0:
        miss += 1
        continue
    vstart = idx + len(keypart)
    # знайти кінець значення: неекранована " перед ],  -> сканер
    i = vstart
    while i < len(lua):
        if lua[i] == "\\":
            i += 2
            continue
        if lua[i] == '"':
            break
        i += 1
    new = lua[:vstart] + esc(new_ua) + lua[i:]
    if new != lua:
        lua = new
        done += 1

open(DB, "w", encoding="utf-8", newline="\n").write(lua)
print(f"Broadcast.lua значень оновлено: {done} | ключ не знайдено: {miss}")
print("баланс {}:", "OK" if lua.count("{") == lua.count("}") else "ДИСБАЛАНС")

# translations.json теж
tr = json.loads(open(ROOT + "/data/translations.json", encoding="utf-8-sig").read())
bc = tr.get("broadcast", {})
n = 0
for en, new_ua in updates.items():
    if isinstance(new_ua, str) and en in bc and bc[en] != new_ua:
        bc[en] = new_ua
        n += 1
json.dump(tr, open(ROOT + "/data/translations.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
print(f"translations.broadcast оновлено: {n}")
