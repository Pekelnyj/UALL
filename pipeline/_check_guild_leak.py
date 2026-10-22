# -*- coding: utf-8 -*-
"""ГЕЙТ: чи не перекладено назву гільдії або річ живого гравця.

Під іменем гравця гра показує ГІЛЬДІЮ, а під його улюбленцем — «<Нік>'s Pet».
Обидва потрапляють у db.subnames разом зі справжніми титулами NPC, і жодне
джерело датамайну підзаголовків не має (creatures.json, api_creatures_full,
_midnight_creatures — 0 записів із subname). «На око» їх не розрізнити, тому
шукаємо лише те, що доводиться даними:

  1) суфікс РЕАЛМУ. Список реалмів не вигадуємо і не беремо за формою слова —
     «Time-Locked Timewalkers» і «Nexus-Captain» теж дефісні, але це звичайні
     назви. Реалми ЗБИРАЄМО зі зборів: беремо «X-Y» там, де X — уже відомий
     нік; тоді Y напевно реалм.
  2) «X's Pet/Minion/Familiar/…», де X немає в creatures.json — річ гравця.
  3) відомий нік у ключі.

Запуск: python _check_guild_leak.py [--sections a,b]
Падає (exit 1), якщо знайшов, — щоб не поїхало в реліз.
"""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from playernames import known_nicks, known_realms, nick_regex, strong_nicks

SECTIONS = ["subnames", "uiTooltips", "npcNames", "globalStrings", "gossip",
            "broadcast", "mail", "questObjectives"]
if "--sections" in sys.argv:
    SECTIONS = sys.argv[sys.argv.index("--sections") + 1].split(",")

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
crea = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
cap = json.loads((DATA_DIR / "source" / "captured_creatures.json").read_text(encoding="utf-8-sig"))

anchors = set()
for cid, v in crea.items():
    if isinstance(v, dict):
        nm = v.get("name") if isinstance(v.get("name"), dict) else v
        en = nm.get("en") if isinstance(nm, dict) else None
        if en:
            anchors.add(en)
anchors |= {v for v in cap.values() if isinstance(v, str)}

# --- 1. реалми: збираємо з даних -------------------------------------------
nicks = set(known_nicks())
# Реалми беремо з playernames.known_realms(): там вони зібрані ЛИШЕ з
# системних рядків («Ім'я-Реалм has left the instance group»).
# Тутешнє правило «X-Y, де X — відомий нік» трималося, поки ніків було
# шістдесят. Щойно збір підняв список до тисяч, «реалмами» ставали звичайні
# слова — Cho, Thrall, Arathi, Blade — і гейт починав бачити витік у
# «Void-Blade Zedaat», «Gai-Cho Cauterizer» та «Th--Thrall».
REALMS = known_realms() | {"Aggra(Português)"}

# Перед дефісом мусить стояти ІМ'Я — щонайменше дві літери, і сам дефіс має
# бути одинарним. Багато реалмів названо на честь героїв (Thrall, Turalyon,
# Alleria, Arathi), а гра пише тире ПОДВІЙНИМ дефісом, тож без цих умов
# «Your father--Turalyon--» і «Th--Thrall?» читалися як «ім'я-реалм».
# ВИНЯТКИ: ігровий текст, де частина після дефіса випадково збіглася зі
# списком реалмів/ніків. «Crag-Leaper's Cache» — назва схованки в грі, а не
# гравець із реалму «Leaper». Додавати сюди лише з доказом, що рядок ігровий.
REALM_OK = re.compile(r"Crag-Leaper")

REALM_RX = (re.compile(r"(?<!-)\b\w{2,}-(?:%s)\b"
                       % "|".join(re.escape(r) for r in sorted(REALMS)))
            if REALMS else None)
# Дві ролі ніків, як у _check_playernames.py. НАДІЙНІ (ручний список +
# meta.playerName) шукаємо будь-де в ключі. ЗІБРАНІ з системних рядків — лише
# голим ключем: гравці носять ігрові слова як імена, і 13.09 новий збір дав
# «Razik», «Varkul», «Resize», «Downstairs» — гейт почав бачити витік у
# «Razik's prototype», «Kill Varkul the Unrelenting», «Disable Resize».
# Витоки посеред речення ловить правило-двійник {NAME} у _check_playernames.
_strong = strong_nicks(min_len=4)
NICK = (re.compile(r"(?:(?<=\|c[0-9A-Fa-f]{8})|\b)("
                   + "|".join(re.escape(n) for n in sorted(_strong)) + r")\b")
        if _strong else re.compile(r"(?!x)x"))
HARVESTED = set(known_nicks(min_len=4)) - _strong
# Власник — це ІМ'Я, тож артикль на початку виключаємо: «A Centaur's Companion»
# і «The Children's Loa» — назви з гри, а не речі гравця.
POSS = re.compile(r"^(?!(?:A|An|The)\s)(.+?)'s\s+"
                  r"(Pet|Minion|Gateway|Companion|Guardian|Ghoul|Steed|Mount|"
                  r"Familiar|Butler|Servant|Imp|Voidwalker|Felhunter)$")

# Тултіп гільдійної групи: гра вписує НАЗВУ ГІЛЬДІЇ посеред речення. Такий ключ
# мертвий для всіх інших гільдій і сам є витоком. Перекладає це шаблон у
# UIHooks (TT_FORMAT_PATTERNS), у базі цих рядків бути не повинно. 13.09 у
# uiTooltips знайшлося 11 штук на три гільдії, одна ще й із підміною значення.
GUILD_GROUP = re.compile(r"are members of [^%]+\. Guild achievements"
                         r"|composed of guild members of [^%]+\. Guild achievements")

bad = []
for sec in SECTIONS:
    for en, ua in (tr.get(sec) or {}).items():
        if not isinstance(en, str) or not isinstance(ua, str):
            continue
        if GUILD_GROUP.search(en):
            bad.append((sec, en, ua, "назва гільдії в тултіпі гільдійної групи"))
            continue
        if REALM_RX and REALM_RX.search(en) and not REALM_OK.search(en):
            bad.append((sec, en, ua, "суфікс реалму -> гравець/гільдія"))
            continue
        m = POSS.match(en)
        if m and m.group(1) not in anchors:
            bad.append((sec, en, ua, "річ гравця (власника нема в creatures)"))
            continue
        if NICK.search(en):
            bad.append((sec, en, ua, "відомий нік у ключі"))
        elif en.strip() in HARVESTED:
            bad.append((sec, en, ua, "голий зібраний нік як ключ"))

print(f"реалмів зібрано з даних: {len(REALMS)} -> {sorted(REALMS)[:12]}")
for sec, en, ua, why in bad[:40]:
    print(f"  [{sec}] {en[:70]!r} -> {ua[:60]!r}\n        {why}")
if bad:
    print(f"\n❌ ГЕЙТ ГІЛЬДІЙ/ГРАВЦІВ: знайдено {len(bad)}")
    sys.exit(1)
print("✅ ГЕЙТ ГІЛЬДІЙ/ГРАВЦІВ: перекладених гільдій і речей гравців не знайдено.")
