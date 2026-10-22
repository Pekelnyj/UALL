-- WoWUkraine: трекер цілей на екрані (список квестів праворуч).
-- Перемикач: «Квести → Трекер цілей на екрані» (quests.tracker).
--
-- Перекладаємо три типи рядків:
--   1. Назви квестів — з бази ns.quests (звіряємо EN-назву через журнал).
--   2. Рядки цілей «Crates discarded: 2/3» — база ns.questObjectives
--      (ключ — текст БЕЗ лічильника), лічильник зберігаємо як є.
--   3. Заголовки секцій трекера (Quests, Campaign...) — точний збіг.
--
-- Підхід той самий, що в ClassSpecHooks: обхід FontString-ів, підміна
-- лише видимого тексту, оригінали пам'ятаємо для клавіші «оригінал».

local _, ns = ...

local HEADERS = {
    ["Objectives"] = "Цілі",
    ["All Objectives"] = "Всі цілі",
    ["Quests"] = "Квести",
    ["Campaign"] = "Кампанія",
    ["World Quests"] = "Світові квести",
    ["Bonus Objectives"] = "Додаткові цілі",
    ["Achievements"] = "Досягнення",
    ["Scenario"] = "Сценарій",
    ["Dungeon"] = "Підземелля",
    ["Proving Grounds"] = "Випробувальний полігон",
    ["Monthly Activities"] = "Місячні активності",
}

-- EN-назва квесту -> UA. Клієнт англійський, тож назва з журналу — оригінал.
-- Перебудовується при кожному оновленні трекера (журнал — до ~100 записів),
-- але не частіше ніж раз на пів секунди (події приходять чергами).
local titleLookup = {}
-- objLookup[EN-ціль] = UA-ціль. Ціль-РЕЗЮМЕ квесту в базі лежить за questID
-- (ns.quests[id].objectives), а не за текстом; список журналу шукає ЗА ТЕКСТОМ,
-- тож без цього містка ціль у списку лишалась англійською (хоч деталі, що беруть
-- за questID, її показували українською). EN-текст цілі беремо в ГРИ в рантаймі
-- (GetQuestObjectives повертає локаллю клієнта = англ.), UA — з нашого questID→UA.
-- ГЕЙТ: лише квести з ОДНІЄЮ ціллю — щоб єдиний UA-блоб не приліпити до одного з
-- кількох рядків багатоцільового квесту (ті йдуть через ns.questObjectives).
local objLookup = {}
local lastTitleBuild = 0
local function AddObjBridge(qid)
    if not (qid and C_QuestLog.GetQuestObjectives) then return end
    local t = ns.quests[qid]
    local uaObj = t and t.objectives
    if not (uaObj and uaObj ~= "") then return end
    local objs = C_QuestLog.GetQuestObjectives(qid)
    if type(objs) == "table" and #objs == 1 then
        local o = objs[1]
        -- ЛІЧИЛЬНИКОВІ цілі (kill/collect «X/Y», progressbar «%») НЕ місткуємо:
        -- гра формує «Flamewaker slain» + окремий лічильник 8, а наша summary-ціль
        -- («Убий 8 Полум'яних слуг») число має вбите й слота лічильника не має —
        -- місток затер би «X/Y». Такі йдуть через TranslateObjectiveLine (зберігає
        -- лічильник). Місток лишаємо лише для одноцільових БЕЗ лічильника (події/
        -- розмови) — саме він фіксить англ. назву цілі в списку.
        if o and (o.type == "progressbar" or (o.numRequired and o.numRequired > 1)) then
            return
        end
        local en = o and o.text
        if en and en ~= "" and not (ns.HasCyrillic and ns.HasCyrillic(en)) then
            objLookup[en] = uaObj
        end
    end
end
local function RebuildTitleLookup()
    if not ns.quests then return end
    if GetTime() - lastTitleBuild < 0.5 then return end
    lastTitleBuild = GetTime()
    titleLookup = {}
    objLookup = {}
    -- 1) Квести в журналі (як було).
    for i = 1, C_QuestLog.GetNumQuestLogEntries() do
        local info = C_QuestLog.GetInfo(i)
        if info and not info.isHeader and info.questID and info.title then
            local t = ns.quests[info.questID]
            if t and t.title then
                titleLookup[info.title] = t.title
            end
            AddObjBridge(info.questID)
        end
    end
    -- 2) Відстежувані квести (мінімапа/мапа показують саме їх — інколи
    --    вони поза звичайною нумерацією журналу).
    if C_QuestLog.GetNumQuestWatches then
        for i = 1, C_QuestLog.GetNumQuestWatches() do
            local qid = C_QuestLog.GetQuestIDForQuestWatchIndex
                and C_QuestLog.GetQuestIDForQuestWatchIndex(i)
            local t = qid and ns.quests[qid]
            local en = qid and C_QuestLog.GetTitleForQuestID
                and C_QuestLog.GetTitleForQuestID(qid)
            if t and t.title and en then titleLookup[en] = t.title end
            if qid then AddObjBridge(qid) end
        end
    end
    -- 3) СВІТОВІ КВЕСТИ — окремий список стеження (WQ НЕ в GetNumQuestWatches
    --    і НЕ в журналі, тож їхні заголовки в трекері лишалися англійськими,
    --    хоч цілі під ними перекладені; напр. «Bleed the Spire»→«Знекровити Шпиль»).
    if C_QuestLog.GetNumWorldQuestWatches then
        for i = 1, C_QuestLog.GetNumWorldQuestWatches() do
            local qid = C_QuestLog.GetQuestIDForWorldQuestWatchIndex
                and C_QuestLog.GetQuestIDForWorldQuestWatchIndex(i)
            local t = qid and ns.quests[qid]
            local en = qid and C_QuestLog.GetTitleForQuestID
                and C_QuestLog.GetTitleForQuestID(qid)
            if t and t.title and en then titleLookup[en] = t.title end
            if qid then AddObjBridge(qid) end
        end
    end
end

-- Прибирає кольорові коди |cAARRGGBB...|r, ТЕКСТУРИ/АТЛАСИ |T..|t |A..|a (зокрема
-- стрілку ▲/▼ напрямку «вище/нижче», яку гра додає до тултіпа квесту/POI на
-- мінімапі, коли об'єкт на іншій висоті — САМЕ через неї точний збіг ламався на
-- відстані) і префікс рівня «[80] ». TranslateOneLine підставляє переклад
-- ПІДРЯДКОМ замість очищеного тексту, тож стрілка/коди довкола зберігаються.
local function StripDecorations(text)
    local s = text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
    s = s:gsub("|T.-|t", ""):gsub("|A.-|a", "")   -- інлайн-текстури/атласи (стрілки)
    s = s:gsub("^%s*%[%d+%+?%]%s*", "")
    return s:gsub("^%s+", ""):gsub("%s+$", "")
end

-- Пара «оригінал/переклад» кожного зміненого напису (слабкі ключі).
local originals = ns.replacements -- спільний центральний реєстр (Shift свопає його)

-- Виокремлює «голу» ціль без лічильника з трьох форматів:
-- "2/10 Текст" | "Текст: 2/10" | "Текст (47%)". nil, якщо лічильника нема.
local function ObjectiveBase(text)
    local base = text:match("^[%d]+/[%d]+%s+(.+)$")
    if base then return base end
    base = text:match("^(.-)%s*:%s*[%d%./%%%s]+$")
    if base then return base end
    base = text:match("^(.-)%s*%([%d%./%%%s]+%)$")
    return base
end

-- Знімає маркер цілі «- »/«• » попереду, якщо він є в самому тексті.
local function StripDash(text)
    return (text:gsub("^%s*[%-•–—]%s*", ""))
end

-- Неперекладені цілі складаємо в CaptureDB на майбутній переклад
-- (сезонні/динамічні/без-лічильникові — серверні, в офлайн-даних їх нема).
-- Назви квестів (titleLookup) НЕ збираємо — то інша категорія.
local function CaptureObjective(text)
    if ns.HasCyrillic(text) then return end           -- ВЖЕ перекладено — не збирати
    local base = ObjectiveBase(text) or StripDash(text)
    if not base or base == "" then return end
    if not base:find("%a") then return end           -- лише текст, не числа
    if #base > 120 then return end                    -- не описи/довгі рядки
    if titleLookup[base] or titleLookup[text] then return end -- це назва квесту
    if ns.questObjectives and ns.questObjectives[base] then return end
    local db = ns.GetCaptureDB()
    db.objLines = db.objLines or {}   -- окремо від db.objectives (/wowukraine цілі)
    db.objLines[base] = true
end

-- Kill-цілі «{Моб} slain/killed/defeated/destroyed» клієнт формує РАНТАЙМ із імені
-- істоти — у офлайн-БД їх нема. Підставляємо переклад імені з ns.npcNames + дієслово.
-- ГЕЙТ — world.npcNames (це переклад імен NPC; типово вимкнено, як і всюди).
local KILL_VERB = { slain = "вбито", killed = "вбито", defeated = "переможено",
                    destroyed = "знищено", slaughtered = "перебито" }
local function KillObjectiveUA(base)
    if not ns.npcNames or not ns.IsEnabled("world.npcNames") then return nil end
    local creature, verb = base:match("^(.+)%s+(%a+)$")
    if not creature then return nil end
    local uaVerb = KILL_VERB[verb:lower()]
    if not uaVerb then return nil end
    local uaName = ns.npcNames[creature]
    if uaName then return uaName .. " " .. uaVerb end
    return nil
end

