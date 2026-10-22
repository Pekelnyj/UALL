# -*- coding: utf-8 -*-
"""Порівняння якості: WOW-UKRAINE bubbles (id->ua) vs EN(BroadcastText) vs наш Broadcast.lua."""
import sys, re, csv, zipfile
sys.stdout.reconfigure(encoding="utf-8")
csv.field_size_limit(10 ** 7)

z = zipfile.ZipFile("testerlua/WOW-UKRAINE_16-06-26.zip")
bb = z.read("WOW-UKRAINE/Translations/Bubbles_UA.lua").decode("utf-8", "replace")
# їхні: t[ID]="UA"
their = {}
for m in re.finditer(r'\[(\d+)\]\s*=\s*"((?:[^"\\]|\\.)*)"', bb):
    their[int(m.group(1))] = m.group(2).replace('\\"', '"')

# EN з BroadcastText по ID
en = {}
with open("data/wago/BroadcastText.enUS.latest.csv", encoding="utf-8") as f:
    r = csv.reader(f); h = next(r); idi = h.index("ID"); ti = h.index("Text_lang")
    for row in r:
        if row[ti].strip():
            en[int(row[idi])] = row[ti]

# наш Broadcast.lua (en->ua)
bl = open("addon/WoWUkraine/Database/Broadcast.lua", encoding="utf-8").read()
our = dict(re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', bl))


def un(s):
    return s.replace('\\"', '"').replace("\\n", " ").replace("\\r", "")


# знайти ID, де є і EN, і їхній UA, і (бажано) наш
shown = 0
for tid, tua in their.items():
    e = en.get(tid)
    if not e or len(e) < 20:
        continue
    ekey = e
    ours = our.get(ekey)
    print("=" * 70)
    print("EN  :", un(e)[:140])
    print("ВОНИ:", un(tua)[:140])
    print("МИ  :", un(ours)[:140] if ours else "(нема — у нас не перекладено цей рядок)")
    shown += 1
    if shown >= 12:
        break
