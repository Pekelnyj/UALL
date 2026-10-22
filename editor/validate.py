# -*- coding: utf-8 -*-
"""Валідація українського перекладу для редактора — ті самі правила, що в пайплайні.
Повертає список попереджень (не блокує збереження, лише сигналізує редакторові)."""
import re
from pathlib import Path

_COMBINING = re.compile("[̀-ͯ]")           # наголоси ◌́ — ламають кінематик-шрифт
_VAR = re.compile(r"\$@?\w+|\$\{[^}]*\}|\$<\w+>|\$/\d+;?|\$\*\d*|\$bullet;|{[A-Za-z]+}")
_CODE = re.compile(r"\|c[0-9A-Fa-f]{8}|\|r|\|T.-?.*?\|t|\|H.-?.*?\|h|\|A.-?.*?\|a|\|n")
# ІМЕНА ГРАВЦІВ. У коді їх не тримаємо: список локальний і в кожного власника
# свій (див. pipeline/playernames.py). Файл data/playernames.local.json поза
# git має вигляд ["Нік", ...]; якщо його немає — перевірка мовчить.
def _player_rx():
    import json
    p = Path(__file__).resolve().parent.parent / "data" / "playernames.local.json"
    try:
        names = [n for n in json.loads(p.read_text(encoding="utf-8"))
                 if isinstance(n, str) and len(n) >= 3]
    except (OSError, ValueError):
        return None
    if not names:
        return None
    return re.compile(r"\b(" + "|".join(re.escape(n) for n in names) + r")\b")


_PLAYER = _player_rx()


def _multiset(rx, s):
    out = {}
    for m in rx.findall(s or ""):
        out[m] = out.get(m, 0) + 1
    return out


def validate(en, ua):
    """en — оригінал (може бути порожній), ua — переклад. -> [попередження]."""
    w = []
    ua = ua or ""
    if not ua.strip():
        return ["Порожній переклад"]
    if _COMBINING.search(ua):
        w.append("Комбінований наголос (◌́) — прибери, ламає кінематик-шрифт")
    if _PLAYER and _PLAYER.search(ua):
        w.append("Містить нік гравця — має бути {NAME}")
    if en:
        ev, uv = _multiset(_VAR, en), _multiset(_VAR, ua)
        for tok, cnt in ev.items():
            if uv.get(tok, 0) != cnt:
                w.append(f"Змінна {tok}: в оригіналі {cnt}, у перекладі {uv.get(tok,0)}")
        for tok in uv:
            if tok not in ev:
                w.append(f"Зайва змінна в перекладі: {tok}")
        # коди оформлення (кольори/текстури/лінки) — груба перевірка кількості
        if len(_CODE.findall(en)) != len(_CODE.findall(ua)):
            w.append("Кількість кодів |c/|T/|H не збігається з оригіналом")
        en_nl, ua_nl = en.count("\\n") + en.count("\n"), ua.count("\\n") + ua.count("\n")
        if en_nl and ua_nl == 0:
            w.append("Втрачено переноси рядків (\\n)")
    return w


if __name__ == "__main__":
    print(validate("$s1 Arcane damage to {NAME}", "$s1 арканної шкоди для {NAME}"))   # ок
    print(validate("$s1 Fire damage", "вогняна шкода"))                                # втрата $s1
    print(validate("Hello", "Привіт, Pekelnyj"))                                       # нік
