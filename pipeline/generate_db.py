"""Генерація Lua-баз аддона з data/translations.json.

Перезаписує addon/<Назва>/Database/Quests.lua і Database/Spells.lua.
Запускати після кожного перекладу, потім у грі — /reload (або перезайти).

Використання:
    python generate_db.py
"""

import json
import re
from collections import Counter

from common import DATA_DIR, find_addon_dir

TRANSLATIONS_PATH = DATA_DIR / "translations.json"
DB_DIR = find_addon_dir() / "Database"
MAIN_NAME = find_addon_dir().name  # ім'я головного аддона (LoD-під-аддони = MAIN_NAME_<suffix>)
# Версія для LoD-.toc — беремо з головного .toc, щоб усі аддони збігалися.
_mtoc = find_addon_dir() / (find_addon_dir().name + ".toc")
_mver = re.search(r"##\s*Version:\s*(\S+)", _mtoc.read_text(encoding="utf-8"))
VERSION = _mver.group(1) if _mver else "0.0.0"

QUEST_FIELDS = ["title", "description", "objectives", "progress", "completion"]

QUESTS_HEADER = """\
-- WoWUkraine: база перекладів квестів.
-- ЦЕЙ ФАЙЛ ГЕНЕРУЄТЬСЯ АВТОМАТИЧНО скриптом pipeline/generate_db.py — не редагуйте вручну.
-- Ключ — questID. Поля: title, description, objectives, progress, completion.

local _, ns = ...

ns.quests = {
"""

SPELLS_HEADER = """\
-- WoWUkraine: база перекладів назв заклять.
-- ЦЕЙ ФАЙЛ ГЕНЕРУЄТЬСЯ АВТОМАТИЧНО скриптом pipeline/generate_db.py — не редагуйте вручну.
-- Ключ — spellID, значення — українська назва.

local _, ns = ...

ns.spells = {
"""


_COMBINING = re.compile("[̀-ͯ]")  # наголоси та ін. — ламають кінематик-шрифт


_APOS = str.maketrans({"ʼ": "'", "’": "'", "‘": "'"})  # U+02BC/2019/2018 -> U+0027


def lua_escape(s: str) -> str:
    s = _COMBINING.sub("", s)  # прибрати комбіновані діакритики (наголоси): тофу в катсценах
    s = s.translate(_APOS)     # «екзотичні» апострофи -> прямий ' (U+0027): декор. шрифти не мають □
    return (
        s.replace("\\", "\\\\")
        .replace('"', '\\"')
        .replace("\r\n", "\n")
        .replace("\n", "\\n")
        .replace("\r", "\\n")
    )


def generate_quests(quests: dict):
    lines = [QUESTS_HEADER]
    for quest_id in sorted(quests, key=int):
        entry = quests[quest_id]
        lines.append(f"    [{int(quest_id)}] = {{\n")
        for field in QUEST_FIELDS:
            value = entry.get(field)
            if value:
                lines.append(f'        {field} = "{lua_escape(value)}",\n')
        lines.append("    },\n")
    lines.append("}\n")
    (DB_DIR / "Quests.lua").write_text("".join(lines), encoding="utf-8")
    print(f"Квестів: {len(quests)} -> {DB_DIR / 'Quests.lua'}")


def generate_spells(spells: dict):
    # Переклади зберігаються за ОДНИМ id-представником на унікальну назву (дедуп
    # у prep_spells). Хук шукає за spellID, тож РОЗШИРЮЄМО переклад на ВСІ spellID
    # з тією самою англійською назвою (інакше дублі-закляття лишались би англ.).
    out = {}                       # spellID(int) -> ua
    by_en = {}                     # en назва -> ua (з представників)
    source_path = DATA_DIR / "source" / "spells.json"
    src = {}
    if source_path.exists():
        src = json.loads(source_path.read_text(encoding="utf-8-sig"))
    for spell_id, name in spells.items():
        if isinstance(name, dict):
            name = name.get("name", "")
        if not name:
            continue
        out[int(spell_id)] = name
        en = ((src.get(str(spell_id)) or {}).get("name") or {}).get("en")
        if en and en not in by_en:
            by_en[en] = name
    expanded = 0
    if by_en:
        for sid, s in src.items():
            en = (s.get("name") or {}).get("en")
            ua = en and by_en.get(en)
            if ua and int(sid) not in out:
                out[int(sid)] = ua
                expanded += 1
    lines = [SPELLS_HEADER]
    for spell_id in sorted(out):
        lines.append(f'    [{spell_id}] = "{lua_escape(out[spell_id])}",\n')
    lines.append("}\n")
    (DB_DIR / "Spells.lua").write_text("".join(lines), encoding="utf-8")
    print(f"Заклять: {len(out)} -> {DB_DIR / 'Spells.lua'} "
          f"(+{expanded} розширено за назвою)")


DESC_HEADER = """\
-- WoWUkraine: база перекладів ОПИСІВ заклять (шаблони з $-формулами).
-- ЦЕЙ ФАЙЛ ГЕНЕРУЄТЬСЯ АВТОМАТИЧНО скриптом pipeline/generate_db.py — не редагуйте вручну.
-- descTemplates: унікальні пари en/ua шаблонів (en потрібен, щоб у грі
-- зіставити відрендерений опис і витягти живі числа для української).
-- spellDescIndex: spellID -> індекс шаблону.

local _, ns = ...

"""


def generate_spell_descriptions(templates: dict):
    """templates: {en шаблон: ua шаблон} + source -> spellID -> індекс."""
    source_path = DATA_DIR / "source" / "spells.json"
    if not templates or not source_path.exists():
        return
    source = json.loads(source_path.read_text(encoding="utf-8-sig"))

    # Деякі спели мають опис-ПОСИЛАННЯ «$@spelldescNNN» (та сама абілка під іншим
    # ID, напр. Death Charge 444347 -> 444010). Розв'язуємо до реального тексту
    # опису цільового спела (до 3 хопів), щоб індекс вів на ПЕРЕКЛАДЕНИЙ шаблон,
    # а не на порожній ref-токен (інакше опис лишається англійським).
    _REF = re.compile(r"^\s*\$@spelldesc(\d+)\s*$")

    def resolve_desc_en(e, hops=3):
        en = (e.get("description") or {}).get("en")
        seen = set()
        while en and hops > 0:
            m = _REF.match(en)
            if not m or m.group(1) in seen:
                break
            seen.add(m.group(1))
            ref = source.get(m.group(1))
            en = (ref.get("description") or {}).get("en") if isinstance(ref, dict) else None
            hops -= 1
        return en

    index_of = {}
    entries = []
    spell_index = {}
    for sid, e in source.items():
        en = resolve_desc_en(e)
        ua = en and templates.get(en)
        if not ua:
            continue
        idx = index_of.get(en)
        if idx is None:
            entries.append((en, ua))
            idx = len(entries)
            index_of[en] = idx
        spell_index[int(sid)] = idx

    lines = [DESC_HEADER, "ns.descTemplates = {\n"]
    for en, ua in entries:
        lines.append(f'    {{ en = "{lua_escape(en)}", ua = "{lua_escape(ua)}" }},\n')
    lines.append("}\n\nns.spellDescIndex = {\n")
    for sid in sorted(spell_index):
        lines.append(f"    [{sid}] = {spell_index[sid]},\n")
    lines.append("}\n")
    (DB_DIR / "SpellDescriptions.lua").write_text("".join(lines), encoding="utf-8")
    print(f"Описів заклять: {len(spell_index)} spellID на {len(entries)} шаблонів "
          f"-> {DB_DIR / 'SpellDescriptions.lua'}")


AURA_HEADER = """\
-- WoWUkraine: ОПИСИ БАФІВ І ДЕБАФІВ (AuraDescription) — шаблони з $-формулами, як описи заклять.
-- ЦЕЙ ФАЙЛ ГЕНЕРУЄТЬСЯ АВТОМАТИЧНО скриптом pipeline/generate_db.py — не редагуйте вручну.
-- Шаблони дописуються в спільний ns.descTemplates (SpellDescriptions.lua вантажиться раніше);
-- ns.auraDescIndex: spellID -> індекс шаблону в ns.descTemplates (07.10.2026).

local _, ns = ...
ns.descTemplates = ns.descTemplates or {}
local base = #ns.descTemplates
local add = {
"""


