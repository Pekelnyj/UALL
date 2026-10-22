# -*- coding: utf-8 -*-
import sys, re, glob
sys.stdout.reconfigure(encoding="utf-8")
sv = open(glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0],
          encoding="utf-8", errors="replace").read()

print("версія:", (re.findall(r"v0\.19\.26-test\d+", sv) or ["?"])[-1])


def block(text, key):
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', text)
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


for key in ["errors", "diag"]:
    b = block(sv, key)
    print(f"\n=== {key} ===")
    if b is None:
        print("  (нема блоку)")
        continue
    # рядкові значення (errors=масив рядків; diag=мікс)
    vals = re.findall(r'"((?:[^"\\]|\\.)*)"', b)
    print(f"  значень: {len(vals)}")
    show = vals[-30:] if key == "errors" else vals[-20:]
    for v in show:
        try:
            v = v.encode().decode("unicode_escape")
        except Exception:
            pass
        print("   ", v[:170])
