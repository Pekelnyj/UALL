# -*- coding: utf-8 -*-
import sys, csv, re, os
sys.stdout.reconfigure(encoding="utf-8")
csv.field_size_limit(10 ** 7)


def load(path):
    out = {}
    if not os.path.exists(path):
        return out
    with open(path, encoding="utf-8") as f:
        r = csv.reader(f); h = next(r)
        idi = h.index("ID"); ti = h.index("Text_lang") if "Text_lang" in h else None
        for row in r:
            if ti is not None and row[ti].strip():
                out[row[idi]] = row[ti]
    return out


en = load("data/wago/BroadcastText.enUS.latest.csv")
de = load("data/wago/BroadcastText.deDE.latest.csv")
fr = load("data/wago/BroadcastText.frFR.latest.csv")
print("BroadcastText: en", len(en), "| de", len(de), "| fr", len(fr))

real = {i: t for i, t in en.items() if re.search(r"[A-Za-z]", t)}
uniq = set(real.values())
print(f"непорожніх (з літерами): {len(real)} | унікальних текстів: {len(uniq)}")

bl = open("addon/WoWUkraine/Database/Broadcast.lua", encoding="utf-8").read()


def esc(s):
    return s.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n").replace("\r", "\\r")


have = sum(1 for t in uniq if '["' + esc(t) + '"]' in bl)
print(f"вже в Broadcast.lua: {have} | НОВИХ з DB2 на переклад: {len(uniq) - have}")
words = sum(len(t.split()) for t in uniq if '["' + esc(t) + '"]' not in bl)
print(f"слів у нових: ~{words:,}")
print("\nприклади нових:")
shown = 0
for t in uniq:
    if '["' + esc(t) + '"]' not in bl and 5 < len(t) < 80:
        print("  ", repr(t))
        shown += 1
        if shown >= 8:
            break
