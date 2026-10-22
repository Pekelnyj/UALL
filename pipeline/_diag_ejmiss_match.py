# -*- coding: utf-8 -*-
"""Для ПРОСТИХ ejmiss-абілок (без $?/$@): дістати РЕНДЕР з db.ejmiss + ШАБЛОН зі
spells.json, побудувати regex як BuildMatcher (Lua) і перевірити, чи матчиться.
Якщо ні — показати, де розбіжність."""
import sys, re, json, glob
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

sv = open(glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0],
          encoding="utf-8", errors="replace").read()
spells = json.loads((DATA_DIR / "source" / "spells.json").read_text(encoding="utf-8-sig"))


def block(key):
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', sv)
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


def un(s):
    return s.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r").replace("\\\\", "\\")


keys = [un(k) for k in re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=', block("ejmiss"))]

# шаблон-EN → spell (прості, без $?/$@spelldesc)
PROBES = {"244579": "Zuraal", "154135": "Araknath", "1253510": "Rukhran", "1280067": "Saprish"}
for sid, name in PROBES.items():
    tmpl = spells[sid]["description"]["en"]
    # знайти рендер у ejmiss за початком (перші 25 символів без $)
    prefix = re.sub(r"\$.*", "", tmpl)[:25]
    rendered = next((k for k in keys if k.startswith(prefix[:20])), None)
    print(f"=== {name} ({sid}) ===")
    print("ШАБЛОН :", repr(tmpl[:120]))
    print("РЕНДЕР :", repr(rendered[:120]) if rendered else "НЕ в ejmiss (можливо вже показується/стейл)")
    if rendered:
        # побудувати regex: $-коди -> [\d,.]+, екранувати решту
        pat = re.escape(tmpl)
        pat = re.sub(r"\\\$@?\w+", r"[\\d.,%]+", pat)  # $s1, $1234s1, $d, $@spellname123
        pat = pat.replace(r"\ ", " ")
        ok = re.match(pat + r"\s*$", rendered.strip())
        print("МАТЧ regex:", "OK" if ok else "FAIL")
        if not ok:
            print("  patt:", repr(pat[:130]))
    print()
