# -*- coding: utf-8 -*-
import sys, re
sys.stdout.reconfigure(encoding="utf-8")
s = open("testerlua/WoWUkraine (11).lua", encoding="utf-8", errors="replace").read()
# топ-рівневий ключ "Zuronar" — що всередині?
m = re.search(r'\n    \["Zuronar"\]\s*=\s*', s)
if m:
    print("Zuronar (топ) =", s[m.end():m.end()+300])
# чи є db.errors / db.ui / db.objLines / db.questCapture?
for k in ["errors", "ui", "objLines", "ejmiss", "uitooltip", "questText", "quests", "objectives", "spellCapture", "creatures", "books", "minimap"]:
    found = re.search(r'\["' + k + r'"\]\s*=', s)
    print(f"  db.{k}: {'Є' if found else '—'}")
