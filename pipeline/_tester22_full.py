# -*- coding: utf-8 -*-
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
s = (B / "testerlua/WoWUkraine (22).lua").read_text(encoding="utf-8", errors="replace")


def block(key):
    m = re.search(r'\["' + re.escape(key) + r'"\]\s*=\s*\{', s)
    if not m:
        return ""
    i, d, instr, esc = m.end(), 1, False, False
    while i < len(s) and d > 0:
        c = s[i]
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
                d += 1
            elif c == "}":
                d -= 1
        i += 1
    return s[m.end():i - 1]


def cyr(x):
    return bool(re.search(r"[А-Яа-яІЇЄҐ]", x))


KV = re.compile(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"')

# broadcast (субтитри)
bb = KV.findall(block("broadcast"))
bnew = [k for k, v in bb if k and not cyr(k) and len(k) > 4]
print(f"BROADCAST: зібрано {len(bb)} | англ-кандидати {len(bnew)}")
for k, v in bb[:3]:
    print(f"    • {k[:55]}")

for cat in ["gossip", "quests", "objLines", "minimap", "profui", "profdesc", "ejmiss"]:
    blk = block(cat)
    kv = KV.findall(blk)
    en = [(k, v) for k, v in kv if k and not cyr(k) and len(k) > 3]
    print(f"{cat}: записів {len(kv)} | англ-ключі {len(en)}")
    for k, v in en[:3]:
        print(f"    • {k[:50]}")

# errors: наші (✓) vs чужі ([?чужа])
eb = block("errors")
print(f"\nERRORS: ✓наші={eb.count(chr(10003))} | [?чужа]={eb.count('?чужа')}")