def generate_aura_descriptions(aura_templates: dict, desc_templates: dict):
    """aura_templates: {en: ua} (секція auraDescriptions); опис, що дослівно збігається з
    описом закляття, береться з descTemplates. Джерело spellID -> en — data/source/spell_auras.json
    (свіжа таблиця Spell з wago: опис бафа в підказці аури)."""
    src_path = DATA_DIR / "source" / "spell_auras.json"
    if not src_path.exists():
        return
    source = json.loads(src_path.read_text(encoding="utf-8-sig"))
    entries, index_of, spell_index = [], {}, {}
    for sid, en in source.items():
        ua = aura_templates.get(en) or desc_templates.get(en)
        if not ua or ua == en:
            continue
        idx = index_of.get(en)
        if idx is None:
            entries.append((en, ua))
            idx = len(entries)
            index_of[en] = idx
        spell_index[int(sid)] = idx
    lines = [AURA_HEADER]
    for en, ua in entries:
        lines.append(f'    {{ en = "{lua_escape(en)}", ua = "{lua_escape(ua)}" }},\n')
    lines.append("}\nfor i, t in ipairs(add) do ns.descTemplates[base + i] = t end\n\nlocal idx = {\n")
    for sid in sorted(spell_index):
        lines.append(f"    [{sid}] = {spell_index[sid]},\n")
    lines.append("}\nns.auraDescIndex = {}\nfor sid, i in pairs(idx) do ns.auraDescIndex[sid] = base + i end\n")
    (DB_DIR / "AuraDescriptions.lua").write_text("".join(lines), encoding="utf-8")
    print(f"Описів бафів: {len(spell_index)} spellID на {len(entries)} шаблонів "
          f"-> {DB_DIR / 'AuraDescriptions.lua'}")


def generate_set_pieces(item_names: dict):
    """ns.setPieces = {EN: UA} для назв предметів, що входять у сети (список EN у
    data/set_piece_names.json з ItemSet.db2). UA беремо з itemNames — ЄДИНЕ джерело,
    щоб назви в списку сету не дрейфували від назви предмета. Використовує ItemHooks
    для перекладу рядків списку сет-піс у тултіпі, коли їх нема в uiTooltips."""
    names_path = DATA_DIR / "set_piece_names.json"
    if not names_path.exists() or not item_names:
        return

    def uaname(en):
        v = item_names.get(en)
        return (v.get("name") if isinstance(v, dict) else v) if v else None

    names = json.loads(names_path.read_text(encoding="utf-8-sig"))
    lines = ["local _, ns = ...\n\nns.setPieces = {\n"]
    n = 0
    for en in sorted(names):
        ua = uaname(en)
        if ua and ua != en:
            lines.append(f'    ["{lua_escape(en)}"] = "{lua_escape(ua)}",\n')
            n += 1
    lines.append("}\n")
    (DB_DIR / "SetPieces.lua").write_text("".join(lines), encoding="utf-8")
    print(f"setPieces: {n} -> {DB_DIR / 'SetPieces.lua'}")


def generate_set_bonuses(templates: dict):
    """setBonus: пари en/ua ШАБЛОНІВ бонусів сету (з $-токенами). У грі рядок сет-
    бонусу «(N) Set: <опис>» не має spellID, тож зіставляється за нормалізованим
    текстом (токени/числа→wildcard), а MatchAndFill вставляє живі числа."""
    if not templates:
        return
    lines = ["local _, ns = ...\n\nns.setBonus = {\n"]
    n = 0
    for en in sorted(templates):
        ua = templates[en]
        if en and ua and en != ua:
            lines.append(f'    {{ en = "{lua_escape(en)}", ua = "{lua_escape(ua)}" }},\n')
            n += 1
    lines.append("}\n")
    (DB_DIR / "SetBonuses.lua").write_text("".join(lines), encoding="utf-8")
    print(f"setBonus: {n} -> {DB_DIR / 'SetBonuses.lua'}")


def generate_trait_templates(templates: dict):
    """traitTemplates: пари en/ua ШАБЛОНІВ описів вузлів проф-спец-дерева (TraitDefinition,
    $ev1/$en1/${…}). Вузол не має spellID → зіставляється за нормалізованим текстом
    (ns.TraitTemplateTry), MatchAndFill вставляє живі числа/назви."""
    if not templates:
        return
    lines = ["local _, ns = ...\n\nns.traitTemplates = {\n"]
    n = 0
    for en in sorted(templates):
        ua = templates[en]
        if en and ua and en != ua:
            lines.append(f'    {{ en = "{lua_escape(en)}", ua = "{lua_escape(ua)}" }},\n')
            n += 1
    lines.append("}\n")
    (DB_DIR / "TraitTemplates.lua").write_text("".join(lines), encoding="utf-8")
    print(f"traitTemplates: {n} -> {DB_DIR / 'TraitTemplates.lua'}")


# Предмети розбито ПО ДОПОВНЕННЯХ (окремі файли) + на чанки-функції всередині.
# Чому: одна гігантська таблиця (124k записів) перевищує ліміт констант Lua 5.1
# (~262144 на функцію) і файл НЕ КОМПІЛЮЄТЬСЯ → усі предмети англійською.
# Кожен файл дописує у спільну ns.items, тож ItemHooks не змінюється.
ITEMS_PREFIX = """\
local _, ns = ...
ns.items = ns.items or {}
local t = ns.items
local function add(f) f(t) end
"""

# ExpansionID -> ім'я файлу. EXP_ORDER — порядок завантаження (для .toc).
EXP_FILE = {
    "0": "Classic", "1": "TBC", "2": "Wrath", "3": "Cataclysm", "4": "MoP",
    "5": "WoD", "6": "Legion", "7": "BfA", "8": "Shadowlands", "9": "Dragonflight",
    "10": "WarWithin", "11": "Midnight", "-3": "Special",
}
EXP_ORDER = ["Classic", "TBC", "Wrath", "Cataclysm", "MoP", "WoD", "Legion",
             "BfA", "Shadowlands", "Dragonflight", "WarWithin", "Midnight",
             "Special", "Other"]
ITEM_CHUNK = 12000  # записів на чанк-функцію (~48k констант, далеко під лімітом)

# ── LoadOnDemand: предмети винесено в ОКРЕМИЙ аддон WoWUkraine_Items (сусід головного),
# який головний вантажить лише коли увімкнено переклад предметів. Економить RAM, коли
# фіча вимкнена. Спільний ns — через глобал _G.WoWUkraineNS (виставляє головний аддон).
LOD_ITEMS_DIR = find_addon_dir().parent / f"{MAIN_NAME}_Items"
ITEMS_PREFIX_LOD = """\
-- WoWUkraine: предмети (LoadOnDemand). Автоген pipeline/generate_db.py — не редагуйте.
-- Вантажиться головним аддоном лише коли увімкнено опції items.*. ns — спільний глобал.
local ns = _G.WoWUkraineNS
if not ns then return end
ns.items = ns.items or {}
local t = ns.items
local function add(f) f(t) end
"""


def _lod_dir(suffix):
    return find_addon_dir().parent / f"{MAIN_NAME}_{suffix}"


def _write_lod_toc(suffix, title, files):
    """Генерує <MAIN_NAME>_<suffix>.toc (LoadOnDemand-під-аддон)."""
    d = _lod_dir(suffix)
    d.mkdir(parents=True, exist_ok=True)
    lines = [
        # Версія клієнта. Зашита тут, бо генератор ПЕРЕЗАПИСУЄ .toc LoD-аддонів:
        # правка вручну в addon/*/*.toc відкочується на першому ж generate_db.
        "## Interface: 120100\n",
        f"## Title: {MAIN_NAME} |cff808080({title})|r\n",
        f"## Notes: {title} (LoadOnDemand — вантажиться за потреби)\n",
        f"## Author: {MAIN_NAME}\n## Version: {VERSION}\n",
        f"## LoadOnDemand: 1\n## Dependencies: {MAIN_NAME}\n\n",
    ]
    lines += [f + "\n" for f in files]
    (d / f"{MAIN_NAME}_{suffix}.toc").write_text("".join(lines), encoding="utf-8")


