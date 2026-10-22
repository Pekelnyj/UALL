# -*- coding: utf-8 -*-
"""ГЕЙТ: у НАЗВАХ істот (npcNames/subnames) суфікс -walker/-strider/-runner НЕ може
закінчуватися русизмом «-оход» (nom sg). Українська: закритий склад → «-охід»
(розломохід, степохід, рогохід — як «Sunwalker»→«Сонцехід», всюдихід, перехід).
Множина/відмінки («-оходи/-оходу/-оходом/-оходів») коректні — «о» у відкритому складі,
тому перевіряємо ЛИШЕ word-final «оход». Глосарій: [[no-russian-calques]].
Запуск перед мерджем/релізом: python pipeline/_ohod_gate.py
"""
from pathlib import Path
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
ROOT = str(Path(__file__).resolve().parent.parent)

END = re.compile(r"оход$")
bad = []

tr = json.load(open(ROOT + "/data/translations.json", encoding="utf-8-sig"))
for sec in ("npcNames", "subnames"):
    for k, v in tr.get(sec, {}).items():
        if isinstance(v, str) and END.search(v):
            bad.append((sec + "/" + str(k), v))

# ручне джерело імен теж
try:
    man = json.load(open(ROOT + "/data/source/manual_npc_names.json", encoding="utf-8-sig"))
    for k, v in man.items():
        if isinstance(v, str) and END.search(v):
            bad.append(("manual/" + str(k), v))
except FileNotFoundError:
    pass

if bad:
    print(f"❌ ГЕЙТ -ОХІД: {len(bad)} назв із русизмом «-оход» (має бути «-охід»)")
    for k, v in bad[:60]:
        print(f"   {k}: {v}  ->  {END.sub('охід', v)}")
    sys.exit(1)
print("✅ ГЕЙТ -ОХІД: чисто (walker/strider = «-охід», не русизм «-оход»).")
