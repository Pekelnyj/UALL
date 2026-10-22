# -*- coding: utf-8 -*-
import sys, re, json
sys.stdout.reconfigure(encoding="utf-8")


def parse_cond_chain(s, start):
    # s[start] == '$'; повертає (after_pos, branches)
    pos = start + 1  # після '$'
    branches = []
    while pos < len(s) and s[pos] == "?":
        br = s.find("[", pos)
        if br < 0:
            return None
        end = match_bracket(s, br)
        if end < 0:
            return None
        branches.append(s[br + 1:end])
        pos = end + 1
    # else-гілка, можливо через пробіли/переноси (мій фікс)
    epos = pos
    while epos < len(s) and s[epos].isspace():
        epos += 1
    if epos < len(s) and s[epos] == "[":
        end = match_bracket(s, epos)
        if end >= 0:
            branches.append(s[epos + 1:end])
            pos = end + 1
    if not branches:
        return None
    return pos, branches


def match_bracket(s, br):
    # s[br]=='['; повертає індекс відповідного ']'
    depth = 0
    for i in range(br, len(s)):
        if s[i] == "[":
            depth += 1
        elif s[i] == "]":
            depth -= 1
            if depth == 0:
                return i
    return -1


def expand(template):
    queue = [(template, [])]
    result = []
    while queue:
        text, choices = queue.pop()
        s = text.find("$?")
        if s < 0:
            result.append((text, choices))
            if len(result) > 64:
                return None
        else:
            r = parse_cond_chain(text, s)
            if not r:
                return None
            after, branches = r
            for i, b in enumerate(branches):
                queue.append((text[:s] + b + text[after:], choices + [i + 1]))
    return result


def norm_nl(s):
    return re.sub(r'[\r\n]+', '\n', s)


def build_pattern(en):
    # $s1/$a1/$d/$NNNNs1 → число; решта — літерал
    parts = []
    i = 0
    toks = 0
    for m in re.finditer(r'\$\d*[a-zA-Z]+\d*', en):
        parts.append(re.escape(en[i:m.start()]))
        parts.append(r'([\d,\.]+)')
        toks += 1
        i = m.end()
    parts.append(re.escape(en[i:]))
    return "^" + "".join(parts) + "$", toks


src = json.loads(open("data/source/spells.json", encoding="utf-8-sig").read())
en = src["1253416"]["description"]["en"]
disp = "The Sunwing erupts in a blaze of glory upon defeat, inflicting 152,535 Fire damage to players within 8 yards of the impact area.\r\n\r\nSmoldering Eggs caught in the blast remerge as a Sunwing."
print("EN repr:", repr(en))
print()
variants = expand(en)
print(f"варіантів: {len(variants) if variants else 'ExpandTemplate FAIL'}")
if variants:
    dispn = norm_nl(disp)
    for vtext, choices in variants:
        vn = norm_nl(vtext)
        pat, toks = build_pattern(vn)
        m = re.match(pat, dispn)
        print(f"  choice={choices} match={'ТАК' if m else 'ні'} | variant: {vn[:60]!r}")
        if m:
            print(f"    extracted: {m.groups()}")