def _move_db_to_lod(filenames, suffix, title):
    """Перенести згенеровані DB_DIR/<file> у LoD-аддон WoWUkraine_<suffix>:
    `local _, ns = ...` → спільний глобал-ns; видалити оригінали; згенерувати .toc."""
    d = _lod_dir(suffix)
    d.mkdir(parents=True, exist_ok=True)
    moved = []
    for fn in filenames:
        src = DB_DIR / fn
        if not src.exists():
            continue
        text = src.read_text(encoding="utf-8").replace(
            "local _, ns = ...",
            "local ns = _G.WoWUkraineNS\nif not ns then return end", 1)
        (d / fn).write_text(text, encoding="utf-8")
        src.unlink()
        moved.append(fn)
    if moved:
        _write_lod_toc(suffix, title, moved)
        print(f"  -> LoD WoWUkraine_{suffix}: {', '.join(moved)}")


def _write_items_toc(files):
    """Генерує WoWUkraine_Items.toc (LoadOnDemand-аддон)."""
    _write_lod_toc("Items", "Предмети", files)


def _expansion_map():
    import csv
    csv.field_size_limit(10 ** 7)
    m = {}
    with open(DATA_DIR / "wago" / "ItemSparse.enUS.latest.csv", encoding="utf-8") as fh:
        for row in csv.DictReader(fh):
            m[row["ID"]] = row.get("ExpansionID")
    return m


def generate_items(names: dict, flavors: dict):
    """names: {en назва: ua}, flavors: {en флейвор: ua} -> Items_<доповнення>.lua."""
    source_path = DATA_DIR / "source" / "items.json"
    if not names or not source_path.exists():
        return
    source = json.loads(source_path.read_text(encoding="utf-8-sig"))
    expmap = _expansion_map()

    buckets = {name: [] for name in EXP_ORDER}
    count = flavored = 0
    for iid_str in sorted(source, key=int):
        e = source[iid_str]
        en = e.get("name", {}).get("en")
        ua = en and names.get(en)
        if not ua:
            continue
        fl_en = (e.get("flavor") or {}).get("en")
        fl_ua = fl_en and flavors.get(fl_en)
        if fl_ua:
            line = (f'    t[{int(iid_str)}] = {{ name = "{lua_escape(ua)}", '
                    f'fen = "{lua_escape(fl_en)}", fua = "{lua_escape(fl_ua)}" }}\n')
            flavored += 1
        else:
            line = f'    t[{int(iid_str)}] = "{lua_escape(ua)}"\n'
        buckets[EXP_FILE.get(expmap.get(iid_str), "Other")].append(line)
        count += 1

    # Предмети тепер у LoadOnDemand-аддоні WoWUkraine_Items (не в головному).
    LOD_ITEMS_DIR.mkdir(parents=True, exist_ok=True)
    for f in DB_DIR.glob("Items_*.lua"):  # прибрати старі з головного аддона
        f.unlink()
    old = DB_DIR / "Items.lua"
    if old.exists():
        old.unlink()

    written, toc_files = [], []
    for name in EXP_ORDER:
        entries = buckets[name]
        fname = f"Items_{name}.lua"
        out = [f"-- WoWUkraine: предмети ({name}) — LoadOnDemand.\n", ITEMS_PREFIX_LOD]
        for i in range(0, len(entries), ITEM_CHUNK):
            out.append("add(function(t)\n")
            out.extend(entries[i:i + ITEM_CHUNK])
            out.append("end)\n")
        (LOD_ITEMS_DIR / fname).write_text("".join(out), encoding="utf-8")
        written.append((name, len(entries)))
        toc_files.append(fname)
    _write_items_toc(toc_files)
    print(f"Предметів: {count} (з флейвором: {flavored}) -> {MAIN_NAME}_Items (LoD), {len(EXP_ORDER)} файлів:")
    print("    " + ", ".join(f"{n}:{c}" for n, c in written if c))


NPCNAMES_HEADER = """\
-- WoWUkraine: база перекладів імен NPC/монстрів.
-- ЦЕЙ ФАЙЛ ГЕНЕРУЄТЬСЯ АВТОМАТИЧНО скриптом pipeline/generate_db.py — не редагуйте вручну.
-- Ключ — англійське ім'я (рядок), значення — українське. Зіставлення в грі
-- йде за показаним іменем істоти. Перемикач world.npcNames (типово вимкнено).

local _, ns = ...

ns.npcNames = {
"""


def generate_npc_names(npc: dict, subnames: dict = None):
    """npc: {creatureID: ua}. Мапимо ID->en через creatures.json + api_creatures_full
    (ОБ'ЄДНАННЯ: wago-екстракт нового білда менший за накопичений API-набір, тож
    самого creatures.json мало — інакше база імен різко падає)."""
    source_path = DATA_DIR / "source" / "creatures.json"
    if not npc or not source_path.exists():
        return
    source = json.loads(source_path.read_text(encoding="utf-8-sig"))
    acf_path = DATA_DIR / "source" / "api_creatures_full.json"
    acf = json.loads(acf_path.read_text(encoding="utf-8-sig")) if acf_path.exists() else {}
    # Капчур-мапа з гри (нові істоти, яких ще нема в creatures.json/API)
    cap_path = DATA_DIR / "source" / "captured_creatures.json"
    cap = json.loads(cap_path.read_text(encoding="utf-8-sig")) if cap_path.exists() else {}

    def id_to_en(cid):
        e = (source.get(str(cid), {}).get("name") or {}).get("en")
        if e:
            return e
        n = (acf.get(str(cid)) or {}).get("name")
        if isinstance(n, dict) and n.get("en"):
            return n["en"]
        if isinstance(n, str) and n:
            return n
        return cap.get(str(cid))

    # ОДНА АНГЛІЙСЬКА НАЗВА — КІЛЬКА УКРАЇНСЬКИХ. База тримає переклад за
    # creatureID, а тут мапа EN->UA, тож при збігу англійської назви хтось мусить
    # програти. Раніше вигравав ОСТАННІЙ за порядком словника: форма в грі
    # залежала від порядку ключів, а не від рішення перекладача, і мінялася між
    # збірками. Тепер беремо НАЙЧАСТІШУ форму, а при рівному рахунку — ту, що в
    # істоти з найменшим ID (стабільно й відтворювано). 14.10: таких назв 184.
    variants = {}
    for cid, ua in npc.items():
        en = id_to_en(cid)
        if not (en and ua and en != ua):
            continue
        try:
            key_id = int(cid)
        except (TypeError, ValueError):
            key_id = 1 << 62
        variants.setdefault(en, []).append((ua, key_id))
    by_en, collisions = {}, 0
    for en, lst in variants.items():
        if len({u for u, _ in lst}) > 1:
            collisions += 1
        counts = Counter(u for u, _ in lst)
        best = {u for u, c in counts.items() if c == max(counts.values())}
        by_en[en] = min((x for x in lst if x[0] in best), key=lambda x: x[1])[0]
    if collisions:
        print(f"  ! імен з кількома перекладами: {collisions} "
              f"(узято найчастішу, при рівності — за найменшим ID)")

    # Ручні EN->UA override: істоти без creatureID у джерелі (напр. генеричні kill-цілі
    # «Quilboar slain», де в objective лише назва типу, а не конкретний npcID).
    man_path = DATA_DIR / "source" / "manual_npc_names.json"
    if man_path.exists():
        for en, ua in json.loads(man_path.read_text(encoding="utf-8-sig")).items():
            if en and ua:
                by_en[en] = ua

    lines = [NPCNAMES_HEADER]
    for en in sorted(by_en):
        lines.append(f'    ["{lua_escape(en)}"] = "{lua_escape(by_en[en])}",\n')
    lines.append("}\n")
    # Підзаголовки істот (ns.npcSubnames en->ua) — у тому ж файлі (без нового .toc).
    subs = subnames or {}
    lines.append("ns.npcSubnames = {\n")
    for en in sorted(subs):
        ua = subs[en]
        if ua and ua.strip():
            lines.append(f'    ["{lua_escape(en)}"] = "{lua_escape(ua.strip())}",\n')
    lines.append("}\n")
    (DB_DIR / "NpcNames.lua").write_text("".join(lines), encoding="utf-8")
    print(f"Імен NPC: {len(by_en)} (+підзаголовків {len(subs)}) -> {DB_DIR / 'NpcNames.lua'}")


