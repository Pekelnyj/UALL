# Каталог хуків UALL

> Довідник: який файл яку поверхню перекладає, які `ns.*` читає, яким
> перемикачем гейтиться. Патерн хука й правила — у
> [ARCHITECTURE.md](ARCHITECTURE.md#патерн-хука-обовʼязковий). Як додати новий —
> у [DEVELOPMENT.md §4](DEVELOPMENT.md#4-новий-хук-нова-поверхня-ui).

Колонки: **Файл** · **Поверхня** · **`ns.*` (головні)** · **Гейт** · **Механізм**.
39 хуків у `addon/UALL/`. «Механізм» — домінанта; майже всі додатково роблять
walk-FontString + `ns.Remember` для Shift-оригіналу.

## Квести і трекер
| Файл | Поверхня | ns.* | Гейт | Механізм |
|---|---|---|---|---|
| `QuestHooks.lua` | Тексти квестів (пропозиція/журнал) | quests, items, currencyByName | `quests.ui/.title/.text/.objectives` | hooksecurefunc + подія |
| `TrackerHooks.lua` | Трекер цілей на екрані | quests, questObjectives, npcNames, scenario, minimapLabels, vignette, setPieces | `quests.tracker` | hooksecurefunc + HookScript + TooltipDataProcessor |
| `QuestLineHooks.lua` | Назви сюжетних ліній/кампаній | questLines | `interface.menu` | HookScript |
| `QuestPinHooks.lua` | ⚠️ **ВИМКНЕНО** — назва квесту в тултіпі піна мапи | — | — | реєстрацію знято (таїнт AreaPOI) |

## Діалоги NPC
| Файл | Поверхня | ns.* | Гейт | Механізм |
|---|---|---|---|---|
| `GossipHooks.lua` | Вікно розмови (gossip) | gossip, quests, npcNames | динамічний (репліки/варіанти) + `world.npcNames` | hooksecurefunc + RegisterCallback |
| `BroadcastHooks.lua` | Субтитри / talking heads / репліки NPC у чаті | broadcast, npcNames | `subtitles` (+ chat, world.npcNames) | подія + hooksecurefunc |
| `NpcHooks.lua` | Імена NPC/монстрів (тултіп) | npcNames, npcSubnames | `world.npcNames` | TooltipDataProcessor |
| `BookHooks.lua` | Книги/листи/таблички | bookTexts | лише Shift | hooksecurefunc |

## Предмети
| Файл | Поверхня | ns.* | Гейт | Механізм |
|---|---|---|---|---|
| `ItemHooks.lua` | Тултіпи предметів | items, itemEffects, setPieces, enchants, itemSuffixes, itemSetsByName | `items.name/.flavor/.effects/.statsSlots` | TooltipDataProcessor |
| `LootHooks.lua` | Вікно луту | items | `items.name` | подія (без таїнту) |
| `MerchantHooks.lua` | Вікно торговця (+ Buyback) | items | `items.merchant` | hooksecurefunc |
| `BagSearchHooks.lua` | Пошук у сумках/банку за UA-назвою | items | `items.bagSearch` | hooksecurefunc |

## Закляття, класи, професії
| Файл | Поверхня | ns.* | Гейт | Механізм |
|---|---|---|---|---|
| `SpellHooks.lua` | Тултіпи заклять (назва+опис) | spells, spellDescIndex, descTemplates, setBonus, traitTemplates, profDesc | `spells.name/.description` | TooltipDataProcessor + hooksecurefunc |
| `ClassSpecHooks.lua` | Класи/спеки + **книга заклять** | spells, uiMisc, uiStrings | `classes` (+ `spells.name`) | HookScript + RegisterCallback |
| `ProfessionsBookHooks.lua` | Книга професій | spells, uiStrings | `spells.name` | HookScript |
| `ProfessionsFrameHooks.lua` | Вікно крафту | items, spells, profDesc | `interface.menu` | hooksecurefunc |
| `GenericTraitHooks.lua` | Generic-трейт-дерева (Loa Blessings…) | uiStrings, profDesc | `interface.menu` | HookScript + walk |

## Досягнення
| Файл | Поверхня | ns.* | Гейт | Механізм |
|---|---|---|---|---|
| `AchievementHooks.lua` | Вікно досягнень (назва+опис) | achievements, achievementChrome, ejStrings | `achievements` | hooksecurefunc + TooltipDataProcessor |
| `AchievementKrowiHooks.lua` | Досягнення в аддоні KrowiAF | achievements, achievementChrome, ejStrings | `compat.krowiAF` + `achievements` | hooksecurefunc (мікшин KrowiAF) |

## Колекції
| Файл | Поверхня | ns.* | Гейт | Механізм |
|---|---|---|---|---|
| `EncounterJournalHooks.lua` | Путівник пригод / журнал підземель | journalEncounterNames, journalLore, journalInstances, journalSections, descTemplates | лише Shift | hooksecurefunc + RegisterCallback |
| `JourneysHooks.lua` | Adventure Guide → Journeys (Renown) | factionByName, journeys, journalInstances | `interface.menu` (+ groupfinder.names) | hooksecurefunc + HookScript |
| `TransmogHooks.lua` | Трансмог-сети (Гардероб) | transmogSets, transmogSetGroups, items | `interface.menu` | hooksecurefunc + RegisterCallback |
| `ToyBoxHooks.lua` | Скриня іграшок | items, toyEffects, toySource | `interface.menu` | HookScript OnEnter + TooltipDataProcessor |
| `PetBattleHooks.lua` | Бойові улюбленці (журнал/бій) | battlePets, battlePetAbilities | `interface.menu` | HookScript OnShow |
| `TitleHooks.lua` | Титули гравця | titles | `enabled` | hooksecurefunc + HookScript |

## Світ і мапа
| Файл | Поверхня | ns.* | Гейт | Механізм |
|---|---|---|---|---|
| `AreaPOIHooks.lua` | Точки інтересу на мапі (піни+тултіп) | areaPOI | `interface.menu` | HookScript OnShow + walk |
| `VignetteHooks.lua` | Рідкісні моби/скарби (vignette) | vignette | `interface.menu` | HookScript |
| `TaxiHooks.lua` | Точки польоту (тултіп) | taxiNodes | `interface.menu` | HookScript |

## Інтерфейс, чат, інше
| Файл | Поверхня | ns.* | Гейт | Механізм |
|---|---|---|---|---|
| `UIHooks.lua` | Меню Esc + вікно налаштувань | uiStrings, ejStrings, factionByName, uiTooltips | `interface.menu`, `interface.character`, `currency`, `groupfinder.names` | hooksecurefunc + RegisterCallback |
| `Tier3Hooks.lua` | Housing / пошук групи / професії / календар | journalInstances, garrison | `interface.menu`, `groupfinder.names` | комбінований |
| `ChatHooks.lua` | Лут/валюта/емоції в чаті | items, currencies, emotes | `chat` (+ items.name, currency) | `ChatFrame_AddMessageEventFilter` |
| `MailHooks.lua` | Пошта | mail, npcNames | `mail` | hooksecurefunc + подія |
| `CurrencyHooks.lua` | Валюти (тултіп + слоти нагород) | currencies, currencyByName | `currency` | TooltipDataProcessor |
| `PlayerChoiceHooks.lua` | PlayerChoiceFrame (вибір історії) | playerChoice, ejStrings, broadcast | `interface.menu` | hooksecurefunc + HookScript |
| `PerksProgramHooks.lua` | Торговий пост (Trading Post) | perksActivity, items | `interface.menu` | hooksecurefunc + HookScript |
| `BarberShopHooks.lua` | Перукарня (підписи кастомізації) | chrCustomization, uiStrings, uiMisc | `interface.menu` | hooksecurefunc + HookScript |
| `HelpTipHooks.lua` | Спливні підказки-туторіали | uiMisc, uiStrings, skillLines | `interface.menu` | hooksecurefunc |
| `TutorialHooks.lua` | Банери навчання | uiMisc, uiStrings | `interface.menu` | hooksecurefunc + HookScript |
| `WelcomeHooks.lua` | Вітальне вікно (одноразове) | — | флаг `db.welcomeShown` | подія |

## Окремо: збирач
- **`Capture.lua`** — це **збирач, не перекладач**. Пише англійські тексти,
  яких ще немає в базах, у SavedVariables через `ns.GetCaptureDB()` — для
  пайплайну перекладу. Гейт `if ns.PUBLIC then return end` (у публічній збірці
  збирача немає). Сам збір працює завжди; `capture.notify` керує лише
  сповіщеннями в чаті. Не читає перекладацьких `ns.*` для підміни.

## Важливі примітки
- **`QuestPinHooks.lua`** — фактично мертвий код (`if true then return end`,
  ~рядок 16): реєстрацію `TooltipDataProcessor` знято навмисно через таїнт
  AreaPOI-пінів. Не видаляти бездумно — це свідоме вимкнення, не забутий баг.
- **`BookHooks.lua`, `EncounterJournalHooks.lua`** не мають `ns.IsEnabled(...)` —
  гейтяться лише через `ns.ShowOriginal()` (Shift).
- **`ChatHooks.lua`, `LootHooks.lua`** не використовують `hooksecurefunc`/
  `HookScript` — працюють через `ChatFrame_AddMessageEventFilter` та події
  (display-only, без таїнту).
- Спільний патерн майже всюди: walk по FontString + `ns.Remember` + `ns.SafeText`
  першим (секрет-заслін) + `ns.ApplyCyrFont`.
