# -*- coding: utf-8 -*-
"""Розсортувати захоплені db.ui рядки: Blizzard-опції (є у globalstrings.json) vs
keybind-патерни (Action Bar X Button Y тощо) vs чуже/динамічне (інші аддони — НЕ чіпати)."""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

cap = json.loads((DATA_DIR / "_dbui_new.json").read_text(encoding="utf-8"))
gs_src = json.loads((DATA_DIR / "source" / "globalstrings.json").read_text(encoding="utf-8-sig"))
gs_values = set(v for v in gs_src.values() if isinstance(v, str))

# keybind-патерни (краще перекласти ПАТЕРНОМ, не поштучно)
KEYBIND = re.compile(
    r"^(Action Bar \d+ Button \d+|Action Button \d+|Bonus Action Button \d+|"
    r"Multiaction Bar \d.*|Pet Action Button \d+|Assign \w+ to Target|"
    r"Override Action Bar Button \d+|Extra Action Button \d+)$")

# евристика «чуже» (інші аддони — лексика, якої нема в опціях Blizzard)
ADDON_HINT = re.compile(
    r"undercut|commodit|shopping|posting|auction|reagent bank|TSM|WeakAura|"
    r"shortcut to|the current item|skip posting|favourite/custom", re.I)

in_gs, keybind, other = [], [], []
for s in cap:
    if s in gs_values:
        in_gs.append(s)
    elif KEYBIND.match(s):
        keybind.append(s)
    elif ADDON_HINT.search(s):
        other.append(s)
    else:
        # не у globalstrings і не явно чуже — може бути Blizzard-рядок нової патч-версії
        # АБО чужий аддон. Лишаємо в «непевних» для ручного перегляду.
        other.append(s)

json.dump(in_gs, open(DATA_DIR / "_dbui_blizz.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
json.dump(other, open(DATA_DIR / "_dbui_other.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"Blizzard-опції (у globalstrings.json, ПЕРЕКЛАДАЄМО): {len(in_gs)}")
print(f"keybind-патерни: {len(keybind)} (приклади: {keybind[:3]})")
print(f"чуже/непевне (НЕ чіпаємо за замовч.): {len(other)}")
print("\n--- Blizzard-опції приклади ---")
for s in in_gs[:40]:
    print("  ", repr(s))
print("\n--- 'інше' приклади (перевір, чи нема Blizzard) ---")
for s in other[:30]:
    print("  ", repr(s))
