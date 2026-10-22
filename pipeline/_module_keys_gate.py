# -*- coding: utf-8 -*-
"""ГЕЙТ: у кожного модуля аддона — власний вимикач, і всі ключі в коді справжні.

Чому (07.10.2026): 19 модулів висіли на одному ключі interface.menu, підписаному в
налаштуваннях як «Меню та налаштування»: зняв галочку меню — мовчки зникали Торговий
пост, бої улюбленців, професії, мапа польотів… А книжки свою галочку взагалі не читали,
«Бафи і дебафи» не читав жоден модуль. Гейт не дає цьому повторитися:

  1. кожен ключ у коді (ns.IsEnabled("…"), ключ модуля в ns.Remember(…, "…")) існує в
     Settings.lua — ловить описки («interface.perk»), через які модуль тихо мертвий;
  2. interface.menu — лише в модулях, що й справді про меню й загальні вікна;
  3. кожен *Hooks.lua перевіряє власний ключ (не лише головний «enabled»).
Виклики ns.Remember без ключа модуля — лише показуємо (їх не відкотить миттєво зняття
галочки, тож це вада зручності, а не поломка).

Запуск: python pipeline/_module_keys_gate.py
"""
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
from common import ADDON_ROOT

UALL = ADDON_ROOT / "UALL"
MENU_OK = {"UIHooks.lua", "SpellHooks.lua", "TrackerHooks.lua", "Settings.lua"}
# свідомо без власного ключа: лише вузькі фільтри чи головний вимикач
NO_OWN_KEY_OK = {
    "TitleHooks.lua": "титули — під головним вимикачем",
    "EncounterJournalHooks.lua": "журнал підземель — фільтр назв groupfinder.names",
    "JourneysHooks.lua": "подорожі — фільтр назв groupfinder.names",
    "WelcomeHooks.lua": "власне вікно привітання аддона, не переклад",
}

settings = (UALL / "Settings.lua").read_text(encoding="utf-8")
KEYS = set(re.findall(r'key = "([^"]+)"', settings))
IS_ENABLED = re.compile(r'IsEnabled\(\s*"([^"]+)"')
REMEMBER_KEY = re.compile(r'ns\.Remember\([^\n]*?,\s*(?:key or\s*)?"([a-zA-Z][\w.]*)"\s*\)')

problems, warn = [], []
for f in sorted(UALL.glob("*.lua")):
    src = f.read_text(encoding="utf-8")
    code = "\n".join(l for l in src.split("\n") if not l.lstrip().startswith("--"))
    used = set(IS_ENABLED.findall(code)) | set(REMEMBER_KEY.findall(code))
    for k in sorted(used - KEYS):
        problems.append(f"{f.name}: ключа «{k}» немає в Settings.lua")
    if "interface.menu" in used and f.name not in MENU_OK:
        problems.append(f"{f.name}: interface.menu («Меню та налаштування») — заведіть модулю власний ключ")
    if f.name.endswith("Hooks.lua"):
        own = set(IS_ENABLED.findall(code)) - {"enabled"}
        if not own and f.name not in NO_OWN_KEY_OK:
            problems.append(f"{f.name}: модуль не перевіряє власного ключа — додайте опцію в Settings.lua")
        bare = len(re.findall(r'ns\.Remember\(', code)) - len(REMEMBER_KEY.findall(code))
        if bare > 0 and f.name not in NO_OWN_KEY_OK:
            warn.append(f"{f.name}: ns.Remember без ключа модуля — {bare}")

for w in warn:
    print("  попередження: " + w)
for p in problems:
    print("ВИМИКАЧ: " + p)
if problems:
    sys.exit(1)
print(f"OK: ключі модулів справжні ({len(KEYS)} у Settings.lua), у кожного модуля свій вимикач")
