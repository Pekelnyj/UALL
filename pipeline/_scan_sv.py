# -*- coding: utf-8 -*-
import re, glob, sys
sys.stdout.reconfigure(encoding="utf-8")
paths = glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")
sv = open(paths[0], encoding="utf-8", errors="replace").read()


def block_after(key):
    m = re.search(r'\["' + re.escape(key) + r'"\]\s*=\s*\{', sv)
    if not m:
        return None
    i, depth, start = m.end(), 1, m.end()
    instr = esc = False
    while i < len(sv) and depth > 0:
        c = sv[i]
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
    return sv[start:i - 1]


out = []
for key in ["ui", "uitooltip", "gossip", "broadcast", "npc", "errors", "diag",
            "keystone", "ejmiss", "objectives", "front"]:
    b = block_after(key)
    if b is None:
        out.append(f"{key}: НЕМА")
        continue
    cnt = len(re.findall(r'\["(?:[^"\\]|\\.)*"\]\s*=', b))
    # кілька прикладів ключів (англ. — непокриті UI/ачівки)
    keys = re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=', b)[:5]
    out.append(f"{key}: {cnt} записів | приклади: " + " | ".join(k[:50] for k in keys))
open("data/_sv.txt", "w", encoding="utf-8").write("\n".join(out))
print("ok")
