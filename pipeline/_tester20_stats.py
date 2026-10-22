# -*- coding: utf-8 -*-
import re
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
s = (B / "testerlua/WoWUkraine (20).lua").read_text(encoding="utf-8", errors="replace")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))


def block(key):
    m = re.search(r'\["' + re.escape(key) + r'"\]\s*=\s*\{', s)
    if not m:
        return ""
    i, depth, instr, esc = m.end(), 1, False, False
    while i < len(s) and depth > 0:
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
                depth += 1
            elif c == "}":
                depth -= 1
        i += 1
    return s[m.end():i - 1]


KV = re.compile(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"')

# RENOWN
rb = block("renown")
pairs = KV.findall(rb)
words = sum(len(v.split()) for _, v in pairs)
ren_tr = tr.get("renown", {})
new_ren = [k for k, _ in pairs if k not in ren_tr]
print(f"RENOWN (нова категорія): {len(pairs)} зібрано | ~{words} слів | у перекладі={len(ren_tr)} | НОВИХ={len(new_ren)}")

# KEYSTONE
kp = re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=', block("keystone"))
print(f"KEYSTONE: {len(kp)} рядків")

# ERRORS
errs = re.findall(r'"((?:[^"\\]|\\.)*)"', block("errors"))
ours = [e for e in errs if "✓" in e]
alien = [e for e in errs if "?" in e]
print(f"ERRORS: {len(errs)} | наші(✓)={len(ours)} | підозра-чужі(?)={len(alien)}")

# META
pn = re.search(r'\["playerName"\]\s*=\s*"([^"]*)"', block("meta"))
print(f"META playerName: {pn.group(1) if pn else '?'}")

# топ-рівневі ключі
root = s[re.search(r"WoWUkraineCaptureDB\s*=\s*\{", s).end():]
topkeys = re.findall(r'\n\["([^"\\]+)"\]\s*=', root)
print(f"ТОП-РІВНЕВІ КЛЮЧІ ({len(topkeys)}): {topkeys}")
