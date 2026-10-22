"""Витяг ОПИСІВ заклять (шаблонів із формулами) з wago.tools.

Spell.db2 -> Description_lang. Опис — це шаблон з плейсхолдерами
($s1 = значення ефекту, $d = тривалість, ${$s1/10} = формула,
$?s123[A][B] = умова). Перекладається шаблон, плейсхолдери лишаються.

Класифікація складності (для черговості перекладу):
    simple  — лише прості токени $s1/$d/$a1/${...} — рендеримо в грі самі
    complex — умови $?... тощо — поки лишаються англійською

Результат: у data/source/spells.json додається
    "description": {"en","de","fr"}, "descComplexity": "simple"|"complex"

Використання:
    python extract_spell_descriptions.py
"""

import csv
import io
import json
import re

import requests

from common import DATA_DIR

SOURCE_PATH = DATA_DIR / "source" / "spells.json"
CACHE_DIR = DATA_DIR / "wago"

LOCALES = {"enUS": "en", "deDE": "de", "frFR": "fr"}

# Простий токен: $s1, $d, $d1, $a1, $t1, $n, $x1, $m1, $M1, $u, $h,
# $123456s1 (з іншого спела), ${...} без вкладених $? умов.
SIMPLE_TOKEN = re.compile(r"\$(\d+)?[sdatxmMunhoArRwWeEbc]\d*\b|\$\{[^{}]*\}|\$<\w+>|\$proc[a-z]+")
ANY_TOKEN = re.compile(r"\$\S")


def download_csv(table: str, locale: str, build=None) -> str:
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    cache_path = CACHE_DIR / f"{table}.{locale}.{build or 'latest'}.csv"
    if cache_path.exists():
        print(f"  {cache_path.name}: з кешу")
        return cache_path.read_text(encoding="utf-8")
    print(f"  {cache_path.name}: завантажую (Spell.db2 великий, кілька хвилин)...")
    params = {"locale": locale}
    if build:
        params["build"] = build
    resp = requests.get(f"https://wago.tools/db2/{table}/csv", params=params, timeout=1800)
    resp.raise_for_status()
    cache_path.write_text(resp.text, encoding="utf-8")
    return resp.text


def classify(template: str) -> str:
    """simple, якщо всі $-токени — прості (без умов $?[..][..])."""
    if "$?" in template or "$|" in template:
        return "complex"
    leftover = SIMPLE_TOKEN.sub("", template)
    return "complex" if ANY_TOKEN.search(leftover) else "simple"


def main():
    source = json.loads(SOURCE_PATH.read_text(encoding="utf-8-sig"))
    wanted = {int(k) for k in source}

    csv.field_size_limit(10_000_000)
    found = {short: {} for short in LOCALES.values()}
    for loc, short in LOCALES.items():
        reader = csv.DictReader(io.StringIO(download_csv("Spell", loc)))
        desc_col = None
        for name in reader.fieldnames:
            if name.lower() == "description_lang":
                desc_col = name
                break
        if not desc_col:
            raise KeyError(f"Немає Description_lang: {reader.fieldnames[:15]}")
        for r in reader:
            try:
                sid = int(r["ID"])
            except (KeyError, ValueError):
                continue
            if sid in wanted:
                val = (r.get(desc_col) or "").strip()
                if val:
                    found[short][sid] = val

    added = simple = 0
    for sid_str, entry in source.items():
        sid = int(sid_str)
        en = found["en"].get(sid)
        if not en:
            continue
        desc = entry.setdefault("description", {})
        desc["en"] = en
        for short in ("de", "fr"):
            if found[short].get(sid):
                desc[short] = found[short][sid]
        entry["descComplexity"] = classify(en)
        if entry["descComplexity"] == "simple":
            simple += 1
        added += 1

    SOURCE_PATH.write_text(json.dumps(source, ensure_ascii=False, indent=2),
                           encoding="utf-8")
    print(f"Описів знайдено: {added} (simple: {simple}, complex: {added - simple})")
    print(f"-> {SOURCE_PATH}")


if __name__ == "__main__":
    main()
