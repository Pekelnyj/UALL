# -*- coding: utf-8 -*-
"""Точна копія Lua BuildMatcher+ExpandTemplate на ПОВНОМУ показаному тексті з ejmiss."""
import sys, re, json, glob
sys.stdout.reconfigure(encoding="utf-8")

# --- дістати повний показаний текст із ejmiss ---
sv = glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")[0]
s = open(sv, encoding="utf-8", errors="replace").read()
m = re.search(r'\["ejmiss"\]\s*=\s*\{', s)
i, depth, instr, esc = m.end(), 1, False, False
while i < len(s) and depth > 0:
    c = s[i]
    if instr:
        if esc: esc = False
        elif c == "\\": esc = True
        elif c == '"': instr = False
    else:
        if c == '"': instr = True
        elif c == "{": depth += 1
        elif c == "}": depth -= 1
    i += 1
block = s[m.end():i - 1]
def unesc(v): return v.replace("\\\\", "\\").replace("||", "|").replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r").replace("\\t", "\t")
disp = None
for k, _ in re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*(\d+)', block):
    u = unesc(k)
    if u.startswith("The Sunwing erupts"):
        disp = u; break
print("ПОВНИЙ показаний repr:", repr(disp))

# --- Lua ExpandTemplate/ParseConditionalChain (з фіксом) ---
def match_bracket(s, br):
    depth = 0
    for j in range(br, len(s)):
        if s[j] == "[": depth += 1
        elif s[j] == "]":
            depth -= 1
            if depth == 0: return j
    return -1

def parse_cond(s, start):
    pos = start + 1
    branches = []
    while pos < len(s) and s[pos] == "?":
        br = s.find("[", pos)
        if br < 0: return None
        end = match_bracket(s, br)
        if end < 0: return None
        branches.append(s[br + 1:end]); pos = end + 1
    epos = pos
    while epos < len(s) and s[epos].isspace(): epos += 1
    if epos < len(s) and s[epos] == "[":
        end = match_bracket(s, epos)
        if end >= 0:
            branches.append(s[epos + 1:end]); pos = end + 1
    if not branches: return None
    return pos, branches

def expand(t):
    queue = [(t, [])]; res = []
    while queue:
        text, ch = queue.pop()
        si = text.find("$?")
        if si < 0: res.append((text, ch))
        else:
            r = parse_cond(text, si)
            if not r: return None
            after, br = r
            for idx, b in enumerate(br):
                queue.append((text[:si] + b + text[after:], ch + [idx + 1]))
    return res

# --- Lua BuildMatcher: TOKEN_PATTERNS + EscapeMagic + (.-) ---
TOKENS = [r'\$%b{}', r'\$<\w+>', r'\$proc[a-zA-Z]+', r'\$@[a-zA-Z]+\d*', r'\$\d*[sdatxmMunhoArRwWeEbc]\d*']
# %b{} спрощено: $ {...}
def next_token(t, pos):
    best = None
    cands = [
        re.compile(r'\$\{[^}]*\}'),
        re.compile(r'\$<\w+>'),
        re.compile(r'\$proc[a-zA-Z]+'),
        re.compile(r'\$@[a-zA-Z]+\d*'),
        re.compile(r'\$\d*[sdatxmMunhoArRwWeEbc]\d*'),
    ]
    for c in cands:
        mm = c.search(t, pos)
        if mm and (best is None or mm.start() < best[0] or (mm.start() == best[0] and mm.end() > best[1])):
            best = (mm.start(), mm.end())
    return best

def build_pattern(template):
    parts = ["^"]; tokens = []; pos = 0
    while pos < len(template):
        tk = next_token(template, pos)
        if not tk:
            parts.append(re.escape(template[pos:])); break
        parts.append(re.escape(template[pos:tk[0]]))
        tokens.append(template[tk[0]:tk[1]])
        parts.append("(.*?)")  # Lua (.-)
        pos = tk[1]
    parts.append("$")
    return "".join(parts), tokens

def norm_en(s): return re.sub(r'[\r\n]+', '\n', s)

src = json.loads(open("data/source/spells.json", encoding="utf-8-sig").read())
en = src["1253416"]["description"]["en"]
variants = expand(en)
print(f"\nваріантів: {len(variants)}")
dn = norm_en(disp)
for vt, ch in variants:
    vn = norm_en(vt)
    pat, toks = build_pattern(vn)
    mm = re.match(pat, dn, re.DOTALL)
    print(f"  choice={ch} tokens={toks} match={'ТАК' if mm else 'НІ'}")
    if mm: print("    groups:", mm.groups())
    else:
        # показати де розходиться
        print("    pattern:", repr(pat[:120]))