-- ЧАСОВІ РЯДКИ світових завдань: «Time Left: |cffffffff14 Hours|r».
-- Значення має ВЛАСНИЙ колір (біле число на жовтому підписі), тому переклад усього
-- рядка одним шматком губив цей колір — усе ставало жовтим. Міняємо слова НА МІСЦІ:
-- кольорові коди й числа лишаються рівно там, де стояли.
local HOUR_FORMS = { "година", "години", "годин" }
local MIN_FORMS  = { "хвилина", "хвилини", "хвилин" }
local DAY_FORMS  = { "день", "дні", "днів" }
local SEC_FORMS  = { "секунда", "секунди", "секунд" }
local function PluralUA(n, forms)
    n = tonumber(n) or 0
    local n10, n100 = n % 10, n % 100
    if n10 == 1 and n100 ~= 11 then return forms[1] end
    if n10 >= 2 and n10 <= 4 and (n100 < 12 or n100 > 14) then return forms[2] end
    return forms[3]
end
local function TranslateTimeLine(line)
    -- «Time Left: …» АБО голий відлік («11 seconds» у блоці бойовища/сценарію)
    if not (line:find("Time Left", 1, true)
            or line:match("^%s*%d+%s*[HhMmSsDd]%a*%s*$")) then return nil end
    local out = line:gsub("Time Left", "Лишилось часу")
    -- спершу серверні форми множини |4Hour:Hours;, тоді звичайні слова
    out = out:gsub("(%d+)(%s*)|4[Hh]our:[Hh]ours;", function(n, s) return n .. s .. PluralUA(n, HOUR_FORMS) end)
    out = out:gsub("(%d+)(%s*)|4[Mm]in:[Mm]in;",    function(n, s) return n .. s .. PluralUA(n, MIN_FORMS) end)
    out = out:gsub("(%d+)(%s*)|4[Dd]ay:[Dd]ays;",   function(n, s) return n .. s .. PluralUA(n, DAY_FORMS) end)
    out = out:gsub("(%d+)(%s*)[Hh]ours", function(n, s) return n .. s .. PluralUA(n, HOUR_FORMS) end)
    out = out:gsub("(%d+)(%s*)[Hh]our",  function(n, s) return n .. s .. PluralUA(n, HOUR_FORMS) end)
    out = out:gsub("(%d+)(%s*)[Mm]inutes", function(n, s) return n .. s .. PluralUA(n, MIN_FORMS) end)
    out = out:gsub("(%d+)(%s*)[Mm]ins",  function(n, s) return n .. s .. PluralUA(n, MIN_FORMS) end)
    out = out:gsub("(%d+)(%s*)[Mm]in",   function(n, s) return n .. s .. PluralUA(n, MIN_FORMS) end)
    out = out:gsub("(%d+)(%s*)[Dd]ays",  function(n, s) return n .. s .. PluralUA(n, DAY_FORMS) end)
    out = out:gsub("(%d+)(%s*)[Dd]ay",   function(n, s) return n .. s .. PluralUA(n, DAY_FORMS) end)
    out = out:gsub("(%d+)(%s*)[Ss]econds", function(n, s) return n .. s .. PluralUA(n, SEC_FORMS) end)
    out = out:gsub("(%d+)(%s*)[Ss]econd",  function(n, s) return n .. s .. PluralUA(n, SEC_FORMS) end)
    out = out:gsub("(%d+)(%s*)[Ss]ec",     function(n, s) return n .. s .. PluralUA(n, SEC_FORMS) end)
    if out ~= line then return out end
    return nil
end
ns.TranslateTimeLine = TranslateTimeLine

-- Переклад «голої» цілі: спершу офлайн-БД, тоді kill-підстановка імені моба.
-- Виконану ціль гра дописує суфіксом «(Complete)». Окремих записів під кожен
-- суфікс НЕ тримаємо (це дублювало б усю базу цілей): стрипаємо суфікс,
-- перекладаємо основу, суфікс повертаємо вже українською.
-- Ціль-ПРЕДМЕТ («1/1 Довідник травника…»): клієнт будує рядок РАНТАЙМ із назви
-- предмета, тож у БД цілей його може не бути (DB2-дамп QuestObjective відстає від
-- патчу — свіжі квести Midnight там ще відсутні). Сам предмет при цьому давно
-- перекладено, тож резолвимо назву → itemID через кеш клієнта й беремо ns.items.
-- Не вдалося (нема в кеші) — тихо лишаємо як є, гірше не робимо.
local function ItemObjectiveUA(base)
    if not ns.items or not ns.IsEnabled("items.name") then return nil end
    local getInfo = C_Item and C_Item.GetItemInfoInstant
    if not getInfo then return nil end
    local ok, itemID = pcall(getInfo, base)
    if ok and itemID then
        local ua = ns.items[itemID]
        if type(ua) == "string" and ua ~= "" then return ua end
    end
    return nil
end

local function ObjUA(base)
    local ua = (ns.questObjectives and ns.questObjectives[base])
               or KillObjectiveUA(base) or ItemObjectiveUA(base)
    if ua then return ua end
    local core = base:match("^(.-)%s*%(Complete%)$")
    if core and core ~= "" then
        local uaCore = (ns.questObjectives and ns.questObjectives[core])
                       or KillObjectiveUA(core) or ItemObjectiveUA(core)
        if uaCore then return uaCore .. " (Виконано)" end
    end
    return nil
end

-- Рядок цілі з лічильником: переклад тексту, лічильник лишається.
-- 12.0-трекер пише лічильник ПОПЕРЕДУ ("2/10 Injured Warriors healed"),
-- журнал/вікно квесту — у кінці ("Injured Warriors healed: 2/10").
local function TranslateObjectiveLine(text)
    local counter, base = text:match("^([%d]+/[%d]+)%s+(.+)$")
    if base then
        local ua = ObjUA(base)
        if ua then return counter .. " " .. ua end
    end
    local base2, counter2 = text:match("^(.-)%s*:%s*([%d%./%%%s]+)$")
    if base2 then
        local ua = ObjUA(base2)
        if ua then return ua .. ": " .. counter2 end
    end
    -- "Текст (5/10)" або "Текст (47%)" — лічильник/відсоток у дужках.
    local base3, counter3 = text:match("^(.-)%s*%(([%d%./%%%s]+)%)$")
    if base3 then
        local ua = ObjUA(base3)
        if ua then return ua .. " (" .. counter3 .. ")" end
    end
    -- без лічильника — теж пробуємо kill-підстановку
    return KillObjectiveUA(text)
end

local function TranslateText(text)
    text = ns.SafeText(text) -- секретні значення -> nil, без падіння
    if not text then return nil end
    local ua = titleLookup[text]
        or HEADERS[text]
        or (ns.scenario and ns.scenario[text])           -- назви/кроки сценаріїв
        or (ns.minimapLabels and ns.minimapLabels[text]) -- позначки мінімапи (Mailbox…)
        or (ns.questObjectives and ns.questObjectives[text]) -- ТОЧНА ціль-лідерборд (лічильник цілий)
        or TranslateObjectiveLine(text)                  -- «X/Y ціль» — лічильник зберігається
        or objLookup[text]  -- ОСТАННІЙ запас: ціль-РЕЗЮМЕ квесту (questID→summary). Ставимо
                            -- в КІНЕЦЬ: для лічильникових цілей («Flamewaker slain»→«8/8 …вбито»,
                            -- «Hoe inspected»→«0/1 Оглянуто сапу») пріоритет мають точні форми
                            -- вище — інакше summary-речення («Убий 8…») затирало б лічильник.
    if ua then return ua end
    -- Kaliel's Tracker/квест-теги на початку заголовка: «[90d] Назва», «[Elite] Назва»,
    -- «[Group] Назва» тощо — стрипаємо тег, перекладаємо решту, повертаємо тег на місце.
    local tag, rest = text:match("^(%[[^%]]*%]%s*)(.+)$")
    if tag and rest and not ns.HasCyrillic(rest) then
        local ua2 = TranslateText(rest)
        if ua2 then return tag .. ua2 end
    end
    return nil
end

-- БЕЗПЕЧНЕ лікування накладання: замість SetMaxLines (який вішав гру)
-- обрізаємо сам РЯДОК до ширини віконця й додаємо «…». Текст лишається
-- одним рядком — Blizzard нічого не перераховує, циклу немає.

-- UTF-8-безпечні довжина й підрядок (кирилиця — багатобайтова, не можна
-- різати посеред символу).
local function utf8len(s)
    local n = 0
    for i = 1, #s do
        local b = s:byte(i)
        if b < 0x80 or b >= 0xC0 then n = n + 1 end
    end
    return n
end

local function utf8sub(s, count)
    local i, c, len = 1, 0, #s
    while i <= len and c < count do
        local b = s:byte(i)
        if b < 0x80 then i = i + 1
        elseif b < 0xE0 then i = i + 2
        elseif b < 0xF0 then i = i + 3
        else i = i + 4 end
        c = c + 1
    end
    return s:sub(1, i - 1)
end

-- Прихований напис для вимірювання ширини тексту в пікселях.
local measurer = UIParent:CreateFontString(nil, "ARTWORK")
measurer:Hide()

-- Кеш результатів підгонки (ключ: текст + округлена ширина) — у делві
-- ті самі рядки міряються багато разів; кеш знімає зайву роботу.
local fitCache = {}

