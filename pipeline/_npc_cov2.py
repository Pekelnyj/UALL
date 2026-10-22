# -*- coding: utf-8 -*-
import sys, re, glob
sys.stdout.reconfigure(encoding="utf-8")
sv = open(glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0],
          encoding="utf-8", errors="replace").read()


def block(text, key):
    m = re.search(r'\["' + re.escape(key) + r'"\]\s*=\s*\{', text)
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


# captured id -> EN
b = block(sv, "npc")
pairs = re.findall(r'\["(\d+)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', b)
cap = {}
for cid, en in pairs:
    cap[cid] = en.encode().decode("unicode_escape", "replace") if "\\" in en else en

# generated ns.npcNames (EN -> UA)
nn = open("../addon/WoWUkraine/Database/NpcNames.lua", encoding="utf-8").read()
en_keys = set()
for m in re.finditer(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"', nn):
    k = m.group(1)
    try:
        k = k.encode().decode("unicode_escape")
    except Exception:
        pass
    en_keys.add(k)
print("ns.npcNames EN-ключів:", len(en_keys))

miss = [(cid, en) for cid, en in cap.items() if en not in en_keys]
print(f"npc capture: {len(cap)} зібрано, ПЕРЕКЛАДЕНО {len(cap)-len(miss)}, БЕЗ перекладу {len(miss)}")
# filter out player-ish / odd
for cid, en in sorted(miss, key=lambda x: int(x[0]))[:40]:
    print("   •", cid, en)