ACHIEVEMENTS_HEADER = """\
-- WoWUkraine: переклади досягнень (назва + опис).
-- ЦЕЙ ФАЙЛ ГЕНЕРУЄТЬСЯ АВТОМАТИЧНО скриптом pipeline/generate_db.py — не редагуйте вручну.
-- Ключ — achievementID (число).

local _, ns = ...

ns.achievements = {
"""


def generate_achievements(ach: dict):
    if not ach:
        return
    lines = [ACHIEVEMENTS_HEADER]
    for aid in sorted(ach, key=int):
        e = ach[aid]
        title = e.get("title")
        if not title:
            continue
        if e.get("desc"):
            lines.append(f'    [{int(aid)}] = {{ title = "{lua_escape(title)}", '
                         f'desc = "{lua_escape(e["desc"])}" }},\n')
        else:
            lines.append(f'    [{int(aid)}] = {{ title = "{lua_escape(title)}" }},\n')
    lines.append("}\n")
    (DB_DIR / "Achievements.lua").write_text("".join(lines), encoding="utf-8")
    print(f"Досягнень: {len(ach)} -> {DB_DIR / 'Achievements.lua'}")


CURRENCIES_HEADER = """\
-- WoWUkraine: переклади валют (назва + опис).
-- ЦЕЙ ФАЙЛ ГЕНЕРУЄТЬСЯ АВТОМАТИЧНО скриптом pipeline/generate_db.py — не редагуйте вручну.
-- Ключ — currencyID (число).

local _, ns = ...

ns.currencies = {
"""


def generate_currencies(cur: dict):
    """cur: {id: {name, desc?}}. Додаємо EN-назву (en) і EN-опис (den) із
    джерела — щоб у грі перекладати слот нагороди (за назвою) і опис у тултіпі
    (зіставити EN-рядок і підмінити)."""
    if not cur:
        return
    src_path = DATA_DIR / "source" / "currencies.json"
    src = json.loads(src_path.read_text(encoding="utf-8-sig")) if src_path.exists() else {}

    lines = [CURRENCIES_HEADER]
    for cid in sorted(cur, key=int):
        e = cur[cid]
        name = e.get("name") if isinstance(e, dict) else e
        if not name:
            continue
        s = src.get(str(cid), {})
        en = (s.get("name", {}) or {}).get("en", "")
        den = (s.get("description", {}) or {}).get("en", "")
        desc = e.get("desc") if isinstance(e, dict) else None
        fields = [f'name = "{lua_escape(name)}"']
        if en:
            fields.append(f'en = "{lua_escape(en)}"')
        if desc:
            fields.append(f'desc = "{lua_escape(desc)}"')
        if desc and den:
            fields.append(f'den = "{lua_escape(den)}"')
        lines.append(f'    [{int(cid)}] = {{ {", ".join(fields)} }},\n')
    lines.append("}\n")
    (DB_DIR / "Currencies.lua").write_text("".join(lines), encoding="utf-8")
    print(f"Валют: {len(cur)} -> {DB_DIR / 'Currencies.lua'}")


def generate_item_effects():
    """data/source/item_effects.json {itemID: [spellID,...]} -> ItemEffects.lua.
    Аддон за itemID дізнається spellID ефектів і перекладає рядки Equip:/Use:."""
    p = DATA_DIR / "source" / "item_effects.json"
    if not p.exists():
        return
    data = json.loads(p.read_text(encoding="utf-8-sig"))
    lines = [
        "-- WoWUkraine: мапа предмет -> spellID ефектів (Equip:/Use:).\n"
        "-- ЦЕЙ ФАЙЛ ГЕНЕРУЄТЬСЯ АВТОМАТИЧНО скриптом pipeline/generate_db.py.\n\n"
        "local _, ns = ...\n\nns.itemEffects = {\n"
    ]
    for iid in sorted(data, key=int):
        sids = data[iid]
        if sids:
            lines.append(f"    [{int(iid)}] = {{{', '.join(str(s) for s in sids)}}},\n")
    lines.append("}\n")
    (DB_DIR / "ItemEffects.lua").write_text("".join(lines), encoding="utf-8")
    print(f"Ефектів предметів: {len(data)} -> {DB_DIR / 'ItemEffects.lua'}")


def generate_keyed(data: dict, var: str, filename: str, note: str):
    """Прості бази виду ns.<var> = { ["en"] = "ua" } (госіпи, цілі квестів)."""
    if not data:
        return
    header = (f"-- WoWUkraine: {note}\n"
              f"-- ЦЕЙ ФАЙЛ ГЕНЕРУЄТЬСЯ АВТОМАТИЧНО скриптом pipeline/generate_db.py — не редагуйте вручну.\n\n"
              f"local _, ns = ...\n\nns.{var} = {{\n")
    lines = [header]
    for en in sorted(data):
        ua = data[en]
        if ua:
            lines.append(f'    ["{lua_escape(en)}"] = "{lua_escape(ua)}",\n')
    lines.append("}\n")
    (DB_DIR / filename).write_text("".join(lines), encoding="utf-8")
    print(f"{var}: {len(data)} -> {DB_DIR / filename}")


TITLES_HEADER = """\
-- WoWUkraine: переклади титулів гравця. Автоген pipeline/generate_db.py.
-- Ключ — англійський рядок титулу (як показує гра), значення — український.
local _, ns = ...
ns.titles = {
"""


def generate_titles(titles: dict):
    """titles: {titleID: {name: ua}}. en беремо з api_titles.json -> {en: ua}."""
    src_path = DATA_DIR / "source" / "api_titles.json"
    if not titles or not src_path.exists():
        return
    src = json.loads(src_path.read_text(encoding="utf-8-sig"))
    lines = [TITLES_HEADER]
    n = 0
    for tid, v in titles.items():
        ua = v.get("name") if isinstance(v, dict) else v
        en = (src.get(tid, {}).get("name") or {}).get("en")
        if en and ua:
            lines.append(f'    ["{lua_escape(en.strip())}"] = "{lua_escape(ua.strip())}",\n')
            n += 1
    lines.append("}\n")
    (DB_DIR / "Titles.lua").write_text("".join(lines), encoding="utf-8")
    print(f"Титулів: {n} -> {DB_DIR / 'Titles.lua'}")


JOURNAL_HEADER = """\
-- WoWUkraine: переклади Журналу підземель (боси: ім'я + лорний опис).
-- Автоген pipeline/generate_db.py. Ключ — journalEncounterID (C_EncounterJournal).
-- Значення: n = укр. ім'я боса, d = укр. опис (може бути відсутній).
local _, ns = ...
ns.journal = {
"""


