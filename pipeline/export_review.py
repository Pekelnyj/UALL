"""Експорт перекладів у зручний для вичитки HTML (оригінал — переклад поруч).

Результат: data/review.html — відкривається у браузері, пошук через Ctrl+F.
Квести згруповані по лінійках (у сюжетному порядку), потім одиночні.

Використання:
    python export_review.py
"""

import html
import json

from common import DATA_DIR

OUT = DATA_DIR / "review.html"

CSS = """
body { font-family: 'Segoe UI', sans-serif; margin: 20px auto; max-width: 1400px;
       background: #14161b; color: #d8d8d8; }
h1 { color: #ffd700; } h2 { color: #7ec8ff; margin-top: 2em;
     border-bottom: 1px solid #333; padding-bottom: 4px; }
.q { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin: 14px 0;
     padding: 12px; background: #1d2026; border-radius: 8px; }
.q h3 { margin: 2px 0 8px; font-size: 15px; }
.en h3 { color: #c8b27c; } .ua h3 { color: #ffd700; }
.lbl { color: #6f7a8a; font-size: 11px; text-transform: uppercase; margin-top: 8px; }
.txt { white-space: pre-wrap; font-size: 14px; line-height: 1.45; }
.qid { color: #555; font-size: 12px; float: right; }
.missing { color: #884444; font-style: italic; }
"""


def block(label: str, text: str | None, missing: str = "") -> str:
    if not text:
        return f'<div class="lbl">{label}</div><div class="txt missing">{missing or "—"}</div>' if missing else ""
    return f'<div class="lbl">{label}</div><div class="txt">{html.escape(text)}</div>'


def quest_html(qid: str, src: dict, ua: dict) -> str:
    s_title = src.get("title", {}).get("en", "?")
    s_obj = src.get("objectives", {}).get("en")
    s_desc = src.get("description", {}).get("en")
    parts = [f'<div class="q" id="q{qid}">']
    parts.append(f'<div class="en"><span class="qid">#{qid}</span><h3>{html.escape(s_title)}</h3>')
    parts.append(block("Objectives", s_obj))
    parts.append(block("Description", s_desc))
    parts.append("</div>")
    parts.append(f'<div class="ua"><h3>{html.escape(ua.get("title", "—"))}</h3>')
    parts.append(block("Цілі", ua.get("objectives")))
    parts.append(block("Опис", ua.get("description"),
                       missing="(опис серверний — збереться аддоном у грі)" if s_desc is None else ""))
    parts.append("</div></div>")
    return "".join(parts)


def main():
    src = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))
    trans = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))["quests"]
    lines = json.loads((DATA_DIR / "questlines.json").read_text(encoding="utf-8-sig"))

    out = [f"<!doctype html><meta charset='utf-8'><title>WoWUkraine — вичитка</title>"
           f"<style>{CSS}</style><h1>WoWUkraine — вичитка перекладів "
           f"({len(trans)} квестів)</h1>"]

    used = set()
    chains = []
    for lid, e in lines.items():
        chain = [str(q) for q in e["quests"] if str(q) in trans]
        if len(chain) >= 2:
            chains.append((e.get("name", {}).get("en") or f"Лінійка {lid}", chain))
            used.update(chain)
    chains.sort(key=lambda c: -len(c[1]))

    for name, chain in chains:
        out.append(f"<h2>📜 {html.escape(name)} ({len(chain)})</h2>")
        for qid in chain:
            out.append(quest_html(qid, src.get(qid, {}), trans[qid]))

    loose = [q for q in sorted(trans, key=int) if q not in used]
    if loose:
        out.append(f"<h2>Одиночні квести ({len(loose)})</h2>")
        for qid in loose:
            out.append(quest_html(qid, src.get(qid, {}), trans[qid]))

    OUT.write_text("".join(out), encoding="utf-8")
    print(f"Готово: {OUT}")


if __name__ == "__main__":
    main()
