"""Повна статистика перекладу: кількість + слова по категоріях + залишок."""
import json
import re
from common import DATA_DIR

ADDON_DB = DATA_DIR.parent / "addon" / "UALL" / "Database"


def words(s):
    return len(str(s).split()) if s else 0


def main():
    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8"))
    src = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8"))

    cats = {}

    # Квести
    q = tr["quests"]
    qw = 0
    for v in q.values():
        for f in ("title", "description", "objectives", "progress", "completion"):
            qw += words(v.get(f))
    cats["Квести"] = (len(q), qw)

    def wd(d, fields=None):
        w = 0
        for v in d.values():
            if isinstance(v, str):
                w += words(v)
            elif isinstance(v, dict):
                for f in (fields or v.keys()):
                    w += words(v.get(f))
        return w

    cats["Цілі трекера"] = (len(tr["questObjectives"]), wd(tr["questObjectives"]))
    cats["Назви заклять"] = (len(tr["spells"]), wd(tr["spells"]))
    cats["Описи заклять"] = (len(tr["descTemplates"]), wd(tr["descTemplates"], ["ua"]))
    cats["Назви предметів"] = (len(tr["itemNames"]), wd(tr["itemNames"]))
    cats["Описи предметів"] = (len(tr["itemFlavors"]), wd(tr["itemFlavors"]))
    cats["Діалоги (gossip)"] = (len(tr["gossip"]), wd(tr["gossip"]))
    cats["Досягнення"] = (len(tr["achievements"]), wd(tr["achievements"], ["title", "desc"]))

    # Субтитри з Broadcast.lua: ["en"] = "ua",
    bt = (ADDON_DB / "Broadcast.lua").read_text(encoding="utf-8")
    pairs = re.findall(r'\]\s*=\s*"((?:[^"\\]|\\.)*)"\s*,', bt)
    cats["Субтитри/боси"] = (len(pairs), sum(words(p) for p in pairs))

    print("=" * 54)
    print(f'{"КАТЕГОРІЯ":<30}{"ШТ.":>9}{"СЛІВ":>13}')
    print("=" * 54)
    ti = tw = 0
    for name, (c, w) in cats.items():
        print(f"{name:<30}{c:>9}{w:>13,}")
        ti += c
        tw += w
    print("=" * 54)
    print(f'{"РАЗОМ":<30}{ti:>9}{tw:>13,}')
    print()

    def hasdesc(v):
        d = v.get("description")
        return bool(d and (d.get("en") or "").strip())

    allq = [k for k in src if hasdesc(src[k])]
    done = [k for k in allq if k in q]
    old = [k for k in allq if int(k) < 38000 and k not in q]
    print(f"КВЕСТИ: {len(done)} / {len(allq)} перекладено "
          f"({100*len(done)//len(allq)}%) | лишилось старих: {len(old)}")
    for nm, a, b in [("Classic", 1, 9000), ("TBC", 9000, 11000),
                     ("Wrath", 11000, 14000), ("Cata", 24000, 29000),
                     ("MoP", 29000, 34000), ("WoD", 34000, 38000)]:
        c = len([k for k in old if a <= int(k) < b])
        if c:
            print(f"   {nm}: {c}")


if __name__ == "__main__":
    main()
