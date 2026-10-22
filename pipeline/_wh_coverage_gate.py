# -*- coding: utf-8 -*-
"""ГЕЙТ покриття objectives — ловить зламаний парсер РАНО (а не за 2 доби).
Логіка: для кожної ери рахуємо % викачаних квестів, що мають objectives. «Здоровий»
парсер дає 30-65% (Midnight 63, TWW 40). Якщо ера має БАГАТО викачаних квестів, але
<10% із objectives — це майже напевно СЛІД зламаного парсера (як було з DF: 0%).
Падає з ненульовим кодом → видно одразу, не після марних годин качання.

Запуск:  python pipeline/_wh_coverage_gate.py
"""
import json, os, sys
sys.stdout.reconfigure(encoding="utf-8")
R = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
wh = json.load(open(f"{R}/data/source/wowhead_quests.json", encoding="utf-8-sig"))

BANDS = [("Midnight", 90000, 200000), ("TWW", 78000, 90000), ("DF", 63000, 78000),
         ("Shadowlands", 58000, 63000), ("BfA", 46000, 58000), ("Legion", 36000, 46000),
         ("WoD", 30000, 36000), ("MoP", 24000, 30000), ("Classic-Cata", 0, 24000)]
MIN_QUESTS = 200   # ери з малою вибіркою не судимо (шум)
FLOOR_PCT = 10     # <10% при великій вибірці = підозра на зламаний парсер

print("=== ГЕЙТ ПОКРИТТЯ OBJECTIVES ===")
alarms = []
for name, lo, hi in BANDS:
    data = [(q, v) for q, v in wh.items() if q.isdigit() and lo <= int(q) < hi and isinstance(v, dict) and v]
    if not data:
        continue
    obj = sum(1 for q, v in data if v.get("objectives"))
    pct = obj * 100 // len(data)
    flag = len(data) >= MIN_QUESTS and pct < FLOOR_PCT
    mark = "  ⚠️ ПІДОЗРА (парсер?/треба refetch)" if flag else ""
    print(f"  {name:14} {obj:5}/{len(data):5} = {pct:3}%{mark}")
    if flag:
        alarms.append((name, pct, len(data)))

if alarms:
    print(f"\n❌ {len(alarms)} ер з аномально низьким покриттям (<{FLOOR_PCT}% при ≥{MIN_QUESTS} квестах):")
    for n, p, c in alarms:
        print(f"   {n}: {p}% з {c} — імовірно стягнуто зламаним парсером, треба refetch (з кешу — миттєво).")
    sys.exit(1)
print("\n✅ покриття в нормі — жодної ери з аномально низьким % objectives.")
