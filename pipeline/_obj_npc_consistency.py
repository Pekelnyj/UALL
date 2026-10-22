# -*- coding: utf-8 -*-
"""ПЕРЕВІРКА КОНСИСТЕНТНОСТІ ЦІЛЕЙ КВЕСТІВ vs NPCNAMES: ловить, де ім'я істоти/NPC
у ЦІЛІ квесту (questObjectives) перекладене ІНАКШЕ, ніж канон npcNames (те, що
гравець бачить на неймплейті / у kill-підстановці опису).

Чому: цілі НЕ потрапляли в questline-QA (пакет гілки = лише title+description),
тож «вбий {Моб}» у цілі міг розійтися з тим, як той самий моб зветься на неймплейті.

Фільтрує хибні: різниця лише у відмінку/регістрі того самого кореня — НЕ розбіжність.

Запуск: python pipeline/_obj_npc_consistency.py   (звіт + data/wago_bulk/_obj_real.json)
"""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))


def load(p):
    return json.loads((B / p).read_text(encoding="utf-8-sig"))


def id2en(d):
    m = {}
    for k, v in d.items():
        nm = v.get("name") if isinstance(v, dict) else None
        en = nm.get("en") if isinstance(nm, dict) else None
        if isinstance(en, str):
            m[str(k)] = en
    return m


CRE = {**id2en(load("data/source/api_creatures_full.json")),
       **id2en(load("data/source/creatures.json"))}
# EN-ім'я істоти -> канон npcNames
en2ua = {}
for i, ua in tr.get("npcNames", {}).items():
    if isinstance(ua, str):
        en = CRE.get(str(i))
        if en and len(en) >= 5:
            en2ua.setdefault(en, ua)

# мультислівні власні назви для пошуку в фразах цілей (довші — спершу)
names = sorted([(en, ua) for en, ua in en2ua.items()
                if re.match(r"^[A-Z]", en) and " " in en and len(en) >= 8],
               key=lambda x: -len(x[0]))

SKIP_EN = {"Kill Credit", "Defense Position", "Raid Leader"}


def norm(w):
    return re.sub(r"[ьʼ']", "", w.lower().replace("і", "и").replace("ї", "и")
                  .replace("є", "е").replace("ґ", "г"))


def roots(s):
    return {norm(w)[:5] for w in re.findall(r"[А-Яа-яІіЇїЄєҐґʼ']{4,}", s)}


# 5 символів префікса ЗАХОПЛЮЮТЬ ЗАКІНЧЕННЯ, тож відмінок читався як інший
# корінь: «гієна»→«гиена» проти «гієну»→«гиену» не збігалися, і гейт показував
# розбіжність там, де ціль просто стоїть у знахідному («Вбито пильну гієну»).
# Тому порівнюємо ПОПАРНО за спільним префіксом у 4 символи — цього досить,
# щоб «василіск» і «базиліск» (справжній різнобій) не злилися.
STEM = 4


def stems(s):
    return [norm(w) for w in re.findall(r"[А-Яа-яІіЇїЄєҐґʼ']{4,}", s)]


def shares_stem(a, b):
    sa = [w[:STEM] for w in stems(a)]
    return any(w[:STEM] in sa for w in stems(b))


real = []
for enk, ua in tr.get("questObjectives", {}).items():
    if not isinstance(ua, str) or not re.search(r"[А-Яа-яІіЇїЄєҐґ]", ua):
        continue
    for en, canon in names:
        if en in enk and en not in SKIP_EN:
            if not shares_stem(canon, ua) and stems(canon):
                real.append({"en": en, "obj_en": enk, "obj_ua": ua, "canon": canon})
            break

print(f"=== ЦІЛІ vs NPCNAMES: реальних розбіжностей імен: {len(real)} ===")
for it in real[:30]:
    print(f"  «{it['en']}»: неймплейт '{it['canon']}' ≠ ціль '{it['obj_ua'][:55]}'")
(B / "data/wago_bulk/_obj_real.json").write_text(
    json.dumps(real, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"\n-> data/wago_bulk/_obj_real.json ({len(real)})")
sys.exit(1 if real else 0)
