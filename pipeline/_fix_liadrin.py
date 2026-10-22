# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding="utf-8")
tr = json.load(open("data/translations.json", encoding="utf-8-sig"))
g = tr.get("gossip", {})
key = None
for k in g:
    if "return and remain here in Zul'Aman" in k:
        key = k
        break
if not key:
    print("НЕ знайдено")
    sys.exit()
ua = g[key]
before = ua
ua = ua.replace("Я вирішив", "Я вирішила").replace("я довго бився", "я довго билася").replace("гнаний", "гнана")
g[key] = ua
json.dump(tr, open("data/translations.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("змін:", sum(1 for a, b in zip(before.split(), ua.split()) if a != b))
print("ТЕПЕР:", repr(ua[:160]))
