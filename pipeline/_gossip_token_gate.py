# -*- coding: utf-8 -*-
"""ГЕЙТ ТОКЕНА ІМЕНІ: у gossip плейсхолдер гравця — {name} МАЛИМИ (рушій GossipHooks
підставляє саме його); {NAME} великими — канон broadcast. Переплутаний регістр →
буквальний «{NAME}» світиться гравцеві у вікні розмови (репро: Інструктор Талендір).
Історія: 16 записів прийшли з капчі з {NAME} у gossip — виправлено 2026-07-02.
Запуск перед мерджем/релізом: python pipeline/_gossip_token_gate.py
"""
from pathlib import Path
import json, sys, io
sys.stdout.reconfigure(encoding="utf-8")
ROOT = str(Path(__file__).resolve().parent.parent)

d = json.load(io.open(ROOT + "/data/translations.json", encoding="utf-8-sig"))
bad = []
for k, v in d.get("gossip", {}).items():
    if isinstance(v, str) and "{NAME}" in v:
        bad.append(("gossip", k[:70], "у значенні {NAME} → має бути {name}"))
    if "{NAME}" in k:
        bad.append(("gossip", k[:70], "у КЛЮЧІ {NAME} → капча мала дати {name}"))
for k, v in d.get("broadcast", {}).items():
    if isinstance(v, str) and "{name}" in v:
        bad.append(("broadcast", k[:70], "у значенні {name} → має бути {NAME}"))

if bad:
    print(f"❌ ГЕЙТ ТОКЕНА: {len(bad)} записів із неправильним регістром плейсхолдера")
    for sect, key, why in bad[:20]:
        print(f"   [{sect}] {key!r}: {why}")
    sys.exit(1)
print("✅ ГЕЙТ ТОКЕНА: чисто (gossip={name}, broadcast={NAME}).")
