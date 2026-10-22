import json, re
from collections import Counter
from common import DATA_DIR

TOKEN = re.compile(r"\$\{[^{}]*\}|\$<\w+>|\$proc[a-z]+|\$@[a-zA-Z]+\d*|\$(\d+)?[sdatxmMunhoArRwWeEbc]\d*")
def toks(s): return Counter(m.group(0) for m in TOKEN.finditer(s))

src = json.loads((DATA_DIR / "source" / "spells.json").read_text(encoding="utf-8-sig"))
trp = DATA_DIR / "translations.json"
tr = json.loads(trp.read_text(encoding="utf-8-sig"))
dt = tr.setdefault("descTemplates", {})

en = src["214449"]["description"]["en"]
ua = ("Коли ви отримуєте магічну шкоду, є шанс накласти Удушливе Полум'я на "
      "нападника, занімовуючи його на $214459d.\n\n\n\nЦе може статися не частіше "
      "ніж раз на $proccooldown с.")
print("EN tokens:", dict(toks(en)))
print("UA tokens:", dict(toks(ua)))
if toks(en) == toks(ua):
    dt[en] = ua
    trp.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
    print("OK -> 214449 додано")
else:
    print("ТОКЕНИ НЕ ЗБІГ")
