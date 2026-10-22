# -*- coding: utf-8 -*-
import json, glob, re, sys
sys.stdout.reconfigure(encoding="utf-8")
ROOT = r"g:/Claude Code/WoWUkraine"
mp = ROOT + "/data/source/manual_npc_names.json"
man = json.load(open(mp, encoding="utf-8-sig"))
before = len(man)

# не-імена (професії/UI/рантайм-мітки) — у базу імен не кладемо
BLOCK = {"Looting","Mining","Skinning","Herbalism","Fishing","Herb Gathering","Skinning ",
         "XP","Unknown","Waiting","Logging Out","Resting","Combat","Moths Gathered"}
def is_player_tag(en):
    if " " in en: return False
    if en.islower(): return True                      # blaffie, wilson
    if re.match(r"^[A-Z][a-z]+[A-Z]", en): return True  # HughTheCold, InvisBunny, FrankMiller
    if re.match(r"^([A-Z]\.){2,}", en): return True   # H.A.R.V.E.Y.
    return False

added = skip_id = skip_junk = 0
samples = []
for f in sorted(glob.glob(ROOT + "/data/tester_new/npc/n*_out.json")):
    d = json.load(open(f, encoding="utf-8"))
    for en, ua in d.items():
        if not ua or not ua.strip(): skip_junk += 1; continue
        if ua.strip() == en.strip(): skip_id += 1; continue           # гравці/без перекладу
        if en in BLOCK or en.rstrip().endswith(":") or is_player_tag(en):
            skip_junk += 1
            if len(samples) < 12: samples.append(en)
            continue
        if en not in man:
            man[en] = ua.strip(); added += 1

json.dump(man, open(mp, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"manual_npc_names: {before} -> {len(man)} (+{added})")
print(f"пропущено: identity/гравці={skip_id}, не-імена={skip_junk}")
print("приклади відсіяних не-імен:", samples)
