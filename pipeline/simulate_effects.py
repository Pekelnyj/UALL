"""Офлайн-верифікація перекладу ефектів: чи ЗМАТЧИТЬСЯ кожен шаблон.

Реплікує логіку RenderDescription/MatchAndFill (простий шлях, без $?умов):
для кожного перекладеного ефект-шаблону триньки підставляє в EN числа замість
токенів (імітує тултіп), будує матчер із EN і перевіряє, що він матчить і що
UA-підстановка не лишає $-токенів. Так бачимо, скільки реально спрацює в грі,
БЕЗ наведення предметів у клієнті.
"""

import io
import json
import re

from common import DATA_DIR

# Ті самі токени, що в рушії (SpellHooks TOKEN_PATTERNS).
TOK = re.compile(r"\$\{[^{}]*\}|\$<\w+>|\$proc[a-z]+|\$@[a-zA-Z]+\d*|\$(?:\d+)?[sdatxmMunhoArRwWeEbc]\d*")
MAGIC = r"([\^\$\(\)\.\[\]\*\+\-\?\\])"


def build_pattern(en):
    """en -> regex (токени -> (.*?)), як BuildMatcher."""
    parts, pos, toks = ["^"], 0, []
    for m in TOK.finditer(en):
        parts.append(re.sub(MAGIC, r"\\\1", en[pos:m.start()]))
        parts.append("(.*?)")
        toks.append(m.group(0))
        pos = m.end()
    parts.append(re.sub(MAGIC, r"\\\1", en[pos:]))
    parts.append("$")
    return "".join(parts), toks


def main():
    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
    src = json.loads(io.open(DATA_DIR / "source" / "spells.json", encoding="utf-8-sig").read())
    ie = json.loads((DATA_DIR / "source" / "item_effects.json").read_text(encoding="utf-8-sig"))
    dt = tr.get("descTemplates", {})

    # ефект-спели триньок (із item_effects.json — там усі слоти; беремо ті, що
    # мають skillLine=ItemEffect у source, тобто наші витягнуті ефекти)
    eff_spells = {s for s, e in src.items() if e.get("skillLine") == "ItemEffect"}

    ok = no_match = leftover = not_translated = 0
    fails = []
    for s in eff_spells:
        en = (src[s].get("description", {}) or {}).get("en")
        ua = en and dt.get(en)
        if not ua:
            not_translated += 1
            continue
        en_n = re.sub(r"[\r\n]+", "\n", en)
        ua_n = re.sub(r"[\r\n]+", "\n", ua)
        pattern, toks = build_pattern(en_n)
        # імітуємо тултіп: кожен унікальний токен -> число
        vals = {}
        rendered = en_n
        for i, t in enumerate(dict.fromkeys(toks)):
            vals[t] = str(10 + i)
        # підставляємо (довші першими, щоб $s1 не зачепив $s12)
        for t in sorted(set(toks), key=len, reverse=True):
            rendered = rendered.replace(t, vals[t])
        m = re.match(pattern, rendered, re.S)
        if not m:
            no_match += 1
            fails.append(("no_match", s, en[:60]))
            continue
        # підстановка у UA
        out = ua_n
        for t in sorted(set(toks), key=len, reverse=True):
            out = out.replace(t, vals[t])
        if "$" in re.sub(r"\$<\w+>|\$\{[^{}]*\}", "", out):  # лишилися токени?
            leftover += 1
            fails.append(("leftover", s, out[:60]))
            continue
        ok += 1

    print(f"Перекладених ефект-шаблонів: {ok + no_match + leftover}")
    print(f"  ✅ зматчиться коректно: {ok}")
    print(f"  ❌ не матчиться (структура): {no_match}")
    print(f"  ❌ лишаються токени в UA: {leftover}")
    print(f"  (не перекладено: {not_translated})")
    for kind, s, txt in fails[:12]:
        print(f"    [{kind}] {s}: {txt}")


if __name__ == "__main__":
    main()
