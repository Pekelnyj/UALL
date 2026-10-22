# -*- coding: utf-8 -*-
# Готує батчі НЕперекладених квестів (title+description) з контекстом en/de/fr.
# Дедупу нема (кожен questID унікальний). Запуск: python pipeline/prep_quests.py
import json, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data"
def load(p): return json.loads((DATA / p).read_text(encoding="utf-8-sig"))

quests = load("source/quests.json")
tr = load("translations.json")
done = set(tr.get("quests", {}))

import re
# Службові квести (гравець не бачить): DNT/PH/HIDDEN/NOT USED/TEST/[Internal].
NOISE = re.compile(r"\b(DNT|PH|HIDDEN QUEST|NOT USED|DEPRECAT|\[?TEST\]?|"
                   r"PLACEHOLDER|DO NOT USE|INTERNAL|TEMPLATE|OLD |TRACKING QUEST|"
                   r"LFGDungeons|G\.E\.T\.A)\b|\[DNT\]|\[PH\]|\(DNT\)", re.I)
# Теги-мітки доповнення/рівня: «Dragonflight (60-69) E», «Shadowlands 60 E», «Legion 110 H».
TAG = re.compile(r"^(Classic|TBC|The Burning Crusade|Burning Crusade|Wrath|Cataclysm|"
                 r"Mists of Pandaria|Pandaria|Warlords|Draenor|Legion|Battle for Azeroth|"
                 r"BfA|Shadowlands|Dragonflight|The War Within|War Within|Midnight|Vanilla)\b.{0,14}\d.{0,4}$",
                 re.I)
def is_noise(t, d):
    en = (t.get("en") or "")
    de = (t.get("de") or "")
    fr = (t.get("fr") or "")
    den = (d.get("en") or "")
    if NOISE.search(en):           # шумна назва
        if not den or NOISE.search(den):
            return True
    if TAG.search(en) and not den:  # «Midnight (90) E» без опису = внутрішня мітка
        return True
    # Внутрішній тег: НЕМА опису І заголовок НЕ локалізований (de/fr порожні або = en).
    # Реальний квест має або опис, або локалізований de/fr-заголовок.
    if not den:
        de_loc = de and de != en
        fr_loc = fr and fr != en
        if not de_loc and not fr_loc:
            return True
    return False

items = []
noise = 0
for qid, q in quests.items():
    if qid in done:
        continue
    t = q.get("title") or {}
    d = q.get("description") or {}
    if not (t.get("en") or d.get("en")):
        continue
    if is_noise(t, d):
        noise += 1
        continue
    e = {"id": qid}
    if t.get("en"): e["title_en"] = t["en"]; e["title_de"] = t.get("de", ""); e["title_fr"] = t.get("fr", "")
    if d.get("en"): e["desc_en"] = d["en"]; e["desc_de"] = d.get("de", ""); e["desc_fr"] = d.get("fr", "")
    items.append(e)

print(f"Квестів до перекладу: {len(items)} (відсіяно службового шуму: {noise})")

B = 20
d = DATA / "quest_batches_new"
d.mkdir(exist_ok=True)
for f in d.glob("*.json"): f.unlink()
n = 0
for i in range(0, len(items), B):
    (d / f"q_{n:03d}.json").write_text(
        json.dumps(items[i:i+B], ensure_ascii=False, indent=1), encoding="utf-8")
    n += 1
print(f"Батчів по {B}: {n}")
