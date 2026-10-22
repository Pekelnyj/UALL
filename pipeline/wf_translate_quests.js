export const meta = {
  name: 'translate-quests-wave',
  description: 'Хвиля перекладу квестів Midnight: батчі за args.from..args.to',
  whenToUse: 'Чергова хвиля повного перекладу квестів (батчі з data/batches/quests)',
  phases: [{ title: 'Переклад' }],
}

const FROM = args && args.from
const TO = args && args.to
if (!FROM || !TO) throw new Error('Потрібні args.from і args.to (номери батчів)')

const BATCHES = []
for (let i = FROM; i <= TO; i++) BATCHES.push(i)

const SCHEMA = {
  type: 'object',
  properties: { translated: { type: 'number' } },
  required: ['translated'],
}

const results = await parallel(BATCHES.map(n => () => {
  const nnn = String(n).padStart(3, '0')
  return agent(`Ти — перекладач української локалізації World of Warcraft: Midnight. Якість понад усе: переклад читатимуть тисячі гравців.

КРОК 1. Прочитай правила стилю і глосарій: g:\\Claude Code\\WoWUkraine\\pipeline\\glossary.md — ОБОВ'ЯЗКОВО. Особливо правило №7 (тільки загальновживана лексика, жодних архаїзмів) і №8 (звіряйся з de/fr).

КРОК 2. Прочитай файл g:\\Claude Code\\WoWUkraine\\data\\batches\\quests\\batch_${nnn}.json — масив квестів: {"id", "title": {"en","de","fr"}, "description": {"en","de","fr"}, інколи "objectives"}.

КРОК 3. Переклади КОЖЕН квест: title, description і objectives (якщо є) українською.
- de/fr дано для звірки: рід, однина/множина, особа-чи-організація, неоднозначні терміни — дивись, як вирішили німці й французи
- Плейсхолдери {name}, {class}, {race} зберігай ТОЧНО як у en. Якщо плейсхолдер у звертанні і потрібен кличний відмінок — пиши {class:v} / {race:v}
- NPC звертаються до гравця на «ти»
- Переноси рядків зберігай (\\n як у оригіналі; \\r\\n заміняй на \\n)
- Імена власні — за глосарієм; нема в глосарії — усталена транслітерація (Сільвермун, Кель'Талас)
- Природна жива українська, без кальок з англійського порядку слів

КРОК 4. ОДРАЗУ запиши результат у g:\\Claude Code\\WoWUkraine\\data\\batches\\quests\\out_${nnn}.json (utf-8):
[{"id": "<як у вході>", "title": "...", "description": "...", "objectives": "..."}, ...]
- поле objectives лише якщо було у вході
- ЗАПИС ФАЙЛУ — НАЙВАЖЛИВІШИЙ КРОК: спершу запиши, потім усе інше

Поверни {"translated": N}.`,
    { label: `квести:батч ${nnn}`, phase: 'Переклад', schema: SCHEMA })
}))

const done = results.filter(Boolean)
log(`Хвиля ${FROM}-${TO}: ${done.length}/${BATCHES.length} батчів, ${done.reduce((s, r) => s + r.translated, 0)} квестів`)
return { from: FROM, to: TO, batches: done.length, translated: done.reduce((s, r) => s + r.translated, 0) }