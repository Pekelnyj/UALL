# -*- coding: utf-8 -*-
"""Покриття свіжого capture: для кожного баскета — скільки EN-рядків ще НЕ перекладено."""
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


def top_string_keys(b):
    out, i, depth = [], 0, 0
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
                        try:
                            out.append(m.group(1).encode().decode("unicode_escape"))
                        except Exception:
                            out.append(m.group(1))
                instr = True
            elif c == "{":
                depth += 1
            elif c == "}":
                depth -= 1
        i += 1
    return out


def has_cyr(s):
    return any("Ѐ" <= ch <= "ӿ" for ch in s)


print(f"SV {os.path.getsize(SV):,} байт\n")
print("=== ЗРАЗКИ структури ===")
for key in ["npc", "broadcast", "gossip", "ui", "uitooltip"]:
    b = block(sv, key)
    if b:
        print(f"--- {key} ---\n{b[:260].strip()}\n")

# --- Покриття: ключі (EN) без перекладу ---
print("=== ПОКРИТТЯ (EN-рядки в capture без перекладу) ===")

# broadcast: ключ = EN субтитр, звірка з TR['broadcast']
bdict = {k: v for k, v in (TR.get("broadcast") or {}).items()}
b = block(sv, "broadcast")
if b is not None:
    keys = top_string_keys(b)
    miss = [k for k in keys if k not in bdict and not has_cyr(k)]
    print(f"broadcast: {len(keys)} зібрано, НЕ перекладено ~{len(miss)}")
    for k in miss[:12]:
        print("   •", k[:120])

# gossip
gdict = TR.get("gossip") or {}
b = block(sv, "gossip")
if b is not None:
    keys = top_string_keys(b)
    miss = [k for k in keys if k not in gdict and not has_cyr(k)]
    print(f"gossip:    {len(keys)} зібрано, НЕ перекладено ~{len(miss)}")
    for k in miss[:8]:
        print("   •", k[:120])

# ui / uitooltip vs globalStrings + uiTooltips
gs = TR.get("globalStrings") or {}
uitt = TR.get("uiTooltips") or {}
for key, ref in [("ui", gs), ("uitooltip", uitt)]:
    b = block(sv, key)
    if b is not None:
        keys = top_string_keys(b)
        miss = [k for k in keys if k not in ref and k not in gs and not has_cyr(k)]
        print(f"{key:10s}: {len(keys)} зібрано, НЕ перекладено ~{len(miss)}")
        for k in miss[:10]:
            print("   •", k[:120])
