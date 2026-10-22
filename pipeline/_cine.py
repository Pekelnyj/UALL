# -*- coding: utf-8 -*-
"""Показати зібрані broadcast-репліки контексту сініматика (Alleria/Turalyon/Void/Light...)
і скільки з них НЕ перекладено."""
import sys, re, glob, json
sys.stdout.reconfigure(encoding="utf-8")
sv = open(glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0],
          encoding="utf-8", errors="replace").read()
TR = json.load(open("data/translations.json", encoding="utf-8"))
bdict = TR.get("broadcast", {})


def block(text, key):
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', text)
    if not m:
        return ""
    i, depth, start = m.end(), 1, m.end()
    instr = esc = False
    while i < len(text) and depth > 0:
        c = text[i]
        if instr:
            if esc:
                esc = False
            elif c == "\\":
                esc = True
            elif c == '"':
                instr = False
        else:
            if c == '"':
                instr = True
            elif c == "{":
                depth += 1
            elif c == "}":
                depth -= 1
        i += 1
    return text[start:i - 1]


b = block(sv, "broadcast")
pairs = re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', b)


def dec(s):
    try:
        return s.encode().decode("unicode_escape")
    except Exception:
        return s


def has_cyr(s):
    return any("Ѐ" <= ch <= "ӿ" for ch in s)


SPEAKERS = ["Alleria", "Turalyon", "Arator", "Xal", "Void", "Light", "Shadowguard"]
hits = []
for k, v in pairs:
    vv = dec(v)
    kk = dec(k)
    if any(sp in vv for sp in ["Alleria", "Turalyon", "Arator"]) or any(sp in kk for sp in ["Void", "Light", "Shadowguard", "wield"]):
        hits.append((vv, kk, kk in bdict))
print(f"broadcast-реплік контексту сініматика: {len(hits)}\n")
for spk, txt, done in sorted(hits):
    print(f"  [{'✓' if done else '✗'}] {spk}: {txt[:95]}")
