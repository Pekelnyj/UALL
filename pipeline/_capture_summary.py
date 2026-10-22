# -*- coding: utf-8 -*-
"""Підсумок свіжого capture з SavedVariables: що зібрано в кожному баскеті
і скільки з того ще НЕ перекладено (звірка з translations.json)."""
import sys, re, glob, json, os
sys.stdout.reconfigure(encoding="utf-8")

SV = glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0]
sv = open(SV, encoding="utf-8", errors="replace").read()
HERE = os.path.dirname(__file__)
TR = json.load(open(os.path.join(HERE, "..", "data", "translations.json"), encoding="utf-8"))


def block(text, key):
    m = re.search(r'\["' + re.escape(key) + r'"\]\s*=\s*\{', text)
    if not m:
        return None
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


def top_keys(b):
    """ключі верхнього рівня [\"...\"]= на глибині 0 у блоці."""
    out = []
    i, depth = 0, 0
    instr = esc = False
    while i < len(b):
        c = b[i]
        if instr:
            if esc:
                esc = False
            elif c == "\\":
                esc = True
            elif c == '"':
                instr = False
        else:
            if c == '"':
                if depth == 0:
                    m = re.match(r'"((?:[^"\\]|\\.)*)"\s*\]\s*=', b[i:])
                    if m:
                        out.append(m.group(1).encode().decode("unicode_escape", "replace"))
                instr = True
            elif c == "{":
                depth += 1
            elif c == "}":
                depth -= 1
        i += 1
    return out


print(f"SV: {SV}\nрозмір: {len(sv):,} симв\n")
print(f"{'баскет':16s} {'записів':>9s}   опис")
print("-" * 60)
BUCKETS = ["ui", "uitooltip", "errors", "npc", "broadcast", "gossip",
           "spellCapture", "diag", "globalStrings", "minimap", "ejhdr",
           "renown", "quest", "qcap"]
data = {}
for key in BUCKETS:
    b = block(sv, key)
    if b is None:
        continue
    keys = top_keys(b)
    data[key] = keys
    print(f"{key:16s} {len(keys):>9d}")

# diag/errors — показати приклади
for key in ["diag", "errors"]:
    if data.get(key):
        print(f"\n=== {key} (приклади) ===")
        for k in data[key][:25]:
            print("  ", k[:140])
