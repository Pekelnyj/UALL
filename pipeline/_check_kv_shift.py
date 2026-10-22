# -*- coding: utf-8 -*-
"""Гейт: підміна значення — переклад стоїть під ЧУЖИМ ключем.

Хвиля перекладу віддає файл {англ: укр}. Якщо агент зіб'ється й припише
готові українські тіла ключам-сусідам по абетці, `_merge_uitt_wave.py`
запише це мовчки: він зливає за ключем і не має чим відрізнити чужу пару
від своєї. 26.08.2026 так було зіпсовано 8 записів у uiTooltips — під
«Warlock - Demonology» лежало тіло підказки іграшки «Wyrmhole Generator»,
і в грі замість спеціалізації показувало «Генератор вирмодір: Драконові
Острови». Двохрядкове значення ще й затуляло сусідній рядок.

Два докази, обидва не покладаються на здогад:

  [A] ОДНЕ значення під кількома ключами, з яких один багаторядковий, а
      другий ні. Структурно різні ключі не можуть мати однакове тіло —
      багаторядковий і є правильним, решта чужі.

  [B] НЕСПІВМІРНА ДОВЖИНА. Ключ у цих секціях — це і є англійський
      оригінал, тож переклад мусить бути з ним співмірний: українська дає
      приблизно 1,0–1,3 довжини англійської. Значення втричі довше за свій
      ключ («Troops in the Field» -> цілий абзац про поліпшення
      спорядження) — це тіло від іншого рядка.

      Пробував був простіше — «багаторядкове значення під однорядковим
      ключем», — але воно й шумить, і пропускає: у ключах перенос записано
      ЛІТЕРАЛЬНО, двома символами \\n, тож 44 записи з 47 були фальшиві, а
      «Try not to One-Shot him…» проскочив. Довжина не залежить ні від
      переносів, ні від форми ключа.

Природні збіги коротких значень («Сумка» у двох місцях) відсіює поріг
довжини MIN_LEN, а перекоси на дуже коротких ключах — доданок SLACK.

Запуск: python _check_kv_shift.py   (код виходу 1, якщо є підміни)
"""
import json
import re
import sys
from collections import defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

# Секції з ключем-англійським-рядком.
SECTIONS = ("uiTooltips", "uiMisc", "uiStrings", "groupFinder",
            "minimapLabels", "gameObjects", "housingUI")
# Секції з ключем-ID. Спершу я їх сюди не брав, бо «там ключ не текст, отже
# підміна неможлива». Це хибне міркування: хвиля однаково віддає {англ: укр},
# і чуже тіло лягає на ID через зіставлення за назвою. 26.08.2026 так у
# npcNames опинилося «Vilescar Poacher» -> «Слалом Дикого Заповідника…».
# Англійську тут беремо з data/source [[sv-bucket-vs-section-key]].
ID_SECTIONS = (("npcNames", "creatures.json", "name"),
               ("itemNames", "items.json", "name"),
               ("spells", "spells.json", "name"),
               ("achievements", "achievements.json", "title"))
MIN_LEN = 25
# Скільки разів переклад може бути довшим за оригінал, перш ніж це стане
# доказом підміни. 2.2 узято з запасом: найдовші законні пари в базі дають
# близько 1.6 (кольорові коди й {токени} не перекладаються, але місце
# займають), а підміни починаються з 2.6.
# Доданок був 24 — і затуляв саме те, заради чого гейт писався: ключ
# «Vilescar Poacher» (16 симв.) зі значенням на 45 давав поріг 59 і мовчав.
# Вимір по всій базі: 24 -> 0 влучань, 14 -> 6, 8 -> 11 (з них 9 справжніх
# підмін і 2 чесні фальшивки в закляттях, де український термін просто
# довший: «Time Bomb» -> «Бомба з Годинниковим Механізмом»), 4 -> 16.
RATIO, SLACK = 2.2, 8
# [C] Числа не перекладаються. Якщо в оригіналі є двозначні й більші числа,
# а в перекладі ЖОДНОГО з них немає — текст не про те. Цей доказ не залежить
# ні від мови, ні від довжини, тож ловить підміни, де довжини збіглися.
#
# Два обмеження, без яких він шумить:
#   • розряди відокремлюють по-різному («6,022» проти «6 022»), тож перед
#     порівнянням роздільники всередині числа прибираємо;
#   • одне-єдине число буває ідіомою, а не величиною: «Shooting 101» — це
#     «основи стрільби», і цифр там бути не повинно [[dont-overcorrect-literalism]].
#     Тому вимагаємо, щоб зникло щонайменше ДВА різні числа.
NUM = re.compile(r"(?<![\w$])\d[\d,  ]*\d|(?<![\w$])\d{2,}")
MIN_NUMS = 2


