# -*- coding: utf-8 -*-
import sys, re, glob
sys.stdout.reconfigure(encoding="utf-8")

sv = open(glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0],
          encoding="utf-8", errors="replace").read()


def block(key):
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', sv)
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


b = block("uitooltip")
if b is None:
    print("uitooltip НЕМА")
    sys.exit()
keys = re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=', b)
print("uitooltip усього:", len(keys))
needle = "Light Shard"
hits = [k for k in keys if needle in k]
print("Light Shard зловлено?:", hits)
pat = re.compile(r"Shard|Void|Brazier|Behemoth|Repository|forged|found|Blade|Aggress")
forge = [k for k in keys if pat.search(k)]
print("форж/ціль-схожі:", len(forge))
for k in forge[:20]:
    print("   ", repr(k[:60]))
