# -*- coding: utf-8 -*-
"""Злиття хвилі ОПИСІВ БАФІВ (data/batches/auras/out_*.json) у translations.json → auraDescriptions.

Перевірки кожної пари (07.10.2026, хвиля Fable 5.1):
  * токени EN і UA збігаються як МУЛЬТИМНОЖИНИ ($s1, $123s1, $d, ${…}, $@spellname…, $?a…,
    $<…>, $bullet;, |cXXXXXXXX, |cnНАЗВА:, |r, переноси) — агент легко губить другий $s2 чи
    міняє $s1 і $s2 місцями, і в грі замість шкоди стає тривалість;
    конструкції множини/роду ($l…:…;, |4…:…;, $g…:…;) мовні — з порівняння вилучаються;
  * є кирилиця (або ua == en — службове, лишаємо англійським і НЕ пишемо в базу);
  * немає російських літер і типографських апострофів.
Невдалі — у data/batches/auras/rejected.json із причиною (на повторний прохід).

Запуск: python pipeline/_merge_aura_wave.py [--dry]
"""
import collections
import glob
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

B = DATA_DIR / "batches" / "auras"
# множина $l… (і варіанти $Ltarget;targets, $ltarget:targets;) — до пробілу; |4…; і $g…; — до «;»
LANG = re.compile(r"\$[lL][^\s$;]*;?|\|4[^:;|]*:[^;|]*(?::[^;|]*)?;|\$[gG][^:;$]*:[^;$]*;")
TOKENS = re.compile(
    r"\$\{[^}]*\}"                 # формула — дослівно
    r"|\$@[a-z]+\d+"               # $@spellname123 / $@spelldesc123 / $@spellicon123
    r"|\$\?[!]?[a-zA-Z]\d+"        # умова $?a123 / $?s123
    r"|\$<[^>]+>"                  # змінна $<name>
    r"|\$bullet;"
    r"|\$\d*[a-zA-Z]+\d*"          # $s1, $123456s1, $d, $t1, $w1 …
    r"|\|c[0-9A-Fa-f]{8}|\|cn[A-Z_]+:|\|r"
    r"|\n")
RU = re.compile("[ыэъёЫЭЪЁ]")
CYR = re.compile("[А-Яа-яІіЇїЄєҐґ]")


def tokens(s):
    return collections.Counter(TOKENS.findall(LANG.sub("", s)))


def check(en, ua):
    if not isinstance(ua, str) or not ua.strip():
        return "порожньо"
    if ua == en:
        return "same"
    if not CYR.search(ua):
        return "без кирилиці"
    if RU.search(ua):
        return "російські літери"
    if re.search("[‘’ʼ]", ua):
        return "типографський апостроф"
    te, tu = tokens(en), tokens(ua)
    if te != tu:
        miss = te - tu
        extra = tu - te
        return f"токени: бракує {dict(miss)} зайві {dict(extra)}"
    return None


def main():
    dry = "--dry" in sys.argv
    want = {}
    for p in sorted(B.glob("in_*.json")):
        for item in json.loads(p.read_text(encoding="utf-8")):
            want[item["en"]] = p.name
    got = {}
    for p in sorted(B.glob("out_*.json")):
        try:
            got.update(json.loads(p.read_text(encoding="utf-8")))
        except ValueError as e:
            print(f"!! {p.name}: невалідний JSON — {e}")
    ok, same, rejected = {}, 0, {}
    for en in want:
        if en not in got:
            rejected[en] = "немає у виході"
            continue
        why = check(en, got[en])
        if why == "same":
            same += 1
        elif why:
            rejected[en] = why
        else:
            ok[en] = got[en]
    stray = [k for k in got if k not in want]
    print(f"очікувалось {len(want)} | прийнято {len(ok)} | лишено англійським {same} | "
          f"відхилено {len(rejected)} | зайвих ключів у виході {len(stray)}")
    reasons = collections.Counter(r.split(":")[0] for r in rejected.values())
    print("причини:", dict(reasons))
    (B / "rejected.json").write_text(json.dumps(
        [{"en": k, "why": v, "ua": got.get(k), "batch": want.get(k)} for k, v in rejected.items()],
        ensure_ascii=False, indent=1), encoding="utf-8")
    # Вирівнювання між порціями (агенти писали по-різному; беремо форму, що переважає в базі):
    # «ярд…» → «м» (м 1003 : ярд 866), «Заглушено» → «Змушено замовкнути» (у базі «Заглушено» нема).
    # «с» (секунди) НЕ чіпаємо: це офіційне скорочення; «сек»/«с» у базі ≈56:44 — окреме рішення.
    for en in list(ok):
        ua = ok[en]
        ua = re.sub(r"(\$\w+|\d+)\s+ярд\w*", r"\1 м", ua)
        ua = ua.replace("Заглушено", "Змушено замовкнути").replace("заглушено", "змушено замовкнути")
        if ua != ok[en] and check(en, ua) is None:
            ok[en] = ua
    if dry:
        return
    path = DATA_DIR / "translations.json"
    raw = path.read_bytes().decode("utf-8")
    crlf = "\r\n" in raw
    data = json.loads(raw.replace("\r\n", "\n"))
    sec = data.setdefault("auraDescriptions", {})
    sec.update(ok)
    out = json.dumps(data, ensure_ascii=False, indent=1)
    if raw.endswith("\n"):
        out += "\n"
    if crlf:
        out = out.replace("\n", "\r\n")
    path.write_bytes(out.encode("utf-8"))
    print(f"auraDescriptions: {len(sec)} → {path}")


if __name__ == "__main__":
    main()