-- Підганяє український текст під віконце трекера. КЛЮЧОВЕ: оригінал (en) уже
-- зверстаний у N рядків, і Blizzard виділив під блок висоту саме на ці N рядків.
-- Тож дозволяємо нашому тексту зайняти СТІЛЬКИ Ж рядків (хай переноситься, як
-- оригінал) — це не виходить за виділену висоту, не чіпає SetMaxLines і не
-- накладається на сусідні елементи. «…» обрізаємо ЛИШЕ якщо нам треба БІЛЬШЕ
-- рядків, ніж в оригіналу. origLines беремо з уже відмальованого fs (GetNumLines),
-- підстраховуючись оцінкою за шириною оригіналу.
local function FitToWidth(fs, en, ua)
    -- ВИНЯТОК: короткий підпис «Level N» у блоці сценарію/М+ (parentKey .Level,
    -- Blizzard_ScenarioObjectiveTracker.xml). Його віконце — 55.6 px: «Level 13»
    -- влазить, довше «Рівень 13» ні, і ми чесно різали його до «Рівень …».
    -- Саме це тестер бачив як «обрізання», хоча рушій тут ні до чого
    -- (діагностика /uall lvl: обрізано=false, ширина=рядок=безмежний=55.6).
    -- Різати НЕ можна: це не багаторядкова ціль трекера, а підпис із числом,
    -- і втрата числа робить його безглуздим. Напис має ОДИН якір (TOPLEFT),
    -- тож ширину можна просто збільшити — це робить ns.UnclipIfTruncated,
    -- якого викликає той самий колбек одразу після нас.
    local par = fs.GetParent and fs:GetParent()
    if par and rawget(par, "Level") == fs then return ua end

    local width = fs.GetWidth and fs:GetWidth()
    if not width or width <= 4 then return ua end -- ширини нема — не чіпаємо

    -- ЗАМКНЕНЕ КОЛО: у напису БЕЗ заданої ширини GetWidth() — це не обмеження, а
    -- РЕЗУЛЬТАТ: він дорівнює ширині поточного тексту. Міряти довший переклад по
    -- ширині коротшого оригіналу означає «не влазить» ЗАВЖДИ, хоч би скільки
    -- вільного місця було поруч. Саме так «Рівень 13» перетворювався на «Рівень …»
    -- у віконці, куди влізло б і «Рівень 999».
    -- Ознака автоширини: ширина віконця збігається з шириною рядка. Тоді різати
    -- не можна — треба розширювати, що й робить ns.UnclipIfTruncated.
    local sw = fs.GetStringWidth and fs:GetStringWidth()
    if sw and math.abs(width - sw) < 1 then return ua end
    local font, size, flags = fs:GetFont()
    if not font then return ua end
    -- SetFont заблокована в обмежених контекстах (кінематик/захищений UI 11.x+):
    -- кидає «Use of function 'SetFont' is disallowed». БЕЗ pcall це флудило db.errors
    -- під час сініматика (трекер оновлював цілі → десятки викликів) і могло гальмувати.
    -- pcall ловить: вимір піде зі старим шрифтом (косметично, лише на той момент).
    if not pcall(measurer.SetFont, measurer, font, size, flags) then return ua end
    -- ВИМІРЮЄМО РЕАЛЬНИЙ ПЕРЕНОС: ставимо ширину віконця і рахуємо GetNumLines —
    -- це точно, на відміну від оцінки «ширина/вікно» (вона брехала: текст влазив
    -- за сумарною шириною, але перенос слів давав зайвий рядок → налазило).
    measurer:SetWidth(width)
    -- скільки рядків займає ОРИГІНАЛ: відмальований fs АБО вимір EN з переносом.
    local origLines = (fs.GetNumLines and fs:GetNumLines()) or 0
    if en then
        measurer:SetText(en)
        origLines = math.max(origLines, measurer:GetNumLines() or 0)
    end
    if origLines < 1 then origLines = 1 end
    local key = ua .. "@" .. math.floor(width) .. "x" .. origLines
    local cached = fitCache[key]
    if cached ~= nil then return cached end
    -- скільки рядків займе UA при тій самій ширині (реальний перенос)
    measurer:SetText(ua)
    local uaLines = measurer:GetNumLines() or 0
    if uaLines == 0 or uaLines <= origLines then
        fitCache[key] = ua; return ua -- влазить у стільки ж рядків, що й оригінал
    end
    -- інакше обрізаємо «…», поки UA не вкладеться в origLines рядків
    local lo, hi, best = 1, utf8len(ua), nil
    while lo <= hi do
        local mid = math.floor((lo + hi) / 2)
        local cut = utf8sub(ua, mid) .. "…"
        measurer:SetText(cut)
        local n = measurer:GetNumLines() or 0
        if n <= origLines then
            best = cut; lo = mid + 1
        else
            hi = mid - 1
        end
    end
    best = best or ua
    fitCache[key] = best
    return best
end

-- ОДНОРЯДКОВІ написи фіксованої ширини (напр. «Level 10» у блоці Міфічного+):
-- ширину віконця Blizzard підігнав під АНГЛІЙСЬКИЙ рядок, а довше українське
-- «Рівень 10» рушій мовчки ріже й дописує «...» — виходило «Рівень ...».
-- FitToWidth тут не рятує: він стежить за КІЛЬКІСТЮ рядків, а рядок лишається один.
-- Тож після підстановки перевіряємо IsTruncated і даємо напису рівно стільки
-- ширини, скільки треба (у блоці праворуч є вільне місце). Тільки РОЗШИРЮЄМО.
-- Реалізація живе в Core.lua (ns.UnclipIfTruncated) — спільна для трекера,
-- банер-віджетів і неймплейтів. Тут лише локальний псевдонім, щоб не тримати
-- другу копію, яка почне розходитись при правках.
local function UnclipIfTruncated(fs)
    if ns.UnclipIfTruncated then ns.UnclipIfTruncated(fs) end
end

-- Лічильники одного проходу + приклади неперекладених текстів — у діаг-лог.
local seen, replaced, sampled = 0, 0, {}

local function TranslateFontString(fs)
    local text = ns.SafeText(fs:GetText()) -- секретне значення -> nil
    if not text then return end
    if ns.HasCyrillic(text) then return end -- ВЖЕ наш переклад — нічого не робимо
    local ua = TranslateText(text)
    if true then
        seen = seen + 1
        if not ua and #sampled < 4 then
            table.insert(sampled, (text:gsub("[\r\n].*", "")):sub(1, 45))
        end
    end
    if ua and ua ~= text then
        replaced = replaced + 1
        local fitted = ua
        -- FitToWidth («…») — ЛИШЕ для трекера (вузький стовпчик). На КНОПКАХ
        -- це обрізало підписи в «Покин…»/«Приб…». Кнопкам лишаємо повний текст.
        local parent = fs.GetParent and fs:GetParent()
        local okT, kind = false, nil
        if parent and parent.GetObjectType then okT, kind = pcall(parent.GetObjectType, parent) end
        if not (okT and kind == "Button") then
            -- передаємо ОРИГІНАЛ (text): дозволяємо стільки ж рядків, скільки в нього
            local ok, res = pcall(FitToWidth, fs, text, ua)
            if ok and res then fitted = res end
        end
        originals[fs] = { en = text, ua = fitted } -- зберігаємо показане
        pcall(fs.SetText, fs, fitted)
        UnclipIfTruncated(fs)                      -- «Рівень ...» → «Рівень 10»
    elseif not ua then
        ns.Guard("трекер", CaptureObjective, text)
    end
end

-- Хук на КОЖНОМУ блоці трекера: квестові/кампанійні блоки мають власні
-- похідні міксини, що скопіювали SetStringText ДО завантаження аддонів,
-- тож хук на базовій таблиці їх не ловить. Блоки пулються і
-- перевикористовуються — хукнути кожен досить один раз.
local hookedBlocks = setmetatable({}, { __mode = "k" })
local HookBlock -- заповнюється нижче, після оголошення обробника

-- БЕЗПЕЧНИЙ ре-фонт: ставимо кирилічний шрифт (з гліфами і/ї/є/ґ) на КОНКРЕТНИЙ
-- FontString незахищеного фрейму (журнал квестів, трекер). На відміну від
-- підміни СПІЛЬНИХ об'єктів шрифтів (Fonts.lua), це НЕ заражає захищений UI —
-- ми чіпаємо лише окремий напис цього фрейму, а не глобальний шрифт, який читає
-- панель дій. Так лагодимо «квадратики» в заголовках-зонах без taint кулдаунів.
local CYR_FONT = "Fonts\\FRIZQT___CYR.TTF"
local function ApplyCyrFont(fs)
    if not (fs and fs.GetFont and fs.SetFont) then return end
    -- захищені/заборонені написи (нова Blizzard_Menu тощо): SetFont заборонено
    -- (taint «Use of function 'SetFont' is disallowed»), pcall не глушить бо
    -- Blizzard репортить через assertsafe → не чіпаємо їх зовсім.
    if fs.IsForbidden and fs:IsForbidden() then return end
    local file, size, flags = fs:GetFont()
    if not size or not file then return end
    if file:find("CYR", 1, true) then return end -- вже кирилічний — не чіпати
    -- self-healing: якщо Blizzard скине шрифт назад, наступний прохід поверне.
    pcall(fs.SetFont, fs, CYR_FONT, size, flags)
end
ns.ApplyCyrFont = ApplyCyrFont  -- спільний хелпер (титули, інші списки) — без taint

local function WalkRegions(frame, depth)
    if ns.IsTooltipFrame(frame) then return  end
    if not frame or depth > 12 or not frame:IsShown() then return end
    if HookBlock then HookBlock(frame) end
    for _, region in ipairs(ns.Regions(frame)) do
        if region.IsObjectType and region:IsObjectType("FontString") then
            ApplyCyrFont(region)
            TranslateFontString(region)
        end
    end
    for _, child in ipairs(ns.Children(frame)) do
        WalkRegions(child, depth + 1)
    end
end

