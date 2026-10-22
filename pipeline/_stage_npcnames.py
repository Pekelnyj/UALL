# -*- coding: utf-8 -*-
"""Staging для перекладу зловлених імен NPC (manual_npc_names шлях).
Чистить сміття, відсіює вже наявне, чанкує для хвиль."""
import re, json, os, sys
sys.stdout.reconfigure(encoding="utf-8")
ROOT = r"g:/Claude Code/WoWUkraine"
SV = r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/129089678#1/SavedVariables/WoWUkraine.lua"

sv = open(SV, encoding="utf-8", errors="replace").read()
names = sorted(set(m.group(1).lstrip("*") for m in re.finditer(r"nameFS \|([^|]+)\| ua=nil", sv)))

tr = json.load(open(ROOT + "/data/translations.json", encoding="utf-8-sig"))
def cyr(x): return bool(re.search(r"[А-Яа-яІЇЄҐіїєґ]", x))
def transl(x): return bool(re.search(r"[A-Za-z]", x)) and not cyr(x) and len(x) >= 3
def junk(n):
    if re.match(r"^[\d\s/%:.,\-x]+(Day|Days|Hour|Hours|Min|sec)?s?$", n): return True
    if len(n) < 3 or not re.search(r"[A-Za-z]", n): return True
    return False

# уже в базі імен? (manual + generated NpcNames)
existing = set()
man_path = ROOT + "/data/source/manual_npc_names.json"
if os.path.exists(man_path):
    existing |= set(json.load(open(man_path, encoding="utf-8-sig")).keys())
npc_lua = ROOT + "/addon/WoWUkraine_NpcNames/NpcNames.lua"
if os.path.exists(npc_lua):
    existing |= set(re.findall(r'\["([^"]+)"\]\s*=', open(npc_lua, encoding="utf-8").read()))

clean = [n for n in names if transl(n) and not junk(n) and n not in existing]
print(f"сирих nameFS-nil: {len(names)} | до перекладу (чистих, нема в базі): {len(clean)}")

os.makedirs(ROOT + "/data/tester_new/npc", exist_ok=True)
json.dump(clean, open(ROOT + "/data/tester_new/npc/_all.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
# чанки по 50
CH = 50
n = (len(clean) + CH - 1) // CH
for i in range(n):
    part = clean[i*CH:(i+1)*CH]
    json.dump({k: "" for k in part}, open(ROOT + f"/data/tester_new/npc/n{i+1:02d}.json", "w", encoding="utf-8"),
              ensure_ascii=False, indent=1)
print(f"чанків по {CH}: {n} (n01..n{n:02d})")
