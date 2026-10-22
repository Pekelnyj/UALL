# Encounter Journal (Путівник пригод, Shift+J) — переклад

Повна архітектура перекладу Encounter Journal. Якщо щось «забулось» при компресії — читай це.
Перевірено на 8 підземеллях (Яма Сарона + 7 M+: Тераса магістрів, Скайріч, Академія Алгетара,
Престол Тріумвірату, Шпиль Віндраннерів, Печери Майсари, Вузлова Точка Ксенас).

---

## 1. Принцип

- Хук: **`addon/WoWUkraine/EncounterJournalHooks.lua`**. LoadOnDemand
  `Blizzard_EncounterJournal` → чіпляємось на `ADDON_LOADED`.
- **Жодного тікера/опитування** (користувач: «не борися з клієнтом, хукай у точці»).
  Тригери СИНХРОННІ: `hooksecurefunc` на `EncounterJournal_DisplayEncounter`/`DisplayInstance`/
  `LootUpdate`/`SetTab`/`DisplayInstances`/`UpdateButtonState` + `ScrollBox:RegisterCallback(
  OnInitializedFrame)` + `EncounterJournal:HookScript("OnShow")`. `Refresh()` робить
  `Walk(EncounterJournal)` одразу після того, як Blizzard поставив текст → без блимання.
- Підхід — **Walk-підміна FontString за ПОКАЗАНИМ текстом** (як GossipHooks), без override
  GlobalString → без taint. CYR-шрифт через `ns.ApplyCyrFont` (інакше □ на ґ/і/ї/є).
- `TranslateFS(fs)` для кожного FontString: `Lookup(text) or SectionLookup(text) or
  AbilityDescLookup(text)`; якщо нема — лог у `db.ejmiss` (збирач, див. §8).

---

## 2. Карта фреймів (Midnight)

| Що | Фрейм |
|---|---|
| Корінь | `EncounterJournal` |
| Список босів | `EncounterJournalEncounterFrameInfo.BossesScrollBox` |
| Лор боса / огляд / **описи абілок** | динамічні діти ScrollTarget (НЕ глобально-іменовані!) |
| Лут | `EncounterJournalEncounterFrameInfo.LootContainer.ScrollBox` |
| Опис підземелля | `EncounterJournalEncounterFrameInstanceFrame.LoreScrollingFont.ScrollBox` |

⚠️ **Midnight прибрав глобальні `EncounterJournalInfoHeader<N>`.** Старий код брав spellID
описів абілок зі спел-лінка в цих хедерах — тепер їх НЕМА (cFound=0). Описи абілок перекладаємо
КОНТЕНТ-МАТЧЕМ (§5), без залежності від фрейм-структури.

---

## 3. Шари перекладу (кожен — своя таблиця + механізм)

| # | Шар | Таблиця в грі | Матч |
|---|---|---|---|
| 1 | Назви босів | `ns.journalEncounterNames[en]` | за текстом (Walk) |
| 2 | Назви підземель | `ns.journalInstances[en]` | за текстом |
| 3 | Лор боса | `ns.journalLore[en]` + `journalLoreNorm` | текст / нормалізований (нижче) |
| 4 | Опис ПІДЗЕМЕЛЛЯ | `ns.journalInstanceDesc[en]` + `…Norm` | текст / норм |
| 5 | Огляд/механіки-буліти | `ns.journalSections[canon]` | КАНОН (§4) |
| 6 | Назви абілок (заголовки) | `ns.journalSections[canon(назва)]` | КАНОН — див. нижче |
| 7 | **Описи абілок** | `ns.descTemplates`+`spellDescIndex` | КОНТЕНТ-МАТЧ (§5) |
| 8 | UI-мітки | `EJ_UI` + патерни `Boss:`/`Class Filter:` | словник |
| 9 | Лут (назви предметів) | `ns.items[itemID]` | itemID з `GetLootInfoByIndex` |

**Лор/опис інстансу — НОРМАЛІЗОВАНИЙ матч (`…Norm`):** гра показує `\n\n`, API має `\r\n\r\n`;
буває розбито по абзацах окремими FontString. Тому крім точного — ще ключ зі згорнутими
пробілами/переносами (`CollapseWS`), і ПОВНИЙ текст, і КОЖЕН абзац окремо. ⚠️ UA опису
підземелля МУСИТЬ бути СТИСЛИМ — довший за EN не влазить у фіксований бокс, верх обрізає.

**Назва абілки (заголовок секції) = `journalSections`-ТИТУЛ, НЕ `ns.spells` напряму!** Після
перекладу спел-назв треба ДОДАТКОВО `journalSections[canon(en_name)] = ua` для кожної en-назви
абілки. Інакше заголовки абілок у журналі англ. (хоч у тултіпі вже перекладені).

**Лут:** елемент `GetData()` дає лише `{index=N}` (НЕ itemID!). itemID+назву беремо
`C_EncounterJournal.GetLootInfoByIndex(index)`. `ns.items[itemID]` — РЯДОК (назва) АБО таблиця
`{name,fen,fua}` (як в ItemHooks: `type(entry)=="table" and entry.name or entry`).

