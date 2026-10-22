"""Детермін. скан якості імен NPC (en->ua з NpcNames.lua). Звужує ~22k до кандидатів.
Категорії: foreign(чужі літери), banned(рідкісні/заборонені слова), calque(описова
калька прізвища замість транслітерації). Пише data/_npc_candidates.json + друкує лічбу.
"""
import json, re
from pathlib import Path
from common import DATA_DIR

LUA = DATA_DIR.parent / "addon" / "UALL" / "Database" / "NpcNames.lua"

# en->ua з ["en"] = "ua",
pairs = []
for en, ua in re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', LUA.read_text(encoding="utf-8")):
    pairs.append((en.replace('\\"', '"'), ua.replace('\\"', '"')))

# A) чужі літери (рос.-винятки) — Ukrainian не має ы ъ э ё
foreign_re = re.compile("[ыъэёЫЪЭЁ]")

# B) рідкісні/заборонені/казкові слова (з історії правок користувача)
BANNED = ["румак", "прудкіст", "курдупел", "морозьк", "грязь", "вожак", "тварюк",
          "запределл", "порожнеч'ю", "пожираюч", "ходяч", "блукаюч", "сидяч",
          "наріжн", "спотворений часом", "вроки", "вроків", "маніяк"]
banned_re = re.compile("|".join(BANNED))

# C) описова калька ПРІЗВИЩА: en має складене прізвище (морфема) → ua має укр. морфему
#    замість транслітерації. Морфема_en -> укр.ознаки.
CALQUE = {
    "blood": ["кров"], "wind": ["вітр"], "song": ["спів", "пісн"], "fury": ["лют", "ярост"],
    "fire": ["вогн", "полум"], "moon": ["місяц", "місяч"], "sun": ["сонц"], "star": ["зор"],
    "blade": ["клинок", "лезо", "меч"], "hammer": ["молот"], "fist": ["кулак"],
    "strider": ["ход", "крок"], "stalker": ["переслід"], "render": ["шматувач", "дерун"],
    "weaver": ["ткач"], "bringer": ["носій", "несуч"], "breaker": ["ламач", "руйнів"],
    "heart": ["серц"], "claw": ["кіготь", "пазур"], "fang": ["ікл"], "horn": ["ріг", "рог"],
    "shadow": ["тін"], "frost": ["мороз", "крижан"], "storm": ["буревій", "шторм", "грозов"],
    "iron": ["залізн"], "stone": ["кам"], "shield": ["щит"], "spear": ["спис"],
    "whisper": ["шепіт", "шепот"], "dawn": ["світанк", "світанков", "зор"],
    "death": ["смерт"], "dread": ["жах"], "doom": ["приреч", "загибел"],
    # розширення (знайдено аудитом хвилі 1)
    "wood": ["лісс", "ліс", "дерев"], "walker": ["ход", "крок"],
    "tusk": ["ікл", "кло", "бивень"], "mourn": ["туг", "журб", "скорбот", "сум"],
    "edge": ["край", "лезо", "вістр"], "bane": ["лих", "погибел", "згуб"],
    "leaf": ["лист", "листя"], "bark": ["кор"], "mane": ["грив"],
    "hoof": ["копит"], "talon": ["пазур", "кіготь"], "scale": ["луск"],
    "wing": ["крил"], "veil": ["запон", "вуал", "пелен"], "gaze": ["погляд", "зір"],
    "sorrow": ["скорбот", "журб", "печал"], "grim": ["похмур", "лют"],
    "bright": ["світл", "яскрав"], "light": ["світл"], "swift": ["прудк", "швидк"],
    "keeper": ["хранитель", "берег"], "warden": ["наглядач", "вартов"],
    "tide": ["прилив", "хвил"], "gale": ["вітр", "буревій"], "dawn": ["світ", "світанк", "зор"],
}
# Описові прикметники/стани істот: якщо ПЕРШЕ слово таке — це ЗВІР (описовий переклад
# нормальний), НЕ персонаж. Тоді калька прізвища не рахується проблемою.
DESCRIPTORS = set("""adolescent aggressive agitated ageless albino alert ancient angry
wild young elder feral rabid crazed savage vicious fierce giant massive enraged corrupted
diseased venomous starving hungry frenzied maddened lesser greater juvenile mature adult
baby infested twisted blighted withered rotting ravenous bloodthirsty mangy scrawny sickly
tamed trained loyal hardened armored armoured wounded dying restless lost wandering
spectral ghostly skeletal undead risen reanimated possessed cursed tainted vile foul
fledgling hatchling whelp pup cub calf nestling primal apex alpha dire prowling lurking
stalking hunting feeding nesting roaming territorial dominant scarred ravaged emaciated
plagued mutated aberrant grotesque monstrous towering colossal hulking""".split())

# розпізнавання прізвища: персонаж = «Given Surname» (2 слова), перше — НЕ описовий
# прикметник; останнє містить складену морфему, а ua переклала її описово.
COMMON = set("""mud fungal dark deep blood bone frost fire shadow void storm sand stone iron
swamp bog cave forest mountain river sea ocean desert jungle plains ridge cliff the of and
devouring roaming buzzing furious wild grand great little big small high low old new red blue
green black white grey gray golden silver crystal molten frozen burning rotting living dead""".split())

def calque_flag(en, ua):
    words = re.findall(r"[A-Za-z']+", en)
    if len(words) != 2:                   # персонаж = рівно «Given Surname»
        return None
    w0 = words[0].lower()
    if w0 in DESCRIPTORS or w0 in COMMON:  # перше слово — опис/загальне → звір
        return None
    if w0.endswith("ing") or w0.endswith("ed"):  # дієприкметник → звір (Devouring, Cracked)
        return None
    ualow = ua.lower()
    last = words[-1].lower()              # перевіряємо ОСТАННЄ слово (прізвище)
    for morph, marks in CALQUE.items():
        if morph in last and len(last) > len(morph) + 1:  # складене прізвище (Sunreaver)
            for m in marks:
                if m in ualow:
                    return morph
    return None

cats = {"foreign": [], "banned": [], "calque": []}
for en, ua in pairs:
    if foreign_re.search(ua):
        cats["foreign"].append((en, ua))
    bm = banned_re.search(ua.lower())
    if bm:
        cats["banned"].append((en, ua, bm.group(0)))
    cm = calque_flag(en, ua)
    if cm:
        cats["calque"].append((en, ua, cm))

print(f"усього пар: {len(pairs)}")
for k, v in cats.items():
    print(f"  {k}: {len(v)}")

# зберегти кандидатів (унікальні en→ua) для рев'ю
cand = {}
for en, ua, *rest in cats["foreign"]:
    cand[en] = ua
for en, ua, *rest in cats["banned"]:
    cand[en] = ua
for en, ua, *rest in cats["calque"]:
    cand[en] = ua
(DATA_DIR / "_npc_candidates.json").write_text(
    json.dumps(cand, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"унікальних кандидатів: {len(cand)} -> data/_npc_candidates.json")

# приклади калька
print("\n=== приклади CALQUE (топ-20) ===")
for en, ua, m in cats["calque"][:20]:
    print(f"  [{m}] {en}  ->  {ua}")
