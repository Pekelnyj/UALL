import io, json, re
from collections import Counter
from common import DATA_DIR

TOKEN = re.compile(r"\$\{[^{}]*\}|\$<\w+>|\$@[a-zA-Z]+\d*|\$(\d+)?[sdatxmMunhoArRwWeEbc]\d*")
def toks(s): return Counter(m.group(0) for m in TOKEN.finditer(s))

src = json.loads((DATA_DIR / "source" / "spells.json").read_text(encoding="utf-8-sig"))
trp = DATA_DIR / "translations.json"
tr = json.loads(trp.read_text(encoding="utf-8-sig"))
dt = tr.setdefault("descTemplates", {})

en = src["1265809"]["description"]["en"]
ua = ("Морок Пера дарує тобі $1265809s1 критичного удару, що згасає протягом "
      "${$1265808t2*$1265808u} с, перш ніж повернутися до повної темряви. "
      "Сила Пера також відновлюється поза боєм.")
print("EN tokens:", dict(toks(en)))
print("UA tokens:", dict(toks(ua)))
if toks(en) == toks(ua):
    dt[en] = ua
    trp.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
    print("OK -> додано 1265809")
else:
    print("ТОКЕНИ НЕ ЗБІГ")
