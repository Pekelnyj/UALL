# -*- coding: utf-8 -*-
"""Злиття зловлених діалогів: gossip→translations.gossip, objectives→questObjectives."""
import sys, json
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
g = tr.setdefault("gossip", {})
qo = tr.setdefault("questObjectives", {})

# gossip
go = json.loads((DATA_DIR / "tester_all" / "gossip_out.json").read_text(encoding="utf-8-sig"))
ng = 0
for en, ua in go.items():
    if en not in g and ua:
        g[en] = ua
        ng += 1

# 4 цілі квестів (ручний переклад за глосарієм: Crest→Герб, Dawncrest→світанковий герб)
OBJ = {
    "Obtain a piece of Veteran track gear and 20 Veteran Dawncrests. Speak to Cuzolth to upgrade a Veteran track item using those crests, then return to Vaskarn in Silvermoon.":
        "Здобудьте предмет спорядження ветеранської гілки та 20 ветеранських світанкових гербів. "
        "Поговоріть із Кузолтом, щоб покращити предмет ветеранської гілки цими гербами, тоді "
        "поверніться до Васкарна в Сільвермуні.",
    "Collect Fragments of Power.": "Зберіть Уламки Сили.",
    "Return your report to Lady Darkglen in Silvermoon City.":
        "Поверніть звіт леді Дарґлен у Сільвермуні.",
    "Speak to Mothkeeper Wew'tam in the Den.":
        "Поговоріть із Доглядачем метеликів Вев'тамом у Лігві.",
}
no = 0
for en, ua in OBJ.items():
    if en not in qo:
        qo[en] = ua
        no += 1

(DATA_DIR / "translations.json").write_text(
    json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"gossip додано: {ng} | objectives додано: {no}")
