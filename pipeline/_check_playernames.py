# -*- coding: utf-8 -*-
"""Запобіжник: жоден РЕЛІЗ-рядок не повинен містити нік гравця (мав би бути {NAME}).
Збирає відомі ніки з meta.playerName усіх тестерських/SV-файлів + базовий список,
сканує translations.json (+ Broadcast.lua) на латинський нік у значеннях.
Друкує порушників; код виходу 1, якщо знайдено."""
import sys, re, json, glob
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from playernames import known_nicks

ROOT = DATA_DIR.parent
# 1) відомі ніки — з playernames.py (єдине джерело: базовий список + усі
#    meta.playerName зі зборів та живих SavedVariables)
names = known_nicks(min_len=2, drop_ambiguous=False)
print("Відомі ніки:", sorted(names))
# ніки, що збігаються з ІГРОВИМИ словами (перс. названо як трава Mageroyal) —
# у ключах/текстах це легітимний контент, не витік; сканувати їх = суцільний шум
# Список неоднозначних беремо зі СПІЛЬНОГО модуля, а не тримаємо свій.
# Тут лежала власна копія {Mageroyal, Rea} — і поповнення playernames.AMBIGUOUS
# до цього гейта не доїжджало: він далі лаявся на «Whoops! Don't worry…»,
# бо хтось із гравців зветься Whoops. Саме проти такої розсинхронізації
# списків і писався playernames.py.
from playernames import AMBIGUOUS, strong_nicks
names -= AMBIGUOUS
# ДВА РІВНІ ДОВІРИ. Усередині речень шукаємо лише НАДІЙНІ ніки (ручний список
# + meta.playerName наших тестерів). Зібрані за суфіксом реалму — тисячі, і
# серед них неминуче є слова ігрового тексту: «Darksting Cave», «High Stakes»,
# «Brandolf», «Poke ya head». Їх шукаємо тільки там, де формат сам доводить:
# ключ ДОРІВНЮЄ імені (плашка наведення) або має суфікс реалму.
# Витоки посеред речення при цьому не губляться — їх ловить правило-двійник
# {NAME} нижче, якому список узагалі не потрібен.
STRONG = strong_nicks(min_len=2, drop_ambiguous=True)
HARVESTED = names - STRONG
STRONG_RX = re.compile(r"(?<![\w'’])(" + "|".join(re.escape(n) for n in sorted(STRONG))
                       + r")(?![\w'’])") if STRONG else re.compile(r"(?!x)x")
# ОДИН регекс-чергування, а не по одному на нік. Раніше тут будувався окремий
# патерн на кожне ім'я, і кожен проганявся по КОЖНОМУ рядку бази: при 62 ніках
# це терпіли, але щойно збір за суфіксом реалму підняв список до ~1700, гейт
# перестав добігати за дві хвилини. Автомат зі спільним чергуванням робить
# один прохід, а саме ім'я дістаємо з групи збігу.
# Межа слова врахована з АПОСТРОФОМ. Голий \b його межею вважає, тож нік
# «Kob» давав збіг усередині «Kob'rok» — справжньої істоти, і гейт валився
# на власному шумі.
# Голе зібране ім'я має вагу ЛИШЕ там, куди воно фізично може потрапити:
# гравець навів курсор на іншого гравця — і підказка показала саме ім'я.
# У секціях із датамайну голе слово має інше походження: «Cryptmaker» —
# зброя, «Brandolf» — гілка завдань [[sv-bucket-vs-section-key]].
HOVER = ("uiTooltips", "subnames", "npcNames")


def ALL_search(s, path=""):
    """Надійний нік — будь-де; зібраний — лише як ГОЛЕ ім'я у hover-секції."""
    m = STRONG_RX.search(s)
    if m:
        return m
    if s.strip() in HARVESTED and any(h in path for h in HOVER):
        return re.match(r".*", s.strip())
    return None


class _ALL:
    search = staticmethod(ALL_search)


