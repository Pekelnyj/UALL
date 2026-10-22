# -*- coding: utf-8 -*-
"""Доллити свіжозловлений gossip (Децимус та ін.) у translations.gossip."""
import sys, json
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
g = tr.setdefault("gossip", {})

T = {
    "Botanist Karquist": "Ботанік Каркіст",
    "I am ready to begin!": "Можна починати!",
    "|cnPURE_BLUE_COLOR:(Quest) I am ready to begin!":
        "|cnPURE_BLUE_COLOR:(Завдання) Можна починати!",
    "The Void is bloodshed and chaos and violence. It is beautiful. It is only "
    "natural that many of us domanaar want to give shape and form to that beauty."
    "\r\n\r\nThis world has been so suffused with Void that it permeates the very "
    "earth itself. So, we have found ways to shape it--to terraform the land with "
    "our mastery of the Void. \r\n\r\nIt is a most satisfying feeling, when power "
    "of the unreal gives you influence over the real.":
        "Порожнеча — це кровопролиття, хаос і насильство. Вона прекрасна. Тож цілком "
        "природно, що багато хто з нас, доманаарів, прагне надати цій красі обрису й "
        "форми.\r\n\r\nЦей світ так просякнутий Порожнечею, що вона пронизує саму землю. "
        "Тому ми знайшли способи формувати її — перетворювати ці землі своєю владою над "
        "Порожнечею. \r\n\r\nНемає приємнішого відчуття, ніж коли сила нереального дає "
        "тобі вплив над реальним.",
}
n = 0
for en, ua in T.items():
    if en not in g:
        g[en] = ua
        n += 1
(DATA_DIR / "translations.json").write_text(
    json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"свіжого gossip додано: {n} / {len(T)}")