---

## 4. Рушій `journalSections` (огляд/механіки + назви абілок)

Текст у грі ≠ API:
- API (`api_journal_sections.json`): `$bullet;`-СКЛЕЄНІ буліти в одному рядку, `[Назва]` плоскі,
  числа=«0», `\r\n`.
- Гра: КОЖЕН буліт окремим FontString, лінк `|cFF..|Hspell:ID|h[Назва]|h|r`, реальні числа, `|n`.

**CANON** (однаково в Lua-хуку `Canon` і generate_db `ej_canon`): зняти `|c`/`|H`(лишити
`[внутр]`)/`|T`/`|A`, прибрати `$bullet;`, `|n`/`\r\n`→пробіл, числа→«#» → спільний ключ.

`generate_journal` РОЗБИВАЄ `$bullet;`-секції на окремі буліти. `ns.journalSections` ключ =
канон одного буліта. `SectionLookup` (Lua): канон-матч → підставити РЕАЛЬНІ числа (позиційно) +
ВІДНОВИТИ `|H`-лінки (обгорнути перекладені `[дужки]` обгортками оригіналу) → лишаються клікабельні.

⚠️ `[англ.назви]` в булетах перекладати за глосарієм назв (інакше `[Blaze of Glory]` лізе англ.,
хоч заголовок тієї ж абілки українською). Плюс множини: `[Void Bombs]`→`[Бомби Порожнечі]`.

---

## 5. Описи абілок — КОНТЕНТ-МАТЧ (найскладніший шар)

Описи абілок = описи СПЕЛІВ. Рушій `ns.RenderDescription(spellID, показанийТекст)` (зі SpellHooks):
бере EN-шаблон (`descTemplates[idx].en` з $-кодами), зіставляє з показаним (живі числа), витягує
значення, заповнює UA-шаблон. Той самий рушій — і в спел-тултіпах.

**Як беремо spellID (Midnight без хедерів):** `AbilityDescLookup` у `TranslateFS`:
1. `WordsKey(text)` — звести показане і EN-шаблони до «слів» (геть розмітку, `$@?коди`, числа,
   пунктуацію, lower). EN-шаблон ($s1 тощо) і показане (реальні числа) дають ОДНАКОВУ послідовність
   слів. Префікс 48 символів (стабільна проза до умовних гілок).
2. `descByWords[префікс]` = СПИСОК spellID (зворотний індекс зі `spellDescIndex`+`descTemplates.en`,
   будується ліниво раз). Список бо **1627 префіксів-колізій** у базі.
3. Пробуємо КОЖЕН кандидат через `RenderDescription` — він сам валідує (`MatchAndFill`): чужий
   шаблон поверне nil, правильний зійдеться. Так колізії не шкодять.

### Три підводні камені описів (усі полагоджені)

1. **`descTemplates` ключ = EN-ШАБЛОН (рядок), НЕ spellID** — див. §6.
2. **`$@spelldesc/$@spellname`-референси** часто НЕ section.spell.id → відсутні в source. Дотягувати
   з wago DB2: `Spell.<lang>.latest.csv` (`Description_lang`) і `SpellName.<lang>.latest.csv`
   (`Name_lang`). `$@spelldescNNN` резолвиться лише якщо NNN у `spellDescIndex`; `$@spellnameNNN` —
   через `ns.spells[NNN]` (тобто referenced НАЗВИ теж перекладати в `translations[spells]`).
   Скрипти: `_extract_refspells.py` (описи), `_collect_namegaps.py` (назви). BFS через референси.
3. **Хвостовий `\n` + Lua `$`** — НАЙпідступніший. FontString опису в журналі має КІНЦЕВИЙ `\n`.
   `BuildMatcher` анкорить на `$`, а в Lua `$` (на відміну від Python!) НЕ матчить перед хвостовим
   `\n` → жоден варіант не сходиться → nil → англ. Фікс: `MatchAndFill` обрізає `%s+$` з enText і
   renderedEN перед матчем. **Офлайн-тест перевіряти СТРОГИМ кінцем (`\Z`)**, бо Python `$`
   поблажливий і бреше «матч» (`_test_render2.py`).
   + Роздільна else-гілка `$?c[.]\n\n\n\n[.\n\nText]`: `ParseConditionalChain` пропускає пробіли
   перед '[' else-гілки.

---

## 6. ⚠️ КЛЮЧІ JSON у translations.json (тихо ламають — попадався двічі)

`generate_db.py` читає шари за ТОЧНИМИ ключами. Зливання в НЕправильний ключ = дані осідають у
кошику, який пайплайн ІГНОРУЄ: у грі англ., а наївний чекер «ключ є?» бреше «OK».

