# -*- coding: utf-8 -*-
"""Витягує НОВІ gossip+broadcast рядки з файлу тестера (не перекладені ще).
Запуск: python _extract_tester_new.py "<шлях .lua>" """
import sys, re, json, os
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

path = sys.argv[1]
s = open(path, encoding="utf-8", errors="replace").read()


def set_block(key):
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', s)
    if not m:
        return []
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
    block = s[m.end():i - 1]
    keys = re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=', block)

    def un(v):
        return (v.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r")
                 .replace("\\t", "\t").replace("\\\\", "\\"))
    return [un(k) for k in keys]


CYR = re.compile(r"[Ѐ-ӿ]")
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
gtr = tr.get("gossip", {})
bl = (DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua").read_text(encoding="utf-8")
btr = tr.get("broadcast", {})


def is_translatable(t):
    return bool(t) and bool(re.search(r"[A-Za-z]", t)) and not CYR.search(t) and len(t) >= 3


# === Ніки гравця -> {NAME} НА ВХОДІ (прибрати leak у джерелі, не ловити потім) ===
# збираємо meta.playerName з УСІХ файлів збору + поточного (як _check_playernames)
import glob
NICKS = set()
for f in glob.glob(str(DATA_DIR.parent / "testerlua" / "*.lua")) + [path]:
    try:
        txt = open(f, encoding="utf-8", errors="replace").read()
    except Exception:
        continue
    for m in re.finditer(r'\["playerName"\]\s*=\s*"([^"]+)"', txt):
        nm = m.group(1).strip()
        if re.fullmatch(r"[A-Za-z]{2,}", nm):
            NICKS.add(nm)
_NRX = [re.compile(r"\b" + re.escape(n) + r"\b") for n in sorted(NICKS)]


def detok(t):
    for rx in _NRX:
        t = rx.sub("{NAME}", t)
    return t


def collect_new(block_key, done_set, in_lua=False):
    out, seen, tok = [], set(), 0
    for t in set_block(block_key):
        if not is_translatable(t):
            continue
        d = detok(t)
        if d != t:
            tok += 1
        if d in done_set or d in seen:
            continue
        if in_lua and (('"' + d.replace('"', '\\"') + '"') in bl or d in bl):
            continue
        seen.add(d)
        out.append(d)
    return out, tok


# gossip / broadcast нові (ім'я гравця вже -> {NAME})
g_new, g_tok = collect_new("gossip", set(gtr))
b_new, b_tok = collect_new("broadcast", set(btr), in_lua=True)

os.makedirs(DATA_DIR / "tester_new", exist_ok=True)
json.dump(g_new, open(DATA_DIR / "tester_new" / "gossip.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
json.dump(b_new, open(DATA_DIR / "tester_new" / "broadcast.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"ніки гравця (meta.playerName, усі файли): {sorted(NICKS)}")
print(f"токенізовано -> {{NAME}}: gossip {g_tok}, broadcast {b_tok} рядків")
print(f"gossip нових: {len(g_new)} | broadcast нових: {len(b_new)}")
print("\n-- приклади gossip --")
for t in g_new[:6]:
    print("  ", repr(t[:90]))
print("\n-- приклади broadcast --")
for t in b_new[:6]:
    print("  ", repr(t[:90]))
