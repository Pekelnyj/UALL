# -*- coding: utf-8 -*-
import re
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
s = Path("F:/Battlenet/World of Warcraft/_retail_/WTF/Account/129089678#1/SavedVariables/WoWUkraine.lua").read_text(encoding="utf-8", errors="replace")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
npcN = tr.get("npcNames", {})


def block(key):
    m = re.search(r'\["' + re.escape(key) + r'"\]\s*=\s*\{', s)
    if not m:
        return ""
    i, depth, instr, esc = m.end(), 1, False, False
    while i < len(s) and depth > 0:
        c = s[i]
        if instr:
            if esc:
                esc = False
            elif c == "\\":
                esc = True
            elif c == '"':
                instr = False
        else:
            if c == '"':
                instr = True
            elif c == "{":
                depth += 1
            elif c == "}":
                depth -= 1
        i += 1
    return s[m.end():i - 1]


nb = block("npc")
pairs = re.findall(r'\["(\d+)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', nb)
ids = {pid: name for pid, name in pairs}
names = set(ids.values())
translated = [n for n in names if n in npcN]
new = sorted(n for n in names if n not in npcN)
print(f"npc записів (id->ім'я): {len(ids)}")
print(f"унікальних імен: {len(names)}")
print(f"  вже перекладені (є в npcNames): {len(translated)}")
print(f"  НОВІ (нема в npcNames): {len(new)}")
print()
print("=== приклади НОВИХ імен мобів (перші 40) ===")
for n in new[:40]:
    print("  ", n)

# зберегти id->name нових (для майбутнього captured_creatures + переклад)
new_map = {pid: nm for pid, nm in ids.items() if nm in set(new)}
(B / "data/_live_new_npc.json").write_text(json.dumps(new_map, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"\nЗбережено {len(new_map)} нових id->ім'я -> data/_live_new_npc.json")