def generate_journal(journal: dict, sections: dict = None, instdesc: dict = None):
    """journal: {journalEncounterID: {name: ua, desc?: ua}}. Ключ — id енкаунтера.
    Додатково — ns.journalEncounterNames = {англ.назва: укр.назва} (англ. з api_journal)
    для Walk-підміни імен босів у списку Encounter Journal за показаним текстом.
    sections: {англ.текст секції: укр} — описи механік/огляд (ns.journalSections)."""
    if not journal:
        return
    aj_path = DATA_DIR / "source" / "api_journal.json"
    aj = json.loads(aj_path.read_text(encoding="utf-8-sig")) if aj_path.exists() else {}

    def aen(jid):
        v = aj.get(str(jid))
        if isinstance(v, dict):
            nm = v.get("name")
            return nm.get("en") if isinstance(nm, dict) else nm
        return None

    lines = [JOURNAL_HEADER]
    by_name = []
    n = 0
    for jid, v in journal.items():
        if not isinstance(v, dict):
            continue
        name = (v.get("name") or "").strip()
        if not name:
            continue
        desc = (v.get("desc") or "").strip()
        if desc:
            lines.append(f'    [{jid}] = {{n="{lua_escape(name)}", d="{lua_escape(desc)}"}},\n')
        else:
            lines.append(f'    [{jid}] = {{n="{lua_escape(name)}"}},\n')
        en = aen(jid)
        if en and en != name:
            by_name.append((en, name))
        n += 1
    lines.append("}\n\n")
    lines.append("ns.journalEncounterNames = {\n")
    for en, ua in sorted(set(by_name)):
        lines.append(f'    ["{lua_escape(en)}"] = "{lua_escape(ua)}",\n')
    lines.append("}\n\n")

    # Лор босів за ТЕКСТОМ (надійніше за encounterID у Midnight): {англ.опис: укр}.
    def aen_desc(jid):
        v = aj.get(str(jid))
        if isinstance(v, dict):
            d = v.get("description")
            return d.get("en") if isinstance(d, dict) else d
        return None

    lore = []
    for jid, v in journal.items():
        if not isinstance(v, dict):
            continue
        ua = (v.get("desc") or "").strip()
        en = aen_desc(jid)
        if ua and en and en.strip():
            lore.append((en.strip(), ua))
    lines.append("ns.journalLore = {\n")
    for en, ua in sorted(set(lore)):
        lines.append(f'    ["{lua_escape(en)}"] = "{lua_escape(ua)}",\n')
    lines.append("}\n\n")

    # Лор НЕ завжди збігається точно (гра показує \n\n, API має \r\n\r\n; буває
    # розбито по абзацах окремими FontString). Тому ще й НОРМАЛІЗОВАНИЙ матч:
    # ключ = згорнуті пробіли/переноси. Зберігаємо і ПОВНИЙ текст, і КОЖЕН абзац.
    def _ws(s):
        return _ws_re2.sub(' ', _ws_re1.sub(' ', s)).strip()
    import re as _re0
    _ws_re1 = _re0.compile(r'[\r\n]+'); _ws_re2 = _re0.compile(r'\s+')
    norm = {}
    # sorted, а не set(): порядок множини залежить від випадкового хешування рядків, тож
    # коли той самий опис боса перекладено двічі по-різному, «перемагав» випадковий варіант —
    # Journal.lua мінявся від збірки до збірки без жодної правки (07.10.2026: 15 таких
    # описів, напр. «Тавріссан»/«Тауріссан»). Тепер збірка стабільна, а конфлікти — у звіті.
    seen_ua = {}
    for en, ua in sorted(set(lore)):
        seen_ua.setdefault(_ws(en), set()).add(ua)
    clashes = {k: v for k, v in seen_ua.items() if len(v) > 1}
    if clashes:
        print(f"  УВАГА журнал: {len(clashes)} описів перекладено по-різному в різних енкаунтерах "
              f"(розв'язати в майстрі journal.*.desc), напр.: {next(iter(clashes))[:60]!r}")
    for en, ua in sorted(set(lore)):
        norm[_ws(en)] = ua
        ep = _re0.split(r'(?:\r?\n){2,}', en); up = _re0.split(r'(?:\r?\n){2,}', ua)
        if len(ep) == len(up) and len(ep) > 1:
            for e, u in zip(ep, up):
                e, u = e.strip(), u.strip()
                if e and u:
                    norm[_ws(e)] = u
    lines.append("ns.journalLoreNorm = {\n")
    for k in sorted(norm):
        if k:
            lines.append(f'    ["{lua_escape(k)}"] = "{lua_escape(norm[k])}",\n')
    lines.append("}\n\n")

    # Описи механік/огляд. Ключ — КАНОНІЧНА форма (зняти лінки/$bullet;/переноси,
    # числа→«#») — щоб збігтися з показаним у грі (де числа реальні, а API має 0).
    import re as _re

    def ej_canon(s):
        s = _re.sub(r'\|c[0-9a-fA-F]{8}', '', s)
        s = _re.sub(r'\|cn[A-Za-z_]+:', '', s)
        s = s.replace('|r', '')
        s = _re.sub(r'\|H.*?\|h(.*?)\|h', r'\1', s)
        s = _re.sub(r'\|T.*?\|t', '', s)
        s = _re.sub(r'\|A.*?\|a', '', s)
        s = s.replace('$bullet;', '').replace('|n', ' ')
        s = _re.sub(r'[\r\n]+', ' ', s)
        s = _re.sub(r'\d[\d,.]*', '#', s)
        return _re.sub(r'\s+', ' ', s).strip()

    def split_b(s):
        # API склеює буліти через $bullet;, гра показує кожен окремим FontString.
        if "$bullet;" in s:
            return [p for p in s.split("$bullet;") if p.strip()]
        return [s]

    seen = {}
    for en, ua in (sections or {}).items():
        if not ua:
            continue
        en_b, ua_b = split_b(en), split_b(ua)
        pairs = zip(en_b, ua_b) if len(en_b) == len(ua_b) else [(en, ua)]
        for e, u in pairs:
            key = ej_canon(e)
            if key:
                seen[key] = _re.sub(r'[\r\n]+', ' ', u).strip()  # буліт у рядок
    lines.append("ns.journalSections = {\n")
    for key in sorted(seen):
        lines.append(f'    ["{lua_escape(key)}"] = "{lua_escape(seen[key])}",\n')
    lines.append("}\n\n")
    ns_count = len(seen)

    # Описи підземель/рейдів (LoreScrollingFont) — плоский текст, матч за EN.
    lines.append("ns.journalInstanceDesc = {\n")
    id_count = 0
    inorm = {}
    for en, ua in sorted((instdesc or {}).items()):
        if ua:
            lines.append(f'    ["{lua_escape(en)}"] = "{lua_escape(ua)}",\n')
            id_count += 1
            inorm[_ws(en)] = ua
            ep = _re0.split(r'(?:\r?\n){2,}', en); up = _re0.split(r'(?:\r?\n){2,}', ua)
            if len(ep) == len(up) and len(ep) > 1:
                for e, u in zip(ep, up):
                    e, u = e.strip(), u.strip()
                    if e and u:
                        inorm[_ws(e)] = u
    lines.append("}\n\n")
    lines.append("ns.journalInstanceDescNorm = {\n")
    for k in sorted(inorm):
        if k:
            lines.append(f'    ["{lua_escape(k)}"] = "{lua_escape(inorm[k])}",\n')
    lines.append("}\n")
    (DB_DIR / "Journal.lua").write_text("".join(lines), encoding="utf-8")
    print(f"Журнал: {n} (+імен {len(set(by_name))}, +лору {len(set(lore))}, "
          f"+секцій {ns_count}) -> {DB_DIR / 'Journal.lua'}")


FACTIONS_HEADER = """\
-- WoWUkraine: переклади фракцій (репутації/Renown): назва + опис.
-- Автоген pipeline/generate_db.py. ns.factions — ключ factionID (n=ім'я, d=опис).
-- ns.factionByName — мапа англ.назва->укр.назва (для хука FontString показу).
local _, ns = ...
ns.factions = {
"""


def generate_factions(factions: dict):
    """factions: {factionID: {name: ua, desc?: ua}}. en беремо з api_factions.json."""
    src_path = DATA_DIR / "source" / "api_factions.json"
    if not factions or not src_path.exists():
        return
    src = json.loads(src_path.read_text(encoding="utf-8-sig"))
    lines = [FACTIONS_HEADER]
    by_name = []
    n = 0
    for fid, v in factions.items():
        ua = (v.get("name") if isinstance(v, dict) else v) or ""
        ua = ua.strip()
        if not ua:
            continue
        desc = (v.get("desc") or "").strip() if isinstance(v, dict) else ""
        if desc:
            lines.append(f'    [{fid}] = {{n="{lua_escape(ua)}", d="{lua_escape(desc)}"}},\n')
        else:
            lines.append(f'    [{fid}] = {{n="{lua_escape(ua)}"}},\n')
        en = (src.get(fid, {}).get("name") or {}).get("en")
        if en:
            by_name.append(f'    ["{lua_escape(en.strip())}"] = "{lua_escape(ua)}",\n')
        n += 1
    lines.append("}\nns.factionByName = {\n")
    lines.extend(by_name)
    lines.append("}\n")
    (DB_DIR / "Factions.lua").write_text("".join(lines), encoding="utf-8")
    print(f"Фракцій: {n} -> {DB_DIR / 'Factions.lua'}")