def numbers(s):
    return {re.sub(r"[,  ]", "", m) for m in NUM.findall(s)}


def unwrap(s):
    """Перенос у ключах записаний літерально («\\n»), у значеннях — справжній."""
    return s.replace("\\r\\n", "\n").replace("\\n", "\n").replace("\r\n", "\n")


def ua_of(v):
    if isinstance(v, str):
        return v
    if isinstance(v, dict):
        for f in ("name", "title", "text", "ua", "value"):
            x = v.get(f)
            if isinstance(x, str) and x.strip():
                return x
    return ""


def common_prefix(items):
    if not items:
        return ""
    a, b = min(items), max(items)
    i = 0
    while i < len(a) and i < len(b) and a[i] == b[i]:
        i += 1
    return a[:i]


def family_shift(d):
    """[D] Рядки-РОДИНИ: однаковий початок англійською -> однаковий українською.

    Blizzard плодить рядки шаблоном: «Visit the Candy Buckets in Kalimdor.»,
    «…in Northrend.», «…in Pandaria.» Переклад такої родини мусить починатися
    однаково; хто вибився — там чуже тіло.

    Цей доказ ловить те, чого не бачить довжина: «…in Kalimdor.» (36 симв.)
    мало значення «Кільце Крилоспочинку, просунуте: золото» (39) — довжини
    майже збіглися, тож співмірність мовчала, а рядок був геть про інше.
    """
    fam = defaultdict(list)
    for k, v in d.items():
        w = unwrap(k).split()
        if len(w) >= 5 and ua_of(v):
            fam[" ".join(w[:4]).lower()].append(k)

    broken, style = [], []
    for head, keys in fam.items():
        if len(keys) < 3:
            continue
        uas = [ua_of(d[k]) for k in keys]
        ens = [unwrap(k) for k in keys]
        en_pref = len(common_prefix(ens))
        ua_pref = len(common_prefix(uas))
        avg_en = sum(map(len, ens)) / len(ens)

        # Англійські майже однакові, а українські не мають нічого спільного
        # на початку. Спокуса — назвати це підміною, але доказу тут немає:
        # в українській вільний порядок слів, тож «- Зірвано Штурми (40%)»
        # і «- Штурми зірвано (20%)» законно розходяться з першого символу.
        # Тому родина йде в БОРГИ, а не в блокувальні підміни: гейт мусить
        # зупиняти лише доказове, інакше його перестають читати.
        if en_pref > avg_en * 0.5 and ua_pref < 4:
            for k in keys:
                broken.append((k, ua_of(d[k]),
                               f"родина «{head}…»: англійські збігаються на "
                               f"{en_pref} симв., українські — на {ua_pref}"))
            continue

        # Спільний початок є, але дехто з нього вибився — це вже не чуже
        # тіло, а різнобій звертання чи слова («Скористайтеся» проти
        # «Скористайся»). Окремий, неблокувальний список.
        starts = defaultdict(list)
        for k, u in zip(keys, uas):
            starts[" ".join(u.split()[:2]).lower()].append(k)
        if len(starts) < 2:
            continue
        top = max(starts.values(), key=len)
        if len(top) * 2 <= len(keys):
            continue
        good = " ".join(ua_of(d[top[0]]).split()[:2])
        for grp in starts.values():
            if grp is not top:
                for k in grp:
                    style.append((k, ua_of(d[k]),
                                  f"решта родини починається з «{good}»"))
    return broken, style


def _report(title, rows, limit=10):
    """Неблокувальний борг: показуємо хвіст значення — обрив видно саме там."""
    if not rows:
        return
    print(f"{title} (не блокує, окремий борг): {len(rows)}")
    for sec, k, u, why in rows[:limit]:
        print(f"    [{sec}] {k[:52]!r}")
        print(f"        -> …{u[-46:]!r}  ({why})")
    if len(rows) > limit:
        print(f"    …ще {len(rows) - limit}")
    print()