ALL = _ALL

# 2) сканувати translations.json значення
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
hits = []


def walk(o, path=""):
    if isinstance(o, dict):
        for k, v in o.items():
            # КЛЮЧІ теж: EN-ключ із ніком = ненормалізована капча (118 таких
            # пропустили, коли сканували лише значення — <нік>/Pekelnyj у gossip)
            if isinstance(k, str):
                m = ALL.search(k, path)
                if m:
                    hits.append((f"{path}/[KEY]", m.group(0)[:40], k))
            walk(v, f"{path}/{k}")
    elif isinstance(o, list):
        for v in o:
            walk(v, path)
    elif isinstance(o, str):
        m = ALL.search(o, path)
        if m:
            hits.append((path, m.group(0)[:40], o))


walk(tr)

# 2b) {name}-ВИТІК: у НЕ-наративних бакетах {name} = підставлене ім'я гравця
#     (як «Pekelnyj»→«{name}»). Наративні (квести/балачки) мають {name} законно.
NARRATIVE = {"quests", "broadcast", "gossip", "playerChoice", "descTemplates",
             "journalSections", "journal", "bossAbilities", "spells", "mail",
             "renown", "books", "bookTexts", "itemFlavors", "achievements"}
# 2c) realm-суфікс у КЛЮЧІ = ім'я гравця/гільдії (Name-Realm)
REALM_RX = re.compile(r"-(Draenor|Kazzak|Outland|Silvermoon|Ravencrest|Stormscale|"
                      r"Sylvanas|Blackrock|Frostmane|Tarren Mill|Twisting Nether|"
                      r"Argent Dawn|Kil'jaeden|Area 52|Stormrage|Illidan)$")
for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    for k, v in d.items():
        if sec not in NARRATIVE and isinstance(v, str) and "{name}" in v:
            hits.append((f"/{sec}/{k}", "{name}-витік", v))
        if isinstance(k, str) and REALM_RX.search(k):
            hits.append((f"/{sec}/{k}", "realm-суфікс", str(v)))

