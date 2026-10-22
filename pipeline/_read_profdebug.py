# -*- coding: utf-8 -*-
import sys, re, glob
sys.stdout.reconfigure(encoding="utf-8")
sv = open(glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0],
          encoding="utf-8", errors="replace").read()


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


# db.diag entries about mixin / крафт
diag = block(sv, "diag") or ""
print("=== db.diag: міксини / крафт ===")
for m in re.finditer(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*true', diag):
    k = m.group(1)
    if ("mixin" in k) or ("крафт" in k) or k.startswith("recipe |"):
        try:
            k = k.encode().decode("unicode_escape")
        except Exception:
            pass
        print("  ", k)

# db.profdebug entries
pd = block(sv, "profdebug")
print("\n=== db.profdebug (рецепти) ===")
if pd is None:
    print("  НЕМА profdebug-блоку")
else:
    n = 0
    for m in re.finditer(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', pd):
        en, line = m.group(1), m.group(2)
        try:
            en = en.encode().decode("unicode_escape")
            line = line.encode().decode("unicode_escape")
        except Exception:
            pass
        print(f"\n  [{en}]\n    {line}")
        n += 1
        if n >= 40:
            print("  ... (більше)")
            break
    print(f"\n  всього записів: ~{len(re.findall(r'\\]\\s*=\\s*\"', pd))}")
