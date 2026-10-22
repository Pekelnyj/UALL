# -*- coding: utf-8 -*-
import json, glob, re, sys
sys.stdout.reconfigure(encoding="utf-8")
ROOT = r"g:/Claude Code/WoWUkraine"
tr = json.load(open(ROOT + "/data/translations.json", encoding="utf-8-sig"))
ut = tr.setdefault("uiTooltips", {})

# нік-тег гравця: "Слово-Реалм" або "Слово Слово-Реалм" без іншого тексту-речення.
# Реалм = CamelCase-слово (TwistingNether, ArgentDawn, Sylvanas, TarrenMill...).
realm_tag = re.compile(r"^[^.!?\n]{1,40}-[A-ZÀ-Ÿ][A-Za-zÀ-ÿ']{2,}$")
def is_player_tag(en):
    if "-" not in en: return False
    if len(en) > 45: return False
    return bool(realm_tag.match(en.strip()))

added = empty = ident = tags = 0
samples_tags = []
for f in sorted(glob.glob(ROOT + "/data/tester_new/t25/ut_*_out.json")):
    d = json.load(open(f, encoding="utf-8"))
    for en, ua in d.items():
        if not ua or not ua.strip():
            empty += 1; continue
        if ua.strip() == en.strip():
            ident += 1; continue
        if is_player_tag(en):
            tags += 1
            if len(samples_tags) < 8: samples_tags.append(en)
            continue
        if en not in ut:
            ut[en] = ua; added += 1
json.dump(tr, open(ROOT + "/data/translations.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"додано в uiTooltips: {added}")
print(f"пропущено: identity={ident}, порожніх={empty}, нік-тегів={tags}")
print("приклади нік-тегів:", samples_tags)
print(f"усього uiTooltips: {len(ut)}")