INSTANCES_HEADER = """\
-- WoWUkraine: переклади назв підземель/рейдів (інстанси Путівника пригод).
-- Автоген pipeline/generate_db.py. ns.journalInstances — мапа англ.назва->укр.назва
-- (хук підміняє FontString у списку EncounterJournalInstanceSelect).
local _, ns = ...
ns.journalInstances = {
"""


def generate_journal_instances(instances: dict):
    """instances: {journalInstanceID: {name: ua}}. en беремо з api_journal_instances.json."""
    src_path = DATA_DIR / "source" / "api_journal_instances.json"
    if not instances or not src_path.exists():
        return
    src = json.loads(src_path.read_text(encoding="utf-8-sig"))
    lines = [INSTANCES_HEADER]
    n = 0
    for iid, v in instances.items():
        ua = (v.get("name") if isinstance(v, dict) else v) or ""
        ua = ua.strip()
        en = (src.get(iid, {}).get("name") or {}).get("en")
        if en and ua:
            lines.append(f'    ["{lua_escape(en.strip())}"] = "{lua_escape(ua)}",\n')
            n += 1
    lines.append("}\n")
    (DB_DIR / "JournalInstances.lua").write_text("".join(lines), encoding="utf-8")
    print(f"Інстансів журналу: {n} -> {DB_DIR / 'JournalInstances.lua'}")


MINIMAP_HEADER = """\
-- WoWUkraine: переклади написів ПОЗНАЧОК МІНІМАПИ (типи: Mailbox тощо, імена точок).
-- Автоген pipeline/generate_db.py. ns.minimapLabels — мапа англ.рядок->укр.
-- Тултіп-перекладач (TrackerHooks) підставляє за показаним текстом. Один переклад
-- «Mailbox» покриває ВСІ поштові скриньки в грі (зіставлення за рядком).
local _, ns = ...
ns.minimapLabels = {
"""


def generate_minimap(minimap: dict):
    """minimap: {id: {name: ua}}. en з api_minimap.json. Пишемо ns.minimapLabels[en]=ua
    (для тултіп-хука як запасний шлях) + ПЕРЕВИЗНАЧАЄМО глобали MINIMAP_TRACKING_*
    у джерелі (надійно: назва POI перекладена скрізь, без ловлі тултіпа). Ці глобали
    суто display (меню стеження), НЕ secure — тейнту немає (на відміну від BINDING_*)."""
    src_path = DATA_DIR / "source" / "api_minimap.json"
    if not minimap or not src_path.exists():
        return
    src = json.loads(src_path.read_text(encoding="utf-8-sig"))
    en2ua = {}
    lines = [MINIMAP_HEADER]
    n = 0
    for mid, v in minimap.items():
        ua = (v.get("name") if isinstance(v, dict) else v) or ""
        ua = ua.strip()
        en = (src.get(mid, {}).get("name") or {}).get("en")
        if en and ua:
            en = en.strip()
            lines.append(f'    ["{lua_escape(en)}"] = "{lua_escape(ua)}",\n')
            en2ua[en] = ua
            n += 1
    lines.append("}\n")

    # Безпечне перевизначення глобалів ярликів POI (MINIMAP_TRACKING_*) у джерелі.
    gs_path = DATA_DIR / "source" / "globalstrings.json"
    over = []
    if gs_path.exists():
        gs = json.loads(gs_path.read_text(encoding="utf-8-sig"))
        for name, en in gs.items():
            if name.startswith("MINIMAP_TRACKING_") and en in en2ua:
                over.append(f'_G["{lua_escape(name)}"] = "{lua_escape(en2ua[en])}"\n')
    if over:
        lines.append("\n-- безпечні глобали ярликів POI (display, не secure)\nlocal _G = _G\n")
        lines.extend(over)
    (DB_DIR / "Minimap.lua").write_text("".join(lines), encoding="utf-8")
    print(f"Написів мінімапи: {n} (+{len(over)} глобалів MINIMAP_TRACKING_*) "
          f"-> {DB_DIR / 'Minimap.lua'}")


GLOBALSTRINGS_HEADER = """\
-- WoWUkraine: переклад інтерфейсу гри (GlobalStrings). Автоген pipeline/generate_db.py.
-- Перевизначаємо глобальні рядки-константи — UI читає їх і показує українською.
-- Завантажується РАНО (до показу більшості вікон). Один переклад значення
-- застосовано до ВСІХ імен GlobalString із цим англ. значенням.
local _, ns = ...
local S = {
"""


# НЕБЕЗПЕЧНІ (taint) GlobalStrings — НЕ перевизначати: гра читає їх у SECURE-коді
# (бінди клавіш -> екшни), і override тейнтить екшн-систему ("blocked from an action
# only available to the Blizzard UI"). Підтверджено на BINDING_*.
import re as _re
GS_BLOCKLIST = _re.compile(
    r"^(BINDING_|KEY_|MACRO_|SECURE_|.*_BINDING$)"  # бінди/клавіші/макро/secure
)


# КОНТЕКСТНІ ОМОНІМИ: переклад за ЗНАЧЕННЯМ отруює імена, де той самий EN-текст
# означає ІНШЕ (Back = кнопка «Назад», АЛЕ слот плаща = «Спина»): тестер бачив
# «Назад» у слоті плаща саме через це. Пер-іменні перекриття мають пріоритет
# над value-мапою (context-scoped-translation на рівні _G).
GS_NAME_OVERRIDES = {
    "INVTYPE_CLOAK": "Спина",  # рядок слота в тултіпі предмета (EN value "Back")
    "BACKSLOT": "Спина",       # підпис слота плаща в паперделі (EN value "Back")
    "INVTYPE_CHEST": "Груди",  # слот, НЕ предмет «Нагрудник» (EN value "Chest")
    "CHESTSLOT": "Груди",
    "INVTYPE_LEGS": "Ноги",    # слот, НЕ предмет «Поножі» (EN value "Legs")
    "LEGSSLOT": "Ноги",
}


def generate_globalstrings(global_strings: dict):
    """global_strings: {en: ua}. NAME->en з globalstrings.json. Пишемо _G[NAME]=ua,
    окрім taint-небезпечних імен (блок-лист); GS_NAME_OVERRIDES — пріоритетні."""
    src_path = DATA_DIR / "source" / "globalstrings.json"
    if not global_strings or not src_path.exists():
        return
    src = json.loads(src_path.read_text(encoding="utf-8-sig"))  # {NAME: en}
    lines = [GLOBALSTRINGS_HEADER]
    n = skipped = 0
    for name, en in src.items():
        if GS_BLOCKLIST.match(name):
            skipped += 1
            continue
        ua = GS_NAME_OVERRIDES.get(name) or global_strings.get(en)
        if ua:
            lines.append(f'    ["{lua_escape(name)}"] = "{lua_escape(ua)}",\n')
            n += 1
    lines.append("}\nfor k, v in pairs(S) do _G[k] = v end\n")
    out_text = "".join(lines)
    # самоперевірка омонімів: регенерація НЕ сміє воскресити «Назад» у слоті плаща
    for nm, want in GS_NAME_OVERRIDES.items():
        if f'["{nm}"]' in out_text and f'["{nm}"] = "{want}"' not in out_text:
            raise SystemExit(f"ГЕЙТ GS-ОМОНІМІВ: {nm} мав бути «{want}» — перевір GS_NAME_OVERRIDES")
    (DB_DIR / "GlobalStrings.lua").write_text(out_text, encoding="utf-8")
    print(f"GlobalStrings (UI): {n} перевизначень | пропущено secure: {skipped} "
          f"-> {DB_DIR / 'GlobalStrings.lua'}")


