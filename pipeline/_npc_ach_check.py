# -*- coding: utf-8 -*-
import sys, re, glob, json
sys.stdout.reconfigure(encoding="utf-8")
sv = open(glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0],
          encoding="utf-8", errors="replace").read()
TR = json.load(open("../data/translations.json", encoding="utf-8"))


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


b = block(sv, "npc")
pairs = re.findall(r'\["(\d+)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', b)
npcN = TR.get("npcNames") or {}
miss = [(cid, en) for cid, en in pairs if en not in npcN]
print(f"npc: зібрано {len(pairs)}, у базі назв {len(npcN)}, БЕЗ перекладу ~{len(miss)}")
for cid, en in miss[:30]:
    print("   •", cid, en)

print("\n=== achievement 61957 ===")
ach = TR.get("achievements") or {}
print("achievements у translations:", len(ach))
e = ach.get("61957") or ach.get(61957)
print("61957 =>", e)
for k, v in ach.items():
    s = json.dumps(v, ensure_ascii=False) if not isinstance(v, str) else v
    if "Runestone Rumbles" in s:
        print("Runestone Rumbles →", k, v)
        break
