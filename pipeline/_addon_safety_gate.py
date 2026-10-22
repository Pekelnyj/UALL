# -*- coding: utf-8 -*-
"""Гейт безпеки коду аддона: незахищені звернення до фреймів.

Чому існує: 12 серпня 2026 тестери спіймали 23 помилки за сесію —
«Attempt to access forbidden object from code tainted by an AddOn» з
NpcHooks:263. Код був СТАРИЙ (є ще в 0.43.0 від 20 липня) і лежав тихо,
доки патч 12.1.0 не розширив перелік захищених об'єктів.

Найгірше: правильний захист був у тому самому файлі, на функцію вище —
знали й уміли, але не застосували скрізь. Тому потрібен не фікс, а гейт.

Правило: НІКОЛИ не звертатися до GetRegions/GetChildren напряму —
лише через ns.Regions()/ns.Children() з Core.lua, які питають IsForbidden
ПЕРШИМ і загортають доступ у pcall.

Запуск: python pipeline/_addon_safety_gate.py
Код повернення 1 — є порушення (годиться для CI/перед релізом).
"""
import glob
import io
import os
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
ADDON = os.path.join(ROOT, "addon")

# Прямий обхід у конструкторі таблиці: `{ frame:GetRegions() }`
RX_DIRECT = re.compile(r"\{\s*[\w.\[\]\"']+:Get(?:Regions|Children)\(\)\s*\}")
# Виклик у циклі без обгортки
RX_LOOP = re.compile(r"for\s+.*\bin\s+ipairs\(\s*\{\s*[\w.]+:Get(?:Regions|Children)\(\)")

# Рядки, де прямий виклик ДОЗВОЛЕНО: самі помічники й місця, де поруч
# у тому ж виразі вже стоїть pcall (обгортка ловить throw).
SAFE_HINT = re.compile(r"pcall|function ns\.(Regions|Children)|safeParts")


def scan():
    bad = []
    for path in sorted(glob.glob(os.path.join(ADDON, "**", "*.lua"), recursive=True)):
        if os.sep + "Database" + os.sep in path:
            continue                       # згенеровані бази — це дані, не код
        rel = os.path.relpath(path, ROOT)
        try:
            src = io.open(path, encoding="utf-8").read()
        except Exception as e:
            print(f"  ! не читається {rel}: {e}")
            continue
        for i, line in enumerate(src.split("\n"), 1):
            if not RX_DIRECT.search(line) and not RX_LOOP.search(line):
                continue
            if SAFE_HINT.search(line):
                continue                   # уже під pcall або це сам помічник
            bad.append((rel, i, line.strip()[:88]))
    return bad


# ---------------------------------------------------------------- правило 2
# ЗАХИЩЕНІ ПОВЕРХНІ. hooksecurefunc(obj, "метод") підміняє метод НА ОБ'ЄКТІ, тож
# наш код виконується всередині блізардівської функції — а якщо та сама функція
# ставить атрибути захищеної кнопки, гра блокує дію («blocked from an action only
# available to the Blizzard UI»).
# Спіймано 17.08.2026: ToyBoxHooks вішав SetText на підпис кнопки Скрині іграшок —
# іграшка переставала використовуватись. Той самий клас: SetMatchesSearch на
# кнопках торб і переказ валют у TokenFrame.
# Іграшки/торби/валюти захищені; маунти й улюбленці — НІ (C_MountJournal.SummonByID
# і C_PetJournal.SummonPetByGUID аддон кличе вільно), тому їх тут немає.
SECURE_SURFACES = ("ToyBox", "TokenFrame", "ContainerFrame", "ActionButton",
                   "SecureActionButton")
RX_OBJ_HOOK = re.compile(r"hooksecurefunc\(\s*(?!\")[\w.\[\]]+\s*,\s*\"(\w+)\"")
WRITE_METHODS = {"SetText", "SetFormattedText", "SetAttribute", "SetMatchesSearch"}


def scan_secure():
    bad = []
    for path in sorted(glob.glob(os.path.join(ADDON, "**", "*.lua"), recursive=True)):
        if os.sep + "Database" + os.sep in path:
            continue
        rel = os.path.relpath(path, ROOT)
        try:
            src = io.open(path, encoding="utf-8").read()
        except Exception:
            continue
        lines = src.split("\n")
        # згадка в КОМЕНТАРІ не рахується: половина файлів пояснює в коментарях,
        # чому вони цих поверхонь НЕ чіпають (TokenFrame у UIHooks — саме такий
        # випадок), і без цього фільтра гейт кричить на правильний код.
        code = "\n".join(l for l in lines if not l.lstrip().startswith("--"))
        if not any(s in code for s in SECURE_SURFACES):
            continue
        for i, line in enumerate(lines, 1):
            if line.lstrip().startswith("--"):
                continue
            if "@taint-ok" in line:
                continue                   # свідоме рішення, пояснене поруч у коді
            m = RX_OBJ_HOOK.search(line)
            if not m or m.group(1) not in WRITE_METHODS:
                continue
            if re.search(r"hooksecurefunc\(\s*(_G\.)?(GameTooltip|ItemRefTooltip"
                         r"|\w*[Tt]ooltip\w*)\s*,", line):
                continue                   # тултіпи не захищені
            bad.append((rel, i, line.strip()[:88]))
    return bad


rows = scan()
print("ГЕЙТ 1: незахищений обхід фреймів (GetRegions/GetChildren)\n")
fail = False
if rows:
    fail = True
    print(f"ПОРУШЕНЬ: {len(rows)}\n")
    for rel, i, line in rows:
        print(f"  {rel}:{i}")
        print(f"      {line}")
    print("\nЯк лагодити: замінити на ns.Regions(frame) / ns.Children(frame).")
    print("Вони питають IsForbidden ПЕРШИМ і загортають доступ у pcall.")
else:
    print("чисто — усі звернення йдуть через ns.Regions/ns.Children або pcall")

rows2 = scan_secure()
print("\nГЕЙТ 2: хук методу на об'єкті в файлі із захищеною поверхнею\n")
if rows2:
    fail = True
    print(f"ПОРУШЕНЬ: {len(rows2)}\n")
    for rel, i, line in rows2:
        print(f"  {rel}:{i}")
        print(f"      {line}")
    print("\nЯк лагодити: не підміняти метод на віджеті захищеної кнопки.")
    print("Перекладати поза блізардівським викликом (свій обхід на OnShow/тікер)")
    print("або малювати власний оверлей, не пишучи в їхні об'єкти.")
else:
    print("чисто — методи захищених кнопок не підмінюються")

sys.exit(1 if fail else 0)
