# -*- coding: utf-8 -*-
"""Заміна літеральних ніків гравців -> {NAME} у Broadcast.lua (МАЙСТЕР).
Хук BroadcastHooks нормалізує ім'я гравця->{NAME} перед пошуком, тож ключі мусять
бути з {NAME}. Захоплені ніки в ключах = мертві записи + leak імені. Порядкова заміна
\\bНІК\\b -> {NAME} (латиниця, межі слів) НЕ чіпає екранування інших символів рядка.
Дедуп не потрібен: дубль-ключ у Lua-конструкторі = валідний (останній виграє).
"""
import sys, re, glob
sys.stdout.reconfigure(encoding="utf-8")
from playernames import known_nicks
ROOT = r"g:/Claude Code/WoWUkraine"
DB = ROOT + "/addon/UALL/Database/Broadcast.lua"

# ніки — з playernames.py, того самого джерела, що й гейт _check_playernames.py
names = known_nicks(min_len=2, drop_ambiguous=False)
# ніки, що збігаються з ІГРОВИМИ словами (трава Mageroyal) — виключаємо,
# як і в _check_playernames.py: інакше фіксер знищив би легітимний контент
names -= {"Mageroyal", "Rea"}
print("Ніки:", sorted(names))

lua = open(DB, encoding="utf-8").read()
before_balance = (lua.count("{"), lua.count("}"))

# Ім'я з СУФІКСОМ РЕАЛМУ («Feintless-Silvermoon») списком ніків не спіймаєш —
# гравців тисячі. Але сам суфікс і є доказом: реалми збираємо з капчур,
# беручи «X-Y» там, де X — уже відомий нік, отже Y напевно реалм.
# Той самий метод, що в гейті _check_guild_leak.py.
import glob as _glob
_realms = {"Aggra(Português)"}
_pair = re.compile(r"\b([A-Za-zÀ-ÿ'’]{3,})-([A-Z][A-Za-z]{2,}(?:\([^)]+\))?)\b")
for _f in _glob.glob(ROOT + "/testerlua/*.lua"):
    try:
        _t = open(_f, encoding="utf-8", errors="replace").read()
    except OSError:
        continue
    for _a, _b in _pair.findall(_t):
        if _a in names:
            _realms.add(_b)
if _realms:
    _rx = re.compile(r"\b[A-Za-zÀ-ÿ'’]{3,}-(?:%s)\b"
                     % "|".join(re.escape(r) for r in sorted(_realms)))
    _n = len(_rx.findall(lua))
    if _n:
        lua = _rx.sub("{NAME}", lua)
        print(f"Замін на ім'я з реалмом: {_n} (реалми: {sorted(_realms)})")

per = {}
for n in sorted(names):
    rx = re.compile(r"\b" + re.escape(n) + r"\b")
    cnt = len(rx.findall(lua))
    if cnt:
        lua = rx.sub("{NAME}", lua)
        per[n] = cnt
open(DB, "w", encoding="utf-8").write(lua)

after_balance = (lua.count("{"), lua.count("}"))
print("Замін на нік:", per, "| разом:", sum(per.values()))
print(f"Баланс {{}} до: {before_balance} | після: {after_balance}",
      "(зросли через {NAME} — норм)" if after_balance[0] > before_balance[0] else "")
