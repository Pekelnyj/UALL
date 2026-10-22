# -*- coding: utf-8 -*-
"""Збирає квести однієї СЮЖЕТНОЇ ЛІНІЇ в один контекст-пакет (по порядку, EN+UA) —
щоб перекладати/ревізувати ланцюг СУЦІЛЬНО: єдина термінологія, наскрізний наратив.

Джерело структури: data/wago/QuestLineXQuest.db2 (лінія→впорядковані квести) +
QuestLine.db2 (назва лінії). Текст: data/source/quests.json (EN) + translations.json (UA).

Використання:
  python pipeline/questline_context.py --list [фільтр]      # перелік ліній (id, назва, к-сть)
  python pipeline/questline_context.py --line <questlineID>  # пакет однієї лінії -> stdout+json
  python pipeline/questline_context.py --name "Twilight"     # за назвою (підрядок)
"""
import sys, os, csv, json, argparse, collections
sys.stdout.reconfigure(encoding="utf-8")
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def load_csv(t):
    p = os.path.join(ROOT, "data", "wago", f"{t}.enUS.latest.csv")
    return list(csv.DictReader(open(p, encoding="utf-8", errors="replace"))) if os.path.exists(p) else []


def build():
    ql = load_csv("QuestLine")
    qlx = load_csv("QuestLineXQuest")
    name = {r["ID"]: r.get("Name_lang", "") for r in ql}
    desc = {r["ID"]: r.get("Description_lang", "") for r in ql}
    lines = collections.defaultdict(list)
    for r in qlx:
        qlid = r.get("QuestLineID")
        qid = r.get("QuestID")
        o = r.get("OrderIndex") or "0"
        if qlid and qid:
            lines[qlid].append((int(o) if o.lstrip("-").isdigit() else 0, qid))
    for k in lines:
        lines[k] = [q for _, q in sorted(lines[k])]
    return name, desc, lines


def _txt(rec, field, lang=None):
    v = rec.get(field) if isinstance(rec, dict) else None
    if isinstance(v, dict):
        return v.get(lang) if lang else v.get("en") or v.get("ua") or ""
    return v or ""


def bundle(qlid, name, desc, lines):
    tr = json.load(open(os.path.join(ROOT, "data", "translations.json"), encoding="utf-8-sig"))
    quests_ua = tr.get("quests", {})
    sp = os.path.join(ROOT, "data", "source", "quests.json")
    src = json.load(open(sp, encoding="utf-8-sig")) if os.path.exists(sp) else {}
    out = {"questlineID": qlid, "name_en": name.get(qlid, ""), "desc_en": desc.get(qlid, ""), "quests": []}
    for qid in lines.get(qlid, []):
        s = src.get(qid, {})
        u = quests_ua.get(qid, {})
        out["quests"].append({
            "id": qid,
            "title_en": _txt(s, "title", "en"),
            "title_ua": u.get("title", ""),
            "desc_en": _txt(s, "description", "en"),
            "desc_ua": u.get("description", ""),
        })
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--list", nargs="?", const="", default=None)
    ap.add_argument("--line")
    ap.add_argument("--name")
    a = ap.parse_args()
    name, desc, lines = build()

    if a.list is not None:
        rows = [(qlid, name.get(qlid, "?"), len(qs)) for qlid, qs in lines.items()]
        flt = a.list.lower()
        rows = [r for r in rows if not flt or flt in r[1].lower()]
        rows.sort(key=lambda x: -x[2])
        for qlid, nm, n in rows[:60]:
            print(f"  {qlid:>6}  {n:>3}  {nm}")
        print(f"\nусього ліній: {len(lines)}")
        return

    qlid = a.line
    if a.name and not qlid:
        for k, nm in name.items():
            if a.name.lower() in (nm or "").lower() and k in lines:
                qlid = k
                break
    if not qlid:
        print("вкажи --line <id> або --name <підрядок> або --list")
        return
    b = bundle(qlid, name, desc, lines)
    print(f"=== Лінія «{b['name_en']}» (id {qlid}, {len(b['quests'])} квестів) ===")
    for q in b["quests"]:
        print(f"\n[{q['id']}] EN: {q['title_en']}\n        UA: {q['title_ua']}")
    out = os.path.join(ROOT, "data", "wago_bulk", f"_questline_{qlid}.json")
    json.dump(b, open(out, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    print(f"\nпакет -> {out}")


if __name__ == "__main__":
    main()
