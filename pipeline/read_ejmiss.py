# -*- coding: utf-8 -*-
"""Читає db.ejmiss (показані-але-неперекладені рядки журналу) + db.keystone
(сирі рядки тултіпа ключа) із SavedVariables. Браузиш журнал/наводиш ключ →
/reload → запусти цей скрипт."""
import sys, glob, re
sys.stdout.reconfigure(encoding="utf-8")
sv = glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0]
s = open(sv, encoding="utf-8", errors="replace").read()


def block_of(key):
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', s)
    if not m:
        return None
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


def unesc(v):
    return (v.replace("\\\\", "\\").replace("||", "|").replace('\\"', '"')
             .replace("\\n", "\n").replace("\\r", "\r").replace("\\t", "\t"))


# --- KEYSTONE ---
kb = block_of("keystone")
print("=" * 70)
if kb is None:
    print("db.keystone: НЕМА (наведи мишу на Mythic Keystone, тоді /reload)")
else:
    idm = re.search(r'\["id"\]\s*=\s*(\d+)', kb)
    print(f"db.keystone  (itemID={idm.group(1) if idm else '?'}) — СИРІ рядки тултіпа:")
    for v in re.findall(r'"((?:[^"\\]|\\.)*)"', kb):
        u = unesc(v)
        if u and not u.isdigit():
            print("   ", repr(u))

# --- EJR2 (чому RenderDescription не дав укр.) ---
rb = block_of("ejr2")
print("=" * 70)
if rb is None:
    print("db.ejr2: НЕМА (відкрий боса з описами абілок, тоді /reload)")
else:
    print("db.ejr2 — sid / pcall / ua(результат|NIL|ERR):")
    for k, v in re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', rb):
        print("  •", unesc(v)[:120])

# --- EJSTRUCT (де лежить spellID елемента абілки) ---
eb = block_of("ejstruct")
print("=" * 70)
if eb is None:
    print("db.ejstruct: НЕМА (відкрий боса з описами абілок, тоді /reload)")
else:
    print("db.ejstruct — структура елемента ScrollBox (де spellID/sectionID):")
    for k, v in re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', eb):
        print("  •", unesc(v)[:400])
        print()

# --- EJMISS ---
mb = block_of("ejmiss")
print("=" * 70)
if mb is None:
    print("db.ejmiss: НЕМА (відкрий журнал, поклацай інстанс+босів, тоді /reload)")
else:
    pairs = re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*(\d+)', mb)
    print(f"db.ejmiss: {len(pairs)} показаних-але-НЕперекладених рядків (сорт. за довжиною):\n")
    rows = sorted(((int(n), unesc(k)) for k, n in pairs), reverse=True)
    for n, k in rows:
        print(f"[{n:>4}] {k[:200]!r}")
