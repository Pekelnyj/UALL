# -*- coding: utf-8 -*-
"""Гейт: чи компілюються файли аддона як Lua.

Навіщо. Зіпсований Database/*.lua не дає жодної помилки — гра просто НЕ
вантажить файл, і переклад «зникає» без сліду [[never-regex-edit-broadcast-lua]].
Око тут не аргумент, баланс дужок теж: незакрите екранування лапки дає цілком
збалансований, але несинтаксичний файл.

Компілюємо (load), а не виконуємо: код звертається до глобалів WoW, яких тут
немає, і виконання впало б на них, а не на синтаксисі.

Запуск: python _check_lua_syntax.py [шлях ...]
Код виходу 1, якщо бодай один файл не компілюється.
"""
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

try:
    # WoW працює на Lua 5.1. Без явного lua51 lupa бере найновішу (тут 5.5) — і гейт
    # пропустив би синтаксис 5.2+ (goto, //, бітові оператори), що в грі не вантажиться
    # (07.10.2026).
    from lupa.lua51 import LuaRuntime
except ImportError:
    try:
        from lupa import LuaRuntime
        print("УВАГА: lupa.lua51 немає — компілюю найновішою Lua, а не 5.1, як у грі")
    except ImportError:
        sys.exit("lupa не встановлено: pip install lupa")

ROOT = DATA_DIR.parent / "addon"
args = [a for a in sys.argv[1:] if not a.startswith("--")]
files = [Path(a).resolve() for a in args] if args else sorted(ROOT.rglob("*.lua"))

lua = LuaRuntime(unpack_returned_tuples=True)
# Lua 5.1: рядок компілює loadstring (load там приймає функцію-читача); 5.2+ — load
loadstring = lua.eval("function(s, n) return (loadstring or load)(s, n) end")

bad = 0
for f in files:
    try:
        src = f.read_text(encoding="utf-8")
    except OSError as e:
        print(f"  ✗ {f.name}: не читається ({e})")
        bad += 1
        continue
    chunk, err = None, None
    try:
        res = loadstring(src, "@" + f.name)
        # load() повертає (nil, повідомлення) на синтаксичній помилці
        if isinstance(res, tuple):
            chunk, err = (res + (None, None))[:2]
        else:
            chunk = res
    except Exception as e:                      # noqa: BLE001
        err = str(e)
    if chunk is None:
        try:
            shown = f.relative_to(ROOT)
        except ValueError:
            shown = f
        print(f"  ✗ {shown}: {err}")
        bad += 1

print(f"\nперевірено файлів: {len(files)} | не компілюються: {bad}")
sys.exit(1 if bad else 0)
