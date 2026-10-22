# -*- coding: utf-8 -*-
"""Зливає всі кінематик-батчі (batch_*.json, EN->UA) у broadcast_out.json для інжекту.
Зрізає SRT/таймкод-префікси з КЛЮЧА і ЗНАЧЕННЯ (рантайм SHOW_SUBTITLE дає чистий текст),
відсіює сміття (404/таймкод-лишки). Далі: _inject_broadcast + _sync_broadcast_master.
"""
import json, glob, re, sys
sys.stdout.reconfigure(encoding="utf-8")
ROOT = r"g:/Claude Code/WoWUkraine"
CIN = ROOT + "/data/tester_new/db2gaps/cinematic/translated"

# SRT «N 00:00:02,000 --> 00:00:05,533 » та «00:02:23:06 - 00:02:27:15, »
SRT = re.compile(r"^\s*\d+\s+\d{1,2}:\d{2}:\d{2}[,.]\d{1,3}\s*-+>\s*\d{1,2}:\d{2}:\d{2}[,.]\d{1,3}\s+")
TC2 = re.compile(r"^\s*\d{1,2}:\d{2}:\d{2}:\d{2}\s*-\s*\d{1,2}:\d{2}:\d{2}:\d{2}\s*,?\s*")
def strip_tc(s):
    s = SRT.sub("", s)
    s = TC2.sub("", s)
    return s.strip()

def junk(s):
    s = s.strip()
    return (not s or s.startswith('{"error"') or len(re.sub(r"[^A-Za-zА-Яа-яІЇЄҐ]", "", s)) < 2)

merged = {}
for f in sorted(glob.glob(CIN + "/batch_*.json")):
    for en, ua in json.load(open(f, encoding="utf-8")).items():
        ck, cv = strip_tc(en), strip_tc(ua)
        if junk(ck) or junk(cv):
            continue
        merged.setdefault(ck, cv)   # перший виграє

# додати у broadcast_out.json лише НОВІ (не вже в Broadcast.lua)
bl = open(ROOT + "/addon/WoWUkraine/Database/Broadcast.lua", encoding="utf-8").read()
BO = ROOT + "/data/tester_new/broadcast_out.json"
bo = json.load(open(BO, encoding="utf-8"))
added = 0
for en, ua in merged.items():
    if en in bo:
        continue
    key = '["' + en.replace("\\", "\\\\").replace('"', '\\"') + '"]'
    if key in bl:
        continue  # вже в майстрі
    bo[en] = ua
    added += 1
json.dump(bo, open(BO, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"кінематик-пар (чистих): {len(merged)} | ДОДАНО нових у broadcast_out: {added} | усього в broadcast_out: {len(bo)}")
print("приклади:")
for en, ua in list(merged.items())[:5]:
    print(f"   {en[:45]!r} -> {ua[:45]!r}")