-- Повертає оригінали (тільки якщо напис досі містить нашу підміну).
-- pcall на GetText: у реєстрі може опинитись перероблений/невалідний віджет
-- (пули FontString), і `fs:GetText()` кидає «GetText on bad self» (лог db.errors).
local function RestoreOriginals()
    for fs, pair in pairs(originals) do
        if fs.GetText then
            local ok, txt = pcall(fs.GetText, fs)
            if ok and ns.SafeText(txt) == pair.ua then
                pcall(fs.SetText, fs, pair.en)
            end
        end
    end
end

-- Лог лише коли картина змінилась — без спаму на кожну подію.
local function DiagOnce(line)
    if line ~= ns.lastTrackerDiag then
        ns.lastTrackerDiag = line
        ns.Diag(line)
    end
end

-- Усі місця, де гра показує назви квестів і рядки цілей:
-- трекер праворуч, журнал квестів на мапі, вікно розмови з NPC.
local function WalkAll()
    if ObjectiveTrackerFrame and ObjectiveTrackerFrame:IsShown() then
        WalkRegions(ObjectiveTrackerFrame, 1)
    end
    -- Kaliel's Tracker (KT): власний фрейм замість Blizzard-трекера (Blizzard-фрейм
    -- KT ховає, тож гілка вище не спрацьовує). Обходимо KT-фрейм окремо — лише коли
    -- увімкнено опцію «Сторонні аддони → Kaliel's Tracker (тестово)».
    if ns.IsEnabled("compat.kalielsTracker")
        and _G.KT_ObjectiveTrackerFrame and _G.KT_ObjectiveTrackerFrame.IsShown
        and _G.KT_ObjectiveTrackerFrame:IsShown() then
        WalkRegions(_G.KT_ObjectiveTrackerFrame, 1)
    end
    if QuestMapFrame and QuestMapFrame:IsShown() then
        WalkRegions(QuestMapFrame, 1)
    end
    if QuestInfoObjectivesFrame and QuestInfoObjectivesFrame:IsShown() then
        WalkRegions(QuestInfoObjectivesFrame, 1)
    end
end

local function Refresh()
    if not ns.IsEnabled("quests.tracker") then
        DiagOnce("трекер: вимкнено в налаштуваннях")
        return
    end
    if ns.ShowOriginal() then
        RestoreOriginals()
        return
    end
    ns.Prof("трекер: список назв", RebuildTitleLookup)
    seen, replaced, sampled = 0, 0, {}
    local ok, err = ns.Prof("трекер: обхід", pcall, WalkAll)
    if not ok then ns.Diag("ПОМИЛКА трекера: " .. tostring(err)) end
    -- Діагностику трекера пишемо ЛИШЕ в режимі debug: інакше вона щосекунди
    -- заповнює лог і витісняє важливіше (помилки). Помилки тепер у db.errors.
    if ns.debug then
        local titles = 0
        for _ in pairs(titleLookup) do titles = titles + 1 end
        DiagOnce(("трекер: написів %d | перекладено %d | назв %d | без перекладу: %s")
            :format(seen, replaced, titles, table.concat(sampled, " ‖ ")))
    end
end

-- Оновлення з невеликою затримкою: події приходять пачками, а Blizzard
-- виставляє тексти трекера вже ПІСЛЯ події — чекаємо кадр-другий.
local pending = false
local function QueueRefresh()
    if pending then return end
    pending = true
    C_Timer.After(0.2, function()
        pending = false
        Refresh()
    end)
end

-- Обробники подій виконуються ДО промальовування кадру: синхронний прохід
-- тут означає, що гравець англійського тексту не побачить узагалі.
-- Відкладений QueueRefresh лишається для трекера, який Blizzard оновлює
-- із власною затримкою вже після події.
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("QUEST_LOG_UPDATE")
f:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
f:RegisterEvent("QUEST_WATCH_UPDATE")
f:RegisterEvent("SUPER_TRACKING_CHANGED")
f:SetScript("OnEvent", function(_, event)
    Refresh()
    QueueRefresh()
    -- Вікно мапи/журналу з'являється на цьому ж кадрі — перекладаємо
    -- його в момент показу, до першого промальовування.
    if event == "PLAYER_ENTERING_WORLD" and QuestMapFrame
        and not ns.questMapHooked then
        ns.questMapHooked = true
        QuestMapFrame:HookScript("OnShow", Refresh)
        if WorldMapFrame then
            WorldMapFrame:HookScript("OnShow", Refresh)
        end
        ns.Diag("хук списку квестів: " .. tostring(ns.lastListHook))
    end
end)

-- Blizzard перемальовує трекер і БЕЗ подій (згортання, наведення миші,
-- перебудова списку) — наш текст при цьому злітає. Тихий цикл раз на
-- секунду повертає переклад; підміна за точним збігом, повторно нічого
-- не чіпає, тож прохід дешевий (~60 написів).
C_Timer.NewTicker(1, function() ns.Prof("трекер 1с", QueueRefresh) end)

-- ШВИДКИЙ переклад: перехоплюємо SetText усіх FontString-ів (метатаблиця),
-- але НІКОЛИ не міняємо текст усередині виклику Blizzard — інакше
-- перерахунок розмітки трекера зациклюється і гра зависає (перевірено).
-- Натомість напис стає в чергу і підміняється НАСТУПНОГО кадру (~16 мс):
-- оку непомітно, а петля неможлива — повторний прохід бачить, що текст
-- уже українська, і нічого не ставить.
-- Канонічний хук трекера: УВЕСЬ текст блоків (заголовок блоку і кожен
-- рядок цілі) Blizzard ставить через ObjectiveTrackerBlockMixin:
-- SetStringText(fontString, text, ...). Хукаємо ЛИШЕ його — синхронно,
-- у тому ж виклику: англійський текст не доживає до промальовування,
-- і скільки б разів гра не переставляла текст квесту у фокусі, гравець
-- бачить стабільну українську. Жодних глобальних перехоплень SetText.
local applying = false

-- СИНХРОННИЙ переклад у момент, коли Blizzard ставить текст блоку через
-- ObjectiveTrackerBlockMixin:SetStringText. Перекладаємо в тому ж виклику,
-- ДО промальовування — без блимання (так само, як вікно квесту).
-- КЛЮЧОВЕ: краш минулого разу був від SetMaxLines (рекурсивний перерахунок
-- висоти трекера). Тут його НЕМАЄ — лише FitToWidth, що обрізає САМ рядок
-- (fs:SetText коротшого тексту НЕ викликає block:SetStringText, тож циклу
-- немає), і guard `applying` від повторного входу.
local function OnBlockSetStringText(_, fontString, text)
    if applying or not fontString then return end
    text = ns.SafeText(text) -- секретне значення трекера -> nil, не падаємо
    if not text then return end
    if ns.HasCyrillic(text) then return end -- ВЖЕ наш переклад — не чіпаємо
    if not ns.IsEnabled("quests.tracker") or ns.ShowOriginal() then return end
    ns.Guard("трекер", RebuildTitleLookup)
    local ua = TranslateText(text)
    if ua and ua ~= text then
        local fitted = ua
        local ok, res = pcall(FitToWidth, fontString, text, ua)
        if ok and res then fitted = res end
        originals[fontString] = { en = text, ua = fitted }
        applying = true
        pcall(fontString.SetText, fontString, fitted)
        UnclipIfTruncated(fontString)
        applying = false
    elseif not ua then
        ns.Guard("трекер", CaptureObjective, text)
    end
end

-- Хук на базовій mixin-таблиці (блоки, що успадковують напряму)...
if ObjectiveTrackerBlockMixin
    and type(ObjectiveTrackerBlockMixin.SetStringText) == "function" then
    hooksecurefunc(ObjectiveTrackerBlockMixin, "SetStringText", OnBlockSetStringText)
end

-- KALIEL'S TRACKER: власний форк ObjectiveTracker (Blizzard-трекер сховано). Має
-- ІДЕНТИЧНИЙ сигнатурою KT_ObjectiveTrackerBlockMixin:SetStringText — хукаємо тим
-- САМИМ обробником, тож текст цілей/назв перекладається синхронно й у KT.
-- (KT завантажується першим через «!»-префікс, тож KT_-глобали вже є; додатковий
-- ретрай у HookAllLayoutModules на подіях — про всяк випадок.)
if _G.KT_ObjectiveTrackerBlockMixin
    and type(_G.KT_ObjectiveTrackerBlockMixin.SetStringText) == "function" then
    hooksecurefunc(_G.KT_ObjectiveTrackerBlockMixin, "SetStringText", function(block, fs, text)
        if ns.IsEnabled("compat.kalielsTracker") then OnBlockSetStringText(block, fs, text) end
    end)
end

-- ...і на кожному живому блоці (похідні міксини квестів/кампанії, що
-- скопіювали метод до завантаження аддона). Викликається з обходу.
HookBlock = function(frame)
    if hookedBlocks[frame] then return end
    if type(frame.SetStringText) ~= "function" then return end
    hookedBlocks[frame] = true
    hooksecurefunc(frame, "SetStringText", OnBlockSetStringText)
end