# БІЛИЙ СПИСОК безпечних display-категорій GlobalStrings (статистика, панель
# персонажа). «Малі кроки»: перевизначаємо ЛИШЕ перевірені display-рядки, а не все
# підряд — так уникаємо тейнту від невідомих secure-рядків. Розширюється віконно.
UI_SAFE_WHITELIST = _re.compile(
    r"^(STAT_|SPELL_STAT\d|ITEM_MOD_|PRIMARY_STAT\d|SPEC_FRAME_PRIMARY_STAT_|"
    r"PAPERDOLL_|RAID_BUFF_\d|SPELL_HASTE|RESISTANCE\d_NAME|ITEM_UPGRADE_STAT_|"
    r"LFG_LIST_ITEM_LEVEL)"
)
UI_SAFE_NAMES = {
    "ARMOR", "SPEED", "REPUTATION", "REPUTATION_ABBR", "CURRENCY", "CHARACTER_INFO",
    "CHARACTER_BUTTON", "COMBAT_FACTION_CHANGE", "AUCTION_CATEGORY_ARMOR",
}

UISAFE_HEADER = """\
-- WoWUkraine: БЕЗПЕЧНИЙ точковий переклад інтерфейсу (білий список display-рядків:
-- статистика, панель персонажа). Автоген. Лише перевірені НЕ-secure глобали, тож
-- тейнту немає (на відміну від повного GlobalStrings, де були BINDING_*).
local _, ns = ...
local S = {
"""


def generate_ui_safe(global_strings: dict):
    src_path = DATA_DIR / "source" / "globalstrings.json"
    if not global_strings or not src_path.exists():
        return
    src = json.loads(src_path.read_text(encoding="utf-8-sig"))
    lines = [UISAFE_HEADER]
    n = 0
    for name, en in src.items():
        if GS_BLOCKLIST.match(name):
            continue  # подвійний захист: ніколи secure
        if not (UI_SAFE_WHITELIST.match(name) or name in UI_SAFE_NAMES):
            continue
        ua = global_strings.get(en)
        if ua:
            lines.append(f'    ["{lua_escape(name)}"] = "{lua_escape(ua)}",\n')
            n += 1
    lines.append("}\nfor k, v in pairs(S) do _G[k] = v end\n")
    (DB_DIR / "UIStrings.lua").write_text("".join(lines), encoding="utf-8")
    print(f"UI безпечні (whitelist): {n} перевизначень -> {DB_DIR / 'UIStrings.lua'}")


def generate_collection(data: dict, src_name: str, var: str, filename: str, label: str):
    """data: {id: {name: ua, desc?: ua}}. en беремо з api source (id->{name:{en},description:{en}}).
    Генерує ns.<var> (id->{n,d}), ns.<var>ByName (en назва->ua), ns.<var>DescByEn (en опис->ua)."""
    src_path = DATA_DIR / "source" / src_name
    if not data or not src_path.exists():
        return
    src = json.loads(src_path.read_text(encoding="utf-8-sig"))
    header = (f"-- WoWUkraine: переклади колекції ({label}): назва + опис. Автоген.\n"
              f"-- ns.{var} — id->{{n,d}}; ns.{var}ByName — англ.назва->укр (хук показу);\n"
              f"-- ns.{var}DescByEn — англ.опис->укр (деталь-панель).\n"
              f"local _, ns = ...\nns.{var} = {{\n")
    lines = [header]
    by_name, by_desc = [], []
    n = 0
    for cid, v in data.items():
        ua = (v.get("name") if isinstance(v, dict) else v) or ""
        ua = ua.strip()
        if not ua:
            continue
        desc = (v.get("desc") or "").strip() if isinstance(v, dict) else ""
        if desc:
            lines.append(f'    [{cid}] = {{n="{lua_escape(ua)}", d="{lua_escape(desc)}"}},\n')
        else:
            lines.append(f'    [{cid}] = {{n="{lua_escape(ua)}"}},\n')
        sv = src.get(str(cid), {})
        en = (sv.get("name") or {}).get("en") if isinstance(sv.get("name"), dict) else sv.get("name")
        if en and en.strip():
            by_name.append(f'    ["{lua_escape(en.strip())}"] = "{lua_escape(ua)}",\n')
        en_d = (sv.get("description") or {}).get("en") if isinstance(sv.get("description"), dict) else sv.get("description")
        if en_d and en_d.strip() and desc:
            by_desc.append(f'    ["{lua_escape(en_d.strip())}"] = "{lua_escape(desc)}",\n')
        n += 1
    lines.append(f"}}\nns.{var}ByName = {{\n")
    lines.extend(by_name)
    lines.append(f"}}\nns.{var}DescByEn = {{\n")
    lines.extend(by_desc)
    lines.append("}\n")
    (DB_DIR / filename).write_text("".join(lines), encoding="utf-8")
    print(f"{label}: {n} -> {DB_DIR / filename}")


