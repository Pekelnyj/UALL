# -*- coding: utf-8 -*-
"""Доганяє КИРИЛИЧНІ форми ніків гравців у Broadcast.lua значеннях -> {NAME}.
Латинський фікс (_fix_broadcast_playernames) уже зробив ключі. Тут — транслітеровані
імена у перекладах (часто відмінювані: Лестане, Ракеліку). Стем + \\w* ловить відмінки.
ВИКЛЮЧЕНО Pekelnyj: його кирилиця «Пекельний» колізує з Hellscream (Пекельний Крик).
Заміна \\bСТЕМ\\w* -> {NAME} не чіпає лапки/бекслеші/переноси (екранування ціле).
"""
import sys, re
sys.stdout.reconfigure(encoding="utf-8")
DB = r"g:/Claude Code/WoWUkraine/addon/WoWUkraine/Database/Broadcast.lua"

# унікальні стеми (без колізій з ігровими словами); \w* добирає відмінкові закінчення
STEMS = ["Олодимир", "Лестан", "Ракелік", "Роллік", "Юйгам", "Юйґам"]

lua = open(DB, encoding="utf-8").read()
b0 = (lua.count("{"), lua.count("}"))
per = {}
for st in STEMS:
    rx = re.compile(r"\b" + st + r"\w*")
    c = len(rx.findall(lua))
    if c:
        lua = rx.sub("{NAME}", lua)
        per[st] = c
open(DB, "w", encoding="utf-8").write(lua)
b1 = (lua.count("{"), lua.count("}"))
print("Кириличні заміни:", per, "| разом:", sum(per.values()))
print(f"Баланс {{}}: до {b0} -> після {b1}", "OK" if b1[0] == b1[1] else "ДИСБАЛАНС!")
