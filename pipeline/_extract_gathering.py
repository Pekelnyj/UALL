# -*- coding: utf-8 -*-
"""Витягнути збиральні рецепти (isGatheringRecipe=true) з db.profdebug: recipeID + EN name."""
import sys, re, glob, json
sys.stdout.reconfigure(encoding="utf-8")
sv = open(glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0],
          encoding="utf-8", errors="replace").read()


def block(text, key):
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', text)
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


pd = block(sv, "profdebug")
out = {}
for m in re.finditer(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', pd):
    en, line = m.group(1), m.group(2)
    if "isGatheringRecipe=true" not in line:
        continue
    rid = re.search(r"recipeID=(\d+)", line)
    if rid:
        out[en] = int(rid.group(1))

# згрупувати за базовою травою/рудою (останнє слово(а))
print(f"Збиральних рецептів: {len(out)}\n")
for en in sorted(out):
    print(f"  {out[en]:>9}  {en}")

json.dump(out, open("data/_gathering_recipes.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("\n-> data/_gathering_recipes.json")