def main():
    translations = json.loads(TRANSLATIONS_PATH.read_text(encoding="utf-8-sig"))
    DB_DIR.mkdir(parents=True, exist_ok=True)
    generate_quests(translations.get("quests", {}))
    generate_spells(translations.get("spells", {}))
    generate_spell_descriptions(translations.get("descTemplates", {}))
    generate_aura_descriptions(translations.get("auraDescriptions", {}), translations.get("descTemplates", {}))
    generate_set_bonuses(translations.get("setBonus", {}))
    generate_trait_templates(translations.get("traitTemplates", {}))
    generate_set_pieces(translations.get("itemNames", {}))
    generate_items(translations.get("itemNames", {}), translations.get("itemFlavors", {}))
    generate_npc_names(translations.get("npcNames", {}), translations.get("subnames", {}))
    generate_achievements(translations.get("achievements", {}))
    generate_currencies(translations.get("currencies", {}))
    generate_item_effects()
    generate_keyed(translations.get("gossip", {}), "gossip", "Gossip.lua",
                   "переклади реплік NPC (вікно розмови) і варіантів відповідей.")
    generate_keyed(translations.get("questObjectives", {}), "questObjectives",
                   "QuestObjectives.lua", "переклади рядків цілей квестів (трекер).")
    generate_keyed(translations.get("emotes", {}), "emotes", "Emotes.lua",
                   "шаблони текстових емоцій (%s — ім'я; матчинг у ChatHooks).")
    # Системний чат тримаємо ШАБЛОНАМИ, а не рядками: «%s joins the party.»
    # покриває всіх гравців одразу, і жодне ім'я не осідає в базі
    # [[player-name-leak-gate]]. Матчинг — той самий, що в емоціях.
    generate_keyed(translations.get("system", {}), "system", "SystemChat.lua",
                   "шаблони системного чату (%s — ім'я/лінк/число; ChatHooks).")
    generate_keyed(translations.get("scenario", {}), "scenario", "Scenario.lua",
                   "назви/кроки сценаріїв (трекер; лук у TrackerHooks).")
    generate_keyed(translations.get("achievementCategories", {}), "achievementCategories",
                   "AchievementCategories.lua",
                   "категорії лівого списку вікна досягнень (раніше — жорсткий UI_CHROME).")
    generate_keyed(translations.get("bossAbilities", {}), "bossAbilities", "BossAbilities.lua",
                   "назви+описи абілок босів (Журнал боїв; доставка описів через журнал-рушій).")
    generate_keyed(translations.get("playerChoice", {}), "playerChoice", "PlayerChoice.lua",
                   "тексти вікна PlayerChoiceFrame (вибір історії/сценарію) — серверні, збір у грі.")
    generate_keyed(translations.get("enchants", {}), "enchants", "Enchants.lua",
                   "назви чарів предметів (SpellItemEnchantment) — показ на тултіпах через ItemHooks.")
    generate_keyed(translations.get("perksActivity", {}), "perksActivity", "PerksActivity.lua",
                   "завдання/описи Торгового поста (PerksActivity) — показ через PerksProgramHooks.")
    generate_keyed(translations.get("housingUI", {}), "housingUI", "HousingUI.lua",
                   "статичні UI-рядки системи Житла (Dashboard/Catalog) — показ через HousingHooks.")
    generate_keyed(translations.get("itemSuffixes", {}), "itemSuffixes", "ItemSuffixes.lua",
                   "суфікси предметів (ItemNameDescription) — показ у назві на тултіпі через ItemHooks.")
    generate_keyed(translations.get("transmogSets", {}), "transmogSets", "TransmogSets.lua",
                   "назви трансмог-сетів (TransmogSet) — показ у гардеробі через TransmogHooks.")
    generate_keyed(translations.get("transmogSetGroups", {}), "transmogSetGroups", "TransmogSetGroups.lua",
                   "назви груп трансмог-сетів (TransmogSetGroup) — показ у гардеробі через TransmogHooks.")
    generate_keyed(translations.get("taxiNodes", {}), "taxiNodes", "Taxi.lua",
                   "назви точок польоту (TaxiNodes) — показ на мапі польотів через TaxiHooks.")
    generate_keyed(translations.get("questLines", {}), "questLines", "QuestLines.lua",
                   "назви сюжетних ліній (QuestLine) — показ у журналі квестів через QuestLineHooks.")
    generate_keyed(translations.get("areaPOI", {}), "areaPOI", "AreaPOI.lua",
                   "назви/описи точок інтересу мапи (AreaPOI) — показ на мапі через AreaPOIHooks.")
    generate_keyed(translations.get("chrCustomization", {}), "chrCustomization", "ChrCustomization.lua",
                   "підписи/варіанти зовнішності (ChrCustomization+BarberShop) — показ у перукарні через BarberShopHooks.")
    generate_keyed(translations.get("battlePets", {}), "battlePets", "BattlePets.lua",
                   "описи/джерела бойових улюбленців (BattlePetSpecies) — показ через PetBattleHooks.")
    generate_keyed(translations.get("battlePetAbilities", {}), "battlePetAbilities", "BattlePetAbilities.lua",
                   "назви/описи здібностей улюбленців (BattlePetAbility) — показ через PetBattleHooks.")
    generate_keyed(translations.get("housing", {}), "housing", "Housing.lua",
                   "декор/барвники/кімнати житлової системи — показ через HousingHooks.")
    generate_keyed(translations.get("groupFinder", {}), "groupFinder", "GroupFinder.lua",
                   "назви/описи активностей пошуку групи й полів бою — показ через GroupFinderHooks.")
    generate_keyed(translations.get("skillLines", {}), "skillLines", "SkillLines.lua",
                   "назви/описи професій і скілів (SkillLine) — показ хуками професій/UI.")
    generate_keyed(translations.get("holidays", {}), "holidays", "Holidays.lua",
                   "назви/описи свят (Holidays) — показ у календарі через CalendarHooks.")
    generate_keyed(translations.get("uiMisc", {}), "uiMisc", "UIMisc.lua",
                   "різні UI-рядки (сплеші/складності/родини/мови) — показ через UIHooks.")
    generate_keyed(translations.get("garrison", {}), "garrison", "Garrison.lua",
                   "абілки соратників/місій + будівлі гарнізону/Зали Ордену — показ через Tier3Hooks.")
    generate_keyed(translations.get("vignette", {}), "vignette", "Vignette.lua",
                   "назви рідкісних мобів/скарбів (мітки на мапі/мінімапі) — показ через VignetteHooks.")
    generate_keyed(translations.get("bookTexts", {}), "bookTexts",
                   "BookTexts.lua", "переклади сторінок книг (ItemText).")
    generate_keyed(translations.get("mail", {}), "mail", "Mail.lua",
                   "переклади поштових листів (тема/тіло) — серверний текст, збір у грі.")
    generate_keyed(translations.get("profDesc", {}), "profDesc", "ProfDesc.lua",
                   "переклади описів рецептів професій (флейвор, $@spelldesc) — точний збіг.")
    # renown-описи нагород («You may purchase…») показуються в GameTooltip трекá Journeys/
    # репутації — той самий хук, що й uiTooltips (ns.uiTooltips[clean]). Окремого ns.renown/
    # Renown.lua нема, тож домержуємо renown у ns.uiTooltips (ключ=англ.опис).
    _ui = dict(translations.get("uiTooltips", {}))
    for _k, _v in translations.get("renown", {}).items():
        if _k not in _ui and isinstance(_v, str) and _v.strip():
            _ui[_k] = _v
    # gameObjects («Broken Barrel», «Nerubian Webs») — назви СВІТОВИХ ОБ'ЄКТІВ, які
    # гра показує тим самим тултіпом наведення. Власної таблиці й хука в них не
    # було, тож 289 перекладів нікуди не доїжджали; домержуємо так само, як renown
    # (аудит 14.10 [[db2-coverage-gate]]).
    for _k, _v in translations.get("gameObjects", {}).items():
        if _k not in _ui and isinstance(_v, str) and _v.strip():
            _ui[_k] = _v
    generate_keyed(_ui, "uiTooltips", "UITooltips.lua",
                   "переклади UI-тултіпів (делви, мапа, renown-описи, світові об'єкти) зі збору.")
    # ns.journeys ЧИТАЄ JourneysHooks.lua (перший у ланцюгу пошуку), але ніхто її
    # не створював — тобто гілка мовчки не працювала, а 383 переклади «Мандрів»
    # лежали в базі без виходу в гру.
    generate_keyed(translations.get("journeys", {}), "journeys", "Journeys.lua",
                   "переклади карток Мандрів (Journeys) — серверний текст, збір у грі.")
    generate_titles(translations.get("titles", {}))
    generate_journal(translations.get("journal", {}), translations.get("journalSections", {}),
                     translations.get("instanceDesc", {}))
    generate_factions(translations.get("factions", {}))
    generate_journal_instances(translations.get("journal_instances", {}))
    # ── LoadOnDemand: винести великі НЕОБОВ'ЯЗКОВІ бази в окремі під-аддони ──
    # NpcNames (типово ВИМК → не вантажиться для більшості); Journal (лише при відкритті
    # Shift+J). Items вже виносить generate_items. Економія RAM, коли фіча неактивна.
    _move_db_to_lod(["NpcNames.lua"], "NpcNames", "Імена NPC")
    _move_db_to_lod(["Journal.lua", "JournalInstances.lua"], "Journal", "Путівник пригод")
    generate_minimap(translations.get("minimap", {}))
    generate_globalstrings(translations.get("globalStrings", {}))
    generate_ui_safe(translations.get("globalStrings", {}))
    # ns.uiStrings — DISPLAY-словник для UIHooks Lookup (панель «Параметри», меню
    # Esc, налаштування): усі globalStrings en->ua, БЕЗ _G-override → без тейнту.
    # Застосовується лише в обході TARGETS-фреймів (settings/menu), гейт interface.menu.
    _gs = translations.get("globalStrings", {})
    # ДОЗВОЛЯЄМО |n (перенос) та |r — це звичайні описи опцій; виключаємо лише
    # формат (%) і розмітку-коди |c/|T/|H/|A/|h (колір/текстура/лінк), бо рантайм
    # GetText їх лишає й точний збіг ламається.
    _uistr = {en: ua for en, ua in _gs.items()
              if isinstance(en, str) and isinstance(ua, str) and ua and en != ua
              and len(en) >= 2 and "%" not in en and not _re.search(r"\|[^nr]", en)
              and any(c.isalpha() for c in en)}
    generate_keyed(_uistr, "uiStrings", "UIStringsDisplay.lua",
                   "display-словник UI (панель налаштувань, меню Esc) для UIHooks — БЕЗ _G-override.")
    generate_collection(translations.get("mounts", {}), "api_mounts.json", "mounts", "Mounts.lua", "Маунти")
    generate_keyed(translations.get("mountDescriptions", {}), "mountDescriptions",
                   "MountDescriptions.lua", "Описи маунтів (флейвор у тултіпі колекції) — з wago DB2")
    generate_collection(translations.get("pets", {}), "api_pets.json", "pets", "Pets.lua", "Улюбленці")
    generate_collection(translations.get("itemSets", {}), "api_item_sets.json", "itemSets", "ItemSets.lua", "Сети")
    print("У грі виконайте /reload, щоб побачити переклади.")


if __name__ == "__main__":
    main()
