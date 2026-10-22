# -*- coding: utf-8 -*-
"""Готує broadcast-батчі для хвилі перекладу: парсить db.broadcast={en:speaker},
дедуп проти translations.broadcast, виключає %-емоут-шаблони (інша система),
нормалізує ім'я гравця -> {NAME}, додає мовця (для роду), чанкує.
-> data/batches/broadcast/bc_NN.json  [{en, speaker}]
%-шаблони -> data/batches/broadcast_emotes.json (окремо, не в цій хвилі)."""
import sys, re, json, glob
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from playernames import nick_regex, known_realms

# Приймає КІЛЬКА файлів. Раніше брався лише sys.argv[1], тож із партії
# тестерських зборів у чергу потрапляв рівно один — решта тихо зникала
# [[patch-refresh-gotchas]]. Ту саму ваду вже виправлено в _extract_uitt.py
# і _prep_objlines_wave.py.
paths = [a for a in sys.argv[1:] if not a.startswith("--")] or glob.glob(
    r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/UALL.lua")
print(f"зборів у роботі: {len(paths)}")
# УВАГА: склеювати файли в один рядок НЕ можна. `re.search` знайде лише
# ПЕРШИЙ блок ["broadcast"] і перший ["playerName"], тож із партії зборів
# у чергу потрапить один файл, а ім'я другого тестера лишиться
# ненормалізованим і поїде в базу [[capture-wave-playername-leaks]].
# Тому кожен файл розбираємо окремо, а результати об'єднуємо.
SOURCES = [open(p, encoding="utf-8", errors="replace").read() for p in paths]
sv = SOURCES[0]
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
done = tr.get("broadcast", {})

PLAYERS = [m.group(1) for src in SOURCES
           for m in re.finditer(r'\["playerName"\]\s*=\s*"([^"]+)"', src)]
PN = PLAYERS[0] if PLAYERS else None
print(f"імена гравців зі зборів: {PLAYERS}")

# блок db.broadcast — з КОЖНОГО збору окремо
def bcast_block(src):
    m = re.search(r'\["broadcast"\]\s*=\s*\{', src)
    if not m:
        return ""
    i, depth, start = m.end(), 1, m.end()
    instr = esc = False
    while i < len(src) and depth > 0:
        c = src[i]
        if instr:
            if esc: esc = False
            elif c == "\\": esc = True
            elif c == '"': instr = False
        else:
            if c == '"': instr = True
            elif c == "{": depth += 1
            elif c == "}": depth -= 1
        i += 1
    return src[start:i - 1]


block = "\n".join(bcast_block(src) for src in SOURCES)


def un(s):
    return (s.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r")
             .replace("\\t", "\t").replace("\\\\", "\\"))


# ["text"] = "speaker"  АБО  ["text"] = true
pairs = re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*(?:"((?:[^"\\]|\\.)*)"|true)', block)

NICK = nick_regex(min_len=4)
CYRIL = re.compile(r"[А-Яа-яЁёІіЇїЄєҐґЪъЫыЭэ]")
# «Нік-Реалм» у СЕРЕДИНІ речення. Широкий патерн «слово-Слово» тут не годиться:
# він зносить «Shado-Pan», «Half-Elf», «Blood-Soaked», «Non-Combat». Тому суфікс
# мусить бути СПРАВЖНІМ реалмом зі списку, зібраного по meta.realm усіх зборів
# і підписах супутників («X-TarrenMill's Pet»).
_REALMS = known_realms()
REALM_NAME = (re.compile(r"\b[A-Za-zÀ-ÿ'’]{3,}-(?:" +
                         "|".join(re.escape(r) for r in sorted(_REALMS, key=len, reverse=True))
                         + r")\b") if _REALMS else None)
import capfilter
from playernames import AMBIGUOUS
# Ім'я буває приклеєне до кольорового коду: «|cFFFF0000Chugayster|r». Між «0» і
# «C» межі слова немає, тож без альтернативи `(?<=|cXXXXXXXX)` таке ім'я не
# нормалізувалось і пройшло в чергу (рейдові попередження [Entomb], 13.09).
PLAYER_RX = [re.compile(r"(?:(?<=\|c[0-9A-Fa-f]{8})|(?<![\w'’]))" + re.escape(p) + r"(?![\w'’])")
             for p in dict.fromkeys(PLAYERS) if p and len(p) >= 4 and p not in AMBIGUOUS]

# Список відомих ніків неповний за визначенням — гравців тисячі. Тому другий,
# ДОКАЗОВИЙ відсів, той самий, що вже працює в _prep_uitt_wave.py: слово з
# великої літери, якого немає в ЖОДНОМУ імені істоти й немає як ключа в базі,
# — це чийсь нік, а не ігровий текст. Так спіймано «Killermachin» (у
# creatures.json його нема, тоді як сусідній «Lil Ki» — справжній улюбленець).
_crea = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
NPC_WORDS = set()
NPC_FULL = set()          # ПОВНІ імена істот — щоб упізнати мовця репліки
for _v in (_crea.values() if isinstance(_crea, dict) else _crea):
    _nm = _v.get("name") if isinstance(_v, dict) else None
    _en = _nm.get("en") if isinstance(_nm, dict) else None
    if _en:
        NPC_WORDS |= set(re.findall(r"[A-Za-z']{3,}", _en))
        NPC_FULL.add(_en)