-- ДЕЛВИ/СЦЕНАРІЇ — окремий шлях рендеру. Модуль ScenarioObjectiveTracker
-- (делви — це сценарії; також BonusObjectiveTracker) розкладає вміст через
-- :LayoutContents, а НЕ через block:SetStringText, тож синхронний хук вище
-- його не ловить. До того ж делв-блок має ЖИВЕ HP (♥) і тир, які Blizzard
-- оновлює щокадру в бою (на кожен каст) → щоразу СКИДАЄ весь трекер на англ.,
-- а наш re-walk висить лише на квест-подіях і відстає → видиме БЛИМАННЯ
-- цілого трекера між UA та EN. Лагодимо: хук :LayoutContents → синхронний
-- прохід по ВСЬОМУ трекеру (заголовки модулів + блоки + цілі) одразу після
-- розкладки, ДО промальовування. WalkAll ідемпотентний (кириличне пропускає),
-- тож зайвих SetText немає, циклу немає.
-- НЕ прив'язуємось до назв модулів (на Midnight 12.0 вони можуть відрізнятись
-- від War Within). Хукаємо :LayoutContents на КОЖНОМУ живому модулі трекера —
-- беремо їх із самого ObjectiveTrackerFrame.modules (+ відомі глобали як запас).
local function HookLayoutOn(mod, label)
    if not mod or mod.__ua_layout_hooked then return false end
    if type(mod.LayoutContents) ~= "function" then return false end
    mod.__ua_layout_hooked = true
    -- Найгарячіша точка модуля: LayoutContents трекер викликає пачками —
    -- на прийняття квесту, на кожне оновлення цілі, на згортання блоку. Обхід
    -- тут СИНХРОННИЙ (інакше кадр блимне англійською), тож якщо мікрофризи
    -- лишилися саме в квестовому UI, вони мають бути видні тут.
    hooksecurefunc(mod, "LayoutContents", function()
        if not ns.IsEnabled("quests.tracker") or ns.ShowOriginal() then return end
        ns.Prof("трекер: LayoutContents", function()
            ns.Guard("трекер", RebuildTitleLookup)
            ns.Guard("трекер", WalkAll)
        end)
    end)
    return true
