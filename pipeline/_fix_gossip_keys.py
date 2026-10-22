# -*- coding: utf-8 -*-
"""Оживити МЕРТВІ ключі балачок: \\r у ключі та {NAME} замість {name}.

GossipHooks.GossipLookup перед пошуком робить дві речі:
    text = text:gsub("\\r\\n", "\\n"):gsub("\\r", "\\n")      -- переноси
    key  = text:gsub(name, "{name}")                      -- ім'я гравця
Отже ключ у базі мусить бути з «\\n» і з «{name}» у НИЖНЬОМУ регістрі. Усе інше
гра не знайде ніколи, хоч переклад і лежить поруч.

Стан на 15.10: 1 749 ключів із «\\r» і 64 з «{NAME}» — разом 1 787 мертвих.
Причина {NAME}: BroadcastHooks нормалізує ім'я у ВЕРХНЬОМУ регістрі, і препи
писали так само, не розрізняючи бакетів [[sv-bucket-vs-section-key]].

Якщо після нормалізації ключ збігається з наявним — лишаємо той, що вже був
(він напевно робочий), а дубль прибираємо.

Запуск: python _fix_gossip_keys.py [--apply]
Далі:   python generate_db.py
"""
import io
import json
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
g = tr.get("gossip") or {}

fixed, merged, kept = {}, 0, 0
stats = {"\\r у ключі": 0, "{NAME} -> {name}": 0}
for k, v in g.items():
    nk = k.replace("\r\n", "\n").replace("\r", "\n")
    if nk != k:
        stats["\\r у ключі"] += 1
    if "{NAME}" in nk:
        nk = nk.replace("{NAME}", "{name}")
        stats["{NAME} -> {name}"] += 1
    nv = v.replace("{NAME}", "{name}") if isinstance(v, str) else v
    if nk in fixed:
        merged += 1
        continue
    fixed[nk] = nv
    kept += 1

print(f"ключів було: {len(g)} | стане: {len(fixed)} | злилося дублів: {merged}")
for why, n in stats.items():
    print(f"   {why}: {n}")
if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
tr["gossip"] = fixed
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print("translations.json записано")
