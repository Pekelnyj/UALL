# -*- coding: utf-8 -*-
"""Злиття перекладу GlobalStrings -> translations.json["globalStrings"] = {en: ua}.

СУВОРА валідація (інакше зламає інтерфейс):
  - мультимножина формат-спеків (%s, %d, %.2f, %1$s ...) мусить ЗБІГАТИСЯ en<->ua;
  - кількість |c...|r кольор-кодів і |H..|h, |T..|t однакова;
  - без кирилиці-помилок ы/ъ/э/ё; ua непорожнє й != en.
Невалідні йдуть у rejects (не вливаються).

Запуск: python merge_globalstrings.py
"""
import glob, json, re, sys, collections
from common import DATA_DIR
sys.stdout.reconfigure(encoding="utf-8")

SPEC = re.compile(r"%\d+\$[sdfxiu]|%[%\d.$+\-]*[sdfxiu]|%[%\d.$+\-]*[sdfxiu]")
SPEC_ALL = re.compile(r"%\d+\$[sdfxiu]?|%[-+0-9.]*[sdfxiu]|%%")
CODE = re.compile(r"\|c[fF][fF]?[0-9A-Fa-f]{6,8}|\|r|\|H.-\|h|\|T.-\|t|\|n")
RUS = re.compile(r"[ыъэёЫЪЭЁ]")


def specs(s):
    return collections.Counter(SPEC_ALL.findall(s))


def codes(s):
    # рахуємо лише прості маркери, що мусять зберегтися: |c..., |r, |T, |H
    return collections.Counter(re.findall(r"\|c[0-9A-Fa-f]{6,8}|\|c[fF]{2}[0-9A-Fa-f]{6}|\|r|\|T|\|H|\|n", s))


def valid(en, ua):
    if not ua or ua == en:
        return "порожнє/без змін"
    if RUS.search(ua):
        return "кирилиця-помилка (ы/ъ/э/ё)"
    if specs(en) != specs(ua):
        return f"формат-спеки не збігаються ({sorted(specs(en).elements())} vs {sorted(specs(ua).elements())})"
    if codes(en) != codes(ua):
        return "кольор-коди/маркери не збігаються"
    return None


def main():
    tr_path = DATA_DIR / "translations.json"
    tr = json.loads(tr_path.read_text(encoding="utf-8-sig"))
    store = tr.setdefault("globalStrings", {})
    added = rej = 0
    rejects = []
    for f in sorted(glob.glob(str(DATA_DIR / "batches" / "globalstrings" / "out_*.json"))):
        for it in json.loads(open(f, encoding="utf-8-sig").read()):
            en = it.get("en"); ua = (it.get("ua") or "").strip()
            if not en:
                continue
            why = valid(en, ua)
            if why:
                rej += 1
                rejects.append({"en": en, "ua": ua, "why": why})
                continue
            store[en] = ua
            added += 1
    tr_path.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
    if rejects:
        (DATA_DIR / "batches" / "globalstrings" / "rejects.json").write_text(
            json.dumps(rejects, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"globalStrings: прийнято {added} | відхилено {rej} | усього {len(store)}")
    for r in rejects[:10]:
        print(f"  ВІДХИЛ: {r['why']} | {r['en'][:40]!r} -> {r['ua'][:40]!r}")


if __name__ == "__main__":
    main()