end
local function HookAllLayoutModules()
    local hooked = {}
    -- 1) живий список модулів трекера (версієнезалежно)
    local otf = ObjectiveTrackerFrame
    if otf and type(otf.modules) == "table" then
        for _, mod in pairs(otf.modules) do
            if HookLayoutOn(mod) then
                hooked[#hooked + 1] = (mod.GetName and mod:GetName()) or "?"
            end
        end
    end
    -- 2) запас: відомі глобали (War Within і ймовірні на Midnight)
    for _, n in ipairs({ "ScenarioObjectiveTracker", "BonusObjectiveTracker",
                         "DelvesObjectiveTracker", "WorldQuestObjectiveTracker" }) do
        if HookLayoutOn(_G[n]) then hooked[#hooked + 1] = n end
    end
    -- 3) Kaliel's Tracker: базовий модуль-міксин (усі KT-модулі успадковують
    -- LayoutContents звідси) + живі модулі з KT-менеджера
    if HookLayoutOn(_G.KT_ObjectiveTrackerModuleMixin) then hooked[#hooked + 1] = "KT_module" end
    if KT and KT.ObjectiveTrackerManager and type(KT.ObjectiveTrackerManager.modules) == "table" then
        for _, mod in pairs(KT.ObjectiveTrackerManager.modules) do
            if HookLayoutOn(mod) then hooked[#hooked + 1] = "KT_mod" end
        end
    end
    if #hooked > 0 then
        DiagOnce("трекер LayoutContents хукнуто: " .. table.concat(hooked, ", "))
    end
end
HookAllLayoutModules()
-- модулі будуються ліниво — повторюємо після входу у світ
if C_Timer then
    C_Timer.After(3, HookAllLayoutModules)
    C_Timer.After(10, HookAllLayoutModules)
end

-- СПИСОК КВЕСТІВ У ЖУРНАЛІ (клавіша L): Blizzard перебудовує його
-- власними функціями оновлення — хукаємо їх і перекладаємо синхронно,
-- у тому ж виклику: список не встигає показатись англійським.
-- (Назва функції мінялась між версіями — пробуємо всі відомі.)
local function RefreshQuestLogList()
    if not ns.IsEnabled("quests.tracker") then return end
    if ns.ShowOriginal() then return end
    ns.Guard("трекер", RebuildTitleLookup)
    local list = QuestMapFrame and QuestMapFrame.QuestsFrame
    if list then
        local ok, err = pcall(WalkRegions, list, 1)
        if not ok then ns.Diag("ПОМИЛКА списку квестів: " .. tostring(err)) end
    end
end

local hookedListFn = "немає"
for _, fname in ipairs({ "QuestLogQuests_Update", "QuestMapFrame_UpdateAll",
                         "QuestMapFrame_UpdateQuestDetailsButtons" }) do
    if type(_G[fname]) == "function" then
        hooksecurefunc(fname, RefreshQuestLogList)
        if hookedListFn == "немає" then hookedListFn = fname end
    end
end
ns.lastListHook = hookedListFn -- видно через діагностику за потреби

-- КВЕСТИ В ТУЛТІПАХ ПІНІВ (мапа, мінімапа): назва + рядки цілей.
-- Рядок цілі може мати маркер «- » попереду — знімаємо, перекладаємо,
-- повертаємо. Підміна йде напряму у FontString тултіпа — без рекурсії.
-- Перекладає ОДИН рядок. Зберігає кольорові коди/префікси довкола: переклад
-- підставляється ПІДРЯДКОМ замість очищеного тексту (а не заміняє весь рядок),
-- тож трейлінг-коди (напр. |cffffffff перед наступним рядком) не губляться.
local function TranslateOneLine(line)
    if ns.HasCyrillic(line) then return nil end -- вже наше (напр. рядок після AddLine-хука)
    -- ЧАС — ПЕРЕД точним збігом: у базі є зліплені рядки «Time Left: 14 Hours»,
    -- і точний збіг замінив би весь рядок, знищивши білий колір значення.
    local t = TranslateTimeLine(line)
    if t then return t end
    local ua = TranslateText(line) -- точний збіг / ціль з лічильником
    if ua then return ua end
    local dash, rest = line:match("^(%s*[-–—]%s*)(.+)$") -- маркер «- » попереду
    if rest then
        local u = TranslateText(rest)
        if u then return dash .. u end
    end
    local stripped = StripDecorations(line) -- назва з кодами/префіксом рівня
    if stripped ~= line then
        local u = TranslateText(stripped)
        if not u then
            -- після зняття кольор-кодів попереду міг лишитись маркер «- »
            -- (ціль на мінімапі: |cff..- 1/3 Hinterlands evidence found|r).
            local d2, r2 = stripped:match("^(%s*[%-•–—]%s*)(.+)$")
            if r2 then
                local t = TranslateText(r2)
                if t then u = d2 .. t end
            end
        end
        if u then
            local s, e = line:find(stripped, 1, true)
            if s then return line:sub(1, s - 1) .. u .. line:sub(e + 1) end
            return u
        end
    end
    return nil
end

-- Тултіп МІНІМАПИ кладе НАЗВУ+ЦІЛІ в ОДИН FontString через \n (NumLines=1).
-- Тому розбиваємо текст по \n і перекладаємо КОЖЕН рядок окремо, зберігаючи
-- структуру. (Раніше шукали весь блоб у словнику — і не знаходили.)
-- Чи власник GameTooltip лежить у вікні Образів? РАННЯ ВІДСІЧКА: якщо Скриня образів
-- навіть не показана — не чіпаємо ланцюжок GetParent (він у бою на неймплейт-аурах
-- натрапляє на secret-фрейми, де :GetParent() кидає «bad self»). pcall — страховка.
local function OwnerInWardrobe()
    local wf = _G.WardrobeCollectionFrame
    if not (wf and wf.IsShown and wf:IsShown()) then return false end
    local ok, res = pcall(function()
        local f = GameTooltip and GameTooltip.GetOwner and GameTooltip:GetOwner()
        for _ = 1, 10 do
            if not f then return false end
            if f == wf then return true end
            if type(f.GetParent) ~= "function" then return false end
            f = f:GetParent()
        end
        return false
    end)
    return ok and res or false
end

local function TranslateTooltipText(text)
    local inWardrobe = OwnerInWardrobe()
    -- ОМОНІМ «Back» (та інші голі слот-слова): значення вирішує ВЛАСНИК тултіпа,
    -- не слово. Кнопка слота у вікні Образів → слотове «Спина/Груди/…» (канон
    -- ItemHooks); будь-де інде голе «Back» — навігаційна кнопка → «Назад».
    if ns.itemTTWords and ns.itemTTWords[text] then
        if inWardrobe then return ns.itemTTMap and ns.itemTTMap[text] or nil end
        if text == "Back" then return "Назад" end -- навігаційна кнопка поза Образами
        return nil
    end
    -- НАЗВА ОБРАЗУ (за itemID через visualInfo власника) + системні рядки Образів.
    if inWardrobe then
        local ua = (ns.WardrobeNameUA and ns.WardrobeNameUA(text))
            or (ns.setPieces and ns.setPieces[text])
            or (ns.uiTooltips and ns.uiTooltips[text])
        if ua and ua ~= text then return ua end
    end
    if not text:find("\n") then return TranslateOneLine(text) end
    local changed, out = false, {}
    for line in (text .. "\n"):gmatch("(.-)\n") do
        local ua = TranslateOneLine(line)
        if ua and ua ~= line then changed = true; out[#out + 1] = ua
        else out[#out + 1] = line end
    end
    if changed then return table.concat(out, "\n") end
    return nil
end

-- Спільний вхід для інших модулів (QuestPinHooks): переклад ОДНОГО рядка тултіпа
-- тим самим ланцюжком, що й трекер (назва квесту → ціль-лідерборд → «X/Y ціль» →
-- kill-підстановка). Повертає укр. рядок або nil. Нічого не пише — рішення, що
-- саме робити з результатом, лишається за викликачем.
function ns.TranslateTooltipLine(text)
    ns.Guard("трекер", RebuildTitleLookup)   -- назви квестів беруться з журналу — оновити перед пошуком
    return TranslateTooltipText(text)
end

-- Оригінали рядків тултіпа (GameTooltipTextLeftN — постійні глобали). Потрібні,
-- щоб Shift МИТТЄВО показував оригінал навіть на тултіпах БЕЗ фрейму-власника
-- (світові моби: перевиклик OnEnter там неможливий, бо власника немає).
local tooltipOriginals = ns.replacements -- теж у центральний реєстр

-- Підміна тексту FontString зі ЗБЕРЕЖЕННЯМ кольору: гра часто фарбує рядок
-- через SetText(text, r,g,b), а наш SetText міняє лише текст — колір треба
-- повернути вручну, інакше напис біліє (поштові скриньки, заголовки POI).
local function SetTextKeepColor(fs, ua)
    local r, g, b, a = fs:GetTextColor()
    fs:SetText(ua)
    if r then fs:SetTextColor(r, g, b, a) end
end

-- ⚠️ ТЕЙНТ-БАР'ЄР [[tooltip-widget-taint]]. Піни СВІТОВОЇ мапи (AreaPOI / quest-offer)
-- чіпляють до GameTooltip widget-set через AreaPoiUtil→GameTooltip_AddWidgetSet, чий
-- layout порівнює SECRET число (LayoutFrame:491). БУДЬ-ЯКИЙ наш SetText у цьому шляху
-- тейнтить спільний GameTooltip → далі сипле «tainted by UALL» на КОЖЕН ClearWidgetSet
-- (кнопки дій, стійки, чат) аж до /reload. Гейт widgetSetID НЕ рятує: сет додається
-- ПІСЛЯ нашого запису (на мить він ще nil). Тому гейтимо за ВЛАСНИКОМ — SetOwner(пін)
-- передує побудові вмісту, тож на момент запису власник уже = пін мапи. Мінімап-блипи
-- й трекер мають ІНШОГО власника (не WorldMapFrame) → функціональність збережено.
local function IsWorldMapPinTooltip()
    local wmf = _G.WorldMapFrame
    if not (wmf and wmf.IsShown and wmf:IsShown()) then return false end
    -- Віджет-сет у тултіпі = той самий SECRET-layout → не чіпаємо (див. вище).
    if GameTooltip.widgetSetID then return true end
    -- ВИНЯТОК: КВЕСТ-ПІН. QuestPinHooks ставить ns.questPinTip у OnMouseEnter
    -- конкретних пін-міксинів (AreaPOI серед них немає), тож ми точно знаємо тип
    -- піна — не вгадуємо за власником. Віджет-сета в такому тултіпі немає (перевірено
    -- вище), тобто SECRET-layout, через який був крах 07.07, не задіяний. Дозволяємо
    -- переклад ТУТ, у хуку SetText/AddLine — тобто в джерелі, без лагу й блимання.
    local pin = ns.questPinTip
    if pin and GameTooltip.GetOwner and GameTooltip:GetOwner() == pin then
        return false
    end
    local owner = GameTooltip.GetOwner and GameTooltip:GetOwner()
    -- Тейнтить САМЕ пін полотна мапи (він у ScrollContainer). Бічний СПИСОК
    -- квестів (QuestMapFrame/QuestScrollFrame) — звичайні кнопки без віджет-сета:
    -- його тултіп (назва+цілі) перекладати безпечно. Ідемо вгору від власника:
    -- що зустрінемо першим, те й вирішує.
    local pinRoot = wmf.ScrollContainer
    local questList = _G.QuestMapFrame
    local f, depth = owner, 0
    while f and depth < 12 do
        if questList and f == questList then return false end  -- бічний список — не пін
        if pinRoot and f == pinRoot then return true end        -- полотно з пінами
        if f == wmf then return true end                        -- решта мапи — як було
        f = f.GetParent and f:GetParent()
        depth = depth + 1
    end
    return false
end

-- Тултіпи ПРЕДМЕТІВ перекладає ItemHooks (слоти/стати/назви з власним словником,
-- де Back=Спина). Тракер НЕ має чіпати їх своїм quest-словником — інакше generic-
-- слова (Back→Назад тощо) протікають у слот плаща. Власник=предмет → пропуск.
local function TooltipShowsItem(tt)
    if TooltipUtil and TooltipUtil.GetDisplayedItem then
        local ok, _, link = pcall(TooltipUtil.GetDisplayedItem, tt)
        if ok and link then return true end
    end
    if tt.GetItem then
        local ok, _, link = pcall(tt.GetItem, tt)
        if ok and link then return true end
    end
    return false
end

-- Назва данжа в тултіпі, чий власник сидить у вікні I (шукач груп/Міфічний+):
-- підпорядковується опції groupfinder.names. Без цього заголовок тултіпа значків
-- сезону перекладався ЦИМ квест-хуком (назва данжа = назва квеста-трекера),
-- обходячи гейт вікна I.
local function IsGroupFinderInstanceTip(text)
    if not ns.IsInstanceName or ns.IsEnabled("groupfinder.names") then return false end
    if not PVEFrame then return false end
    local o = GameTooltip.GetOwner and GameTooltip:GetOwner()
    local d = 0
    while o and d < 12 do
        if o == PVEFrame then return ns.IsInstanceName(text) end
        o = o.GetParent and o:GetParent()
        d = d + 1
    end
    return false
end

local function TranslateTooltipFS(fs, text)
    text = ns.SafeText(text)
    if not fs or not text then return end
    if not ns.IsEnabled("quests.title") or ns.ShowOriginal() then return end
    if IsWorldMapPinTooltip() then return end  -- тейнт-бар'єр (widget-set пінів мапи)
    if TooltipShowsItem(GameTooltip) then return end
    if IsGroupFinderInstanceTip(text) then return end
    ns.Guard("трекер", RebuildTitleLookup)
    local ua = TranslateTooltipText(text)
    if ua and ns.SafeText(fs:GetText()) == text then
        SetTextKeepColor(fs, ua)
        tooltipOriginals[fs] = { en = text, ua = ua }
    end
end

-- startLine — з якого рядка починати (відкладений скан пропускає рядок 1=НАЗВУ,
-- бо її надійно перекладає OnShow зі збереженим жовтим кольором; повторний
-- переклад назви на наступному кадрі знебарвлював її — тому її НЕ чіпаємо).
local function ScanTooltipLines(tt, startLine)
    if tt ~= GameTooltip then return end
    if not ns.IsEnabled("quests.title") or ns.ShowOriginal() then return end
    if IsWorldMapPinTooltip() then return end  -- тейнт-бар'єр (widget-set пінів мапи)
    if TooltipShowsItem(tt) then return end
    ns.Guard("трекер", RebuildTitleLookup)
    for i = (startLine or 1), tt:NumLines() do
        local fs = _G["GameTooltipTextLeft" .. i]
        local t = ns.SafeText(fs and fs:GetText())
        if t and not ns.HasCyrillic(t) and not IsGroupFinderInstanceTip(t) then
            local ua = TranslateTooltipText(t)
            if ua then
                SetTextKeepColor(fs, ua)
                tooltipOriginals[fs] = { en = t, ua = ua } -- реєструємо для Shift
            end
        end
    end
end

if GameTooltip then
    -- ВСІ тултіп-хуки в pcall: ці колбеки викликає САМ рушій тултіпів Blizzard
    -- (у т.ч. на неймплейт-аурах у данжі, де значення бувають secret). Будь-яка
    -- помилка нашого перекладу тут інакше витекла б у конвеєр гри й показалась
    -- гравцеві. pcall гарантує: ми або перекладаємо, або тихо пропускаємо.
    -- Шлях 1: піни великої мапи (Lua ставить текст методами тултіпа).
    hooksecurefunc(GameTooltip, "SetText", function(_, text)
        ns.Guard("трекер", TranslateTooltipFS, GameTooltipTextLeft1, text)
    end)
    hooksecurefunc(GameTooltip, "AddLine", function(self, text)
        pcall(function()
            local n = self:NumLines()
            TranslateTooltipFS(_G["GameTooltipTextLeft" .. n], text)
        end)
    end)
    -- OnShow перекладає ВСІ рядки (назва+те, що вже є). Наступний кадр —
    -- лише ЦІЛІ (рядки 2+), бо рядок цілі мінімапи дописується ПІСЛЯ OnShow.
    -- Назву (рядок 1) відкладений скан НЕ чіпає — щоб не знебарвити.
    GameTooltip:HookScript("OnShow", function(self)
        ns.Guard("трекер", ScanTooltipLines, self, 1)
        if C_Timer and C_Timer.After then
            C_Timer.After(0, function() ns.Guard("трекер", ScanTooltipLines, self, 2) end)
        end
    end)
end

-- ДОКУМЕНТОВАНИЙ надійний спосіб: пост-виклики дата-процесора спрацьовують, коли
-- рядки тултіпа вже виставлені — на будь-якій відстані/таймінгу, без ловлі кадрів.
if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall
   and Enum and Enum.TooltipDataType then
    -- Quest: цілі квестів (назву робить OnShow).
    if Enum.TooltipDataType.Quest then
        TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Quest, function(tt)
            ns.Guard("трекер", ScanTooltipLines, tt, 2)
        end)
    end
    -- Ярлики POI (Mailbox, Flight Master...) приходять у тултіпі блипа мінімапи.
    -- Тип блипа в Midnight може бути різний, тож реєструємось на ВСІ типи, але
    -- перекладаємо ЛИШЕ точні ярлики ns.minimapLabels (інших тултіпів НЕ чіпає,
    -- бо назв предметів/спелів там нема). Колір збережено.
    local function poiPost(tt)
        if tt ~= GameTooltip or not ns.minimapLabels then return end
        if ns.ShowOriginal and ns.ShowOriginal() then return end
        if IsWorldMapPinTooltip() then return end  -- тейнт-бар'єр (widget-set пінів мапи)
        return pcall(function()  -- фаєрить на ВСІХ тултіпах, у т.ч. secret-аурах данжу
        for i = 1, tt:NumLines() do
            local fs = _G["GameTooltipTextLeft" .. i]
            local t = ns.SafeText(fs and fs:GetText())
            if t then
                -- знімаємо стрілку напрямку/коди для пошуку, але ПОВЕРТАЄМО їх у
                -- підставлений текст (далеко від POI гра додає ▲/▼ — без цього
                -- точний збіг ламався, звідси «близько укр., далеко англ.»).
                local clean = StripDecorations(t)
                local ua = ns.minimapLabels[clean]
                if ua and ua ~= clean then
                    local s, e = t:find(clean, 1, true)
                    local newt = s and (t:sub(1, s - 1) .. ua .. t:sub(e + 1)) or ua
                    SetTextKeepColor(fs, newt)
                    tooltipOriginals[fs] = { en = t, ua = newt }
                end
            end
        end
        end)  -- закриває pcall(function()
    end
    for _, dt in pairs(Enum.TooltipDataType) do
        pcall(TooltipDataProcessor.AddTooltipPostCall, dt, poiPost)
    end
end

-- ── ДІАГНОСТИКА (лише при /wowukraine debug): дамп УСІХ рамок-тултіпів. Окремий
-- OnUpdate знаходить будь-яку показану рамку з «Tooltip» в імені й друкує її
-- ІМ'Я + рядки (колір + сирі коди | -> ||). Так дізнаємось, ЯКА саме рамка малює
-- тултіп мінімапи (це не обов'язково GameTooltip). Дедуп за сигнатурою.
do
    local dbg = CreateFrame("Frame")
    local lastSig, tips = "", nil
    dbg:SetScript("OnUpdate", function()
        if not ns.debug then lastSig = ""; return end
        if not tips then  -- зібрати список рамок-тултіпів ОДИН раз
            tips = {}
            for name, f in pairs(_G) do
                if type(name) == "string" and name:find("Tooltip") and type(f) == "table"
                   and type(f.NumLines) == "function" and type(f.IsShown) == "function" then
                    tips[#tips + 1] = { name = name, f = f }
                end
            end
        end
        local anyShown = false
        for _, e in ipairs(tips) do
            local okS, shown = pcall(e.f.IsShown, e.f)
            local okN, n = pcall(e.f.NumLines, e.f)
            if okS and shown and okN and n and n > 0 then
                anyShown = true
                local first = _G[e.name .. "TextLeft1"]
                local sig = e.name .. "#" .. n .. "#" .. (first and first:GetText() or "")
                if sig ~= lastSig then
                    lastSig = sig
                    ns.Diag("=== " .. e.name .. " (рядків " .. n .. ") ===")
                    for i = 1, n do
                        local fs = _G[e.name .. "TextLeft" .. i]
                        local raw = fs and fs.GetText and fs:GetText()
                        if raw and raw ~= "" then
                            local r, g, b = fs:GetTextColor()
                            ns.Diag(("[%d] к(%.2f,%.2f,%.2f) <%s>"):format(
                                i, r or -1, g or -1, b or -1, raw:gsub("|", "||"):sub(1, 70)))
                        end
                    end
                end
            end
        end
        if not anyShown then lastSig = "" end
    end)
end

-- Клавіша «показати оригінал» — миттєво, без черги.
local mod = CreateFrame("Frame")
mod:RegisterEvent("MODIFIER_STATE_CHANGED")
mod:SetScript("OnEvent", function(_, _, key)
    -- Shift «показати оригінал» — централізовано в Core (ns.ToggleOriginal).
    -- Тут лишаємо ВІДКЛАДЕНИЙ Refresh ЛИШЕ щоб трекер перемалював лічильники
    -- після свопу (текст уже свопає Core). Без синхронної роботи — без taint.
    local chosen = ns.GetSetting and ns.GetSetting("originalKey")
    if chosen and chosen ~= "NONE" and key:find(chosen, 1, true) then
        C_Timer.After(0, Refresh)
    end
end)

-- ЗБИРАЧ ЦІЛЕЙ. У 12.0 тексти цілей приходять із сервера (у клієнтських
-- таблицях їх більше нема), тож збираємо їх прямо з гри: запитуємо дані
-- кожного квесту з бази перекладів і складаємо рядки цілей у
-- SavedVariables (запишуться на диск при /reload).
-- Запуск: /wowukraine цілі
function ns.DumpObjectives()
    -- DEV-ONLY: масово шле RequestLoadQuestByID на сервер (~33/сек). У релізі закрито
    -- за debug, щоб ніхто випадково не вистрілив масовими запитами. Цілі беремо пасивно
    -- (db.objLines — те, що гравець реально бачить), цей збирач не потрібен у проді.
    if not ns.debug then
        ns.Print("Збирач цілей лише для розробки. Увімкни «" .. (ns.slash or "/wowukraine")
            .. " debug», якщо справді потрібно.")
        return
    end
    if not ns.quests then
        ns.Print("База квестів не завантажена.")
        return
    end
    local queue, retries = {}, {}
    for id in pairs(ns.quests) do table.insert(queue, id) end
    table.sort(queue)
    local total = #queue
    local db = ns.GetCaptureDB()
    db.objectives = {}
    ns.Print(("Збираю цілі %d квестів із сервера (~хвилина)..."):format(total))

    local ticker
    ticker = C_Timer.NewTicker(0.03, function()
        local id = table.remove(queue, 1)
        if not id then
            ticker:Cancel()
            local n = 0
            for _ in pairs(db.objectives) do n = n + 1 end
            ns.Print(("Зібрано цілі %d квестів. Тепер зроби /reload — "
                .. "дані запишуться на диск."):format(n))
            return
        end
        if not HaveQuestData(id) then
            C_QuestLog.RequestLoadQuestByID(id)
            retries[id] = (retries[id] or 0) + 1
            if retries[id] <= 3 then
                table.insert(queue, id) -- ще раз у кінець черги
            end
            return
        end
        local objs = C_QuestLog.GetQuestObjectives(id)
        if objs then
            local texts = {}
            for _, o in ipairs(objs) do
                if o.text and o.text ~= "" then
                    table.insert(texts, o.text)
                end
            end
            if #texts > 0 then db.objectives[id] = texts end
        end
    end)
end

-- ЦЕНТРАЛЬНИЙ БАНЕР СЦЕНАРІЮ/ДЕЛВУ (транзитний, кілька секунд): показує назву
-- етапу/істоти великим декоративним шрифтом + опис, через UIWidget-контейнер.
-- Хук ObjectiveTracker вище його НЕ ловить (інший фрейм). Декоративний шрифт не
-- має «і/ї/ґ/є» → □; опис лишався англ. Ловимо на подіях сценарію/віджетів:
-- walk контейнерів віджетів → переклад (ns.scenario=опис/крок, ns.npcNames=ім'я
-- істоти) + CYR-шрифт. Транзитний → кілька повторів із затримкою.
-- ОБРІЗАННЯ «Рівень ...»: причина НЕ в ширині й НЕ в кеглі (обидві гіпотези
-- перевірено й відкинуто), а в МОМЕНТІ виміру. Гра ставить «Level 13» ще під час
-- розкладки блоку, ми в ту ж мить підставляємо довше «Рівень 13» — і рушій міряє
-- його по ЩЕ НЕ ФІНАЛЬНІЙ ширині, ріже й дописує «...». Удруге напис ніхто не
-- чіпає, тож обрізок лишається назавжди.
-- Доказ від тестера: щойно гравець помер і в блоці з'явився значок смерті (тобто
-- Blizzard переклав блок заново), напис став повним — попри те, що іконок стало
-- БІЛЬШЕ, а місця менше. Отже ширини вистачало весь час.
-- Лікуємо момент: один-єдиний повтор на наступному кадрі, коли розкладка вже
-- усталилася. Це НЕ тікер — рівно одна відкладена спроба на кожен новий текст,
-- і лише якщо напис справді обрізаний (лічильник спроб не дає зациклитися).
local remeasure = setmetatable({}, { __mode = "k" })
local function RemeasureLater(fs, ua)
    if not (fs and fs.IsTruncated and C_Timer and C_Timer.After) then return end
    local ok, cut = pcall(fs.IsTruncated, fs)
    if not (ok and cut) then return end
    local st = remeasure[fs]
    if st and st.text == ua and st.tries >= 2 then return end   -- запобіжник
    remeasure[fs] = { text = ua, tries = ((st and st.text == ua) and st.tries or 0) + 1 }
    C_Timer.After(0, function()
        if not (fs.GetText and fs.SetText) then return end
        local okT, cur = pcall(fs.GetText, fs)
        if not okT or cur ~= ua then return end                 -- текст уже інший — не чіпаємо
        pcall(fs.SetText, fs, ua)                               -- переміряти при усталеній ширині
        if ns.UnclipIfTruncated then ns.UnclipIfTruncated(fs) end
    end)
end

local function TrBannerFS(fs)
    if not fs or not fs.GetText then return end
    local en = ns.SafeText and ns.SafeText(fs:GetText()) or fs:GetText()
    if not en or en == "" then return end
    ApplyCyrFont(fs)                              -- CYR-шрифт навіть якщо вже UA (□ на «і»)
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    if ns.HasCyrillic and ns.HasCyrillic(en) then return end
    -- ns.vignette: назви винагород/рідкісних на банерах-віджетах
    -- (напр. «Sealed Twilight's Blade Bounty»→«Запечатана Винагорода Клинка Сутінків»)
    -- ns.journalSections/questObjectives: назви зон і точок полів бою («Arathi Basin»,
    -- «Lumber Mill») — вони приходять саме сюди, у віджет-блок бойовища.
    local ua = (ns.scenario and ns.scenario[en])
            or (ns.npcNames and ns.npcNames[en])
            or (ns.vignette and ns.vignette[en])
            or (ns.journalSections and ns.journalSections[en])
            or (ns.questObjectives and ns.questObjectives[en])
            or TranslateTimeLine(en)          -- «11 seconds» → «11 секунд»
            -- «Level 15» → «Рівень 15». У словнику ці рядки лежать ПОШТУЧНО (їх
            -- дав DB2), тому там є 11 і 13, але немає 15, 18, 22–29, 31–34 — саме
            -- тих рівнів ключів, які гравці бачать найчастіше. Правило замість
            -- переліку; число не чіпаємо.
            or (en:match("^Level%s+%d+$") and en:gsub("^Level(%s+%d+)$", "Рівень%1"))
    if ua and ua ~= en then
        if ns.Remember then ns.Remember(fs, en, ua) end
        pcall(fs.SetText, fs, ua)
        ApplyCyrFont(fs)
        if ns.UnclipIfTruncated then ns.UnclipIfTruncated(fs) end
        RemeasureLater(fs, ua)
    end
end

-- ⚠️ БЛОК БОЙОВИЩА/СЦЕНАРІЮ ОНОВЛЮЄТЬСЯ ЩОСЕКУНДИ (зворотний відлік «11 seconds»).
-- Разові сплески обходу (0.1/0.4/1.0 с після події) за цим не встигали: гра
-- перемальовувала англійською, ми виправляли із запізненням — виходило биття
-- перекладу з англійською в такт таймеру (звіт тестера: Аратійська Улоговина).
-- Тому на КОЖЕН напис вішаємо хук SetText — переклад стається В ТУ Ж МИТЬ, коли
-- гра ставить текст, і блимати нема чому. Позначку про «вже підчеплено» тримаємо
-- у ВЛАСНІЙ слабкій таблиці, а не полем на їхньому об'єкті [[bagsearch-taint]].
local bannerHooked = setmetatable({}, { __mode = "k" })
local function HookBannerFS(fs)
    if bannerHooked[fs] then return end
    bannerHooked[fs] = true
    pcall(hooksecurefunc, fs, "SetText", function(self)
        ns.Guard("трекер", TrBannerFS, self)
    end)
    -- ТАКОЖ SetFormattedText: Blizzard ставить текст обома методами, і саме
    -- форматованим ідуть шаблонні написи на кшталт «Level %d» (рівень ключа в
    -- блоці сценарію). Без цього хука гра після усталеної розкладки переставляла
    -- напис англійською, і переклад мовчки зникав. Так само вже зроблено в
    -- GossipHooks/AchievementHooks/HelpTipHooks/BarberShopHooks.
    if type(fs.SetFormattedText) == "function" then
        pcall(hooksecurefunc, fs, "SetFormattedText", function(self)
            ns.Guard("трекер", TrBannerFS, self)
        end)
    end
end

local function WalkBanner(frame, depth)
    if not frame or depth > 9 or type(frame) ~= "table" then return end
    if frame.IsShown and not frame:IsShown() then return end
    if frame.GetRegions then
        for _, rg in ipairs(ns.Regions(frame)) do
            if rg.IsObjectType and rg:IsObjectType("FontString") then
                ns.Guard("трекер", TrBannerFS, rg)
                HookBannerFS(rg)      -- + хук у джерелі: тримає переклад при щосекундних оновленнях
            end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then WalkBanner(c, depth + 1) end end
    end
end

local function RefreshBanners()
    if not ns.IsEnabled("quests.tracker") then return end
    -- банер «New Stage» = система тостів EventToastManagerFrame.currentDisplayingToast
    -- (підтверджено /fstack: EventToastManager.xml). Заголовок + підзаголовок-опис
    -- у дочірніх FontString.
    local etm = _G.EventToastManagerFrame
    if etm then
        ns.Guard("трекер", WalkBanner, etm.currentDisplayingToast, 1)
        ns.Guard("трекер", WalkBanner, etm, 1)
    end
    -- НАЗВА делву/сценарію («Сутінкові Крипти») рендериться через UIWidget у
    -- центр/верх-контейнерах (/fstack: UIWidgetTopCenterContainerFrame тощо),
    -- НЕ через EventToast. Декоративний шрифт без «і/ї/ґ/є» → □. Обходимо ВСІ
    -- UIParent-діти з "Widget" в імені + явні запасні; ApplyCyrFont кожному напису.
    for _, n in ipairs({ "UIWidgetTopCenterContainerFrame", "UIWidgetCenterScreenContainerFrame",
                         "UIWidgetCenterDisplayFrame", "ScenarioBlocksFrame",
                         "ScenarioObjectiveTracker", "UIWidgetBelowMinimapContainerFrame" }) do
        local f = _G[n]; if f then ns.Guard("трекер", WalkBanner, f, 1) end
    end
    -- ...+ УСІ UIParent-діти з "Widget" в імені (банери винагород/подій рендеряться
    -- у різних UIWidget-контейнерах; жорсткий список їх не покриває — напр. банер
    -- «Sealed Twilight's Blade Bounty» унизу справа). Обходимо їх усі динамічно.
    if _G.UIParent and _G.UIParent.GetChildren then
        for _, c in ipairs(ns.Children(_G.UIParent)) do
            -- c:GetName() кидає «bad self» на forbidden/secret-дітях UIParent (у бою) —
            -- ловимо в pcall, інакше помилка тече в конвеєр гри й видима тестеру.
            local ok, nm = pcall(function() return c.GetName and c:GetName() end)
            if ok and nm and nm:find("Widget") and not ns.IsTooltipFrame(c) then
                ns.Guard("трекер", WalkBanner, c, 1)
            end
        end
    end
end

local bannerPending = false
local function BannerBurst()
    if bannerPending then return end          -- тротлінг: один сплеск повторів за раз
    bannerPending = true
    RefreshBanners()
    if C_Timer then
        C_Timer.After(0.1, RefreshBanners)
        C_Timer.After(0.4, RefreshBanners)
        C_Timer.After(1.0, function() RefreshBanners(); bannerPending = false end)
    else
        bannerPending = false
    end
end

local bannerEv = CreateFrame("Frame")
for _, e in ipairs({ "SCENARIO_UPDATE", "SCENARIO_CRITERIA_UPDATE", "SCENARIO_POI_UPDATE",
                     -- банери винагород/рідкісних (vignette) з'являються на ці події
                     -- (UPDATE_UI_WIDGET навмисно НЕ беремо — сипле щокадрово)
                     "VIGNETTES_UPDATED", "VIGNETTE_MINIMAP_UPDATED",
                     "AREA_POIS_UPDATED", "PLAYER_ENTERING_WORLD" }) do
    pcall(bannerEv.RegisterEvent, bannerEv, e)
end
bannerEv:SetScript("OnEvent", function() BannerBurst() end)

-- Надійніший тригер: прямо на показ тоста (EventToastManagerMixin:DisplayToast).
-- currentDisplayingToast виставляється всередині — пройдемо одразу після.
local function HookEventToast()
    local etm = _G.EventToastManagerFrame
    if not etm or etm.__ua_banner then return end
    if type(etm.DisplayToast) == "function" then
        etm.__ua_banner = true
        hooksecurefunc(etm, "DisplayToast", function() BannerBurst() end)
    end
    if etm.HookScript then etm:HookScript("OnShow", function() BannerBurst() end) end
end
HookEventToast()
if C_Timer then C_Timer.After(3, HookEventToast) end

-- ДЕЛВ-ПІКЕР СКЛАДНОСТІ (DelvesDifficultyPickerFrame): мітки/заголовки
-- (напр. «Властивості карти» = DelveModifiersWidgetContainer.ModifiersLabel,
-- /fstack: Blizzard_DelvesDifficultyPicker.xml) перекладені через GlobalString-
-- override, але дефолтним декоративним шрифтом без укр. «і/ї/ґ/є» → □. Жоден
-- walk туди не доходив. Постійний фрейм → хук OnShow + тікер; CYR-шрифт усім
-- написам (WalkBanner ідемпотентний). LoD-аддон → ще й ADDON_LOADED.
local dpTicking = false
local function WalkDelvePicker()
    local f = _G.DelvesDifficultyPickerFrame
    if not (f and f.IsShown and f:IsShown()) then return end
    if not (ns.IsEnabled("interface.menu") or ns.IsEnabled("quests.tracker")) then return end
    ns.Guard("трекер", WalkBanner, f, 1)
end
local function DelvePickerTicker()
    if dpTicking or not (C_Timer and C_Timer.After) then return end
    dpTicking = true
    local function tick()
        local f = _G.DelvesDifficultyPickerFrame
        if not (f and f.IsShown and f:IsShown()) then dpTicking = false; return end
        WalkDelvePicker()
        C_Timer.After(0.3, tick)
    end
    C_Timer.After(0.05, tick)
end
local function HookDelvePicker()
    local f = _G.DelvesDifficultyPickerFrame
    if f and f.HookScript and not f.__ua_dp then
        f.__ua_dp = true
        f:HookScript("OnShow", function() WalkDelvePicker(); DelvePickerTicker() end)
        if f:IsShown() then WalkDelvePicker(); DelvePickerTicker() end
    end
end
HookDelvePicker()
local dpEv = CreateFrame("Frame")
dpEv:RegisterEvent("ADDON_LOADED")
dpEv:SetScript("OnEvent", function(_, _, n)
    if n == "Blizzard_DelvesDifficultyPicker" then HookDelvePicker() end
end)
