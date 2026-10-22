import json, re
from collections import Counter
from common import DATA_DIR

TOKEN = re.compile(r"\$\{[^{}]*\}|\$<\w+>|\$proc[a-z]+|\$@[a-zA-Z]+\d*|\$(?:\d+)?[sdatxmMunhoArRwWeEbc]\d*")
def toks(s): return Counter(m.group(0) for m in TOKEN.finditer(s))

src = json.loads((DATA_DIR / "source" / "spells.json").read_text(encoding="utf-8-sig"))
trp = DATA_DIR / "translations.json"
tr = json.loads(trp.read_text(encoding="utf-8-sig"))
dt = tr.setdefault("descTemplates", {})

en = src["1253110"]["description"]["en"]
ua = ("Ваші критичні удари мають шанс розбурхати в собі Порожнечу, даруючи вам "
      "$s1 $?(a137047|a137005|a137026)[сили]?(a212611|a137009|a137014|a137022|a137034|a137038)"
      "[спритності][сили або спритності] на $1255226d1.")

# валідація: токени + дужки + кількість $?
checks = {
    "tokens": toks(en) == toks(ua),
    "[": en.count("[") == ua.count("["),
    "]": en.count("]") == ua.count("]"),
    "$?": en.count("$?") == ua.count("$?"),
    "?(": en.count("?(") == ua.count("?("),
}
print("EN:", repr(en))
print("UA:", repr(ua))
print("Перевірки:", checks)
if all(checks.values()):
    dt[en] = ua
    trp.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
    print("OK -> 1253110 додано")
else:
    print("ВАЛІДАЦІЯ НЕ ПРОЙДЕНА — не додаю")