# 3) Broadcast.lua: і КЛЮЧІ, і значення
bc = (ROOT / "addon" / "UALL" / "Database" / "Broadcast.lua").read_text(encoding="utf-8")
for m in re.finditer(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', bc):
    for side, s in (("key", m.group(1)), ("val", m.group(2))):
        mm = ALL.search(s, "Broadcast")
        if mm:
            hits.append((f"Broadcast.lua[{side}]", mm.group(0)[:40], s))

# 4) ЧУЖІ ніки — яких у списку немає й бути не може.
# Список ніків збирається з meta.playerName наших тестерів, тож проти
# сторонніх гравців він сліпий за побудовою. А транслітерований нік
# («Hananami» -> «Гананамі») не бачить і латинський пошук вище.
# Доказ, що не потребує списку: ОДИН І ТОЙ САМИЙ хвіст речення з РІЗНИМИ
# першими словами — це серверна підстановка «%s …», а не власна назва.
# Так знайдено 34 записи toy-broadcast із ніками 24 сторонніх гравців.
# Поріг довжини хвоста відсікає шум на кшталт «Kill them!»/«Follow me.»,
# де спільне закінчення — випадковість звичайних речень.
TAIL_MIN = 25
LEADER = re.compile(r"^([A-ZÀ-Þ][\w'À-ɏ]{2,})\s+(.+)$", re.S)
# Займенник на початку двох різних речень дає той самий хвіст («Her screams
# were…» / «Its screams were…») — це граматика, а не підстановка імені.
STOP = {"The", "This", "That", "These", "Those", "Her", "His", "Its", "Their",
        "Our", "Your", "They", "She", "You", "We", "It", "And", "But", "For",
        "All", "Not", "Now", "How", "What", "When", "Where", "Who", "Why",
        "One", "Two", "Some", "Any", "Many", "Every", "Each", "There", "Here"}
try:
    _cr = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
    _npc = set()
    for _v in (_cr.values() if isinstance(_cr, dict) else _cr):
        _n = _v.get("name") if isinstance(_v, dict) else None
        _e = _n.get("en") if isinstance(_n, dict) else None
        if _e:
            _npc |= set(re.findall(r"[A-Za-z']{3,}", _e))
except OSError:
    _npc = None

if _npc:
    from collections import defaultdict
    for _sec in ("broadcast", "gossip", "system", "emotes"):
        _d = tr.get(_sec)
        if not isinstance(_d, dict):
            continue
        _tails = defaultdict(set)
        for _k in _d:
            if not isinstance(_k, str) or "%" in _k:
                continue
            _m = LEADER.match(_k)
            if _m and len(_m.group(2)) >= TAIL_MIN and _m.group(1) not in STOP:
                _tails[_m.group(2).strip()].add(_m.group(1))
        for _tail, _who in _tails.items():
            if len(_who) < 2 or any(w in _npc for w in _who):
                continue
            hits.append((f"/{_sec}", "підстановка %s",
                         f"«…{_tail[:60]}» з іменами: {', '.join(sorted(_who))[:70]}"))

# 5) ДВІЙНИК ІЗ ТОКЕНОМ — найсильніший доказ, бо не потребує ні списку, ні
# позиції в реченні. Якщо та сама фраза існує і з «{NAME}», і з буквальним
# словом на тому самому місці, то гніздо змінне, а слово в ньому — підставлене
# ім'я гравця. Правило (4) вище дивиться лише на ПЕРШЕ слово й тому пропускало
# «A treasure chest has spawned for Kaisertabell!» та звертання посеред речення
# («Дякую, Барбері»). Знято 50 таких.
if _npc:
    MIN_CTX = 30
    SLOT = re.compile(r"\{NAME\}|\{name\}|\b([A-ZÀ-Þ][\w'’À-ɏ]{2,})\b")
    for _sec in ("broadcast", "gossip", "system", "emotes", "uiTooltips",
                 "playerChoice"):
        _d = tr.get(_sec)
        if not isinstance(_d, dict):
            continue
        _sk = defaultdict(dict)
        for _k in _d:
            if not isinstance(_k, str):
                continue
            for _m in SLOT.finditer(_k):
                _s = _k[:_m.start()] + "\x01" + _k[_m.end():]
                if len(_s) - 1 >= MIN_CTX:
                    _sk[_s][_m.group(0)] = _k
        for _s, _f in _sk.items():
            if not any(x.startswith("{") for x in _f):
                continue
            for _w, _key in _f.items():
                if _w.startswith("{") or _w in _npc:
                    continue
                hits.append((f"/{_sec}", "двійник {NAME}",
                             f"«{_w}» у {_key[:60]}"))

# 6) КИРИЛИЦЯ В КЛЮЧІ. Англійський ігровий текст її не містить ніколи, тож
# вона прийшла з підстановки: або нік із кириличного реалму («…acquired by
# Дрелис!»), або петля збору — наш власний вивід, прочитаний назад і записаний
# як «новий англійський рядок» («Прощавай» -> «Прощавай»). Латинські правила
# вище сліпі на обидва випадки.
CYRIL = re.compile(r"[А-Яа-яЁёІіЇїЄєҐґЪъЫыЭэ]")
for _sec, _d in tr.items():
    if not isinstance(_d, dict):
        continue
    for _k in _d:
        if isinstance(_k, str) and CYRIL.search(_k):
            hits.append((f"/{_sec}", "кирилиця в ключі", _k[:70]))

if hits:
    print(f"\n⚠️ ЗНАЙДЕНО {len(hits)} рядків із ніком гравця (мало б бути {{NAME}}):")
    for path, n, s in hits[:40]:
        print(f"  [{path}] нік «{n}»: {s[:80]!r}")
    sys.exit(1)
print("\n✅ Ніків гравця в реліз-рядках не знайдено.")
