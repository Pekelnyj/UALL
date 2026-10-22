"""Вичистка описових кальок ІМЕН -> транслітерація (прив'язано до англ. джерела).

Кальки, що протекли в дані (стара хибна позначка в глосарії):
  - Deathwing  -> Дезвінг   (калька «Смертокрил»; БЕЗПЕЧНО глобально — інших значень нема)
  - Windrunner -> Віндраннер (калька «Вітрогон/Вітрогін»)
  - Windreaver -> Віндрівер  (ТЕЖ калька «Вітрогон» — інше слово! різниться лише англ. джерелом)

«Вітрогон» неоднозначний (Windrunner у квестах vs Windreaver у предметах), тому
маршрутизуємо за АНГЛІЙСЬКИМ ключем/джерелом, а не наосліп.

Запускати ПЕРЕД generate_db. Чистить translations.json і всі out_*.json.
Глосарії правляться руками (там є навмисні негативні приклади).
"""

import json
import glob
import os

from common import DATA_DIR

QSRC = DATA_DIR / "source" / "quests.json"


def death(s):
    # Смертокрил(+відмінок) -> Дезвінг(+той самий відмінок): стем-заміна граматично коректна
    return s.replace("Смертокрил", "Дезвінг") if "Смертокрил" in s else s


def wind(s, en):
    """Замінити Вітрогон/Вітрогін за англ. джерелом en. Повертає (новий_рядок, мітка)."""
    if "Вітрогон" not in s and "Вітрогін" not in s:
        return s, None
    if "Windreaver" in en:
        repl, tag = "Віндрівер", "windreaver"
    elif "Windrunner" in en:
        repl, tag = "Віндраннер", "windrunner"
    else:
        # у квестах Windreaver не трапляється -> Windrunner за замовчуванням
        repl, tag = "Віндраннер", "windrunner(default)"
    return s.replace("Вітрогон", repl).replace("Вітрогін", repl), tag


def main():
    cnt = {"deathwing": 0, "windrunner": 0, "windreaver": 0}
    qsrc = json.loads(QSRC.read_text(encoding="utf-8-sig")) if QSRC.exists() else {}

    def qen(qid):
        e = qsrc.get(str(qid), {})
        return ((e.get("title", {}) or {}).get("en", "") + " "
                + (e.get("description", {}) or {}).get("en", ""))

    # ---- translations.json ----
    tp = DATA_DIR / "translations.json"
    tr = json.loads(tp.read_text(encoding="utf-8-sig"))

    def bump_death(before, after):
        if before != after:
            cnt["deathwing"] += before.count("Смертокрил")

    # itemNames / itemFlavors: ключ = англ. текст -> маршрут за ключем
    for sect in ("itemNames", "itemFlavors"):
        d = tr.get(sect, {})
        for en, ua in list(d.items()):
            if not isinstance(ua, str):
                continue
            n = death(ua); bump_death(ua, n)
            n, tag = wind(n, en)
            if tag:
                cnt["windreaver" if "windreaver" in tag else "windrunner"] += 1
            d[en] = n

    # quests: Deathwing глобально; Вітрогон -> Windrunner (Windreaver у квестах нема)
    for qid, v in tr.get("quests", {}).items():
        if not isinstance(v, dict):
            continue
        for f, val in list(v.items()):
            if not isinstance(val, str):
                continue
            n = death(val); bump_death(val, n)
            n, tag = wind(n, qen(qid))
            if tag:
                cnt["windreaver" if "windreaver" in tag else "windrunner"] += 1
            v[f] = n

    # решта секцій: лише Deathwing (безпечно)
    for sect in ("currencies", "gossip", "broadcast", "spells", "achievements",
                 "descTemplates", "objectives"):
        d = tr.get(sect)
        if not isinstance(d, dict):
            continue
        for k, v in list(d.items()):
            if isinstance(v, str):
                n = death(v); bump_death(v, n); d[k] = n
            elif isinstance(v, dict):
                for f, val in list(v.items()):
                    if isinstance(val, str):
                        n = death(val); bump_death(val, n); v[f] = n

    tp.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")

    # ---- out_*.json (ключ = англ. назва) ----
    for op in glob.glob(str(DATA_DIR / "item_batches" / "out_*.json")):
        data = json.loads(open(op, encoding="utf-8-sig").read())
        ch = False
        for en, entry in data.items():
            if not isinstance(entry, dict):
                continue
            for f in ("name", "flavor"):
                val = entry.get(f)
                if not isinstance(val, str):
                    continue
                n = death(val); bump_death(val, n)
                n, tag = wind(n, en)
                if tag:
                    cnt["windreaver" if "windreaver" in tag else "windrunner"] += 1
                if n != val:
                    entry[f] = n; ch = True
        if ch:
            with open(op, "w", encoding="utf-8") as fh:
                json.dump(data, fh, ensure_ascii=False, indent=1)

    print("Виправлено входжень:")
    print(f"  Deathwing  Смертокрил->Дезвінг : {cnt['deathwing']}")
    print(f"  Windrunner Вітрогон->Віндраннер: {cnt['windrunner']}")
    print(f"  Windreaver Вітрогон->Віндрівер : {cnt['windreaver']}")


if __name__ == "__main__":
    main()