def id_sections(tr):
    """Секції з ключем-ID у вигляді {англ: укр} — щоб перевірки бачили пару."""
    for sec, src, fld in ID_SECTIONS:
        p = DATA_DIR / "source" / src
        if not p.exists():
            continue
        d = json.loads(p.read_text(encoding="utf-8-sig"))
        t = tr.get(sec) or {}
        pairs = {}
        for k, v in d.items():
            nm = v.get(fld) if isinstance(v, dict) else None
            en = nm.get("en") if isinstance(nm, dict) else nm
            ua = ua_of(t.get(str(k)))
            if isinstance(en, str) and en and ua:
                pairs.setdefault(en, ua)
        if pairs:
            yield sec, pairs


def main():
    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
    bad, cut, lost, style = [], [], [], []
    views = [(s, tr.get(s)) for s in SECTIONS]
    views += list(id_sections(tr))
    for sec, d in views:
        if not isinstance(d, dict):
            continue
        rev = defaultdict(list)
        for k, v in d.items():
            u = ua_of(v)
            if u and (len(u) > MIN_LEN or "\n" in u):
                rev[u].append(k)

        flagged = set()
        # [A] те саме значення під структурно різними ключами
        for u, keys in rev.items():
            if len(keys) < 2:
                continue
            multi = [k for k in keys if "\n" in unwrap(k)]
            single = [k for k in keys if "\n" not in unwrap(k)]
            # Той самий текст, у якого десь загубився перенос, — не підміна.
            # Так само не підміна, коли один ключ є початком другого: Blizzard
            # дописує до опису хвіст («Use: Add this Curio…»), і обидва
            # варіанти законно ділять один переклад. Тут спрацьовує [B]:
            # спільне значення виявляється обрізаним для обох.
            flat = sorted({" ".join(unwrap(k).split()) for k in keys}, key=len)
            family = all(s.startswith(flat[0]) for s in flat)
            if multi and single and len(flat) > 1 and not family:
                for k in single:
                    flagged.add(k)
                    bad.append((sec, k, u, f"значення належить {multi[0][:40]!r}"))

        # [B] переклад несумірний із власним оригіналом
        for k, v in d.items():
            if k in flagged:
                continue
            u = ua_of(v)
            if not u or len(u) <= MIN_LEN:
                continue
            en, ua = len(unwrap(k)), len(u)
            if ua > en * RATIO + SLACK:
                bad.append((sec, k, u,
                            f"переклад у {ua / en:.1f} раза довший за оригінал"))
                continue
            if en > ua * RATIO + SLACK:
                # Це вже інша хвороба: не чуже тіло, а власне, обрізане на
                # півслові. Тримаємо окремо — змішувати їх означає зробити
                # гейт шумом, який перестануть читати. Перевіряємо ДО чисел:
                # обрізаний переклад теж губить числа, і без цього порядку
                # обрізання видавало б себе за підміну.
                cut.append((sec, k, u,
                            f"переклад у {en / ua:.1f} раза коротший за оригінал"))
                continue
            nums = numbers(unwrap(k))
            if len(nums) >= MIN_NUMS and not (nums & numbers(u)):
                # Довжини при цьому співмірні, тож це або чуже тіло такого ж
                # розміру, або власний переклад, з якого випали цифри. Розсудити
                # може лише людина, тож не блокуємо — інакше гейт назавжди
                # червоний, а вічно червоний гейт перестають читати.
                lost.append((sec, k, u,
                             f"втрачено числа: {', '.join(sorted(nums)[:4])}"))

        fam_bad, fam_style = family_shift(d)
        for k, u, why in fam_bad + fam_style:
            style.append((sec, k, u, why))

    for title, rows in (("ОБРІЗАНІ ПЕРЕКЛАДИ", cut), ("ВИПАЛИ ЧИСЛА", lost),
                        ("РІЗНОБІЙ У РОДИНІ РЯДКІВ", style)):
        _report(title, rows)

    if not bad:
        print("підмін ключ<->значення не знайдено")
        return 0

    print(f"ПІДМІНИ: {len(bad)}")
    for sec, k, u, why in bad:
        print(f"\n  [{sec}] {k[:60]!r}")
        print(f"      -> {u[:70]!r}")
        print(f"      {why}")
    return 1


if __name__ == "__main__":
    sys.exit(main())
