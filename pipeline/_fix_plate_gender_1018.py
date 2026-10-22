# -*- coding: utf-8 -*-
"""Рід у титулах плашок — за доказами, а не за замовчуванням (18.10.2026).

У цій партії датамайн не має de/fr, тож агенти ставили чоловічий рід типово.
Веб-довідка дала прямі докази. ВАЖЛИВЕ ЗАСТЕРЕЖЕННЯ З ТОЇ Ж ДОВІДКИ: локалізація
Blizzard є доказом статі ЛИШЕ коли маркер стоїть у ВЛАСНОМУ імені NPC, а не в
спільному підзаголовку. Шість ніффенів-арахнологів Ммарла мають один спільний
`<Mmarl Arachnologist>`, і de/it подають його жіночим («Arachnologin») для всіх
шістьох — навіть для Анісена, якого вікі позначає чоловіком. Так само
«Gulcan die Stahlhand» жіноче лише через рід слова Hand.

Тому правимо ЛИШЕ там, де маркер у самому імені або є займенник у тексті:
  215258  Clerk Gretal        de «Angestellte», fr «Magasinière», it «Cancelliera»
  216979  Roughrider Tany     fr «Routière», es «Jinete Recia», ru «Распорядительница»
  213199  Woldkeeper Freydrin de «Holtzhüterin», ru «Хранительница», es «Preservafoldes»
  212700  Woldtender Igris    de «Holtzpflegerin», ru «Хранительница»

І один шар-конфлікт: Nightclaw — імперський рись-воєнний кіт Голловфолу,
якого гравець гладить для досягнення «The Missing Lynx»; у gossip він уже
«Найтклоу», тож описове «Нічний Кіготь» на плашці розходиться з реплікою.

Запуск: python _fix_plate_gender_1018.py [--apply]
"""
import io
import json
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
npc = tr.setdefault("npcNames", {})

FIX = {
    "215258": ("Писар Ґретал", "Писарка Ґретал"),
    "216979": ("Лихий вершник Тані", "Лиха вершниця Тані"),
    "213199": ("Вартовий Видолу Фрейдрин", "Вартівниця Видолу Фрейдрин"),
    "212700": ("Доглядач Видолу Іґріс", "Доглядачка Видолу Іґріс"),
    "216549": ("Нічний Кіготь", "Найтклоу"),
}

for cid, (old, new) in FIX.items():
    cur = npc.get(cid)
    if cur != old:
        print(f"  !! {cid}: очікував {old!r}, там {cur!r} — не чіпаю")
        continue
    print(f"  {cid}: {old!r} -> {new!r}")
    if APPLY:
        npc[cid] = new

if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print("\ntranslations.json записано")
