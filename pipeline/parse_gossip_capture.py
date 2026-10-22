"""Витяг зібраних у грі діалогів NPC (CaptureDB.gossip) на переклад.

Діалоги (вікно розмови) — серверні: аддон збирає їх у SavedVariables, поки
гравець грає. Ім'я гравця в тексті замінюємо на {name}, щоб переклад
працював для всіх (аддон підставить назад).

Вхід:  WTF\\...\\SavedVariables\\WoWUkraine.lua -> CaptureDB.gossip + meta.playerName
Вихід: data/source/gossip_capture.json + data/batches/gossip/gos_NN.json
"""

import json

from luaparser import ast, astnodes

from common import DATA_DIR

import glob
import sys

# Приймає КІЛЬКА файлів; без аргументів бере живий SavedVariables.
# Раніше шлях був зашитий намертво (ще й на стару назву WoWUkraine.lua), тож
# збори від тестерів у чергу не потрапляли зовсім — та сама вада, яку вже
# виправили в _prep_objlines_wave.py і _extract_uitt.py
# [[patch-refresh-gotchas]], [[sv-rename-uall-bridge]].
SV_FILES = [a for a in sys.argv[1:] if not a.startswith("--")] or (
    glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/UALL.lua")
    + glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua"))
OUT_DIR = DATA_DIR / "batches" / "gossip"
BATCH = 30


def s(n):
    v = getattr(n, "s", None)
    if isinstance(v, bytes):
        return v.decode("utf-8", "replace")
    return v


# Глобал збору перейменували: свіжі файли пишуть UALLCaptureDB, старі —
# WoWUkraineCaptureDB. Приймаємо обидва, інакше новий збір мовчки дає нуль
# рядків [[sv-rename-uall-bridge]].
DB_NAMES = ("UALLCaptureDB", "WoWUkraineCaptureDB")


def scan(src, gossip, players):
    tree = ast.parse(src)
    for node in ast.walk(tree):
        if not isinstance(node, astnodes.Assign):
            continue
        for t, v in zip(node.targets, node.values):
            if getattr(t, "id", None) not in DB_NAMES:
                continue
            if not isinstance(v, astnodes.Table):
                continue
            for f in v.fields:
                key = s(f.key)
                if key == "gossip" and isinstance(f.value, astnodes.Table):
                    for g in f.value.fields:
                        k = s(g.key)
                        if k:
                            gossip.append(k)
                elif key == "meta" and isinstance(f.value, astnodes.Table):
                    for m in f.value.fields:
                        if s(m.key) == "playerName":
                            nm = s(m.value)
                            if nm:
                                players.append(nm)


def main():
    gossip, players = [], []
    for path in SV_FILES:
        try:
            src = open(path, encoding="utf-8", errors="replace").read()
        except OSError as e:
            print(f"  ! не читається {path}: {e}")
            continue
        before = len(gossip)
        scan(src, gossip, players)
        print(f"  {path}: +{len(gossip) - before} рядків")
    print(f"зборів у роботі: {len(SV_FILES)} | імена гравців: {players}")

    # Ім'я гравця -> {name}. Мало замінити лише meta.playerName: збір іде на
    # весь АКАУНТ, а playerName записує лише ОСТАННЬОГО персонажа. Балачки,
    # зібрані на альтах, зберігають їхні імена — у черзі 28.08 таких було
    # 214 з 427 (<нік>, <нік>, <нік> при playerName=<нік>).
    # Тому беремо повний список ніків, а не лише імена з цих файлів
    # [[capture-wave-playername-leaks]].
    import re
    from playernames import AMBIGUOUS, nick_regex
    RX = nick_regex(min_len=4)          # коротші збігаються зі звичайними словами

    # МЕЖІ СЛОВА ОБОВ'ЯЗКОВІ. Голий txt.replace(p, …) з'їдає середину слів:
    # персонажа звали «Rea», і в чергу полетіло «{name}dy» (Ready),
    # «{name}ch» (Reach), «{name}lity» (Reality) — 54 зіпсовані ключі.
    # Плюс мінімальна довжина: коротке ім'я збігається зі звичайним словом,
    # і саме тому «Rea» стоїть у playernames.AMBIGUOUS — але цей цикл брав
    # імена з meta.playerName напряму, в обхід і списку, і nick_regex.
    _pl = [re.compile(r"(?<![\w'’])" + re.escape(p) + r"(?![\w'’])")
           for p in players if p and len(p) >= 4 and p not in AMBIGUOUS]

    def norm(txt):
        for rx in _pl:
            txt = rx.sub("{name}", txt)
        return RX.sub("{name}", txt)

    # Уже перекладені — пропускаємо.
    translations = json.loads(
        (DATA_DIR / "translations.json").read_text(encoding="utf-8"))
    done = set(translations.get("gossip", {}))

    # ── ФІЛЬТР СМІТТЯ: кирилиця (наш власний вивід) + назви квестів (їх
    # перекладає quest-хук за questID, а не gossip). Інакше вони щоразу
    # з'являються як «нові діалоги».
    import re as _re
    CYR = _re.compile(r"[Ѐ-ӿ]")

    def strip_color(s):
        return _re.sub(r"\|c%x%x%x%x%x%x%x%x".replace("%x", "[0-9A-Fa-f]"),
                       "", s).replace("|r", "")

    quest_titles = set()
    for q in translations.get("quests", {}).values():
        if q.get("title"):
            quest_titles.add(q["title"])
    src_q = DATA_DIR / "source" / "quests.json"
    if src_q.exists():
        for q in json.loads(src_q.read_text(encoding="utf-8-sig")).values():
            en = (q.get("title", {}) or {}).get("en")
            if en:
                quest_titles.add(en)

    import capfilter

    def is_noise(text):
        if CYR.search(text):
            return True  # наш переклад потрапив назад у збір
        # службовий відбиток аддона («Gossip-Hash=…») і текст неанглійського
        # клієнта: 13.09 у черзі балачок 60 з 84 рядків були саме відбитками
        if capfilter.is_service(text) or capfilter.is_foreign(text):
            return True
        if not text.strip():
            return True  # порожній рядок « »
        # надгробок Глибин: «Here lies <Нік-Реалм> … perished at 08:44 PM»
        if capfilter.why_runtime(text) == "надгробок із часом смерті":
            return True
        # ім'я гравця в гнізді, для якого в базі вже є «{name}»-двійник
        # (13.09: 14 з 21 рядка черги — Klychnica, Kekovych, Ferrik…)
        if capfilter.token_twin(text, done, "{name}"):
            return True
        s = strip_color(text).strip()
        return s in quest_titles  # назва квесту, не діалог

    uniq = []
    seen = set()
    for g in gossip:
        n = norm(g)
        if n in seen or n in done or is_noise(n):
            continue
        seen.add(n)
        uniq.append(n)

    (DATA_DIR / "source" / "gossip_capture.json").write_text(
        json.dumps(uniq, ensure_ascii=False, indent=1), encoding="utf-8")

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for old in OUT_DIR.glob("gos_*.json"):
        old.unlink()
    n = 0
    for i in range(0, len(uniq), BATCH):
        n += 1
        (OUT_DIR / f"gos_{n:02d}.json").write_text(
            json.dumps([{"en": x} for x in uniq[i:i + BATCH]],
                       ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"Зібрано діалогів: {len(gossip)} | нових унікальних: {len(uniq)}"
          f" | гравці: {players} | батчів: {n}")


if __name__ == "__main__":
    main()
