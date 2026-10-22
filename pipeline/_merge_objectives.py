# -*- coding: utf-8 -*-
import sys, json, glob
sys.stdout.reconfigure(encoding="utf-8")
tr = json.load(open("data/translations.json", encoding="utf-8-sig"))
qo = tr.setdefault("questObjectives", {})
# QA: уніфікація найчастіших різнописів (вибрано мажоритарну/канонічну форму)
FIX = [("Шноттц", "Шнотц"), ("Шноц", "Шнотц"),
       ("Хіджал", "Гайджал"),
       ("Роммас", "Роммат"),
       ("Камнемовець", "Каменемовець"),
       ("Вайш'їр", "Вашж'ір"), ("Вашжір", "Вашж'ір"),
       ("Рунотем", "Рунетотем")]
def fix(s):
    for a, b in FIX:
        if a != b: s = s.replace(a, b)
    return s
n = 0
for f in glob.glob("data/tester_all/oout_*.json"):
    for en, ua in json.load(open(f, encoding="utf-8-sig")).items():
        if en not in qo:
            qo[en] = fix(ua); n += 1
json.dump(tr, open("data/translations.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"questObjectives +{n} (разом {len(qo)})")