- `journal` → назви/лор босів.
- `journalSections` → буліти+титули (канон).
- **`instanceDesc`** → описи підземель. **НЕ `journalInstanceDesc`!**
- **`descTemplates`** → описи абілок, ключ = **EN-ШАБЛОН**, НЕ spellID! Ланцюг у
  `generate_spell_descriptions`: `source/spells.json[spellID].description.en` → `descTemplates[en]`
  (UA) → пара `{en,ua}` + `spellDescIndex[spellID]=idx`. Якщо `descTemplates[spellID]=ua` (числовий
  ключ) — generate ІГНОРУЄ → spellID не в spellDescIndex → RenderDescription nil → англ.
- `spells` → назви заклять (резолв `$@spellname`).

**Перевіряти покриття ТІЛЬКИ через `pipeline/journal_coverage.py`** (читає ті самі ключі/ланцюги,
що generate) АБО grep по згенерованих `.lua`. Наївний spellID-чекер бреше.

---

## 7. Пайплайн: як додати НОВЕ підземелля (рецепт, без whack-a-mole)

1. `python extract_dungeon_full.py <iid,...>` → інстанси/боси/секції/section-spell.id одним заходом
   (api_journal_instances/api_instance_desc/api_journal/api_journal_sections/source-spells).
2. `python _extract_refspells.py` → дотягнути $@spelldesc/$@spellname-референси з wago DB2.
3. `python _collect_namegaps.py` → referenced-НАЗВИ (застосувати глосарій / перекласти решту).
4. **Stage 1 — НАЗВИ**: перекласти унікальні en-назви абілок (dedup), застосувати на ВСІ spell-ID
   з тією ж en-назвою. ПОТІМ застосувати на `journalSections`-ТИТУЛИ (§3).
5. **Stage 2 — ОПИСИ**: (а) описи абілок → `descTemplates[EN-шаблон]=ua` (плейсхолдери ДОСЛІВНО;
   чистий `$@spelldescNNN`→той самий рядок); (б) секції-буліти → `journalSections` (`$bullet;`
   дослівно, `[Назви]` з якоря); (в) описи інстансів → `instanceDesc` (СТИСЛІ!).
6. **QA-уніфікація імен** (ОБОВ'ЯЗКОВО — різні хвилі транслітерують босів по-різному):
   канонічні назви з `journal` → variant→canonical replace ЛИШЕ в нових записах. Той самий клас,
   що [[name-calque-leak]]. (Crawth→Кравт, Doragosa→Дораґос-, Nezhar→Нежар, Rukhran→Рухран.)
7. merge → `python generate_db.py` → `/reload`.
8. **Перевірити `journal_coverage.py <iids>`** → описи/секції/лор/інст мають бути 100%, 0 прогалин.

---

## 8. Проти ручного QA на 600 данжах — інструменти

- **`journal_coverage.py <iids>`** — з ДАНИХ рахує перекладено/всього по шарах (реальні ключі/
  ланцюги, як generate). `--dump` → точні прогалини в `data/jcov/`. Ловить ДІРКИ ДАНИХ.
- **`db.ejmiss`** — `TranslateFS` логує КОЖЕН показаний журнал-рядок без перекладу (сирий текст→
  довжина, кап 400). Браузиш кілька босів → /reload → `python pipeline/read_ejmiss.py`. Ловить
  БАГИ МАТЧУ (дані є, не показується — як хвостовий `\n` чи ключ-кошик). `Refresh` робить
  `TranslateAbilityDescriptions`/контент-матч ПЕРЕД Walk, щоб збирач не логував хибно.
- Один зразок підземелля часто виявляє СТРУКТУРНИЙ баг → фікс хук/дані-сторони працює на ВСІХ 600.
- Офлайн-валідація рендера: `_test_descmatch.py`, `_test_render2.py` (СТРОГИЙ кінець `\Z`!).

---

## 9. Гочі / правила

- **Жодного тікера** — синхронні хуки.
- Опис інстансу — **стислий** (фіксований бокс); UA ≤ EN.
- Описи абілок = спел-описи через RenderDescription (НЕ journalSections).
- Лут: itemID через `GetLootInfoByIndex(index)`, не з елемента.
- **Консистентність назв** (журнал↔тултіп↔лор): якорі для агентів. Виправлено по ходу:
  Keystone=**ключ** (НЕ наріжний камінь), construct(Scourge)→потвора, Saronite Sludge=**жижа**
  (НЕ твань/слиз — рідкісне), Tyrannus=Тираннус, Forgemaster=Майстер-коваль, High Sage=Верховна
  **мудриця** (НЕ «мудрейка» — вигадане слово).
- **«Cracked/Mythic Keystone» не показує підземелля** в тултіпі — Blizzard у цьому типі ключа
  данж не дає (той із данжем — аддон Raider.IO). НЕ наш баг.
- `.toc` має `EncounterJournalHooks.lua` → нові .toc-файли = повний рестарт раз; зміни даних у
  наявному `Journal.lua`/`SpellDescriptions.lua` = лише `/reload`.