# ТРЕТЄ джерело імен — NpcNames.lua (зібране в грі, англ. -> укр.). Датамайн
# дірявий: тут 7 399 слів, яких у creatures.json немає зовсім
# [[captured-creatures-source]], [[plates-need-en-from-captures]]. Без нього
# відсів вважав би гравцем будь-якого NPC, що не доїхав до датамайну, і тихо
# викидав би з черги живі репліки.
_npc_lua = DATA_DIR.parent / "addon" / "UALL_NpcNames" / "NpcNames.lua"
if _npc_lua.exists():
    _t = _npc_lua.read_text(encoding="utf-8", errors="replace")
    for _m in re.finditer(r'\["((?:[^"\\]|\\.)*)"\]', _t):
        NPC_WORDS |= set(re.findall(r"[A-Za-z']{3,}", _m.group(1)))
        NPC_FULL.add(_m.group(1))
_capf = DATA_DIR / "source" / "captured_creatures.json"
if _capf.exists():
    _cd = json.loads(_capf.read_text(encoding="utf-8-sig"))
    for _v in (_cd.values() if isinstance(_cd, dict) else _cd):
        _s = _v if isinstance(_v, str) else (
            (_v.get("en") or _v.get("name")) if isinstance(_v, dict) else None)
        if isinstance(_s, str):
            NPC_WORDS |= set(re.findall(r"[A-Za-z']{3,}", _s))
            NPC_FULL.add(_s)
BASE_WORDS = set()
for _sec, _d in tr.items():
    if isinstance(_d, dict):
        for _k in _d:
            if isinstance(_k, str):
                BASE_WORDS |= set(re.findall(r"[A-Za-z']{3,}", _k))
# `(?![A-Za-z])` наприкінці — щоб не відкусити половину складеної назви:
# без нього «Quel'Thalas» давало уламок «Quel'», якого в словнику немає,
# і цілий рядок хибно летів у відсів.
#
# ПОЧАТОК РЯДКА ТЕЖ ПЕРЕВІРЯЄМО. Спершу я його виключив, щоб не чіплятися
# до звичайних слів на початку речення, — і разом із цим осліп на цілу
# родину «Achello places a cozy…», «Antkin sets out a…», де нік стоїть
# найпершим словом. Хибних тривог це не додає: звичайні англійські слова
# є в BASE_WORDS, бо трапляються в тисячах ключів бази.
#
# Клас літер розширено на латиницю з діакритикою: ніки на кшталт «Àndersøn»,
# «Eselbär», «Diabølus» під [A-Za-z] не підпадали зовсім.
LAT_U = "A-ZÀ-ÞŁŠŽ"
LAT_L = "a-zà-ÿłšž'"
# Перегляд уперед мусить виключати і ВЕЛИКІ літери. Спершу я перелічив там
# лише малі — і уламки складених назв проходили як самостійні слова:
# «Anub'Arak» давало «Anub'», «Quel'Thalas» — «Quel'». Таких уламків у
# словнику немає, тож цілий рядок хибно летів у відсів як нік гравця.
MIDCAP = re.compile(rf"(?<![.!?\"']\s)\b([{LAT_U}][{LAT_L}]{{3,}})(?![{LAT_U}{LAT_L}’])")


def unknown_name(s):
    for w in MIDCAP.findall(s):
        # Ім'я персонажа гравця — лише літери, до 12 штук, без апострофа.
        # Слово з апострофом усередині («Phoe'be», «Snoopin'») чи довше за 12
        # («Nyyyunnngggg…») ніком бути не може, а відсів таких слів викидав
        # справжні репліки NPC. Присвійне «'s» спершу знімаємо: «Pyriel's» —
        # це нік «Pyriel» і далі перевіряється як нік.
        core = w[:-2] if w.endswith("'s") else w
        if "'" in core or len(core) > 12:
            continue
        if w not in NPC_WORDS and w not in BASE_WORDS:
            return w
    return None


