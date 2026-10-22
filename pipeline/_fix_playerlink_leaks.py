# -*- coding: utf-8 -*-
"""Прибрати з бази імена гравців, доведені лінком |Hplayer:…|h (18.10.2026).

ЯК ЗНАЙШЛОСЯ. Збирач ніків читав суфікс реалму й системні рядки, але НЕ читав
найсильніший доказ — посилання «|Hplayer:Ім'я-Реалм|h», яке гра будує лише для
справжнього гравця (у зборах таких 239). Коли playernames.py почав його читати,
гейт показав 10 рядків із чужими іменами, що тихо лежали в базі.

ЧОМУ ЧАСТОТНИЙ ЗАСЛІН ЇХ НЕ ЛОВИВ. _game_words() вважає слово ігровим, якщо
воно є в 3+ ключах. Шаблон множить витік: «<нік> activated an Unstable
Nether Portal in …» дав п'ять ключів (по зоні на кожен), нік перетнув поріг і
сам себе оголосив ігровим словом. Тепер для лінк-доказу питаємо дані гри
напряму (attested_in_sources): з шести спірних Battleborne справді є в
items.json («Battleborne Sentinel Gauntlets»), решта п'ять — витоки.

ЩО РОБИМО З КОЖНИМ РЯДКОМ
  • broadcast / gossip / bookTexts — нік у КЛЮЧІ міняємо на токен (хук
    нормалізує ім'я читача перед пошуком, тож рядок почне працювати в усіх,
    а не лише в того тестера), у перекладі — теж токен. Кличні форми
    («Брондгріме», «Пеклю», «Мираселло») розгортаємо в звертання з називним,
    бо токен не відмінюється.
  • Рід дієслова за гравцем — через $p(чол:жін) [[player-gender-token]]:
    «Леаріанель відкрила» було жіночим намертво, бо такою була тестерка.
  • uiTooltips «<нік> must advance to a higher level.» — ВИДАЛЯЄМО. Це
    запечений GlobalString INSTANCE_UNAVAILABLE_OTHER_LEVEL_TOO_LOW
    («%s must advance…»), і ім'я в ньому — ЧУЖОГО члена групи, а не читача;
    токен-ключ тут не зматчився б ніколи (хук підставляє лише своє ім'я), а
    шаблонів із %s секція uiTooltips не підтримує.

Запуск: python _fix_playerlink_leaks.py [--apply]
Далі:   python _rebuild_broadcast_lua.py --apply  (ключі broadcast змінено)
        python _check_playernames.py              (мусить бути чисто)
"""
import io
import json
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))

PORTAL = "Нестабільний Портал Нижнього Світу"
# (секція, старий ключ, новий ключ або None=видалити, новий переклад)
FIX = [
    ("gossip",
     "We are the chosen ones, <нік>. Death knights of the Scourge, sent to"
     " sow the seeds of the master's destruction.",
     "We are the chosen ones, {name}. Death knights of the Scourge, sent to"
     " sow the seeds of the master's destruction.",
     "Ми — обранці, {name}. Лицарі смерті Погибелі, послані сіяти насіння"
     " володаревої згуби."),
    ("bookTexts",
     "<нік> represents a new, united front against the Lich King known as"
     " the Knights of the Ebon Blade. Yes, majesty, death knights turned"
     " against their former master. They are led by the son of Lord Alexandros"
     " Mograine - the Ashbringer. They seek what we seek, what we all seek:"
     " the end of the Scourge.\r\n\r\nI ask not that you accept <нік> and"
     " the Knights of the Ebon Blade into the Alliance, but only that you show"
     " tolerance.",
     "{NAME} represents a new, united front against the Lich King known as"
     " the Knights of the Ebon Blade. Yes, majesty, death knights turned"
     " against their former master. They are led by the son of Lord Alexandros"
     " Mograine - the Ashbringer. They seek what we seek, what we all seek:"
     " the end of the Scourge.\r\n\r\nI ask not that you accept {NAME} and"
     " the Knights of the Ebon Blade into the Alliance, but only that you show"
     " tolerance.",
     "{NAME} — то новий, об'єднаний фронт проти Короля-Ліча, знаний як Лицарі"
     " Чорного Клинка. Так, ваша величносте, лицарі смерті повстали проти"
     " свого колишнього володаря. Їх веде син лорда Александроса Мограйна —"
     " Ешбрінгера. Вони прагнуть того самого, чого прагнемо ми, чого прагнуть"
     " усі: кінця Погибелі.\r\n\r\nЯ не прошу, щоб ви прийняли {NAME} й"
     " Лицарів Чорного Клинка до Альянсу, — лише щоб виявили терпимість."),
    ("uiTooltips", "<нік> must advance to a higher level.", None, None),
    # ДВІЙНИК. Той самий рядок лежав у базі двічі — з двома різними чужими
    # іменами (<нік> і <нік>): два тестери почули його в різні дні. Щойно
    # з'явився токен-ключ, обидва стають і витоком, і мертвим грузом.
    ("broadcast", "Good to see you, <нік>. We must take back Hammerfall.",
     None, None),
    ("broadcast",
     "Good to see you, <нік>. We must take back Hammerfall.",
     "Good to see you, {NAME}. We must take back Hammerfall.",
     "Радий тебе бачити, {NAME}. Ми мусимо відбити Гаммерфол."),
    ("broadcast",
     "Hey, <нік>! Message for you from Grand Master Hight!",
     "Hey, {NAME}! Message for you from Grand Master Hight!",
     "Гей, {NAME}! Тобі послання від Великого магістра Гайта!"),
]
# «X activated an Unstable Nether Portal in Y!» — п'ять зон, один шаблон.
# Заодно зводимо дієслово: у базі було навпіл «відкрила» і «активувала».
for en_zone, ua_zone in (("Dark Stockades", "в Темних Колодах"),
                         ("Felfire Pass", "на Перевалі Сквернагню"),
                         ("Foulshore Strip", "на Косі Гнилоберіжжя"),
                         ("Wrynfall", "в Рінфолі"),
                         ("the Twisted Grounds", "на Покручених Землях")):
    FIX.append((
        "broadcast",
        f"<нік> activated an Unstable Nether Portal in {en_zone}!",
        f"{{NAME}} activated an Unstable Nether Portal in {en_zone}!",
        f"{{NAME}} $p(відкрив:відкрила) {PORTAL} {ua_zone}!"))

done, miss, clash = 0, [], []
for sec, old, new, ua in FIX:
    d = tr.get(sec)
    if not isinstance(d, dict) or old not in d:
        miss.append((sec, old))
        continue
    if new is None:
        print(f"  [{sec}] ВИДАЛЕНО  {old[:70]}")
        if APPLY:
            del d[old]
        done += 1
        continue
    if new in d and d[new] != ua:
        clash.append((sec, new, d[new]))
    print(f"  [{sec}] {old[:62]}\n        -> {new[:62]}\n        == {ua[:70]}")
    if APPLY:
        del d[old]
        d[new] = ua
    done += 1

print(f"\nвиправлено: {done} | не знайдено: {len(miss)} | колізій: {len(clash)}")
for sec, old in miss:
    print(f"  !! нема в [{sec}]: {old[:70]}")
for sec, k, v in clash:
    print(f"  !! токен-ключ уже був у [{sec}] з іншим перекладом: {v[:60]}")
if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print("translations.json записано")
