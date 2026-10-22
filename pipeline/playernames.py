# -*- coding: utf-8 -*-
"""ЄДИНЕ джерело ніків гравців для всього пайплайну.

Досі той самий список лежав окремо в _check_playernames.py,
_fix_broadcast_playernames.py і (частково) в _prep_tester_wave.py. Списки
розсинхронізовувалися: гейт лаявся на нік, якого фіксер не бачив, а препроцесор
не токенізував жодного, крім playerName поточного файлу — через що та сама
репліка приходила в чергу вп'яте з іншим іменем.

Використання:
    from playernames import known_nicks, nick_regex, tokenize
    rx = nick_regex()
    key = tokenize(text, "{NAME}")      # broadcast; для ґосипу — "{name}"
"""
import glob
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

# Альти, підтверджені за контекстом: у капчах фігурують ЛИШЕ як звертання NPC до
# гравця, мають {name}-двійника в базі і не мають NPC-якоря (без de/fr у
# creatures.json). У meta.playerName їх немає, бо персонаж не був залогінений.
# ІМЕНА ЖИВИХ ГРАВЦІВ У КОДІ НЕ ТРИМАЄМО. Це альти тестерів, яких автозбір не
# бачить: у капчах вони фігурують лише як звертання NPC на ім'я, бо персонаж не
# був залогінений і в meta.playerName його немає. Список суто локальний — у
# кожного власника проєкту він свій, і публікувати чужі імена персонажів не
# можна так само, як не можна перекладати їх [[guild-names-never-translate]].
#
# Файл data/playernames.local.json (у .gitignore) має вигляд ["Нік", ...].
# Якщо його немає — працюємо з порожнім списком: автозбір із зборів однаково
# дає основну масу ніків.
def _load_base():
    p = ROOT / "data" / "playernames.local.json"
    try:
        got = json.loads(p.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return set()
    return {n for n in got if isinstance(n, str) and n}


BASE = _load_base()

# Ніки, що збігаються з ІГРОВИМИ словами (персонажа названо як траву Mageroyal).
# У ключах і текстах це легітимний контент, а не витік: сканувати їх = суцільний
# шум, а замінювати — знищити дані.
AMBIGUOUS = {
    "Mageroyal", "Rea",
    # 12.09: збір за суфіксом реалму підняв список до тисяч, і збіги з
    # ігровим текстом стали неминучі. Ці слова гейт позначав як витік, хоча
    # вони — законний вміст. Доводити «за відсутністю в creatures.json» не
    # можна: наш датамайн дірявий (у ньому немає навіть «Clive DelGizmo» —
    # справжнього ґнома з Мехагона) [[verify-names-by-id-anchor]].
    "Whoops",        # вигук, не ім'я: «Whoops! Don't worry…»
    "Surian",        # лор-термін: «the Surian theory» поряд з «Y'serian»
    "Torga",         # лоа-черепаха з Вол'дуну, є в creatures.json
    "Maeryl",        # NPC Голловфолу
    "Clive", "DelGizmo",   # Clive DelGizmo, Мехагон
    "Poke",          # «Poke ya head outcha shell» — звичайне дієслово
    "Inked",         # риса послідовника гарнізону
    "Yaeger",        # вігнетка «Yaeger-367», службова назва
    "Darksting",     # печера Darksting Cave, Дренор
}

SV_GLOBS = [
    str(ROOT / "testerlua" / "*.lua"),
    r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/UALL.lua",
    r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua",
]

_PLAYERNAME = re.compile(r'\["playerName"\]\s*=\s*"([^"]+)"')
# діакритика теж: Vâ, Elúnare, Rüpaage — реальні ніки з емоут-витоків
_VALID = re.compile(r"[A-Za-zÀ-ÿ]{2,}")

_cache = None
_realms_cache = None


def known_realms():
    """Реалми, БАЧЕНІ В СИСТЕМНИХ РЯДКАХ («Ім'я-Реалм has left…»).

    Раніше кожен споживач виводив реалми сам, правилом «X-Y, де X — відомий
    нік». Поки ніків було шістдесят, це трималося; щойно збір підняв список
    до тисяч, «реалмами» ставали звичайні слова — Cho, Thrall, Arathi, Blade,
    і гейт гільдій починав бачити витік у «Void-Blade Zedaat» та «Th--Thrall».
    Тут набір береться лише з системного контексту, де дефіс справді розділяє
    ім'я і реалм.
    """
    if _realms_cache is None:
        known_nicks()          # наповнює обидва кеші
    return set(_realms_cache or ())


# СУФІКС РЕАЛМУ — доказ, що не потребує списку. Гра пише чужого гравця як
# «Ім'я-Реалм» («<нік>-AzjolNerub has left the instance group»), і саме так
# у збори потрапляють сторонні люди, яких у meta.playerName немає й бути не
# може. Реалми виводимо завантажувально: беремо «X-Y» там, де X — уже відомий
# нік, отже Y напевно реалм; далі цим набором реалмів витягуємо решту імен.
# Той самий метод уже працював усередині _fix_broadcast_playernames.py — тут
# він спільний, бо інакше гейт знав менше за фіксер.
# Апостроф у назві реалму ОБОВ'ЯЗКОВО дозволяємо. Без цього «Drak'thul»
# обрізався до «Drak», «Blade'sEdge» — до «Blade», «Cho'gall» — до «Cho», і
# ці уламки потім матчилися в живому тексті: «Void-Blade Zedaat»,
# «Gai-Cho Cauterizer».
_PAIR = re.compile(r"\b([A-Za-zÀ-ÿ'’]{3,})-([A-Z][A-Za-z'’]{2,}(?:\([^)]+\))?)\b")
_REALM_SEED = {"Aggra(Português)"}
# Маркери системних рядків, де «Ім'я-Реалм» — напевно ГРАВЕЦЬ, а не гільдія.
# Перевіряємо дешевим `in` по рядках, а не одним великим регексом: спроба
# описати це патерном з [^"]* дала вкладені квантифікатори, і на
# багатомегабайтних дампах збір не добігав до кінця взагалі.
# Плашка юніта зі зборів: «nameFS |Ім'я-Реалм|». Назви гільдій сюди не
# потрапляють (це ім'я юніта), тож суфікс-реалм однозначно вказує на гравця.
_NAMEPLATE = re.compile(r"nameFS \|([A-Za-zÀ-ÿ'’]{3,})-([A-Z][A-Za-z'’]{2,})\|")

# НАЙСИЛЬНІШИЙ доказ: гіперпосилання «|Hplayer:Ім'я|h» або «|Hplayer:Ім'я-Реалм|h».
# Такий лінк гра будує ВИКЛЮЧНО для гравця (клік відкриває меню гравця), тож тут
# ні реалму, ні контексту не потрібно. 18.10 агент довів саме так, що мовці
# <нік> і <нік> — люди, а не NPC; збирач цього джерела не знав, хоча в
# зборах таких посилань 252.
_PLAYERLINK = re.compile(r"\|Hplayer:([A-Za-zÀ-ÿ'’]{3,})(?:-[A-Za-z'’]+)?[|:]")

_SYSMARK = ("has left", "has joined", "has come online", "has gone offline",
            "joins the", "leaves the")
# Той самий системний рядок, але з ГОЛИМ іменем (гравець зі свого реалму):
# ключ збору цілком — «["Ім'я has joined the raid group."] = true». Одне слово
# 4–12 літер (межі імені персонажа), опційно |W…|w і «(Horde)». Без
# вкладених квантифікаторів — рядок перевіряється лише після дешевого `in`.
_BARE_SYS = re.compile(
    r'^\s*\["(?:\|W)?([A-ZÀ-Þ][a-zà-ÿ]{3,11})(?: \((?:Horde|Alliance)\))?(?:\|w)? '
    r"(?:has joined|has left|joins the|leaves the|has come online|has gone offline)")

_gw_cache = None


def _game_words():
    """Слова ігрового тексту: імена істот + усі слова англійських ключів бази.

    Служить заслоном для збору за суфіксом реалму. Читається один раз.
    """
    global _gw_cache
    if _gw_cache is not None:
        return _gw_cache
    import json
    words = set()
    try:
        cr = json.loads((ROOT / "data" / "source" / "creatures.json")
                        .read_text(encoding="utf-8-sig"))
        for v in (cr.values() if isinstance(cr, dict) else cr):
            nm = v.get("name") if isinstance(v, dict) else None
            en = nm.get("en") if isinstance(nm, dict) else None
            if en:
                words |= set(re.findall(r"[A-Za-z']{3,}", en))
    except (OSError, ValueError):
        pass
    try:
        txt = (ROOT / "addon" / "UALL_NpcNames" / "NpcNames.lua").read_text(
            encoding="utf-8", errors="replace")
        for m in re.finditer(r'\["((?:[^"\\]|\\.)*)"\]', txt):
            words |= set(re.findall(r"[A-Za-z']{3,}", m.group(1)))
    except OSError:
        pass
    try:
        # КЛЮЧІ БАЗИ — з ПОРОГОМ ЧАСТОТИ, а не суцільно. Інакше вийде коло:
        # нік, що вже протік у базу, сам себе оголошує «ігровим словом» і
        # більше ніколи не ловиться. Саме так «<нік>» лишався невидимим —
        # його захищав єдиний рядок «You're the best, <нік>!», який і є
        # витоком. Справжнє ігрове слово трапляється в багатьох ключах,
        # підставлене ім'я — в одному-двох.
        from collections import Counter as _C
        seen = _C()
        tr = json.loads((ROOT / "data" / "translations.json")
                        .read_text(encoding="utf-8-sig"))
        for d in tr.values():
            if isinstance(d, dict):
                for k in d:
                    if isinstance(k, str):
                        seen.update(set(re.findall(r"[A-Za-z']{3,}", k)))
        MIN_KEYS = 3
        words |= {w for w, n in seen.items() if n >= MIN_KEYS}
    except (OSError, ValueError):
        pass
    _gw_cache = words
    return words


def known_realms():
    """Назви реалмів зі зборів — щоб упізнавати «Нік-Реалм» У СЕРЕДИНІ речення.

    Шукати просто «слово-Слово» в репліках не можна: так відсіюються «Shado-Pan»,
    «Half-Elf», «Blood-Soaked», «Non-Combat» (перевірено 14.10). Тому суфікс
    мусить бути РЕАЛМОМ, а реалми ми знаємо з двох надійних джерел:
      • meta.realm кожного збору;
      • підписи супутників чужих гравців («X-TarrenMill's Pet») — там після
        дефіса стоїть гарантовано реалм.
    """
    import glob
    realms = set()
    for p in glob.glob(str(ROOT / "testerlua" / "*.lua")) + glob.glob(
            r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/UALL.lua"):
        try:
            src = open(p, encoding="utf-8", errors="replace").read()
        except OSError:
            continue
        m = re.search(r'\["realm"\]\s*=\s*"([^"]+)"', src)
        if m:
            realms.add(m.group(1).replace(" ", ""))
        for mm in re.finditer(
                r'-([A-Z][A-Za-z\'’]{2,})\'s (?:Pet|Minion|Guardian|Companion|Totem)', src):
            realms.add(mm.group(1))
    return {r for r in realms if len(r) >= 4}


def strong_nicks(min_len=2, drop_ambiguous=True):
    """ЛИШЕ надійні ніки: ручний BASE + meta.playerName зі зборів.

    Навіщо окремо. Збір за суфіксом реалму дає тисячі імен, і серед них
    неминуче трапляються слова ігрового тексту: «Darksting» (печера Дренору),
    «High Stakes» (опція барбершопа), «Brandolf» (гілка завдань), «Poke»,
    «Whoops». Шукати ВЕСЬ цей список усередині речень — приректи гейт на
    нескінченний потік фальшивок і перелік винятків, що ніколи не зійдеться.

    Тому поділ за роллю: надійні ніки шукаємо будь-де в тексті, зібрані —
    лише там, де формат сам доводить (голе ім'я або «Ім'я-Реалм»). Витоки
    посеред речення ловить правило-двійник {NAME}, якому список не потрібен.
    """
    names = set(BASE)
    for g in SV_GLOBS:
        for f in glob.glob(g):
            try:
                txt = open(f, encoding="utf-8", errors="replace").read()
            except OSError:
                continue
            for m in _PLAYERNAME.finditer(txt):
                nm = m.group(1).strip()
                if nm and _VALID.fullmatch(nm):
                    names.add(nm)
    # Лінк |Hplayer: — такий самий ранг доказу, як meta.playerName, тож ці
    # ніки теж шукаємо БУДЬ-ДЕ в тексті. Без цього витік посеред речення
    # лишався невидимим: «Hey, <нік>! Message for you from Grand Master
    # Hight!» гейт не бачив, бо зібрані ніки звіряються лише з голим іменем.
    names |= player_link_nicks(min_len=4)
    if drop_ambiguous:
        names -= AMBIGUOUS
    return {n for n in names if len(n) >= min_len}


_src_cache = {}
# Джерела, засвідчені самою грою. Ключі бази сюди НЕ входять — саме в них і
# лежить витік, який ми шукаємо.
_SRC_FILES = ("creatures.json", "api_creatures_full.json", "captured_creatures.json",
              "_midnight_creatures.json", "items.json", "gameobjects.json",
              "quests.json", "globalstrings.json", "api_titles.json")


def attested_in_sources(words):
    """Які з цих слів засвідчені ІГРОВИМ ДЖЕРЕЛОМ, а не ключем бази.

    Потрібно для найсильнішого доказу — лінка «|Hplayer:Ім'я-Реалм|h»: таке
    посилання гра будує лише для справжнього гравця. Частотний поріг
    _game_words() на цьому доказі ламається, бо шаблон множить той самий
    витік: нік «<нік>» протік у п'ять ключів ОДНОГО рядка
    («<нік> activated an Unstable Nether Portal in …») — по одному на
    зону, перетнув MIN_KEYS=3 і сам себе оголосив ігровим словом.

    Тому для таких імен питаємо дані гри напряму. 18.10 із шести спірних
    Battleborne знайшлося в items.json («Battleborne Sentinel Gauntlets») —
    слово гри; <нік>, <нік>, <нік>, <нік>, <нік> не
    трапляються в жодному джерелі — усі п'ять витоки [[guild-names-never-translate]].
    """
    words = {w for w in words if w}
    key = frozenset(words)
    if key in _src_cache:
        return _src_cache[key]
    found = set()
    if words:
        rx = re.compile(r"\b(" + "|".join(re.escape(w) for w in
                                          sorted(words, key=len, reverse=True)) + r")\b")
        for nm in _SRC_FILES:
            p = ROOT / "data" / "source" / nm
            if not p.exists() or found == words:
                continue
            try:
                with open(p, encoding="utf-8", errors="replace") as fh:
                    for chunk in iter(lambda: fh.read(1 << 22), ""):
                        found |= set(rx.findall(chunk))
                        if found == words:
                            break
            except OSError:
                continue
    _src_cache[key] = found
    return found


def player_link_nicks(min_len=4):
    """Ніки, доведені лінком |Hplayer:…|h — доказ сильніший за суфікс реалму.

    Відсіюємо лише ті, що є в ІГРОВИХ ДЖЕРЕЛАХ (див. attested_in_sources):
    гравець може взяти собі за нік справжнє слово гри, і тоді заміна на
    {NAME} вирізала б його з живого тексту.
    """
    links = set()
    for g in SV_GLOBS:
        for f in glob.glob(g):
            try:
                txt = open(f, encoding="utf-8", errors="replace").read()
            except OSError:
                continue
            for a in _PLAYERLINK.findall(txt):
                if len(a) >= min_len and _VALID.fullmatch(a):
                    links.add(a)
    return links - attested_in_sources(links)


def known_nicks(min_len=2, drop_ambiguous=True):
    """Базовий список + meta.playerName + імена з суфіксом реалму зі зборів."""
    global _cache
    if _cache is None:
        names = set(BASE)
        texts = []
        for g in SV_GLOBS:
            for f in glob.glob(g):
                try:
                    # читаємо файл ЦІЛКОМ: у частині зборів meta.playerName
                    # лежить у кінці, обрізання перших сотень КБ губило нік
                    txt = open(f, encoding="utf-8", errors="replace").read()
                except OSError:
                    continue
                texts.append(txt)
                for m in _PLAYERNAME.finditer(txt):
                    nm = m.group(1).strip()
                    if nm and _VALID.fullmatch(nm):
                        names.add(nm)
        realms = set(_REALM_SEED)
        pairs = [(a, b) for t in texts for a, b in _PAIR.findall(t)]
        for a, b in pairs:
            if a in names:
                realms.add(b)
        # Сирий збір «будь-яке Слово-Реалм» надто брудний: у той самий формат
        # гра пише НАЗВИ ГІЛЬДІЙ, тож у список лізли Ukraine, Police,
        # Gravediggers, Drinkers, а разом з ними уламки кольорових кодів
        # (cffffffff<нік>) і сотні імен із приліпленою літерою «W».
        # Список іде не лише в гейт, а й у фіксер, що ЗАМІНЮЄ знайдене, — тому
        # беремо пару лише з системного рядка про вхід/вихід гравця, де
        # «Ім'я-Реалм» за побудовою є саме гравцем.
        harvested = set()
        for t in texts:
            for line in t.splitlines():
                if not any(mark in line for mark in _SYSMARK):
                    continue
                # Списку реалмів тут НЕ вимагаємо: у рядку «…has left the
                # instance group» формат «Ім'я-Реалм» може належати лише
                # гравцеві, тож контекст і є доказом. Вимога «реалм має бути
                # відомий» лише шкодила: реалм з апострофом (Drak'thul)
                # обрізався до «Drak», не потрапляв у набір — і справжній нік
                # <нік> тихо губився.
                # Мінімум 4 літери. Коротке зібране ім'я нищить гейт: гравець
                # «Kob» дав збіг усередині «Kob'rok» — справжньої істоти, бо
                # для регекса апостроф є межею слова. Та сама причина, через
                # яку tokenize() давно тримає min_len=4.
                for a, b in _PAIR.findall(line):
                    if len(a) >= 4 and _VALID.fullmatch(a):
                        harvested.add(a)
                        realms.add(b)
                # Гравець із ТОГО Ж реалму пишеться БЕЗ суфікса: «<нік> has
                # joined the raid group.» Без цього правила його нік не потрапляв
                # у список, і 13.09 рядок «Brann! <нік> just activated…»
                # пройшов у чергу реплік (нік після «!» не бачить і відсів
                # «невідоме ім'я»). Ігрові слова (NPC-супутники «Brann joins the
                # party») знімає заслін _game_words нижче.
                m = _BARE_SYS.match(line)
                if m and _VALID.fullmatch(m.group(1)):
                    harvested.add(m.group(1))
        # ПЛАШКА З РЕАЛМОМ — «nameFS |<нік>-Deathwing|». Це ім'я ЮНІТА, тож
        # назви гільдій сюди не потрапляють (на відміну від сирого «Слово-Реалм»
        # у довільному тексті), а суфікс-реалм доводить, що юніт — гравець із
        # іншого світу. 18.10 агент довів саме так, що <нік>/<нік>/<нік> —
        # гравці, хоча автозбір їх не бачив: системних рядків про вхід у групу
        # для них у зборах немає. Вимагаємо ВІДОМИЙ реалм, щоб не чіпати
        # складені імена NPC.
        for t in texts:
            for a, b in _NAMEPLATE.findall(t):
                if len(a) >= 4 and _VALID.fullmatch(a) and b in realms:
                    harvested.add(a)
            for a in _PLAYERLINK.findall(t):
                if len(a) >= 4 and _VALID.fullmatch(a):
                    harvested.add(a)
        # ЗАСЛІН. Формат «Ім'я-Реалм» мають не лише гравці, а й ГІЛЬДІЇ, тож
        # сирий збір затягує звичайні слова: Alliance, Chaos, Crusade, Nexus,
        # Serenity, Dragons. А цей список іде не лише в гейт, а й у ФІКСЕР,
        # який замінює знайдене на {NAME} — тобто такі слова було б вирізано
        # з живого тексту. Тому зібране ім'я приймаємо, лише якщо воно НЕ є
        # ігровим словом. Це узагальнення того, що доти трималося вручну
        # списком AMBIGUOUS (Mageroyal, Rea).
        gw = _game_words()
        harvested -= gw
        names |= harvested
        _cache = names
        # Заслін ігрових слів потрібен і РЕАЛМАМ. Системний рядок може містити
        # дефісне ім'я істоти («Crenna Earth-Daughter»), і тоді «Daughter»
        # ставав «реалмом», а гейт бачив витік у кожній згадці цього NPC.
        global _realms_cache
        _realms_cache = {r for r in realms if r not in gw}
    out = set(_cache)
    if drop_ambiguous:
        out -= AMBIGUOUS
    return {n for n in out if len(n) >= min_len}


def nick_regex(min_len=2, drop_ambiguous=True):
    names = known_nicks(min_len, drop_ambiguous)
    if not names:
        return re.compile(r"(?!x)x")  # нічого не матчить
    # Нік, приклеєний до кольорового коду («|cFFFF0000Nick|r»), межі слова ліворуч
    # не має — тому окрема альтернатива після `|cXXXXXXXX`.
    return re.compile(r"(?:(?<=\|c[0-9A-Fa-f]{8})|\b)("
                      + "|".join(re.escape(n) for n in sorted(names)) + r")\b")


def tokenize(text, token="{NAME}", rx=None, min_len=4):
    """Замінити запечений нік на токен.

    min_len=4 за замовчуванням: коротші ніки («Up», «Rea») надто часто
    збігаються зі звичайними словами, і сліпа заміна псує текст.
    Хук нормалізує ім'я ВЛАСНОГО персонажа на токен ПЕРЕД пошуком, тож
    токенізований ключ спрацює в кожного гравця, а не лише в того, чиє
    ім'я випадково потрапило в збір.
    """
    rx = rx or nick_regex(min_len=min_len)
    return rx.sub(token, text)
