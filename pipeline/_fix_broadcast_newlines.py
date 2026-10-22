# -*- coding: utf-8 -*-
"""Лагодить Broadcast.lua: сирі переноси рядка ВСЕРЕДИНІ Lua-рядків ("...") —
синтаксична помилка, через яку файл не вантажиться. Зводимо їх назад у \\n.
Структурні переноси (між записами) лишаються."""
import sys
sys.stdout.reconfigure(encoding="utf-8")
DB = r"g:/Claude Code/WoWUkraine/addon/UALL/Database/Broadcast.lua"
s = open(DB, encoding="utf-8").read()

out = []
instr = False
esc = False
fixed = 0
i = 0
while i < len(s):
    c = s[i]
    if instr:
        if esc:
            out.append(c); esc = False
        elif c == "\\":
            out.append(c); esc = True
        elif c == '"':
            out.append(c); instr = False
        elif c == "\n":
            out.append("\\n"); fixed += 1      # сирий перенос усередині рядка -> \n
        elif c == "\r":
            pass                                # сирий CR усередині рядка -> викинути
        else:
            out.append(c)
    else:
        out.append(c)
        if c == '"':
            instr = True
    i += 1

new = "".join(out)
open(DB, "w", encoding="utf-8", newline="\n").write(new)
print(f"виправлено сирих переносів усередині рядків: {fixed}")
print("баланс {}:", "OK" if new.count("{") == new.count("}") else "BAD")
# перевірка: чи лишились рядки-ключі без закриття (евристика)
import re
broken = len(re.findall(r'\["[^"\n]*\n', new))
print("рядків-ключів із сирим переносом (залишок):", broken)
