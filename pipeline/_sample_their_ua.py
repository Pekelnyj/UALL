# -*- coding: utf-8 -*-
import sys, re, zipfile
sys.stdout.reconfigure(encoding="utf-8")
z = zipfile.ZipFile("testerlua/WOW-UKRAINE_16-06-26.zip")
CYR = re.compile(r"[А-Яа-яіїєґ]")
PAIR = re.compile(r'\[(\d+)\]\s*=\s*"((?:[^"\\]|\\.)*)"')


def samp(fn, n, minlen, step=1):
    t = z.read(fn).decode("utf-8", "replace")
    vals = [m.group(2) for m in PAIR.finditer(t)]
    out = []
    for i, v in enumerate(vals):
        if i % step:
            continue
        u = v.replace('\\"', '"').replace("\\n", " ").replace("\\r", "")
        if len(u) > minlen and CYR.search(u):
            out.append(u)
        if len(out) >= n:
            break
    return out


print("=== GOSSIP (їхні) ===")
for v in samp("WOW-UKRAINE/Translations/Gossip_UA.lua", 7, 50, 1500):
    print("  •", v[:170])
print("\n=== BUBBLES ===")
for v in samp("WOW-UKRAINE/Translations/Bubbles_UA.lua", 7, 40, 3000):
    print("  •", v[:170])
print("\n=== SUBTITLES (кінематики) ===")
for v in samp("WOW-UKRAINE/Translations/Subtitles_UA.lua", 5, 50, 200):
    print("  •", v[:170])
print("\n=== BOOKS ===")
for v in samp("WOW-UKRAINE/Translations/Books_UA.lua", 4, 120, 500):
    print("  •", v[:220])