emotes, todo, seen, strangers = [], [], set(), []
for en_raw, sp_raw in pairs:
    en = un(en_raw)
    sp = un(sp_raw) if sp_raw else ""
    if not en or not re.search(r"[A-Za-z]{3}", en):
        continue
    if en in done:
        continue
    # Нормалізувати ім'я гравця -> {NAME}. Замінюємо ВСІ імена партії, а не
    # лише перше: у збірці з двох тестерів ім'я другого інакше лишиться в
    # базі як є [[guild-names-never-translate]].
    # МЕЖІ СЛОВА й мінімальна довжина обов'язкові: голий replace з'їдає
    # середину слів. Та сама вада в зборі балачок дала 54 зіпсовані ключі —
    # персонаж «Rea» перетворив «Ready» на «{name}dy» [[capture-wave-playername-leaks]].
    en_norm = en
    for rx in PLAYER_RX:
        en_norm = rx.sub("{NAME}", en_norm)
    # ЧУЖІ ніки — не нормалізувати, а ВИКЛЮЧАТИ. Репліки в broadcast рясно
    # адресовані іншим гравцям («A treasure chest has spawned for X!»,
    # «Cut de heads off these snakes, X.»). Підставити туди {NAME} не можна:
    # звертаються не до читача. А лишити нік — це витік і мертвий для всіх,
    # крім однієї людини, ключ [[guild-names-never-translate]].
    # КИРИЛИЦЯ в англійському рядку = підставлений нік з кириличного реалму
    # («Виксэна places a cozy Silvermoon Parade…»). Латинські відсіви нижче
    # такого не бачать зовсім — саме так один рядок і проліз у попередню хвилю.
    if CYRIL.search(en_norm):
        strangers.append(("кирилиця в ключі", en_norm))
        continue
    # НЕАНГЛІЙСЬКИЙ КЛІЄНТ: ключ не зматчиться в англійського гравця ніколи.
    # До цього фільтра в базі вже лежало 23 перекладені німецькі репліки.
    if capfilter.is_foreign(en_norm):
        strangers.append(("текст неанглійського клієнта", en_norm))
        continue
    # ІМ'Я З РЕАЛМОМ («Alestercrowl-Nemesis has slain…»). Правило живе в
    # capfilter.RUNTIME, але преп реплік ніколи не кликав why_runtime, тож шість
    # оголошень Лев'ячої варти дійшли аж до агента, і той відсіяв їх руками
    # (14.10). Застосовуємо САМЕ ЦЕ правило, а не весь набір: там є «сума
    # грошей», а «Заплати мені 50 Gold!» — законна репліка NPC.
    if REALM_NAME and REALM_NAME.search(en_norm):
        strangers.append(("ім'я гравця з реалмом", en_norm))
        continue
    # ДВІЙНИК {NAME}: ім'я в гнізді, для якого в базі вже є токенізований
    # рядок. Ловить і ніки ВЕЛИКИМИ («RAPTOONU WAS TAGGED!»), яких регекс
    # ніків нижче не бачить: 13.09 таких у черзі було 115 із 138.
    _tw = capfilter.token_twin(en_norm, done, "{NAME}")
    if _tw:
        strangers.append((f"двійник {{NAME}}: «{_tw}»", en_norm))
        continue
    if NICK.search(en_norm):
        strangers.append(("відомий нік", en_norm))
        continue
    # НЕЗНАЙОМЕ СЛОВО З ВЕЛИКОЇ — підозра на нік, але лише там, де репліку
    # нема кому приписати. Якщо мовець — ВІДОМИЙ NPC, незнайоме слово в його
    # репліці це лор, а не гравець: оповідач вигадує персонажів своєї казки.
    # 07.10 правило без цієї поправки викинуло з черги «Mattyiuk watched how
    # others fished…» Старійшини Поа, лишивши сусіднє речення тієї самої
    # оповідки, а заразом — рядки з Arygos, Furlbrows, Barleybrews і навіть
    # зоною Maldraxxus's. Нік-фільтри вище (відомий нік, двійник {NAME},
    # кирилиця) працюють як працювали, тож витік це не відкриває.
    _u = unknown_name(en_norm)
    if _u and not (sp and sp in NPC_FULL):
        strangers.append((f"невідоме ім'я «{_u}»", en_norm))
        continue
    # %-шаблони відкладаємо ЛИШЕ ПІСЛЯ нормалізації й відсіву ніків. Раніше
    # їх відкладали одразу, і в чергу пройшли рейдові попередження з ніками
    # цілей: «%s is preparing to [Entomb] Shidoari!» [[guild-names-never-translate]].
    if "%" in en_norm:                  # емоут/системний шаблон -> окремо
        if en_norm not in done and en_norm not in emotes:
            emotes.append(en_norm)
        continue
    if en_norm in seen or en_norm in done:
        continue
    seen.add(en_norm)
    todo.append({"en": en_norm, "speaker": sp})

todo.sort(key=lambda x: x["en"].lower())
OUT = DATA_DIR / "batches" / "broadcast"
OUT.mkdir(parents=True, exist_ok=True)
for f in OUT.glob("*.json"):
    f.unlink()
B = 48
nb = (len(todo) + B - 1) // B
for k in range(nb):
    (OUT / f"bc_{k:02d}.json").write_text(
        json.dumps(todo[k * B:(k + 1) * B], ensure_ascii=False, indent=1), encoding="utf-8")

json.dump(sorted(set(emotes)), open(DATA_DIR / "batches" / "broadcast_emotes.json", "w",
          encoding="utf-8"), ensure_ascii=False, indent=1)

withname = sum(1 for t in todo if "{NAME}" in t["en"])
print(f"до перекладу: {len(todo)} | батчів по {B}: {nb} | з {{NAME}}: {withname}")
print(f"%-емоут-шаблонів (окремо, не в хвилі): {len(emotes)}")
print(f"виключено через чужі ніки: {len(strangers)}")
import collections as _c
print("   за причинами:", dict(_c.Counter(r for r, _ in strangers)))
for r, x in strangers[:6]:
    print(f"    [{r}] {x[:58]}")
