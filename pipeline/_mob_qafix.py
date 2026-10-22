# -*- coding: utf-8 -*-
"""Критичні QA-фікси імен мобів (обсценне, зламані слова, русизми, рід, зміст)."""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
master = json.loads((B / "data/_mob_master.json").read_text(encoding="utf-8-sig"))

FIX = {
    "Craftsman Hui": "Ремісник Гуй",                       # обсценне Хуй -> Гуй (h->г)
    "Sporesmith": "Спороковаль",                           # Smith=коваль (було зламане «Спорокова»)
    "Warmwater Riverfish": "Тепловодна річкова риба",      # «Теплянична» зламане
    "Mosha Starhorn": "Моша Зореріг",                      # «Зорьоріг» зламане
    "Gu'chi the Swarmbringer": "Ґу'чі Роєносець",          # «Рієносець» зламане (Swarm=рій)
    "Silithid Broodling": "Силітидський виплодок",         # рід (було сер.+чол.)
    "Used Mud Mask": "Використана маска з бруду",          # русизм «грязьова»
    "Heavyweight Golem": "Важковаговий голем",             # зміст (не «важкоатлетичний»)
    "Furious Earthguard": "Лютий земляний вартовий",       # earth=земляний, не «земельний»
    "Sihua": "Сіхуа",                                      # азійське h->х
    "Tahira": "Тахіра",                                    # h->х
    "Mithdran Dawntracker": "Мітдран Доунтрекер",          # Dawn->Доун (консистентність)
    "Cawind Trueaim": "Кавінд Труейм",                     # «Трузвлучний» зламане
    "Caledra Dawnbreeze": "Каледра Доунбриз",              # «Дончервень» зламане
    "Xijan Thornpaw": "Сіджан Торнпов",                    # «Терноліп» зламане
}

applied, missing = 0, []
for en, ua in FIX.items():
    if en in master:
        master[en] = ua
        applied += 1
    else:
        missing.append(en)
(B / "data/_mob_master.json").write_text(json.dumps(master, ensure_ascii=False, indent=1), encoding="utf-8")

# одразу в npcNames (id->ua)
TR = B / "data/translations.json"
tr = json.loads(TR.read_text(encoding="utf-8-sig"))
new = json.loads((B / "data/_live_new_npc.json").read_text(encoding="utf-8-sig"))  # id->en
npcN = tr["npcNames"]
upd = 0
for cid, en in new.items():
    if en in FIX:
        npcN[cid] = FIX[en]
        upd += 1
TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"Критичних фіксів застосовано: {applied} | оновлено npcNames-записів: {upd}")
if missing:
    print("НЕ знайдено ключів:", missing)
