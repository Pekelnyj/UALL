-- WoWUkraine: вікно розмови з NPC (gossip) — репліка NPC і варіанти
-- відповідей. Перемикачі: «Діалоги NPC → Репліки NPC / Варіанти відповідей».
--
-- Тексти діалогів — серверні (нема ні в клієнті, ні в API), тому модуль
-- працює у двох режимах одночасно:
--   1. ПЕРЕКЛАД: точний збіг EN-тексту з базою ns.gossip.
--   2. ЗБІР: усе, чого нема в базі, складається в SavedVariables
--      (CaptureDB.gossip) і йде в наступну хвилю перекладу.

local _, ns = ...

-- Оригінали змінених написів — для клавіші «показати оригінал».
local originals = ns.replacements -- спільний центральний реєстр (Shift свопає його)

-- ХУК У ТОЧЦІ ДЖЕРЕЛА (не обхід за таймером). ScrollBox перевикористовує кнопки
-- й СКИДАЄ їхній текст на англ. ПІСЛЯ нашого перекладу. Тому на кожен gossip-
-- FontString вішаємо hooksecurefunc("SetText"): щойно Blizzard ставить англ. —
-- наш хук відразу повертає укр. Жодного тікера, жодного блимання.
-- `applying` боронить від рекурсії (наш власний SetText теж смикає хук).
local hookedFS = setmetatable({}, { __mode = "k" })
local applying = false
local TranslateFontString -- forward-декларація (хук кличе її)

local function selfHeal(self)
    if applying then return end -- це наш власний переклад — не зациклюватись
    if not (GossipFrame and GossipFrame:IsShown()) then return end -- лише в gossip
    applying = true
    ns.Guard("розмова", TranslateFontString, self, "gossip.text")
    applying = false
end

local function HookFontString(fs)
    if hookedFS[fs] or type(fs.SetText) ~= "function" then return end
    hookedFS[fs] = true
    -- ScrollBox може ставити текст кнопки і через SetText, і через SetFormattedText
    -- (+ SetTextColor лишає старий текст) — чіпляємо всі, щоб гарантовано зловити скид.
    hooksecurefunc(fs, "SetText", selfHeal)
    if type(fs.SetFormattedText) == "function" then
        hooksecurefunc(fs, "SetFormattedText", selfHeal)
    end
end

local function CaptureGossip(text)
    if not text or text == "" then return end
    -- Не збирати власний вивід: перекладений текст (кирилиця) інакше потрапляє
    -- назад у збір як «новий діалог» (петля). Назви квестів відсіює questID-хук
    -- ще до збору (TranslateFontString виходить раніше).
    if ns.HasCyrillic and ns.HasCyrillic(text) then return end
    local db = ns.GetCaptureDB()
    db.gossip = db.gossip or {}
    if db.gossip[text] == nil then
        db.gossip[text] = true
    end
end

-- У базі ім'я гравця збережене як {name}. Перед пошуком замінюємо реальне
-- ім'я на {name}, а в перекладі — {name} назад на ім'я.
local function GossipLookup(text)
    if not ns.gossip then return nil end
    -- Сервер дає переноси як \r\n, а ключі в базі нормалізовано до \n
    -- (merge_gossip). Без цього багаторядкові репліки не збігаються
    -- (однорядкові опції збігались — тому й перекладалися, а абзаци ні).
    text = text:gsub("\r\n", "\n"):gsub("\r", "\n")
    local ua = ns.gossip[text]
    if ua then return ua end
    local name = UnitName("player")
    if name and text:find(name, 1, true) then
        local key = text:gsub(name, "{name}")
        ua = ns.gossip[key]
        if ua then return (ua:gsub("%{name%}", name)) end
    end
    return nil
end

-- НАЗВИ КВЕСТІВ у вікні розмови/здачі (GreetingPanel). Текст там англійський,
-- а в нашій базі квести лежать за questID. Будуємо мапу enНазва->questID із
-- ЖИВОЇ API (C_GossipInfo.GetActive/AvailableQuests) — без статичної бази —
-- і беремо переклад напряму з ns.quests[questID].title.
local questTitleByEn = {}

local function RebuildQuestTitleMap()
    wipe(questTitleByEn)
    if not C_GossipInfo then return end
    local lists = {}
    if C_GossipInfo.GetActiveQuests then lists[#lists + 1] = C_GossipInfo.GetActiveQuests() end
    if C_GossipInfo.GetAvailableQuests then lists[#lists + 1] = C_GossipInfo.GetAvailableQuests() end
    for _, list in ipairs(lists) do
        for _, q in ipairs(list or {}) do
            if q.title and q.questID then
                questTitleByEn[q.title] = q.questID
            end
        end
    end
end

local function QuestTitleUA(enTitle)
    local qid = questTitleByEn[enTitle]
    if not qid then
        -- Blizzard дописує до назви квесту в gossip суфікс «(low level)»/«(Daily)»/
        -- «(Repeatable)» тощо, якого нема в q.title з API → точний збіг ламається.
        -- Пробуємо БЕЗ трейлінг-дужкового суфікса (стрипаємо лише останній).
        local base = enTitle:match("^(.-)%s*%b()%s*$")
        if base and base ~= "" then qid = questTitleByEn[base] end
    end
    local e = qid and ns.quests and ns.quests[qid]
    return e and e.title or nil
end

-- Прибрати кольорові коди для ЗІСТАВЛЕННЯ: назва квесту в gossip приходить як
-- |cff000000Second, The Fuel|r — без стрипу точний збіг не спрацьовував (зміряно).
local function StripColor(s)
    return (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""))
end

-- Підставити repl замість find, зберігаючи решту рядка (напр. |c..|r навколо
-- назви). Магічні символи в find екрановано, % у repl подвоєно.
local function PlainGsub(s, find, repl)
    find = find:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
    repl = repl:gsub("%%", "%%%%")
    return (s:gsub(find, repl))
end

function TranslateFontString(fs, settingKey) -- присвоєння forward-локалу (хук її кличе)
    if not fs or type(fs.GetText) ~= "function" then return end
    HookFontString(fs) -- щоб майбутні SetText (скид ScrollBox) самозцілювались
    local raw = ns.SafeText(fs:GetText()) -- секретні значення -> nil
    if not raw then return end
    local text = StripColor(raw) -- для зіставлення — без |c..|r
    -- 1) Назва квесту (за живою мапою enНазва->questID): беремо наш переклад.
    local qua = QuestTitleUA(text)
    if qua then
        if not ns.ShowOriginal() then
            local newText = ns.ApplyNames(qua)
            if raw ~= text then
                local rebuilt = PlainGsub(raw, text, newText) -- зберегти крайові |c..|r
                if rebuilt ~= raw then newText = rebuilt end   -- інакше коди в СЕРЕДИНІ
            end                                                -- → лишаємо повний переклад
            -- ua = ФАКТИЧНО показаний рядок (з |c..|r / ApplyNames), а НЕ plain qua —
            -- інакше Shift-своп Core.ToggleOriginal (точний збіг cur==ua) не спрацює
            -- і назва квесту не перемкнеться на оригінал.
            originals[fs] = { en = raw, ua = newText }
            local prev = applying; applying = true; fs:SetText(newText); applying = prev
        end
        return -- це назва квесту: не чіпаємо як gossip і не збираємо
    end
    -- 2) Звичайний gossip-текст (репліка/опція).
    local ua = GossipLookup(text)
    if ua then
        if ns.IsEnabled(settingKey) and not ns.ShowOriginal() then
            local newText = ns.ApplyNames(ua)
            if raw ~= text then
                local rebuilt = PlainGsub(raw, text, newText) -- зберегти крайові |c..|r
                if rebuilt ~= raw then newText = rebuilt end   -- інакше коди в СЕРЕДИНІ
            end                                                -- → лишаємо повний переклад
            originals[fs] = { en = raw, ua = newText }         -- показаний рядок (див. вище)
            local prev = applying; applying = true; fs:SetText(newText); applying = prev
        end
    else
        CaptureGossip(text)
    end
end

-- Обхід ОДНОГО елемента ScrollBox (без вимоги IsShown: під час ініціалізації
-- елемент ще може бути не показаний). Перекладає його написи синхронно.
local function WalkElement(frame, depth)
    if ns.IsTooltipFrame(frame) then return  end
    if not frame or depth > 6 then return end
    if frame.GetRegions then
        for _, region in ipairs(ns.Regions(frame)) do
            if region.IsObjectType and region:IsObjectType("FontString") then
                TranslateFontString(region, "gossip.text")
            end
        end
    end
    if frame.GetChildren then
        for _, child in ipairs(ns.Children(frame)) do
            WalkElement(child, depth + 1)
        end
    end
end

-- Обхід вікна розмови: великий текст (репліка) і кнопки-опції.
local function WalkGossip(frame, depth)
    if ns.IsTooltipFrame(frame) then return  end
    if not frame or depth > 10 or not frame.IsShown or not frame:IsShown() then
        return
    end
    for _, region in ipairs(ns.Regions(frame)) do
        if region.IsObjectType and region:IsObjectType("FontString") then
            TranslateFontString(region, "gossip.text")
        end
    end
    for _, child in ipairs(ns.Children(frame)) do
        WalkGossip(child, depth + 1)
    end
end

-- Синхронний хук модерного ScrollBox панелі вітання: переклад кожного рядка
-- (назви квестів + репліки/опції) у момент заповнення — без блимання.
-- Зміряно /fstack: назва квесту живе в GreetingPanel.ScrollBox.ScrollTarget.
local greetingHooked = false
local function HookGreetingScrollBox()
    if greetingHooked then return end
    local panel = GossipFrame and GossipFrame.GreetingPanel
    local sb = panel and panel.ScrollBox
    if not sb or type(sb.RegisterCallback) ~= "function" then return end
    local evt = ScrollBoxListViewMixin and ScrollBoxListViewMixin.Event
    if not evt or not evt.OnInitializedFrame then return end
    local ok = pcall(function()
        sb:RegisterCallback(evt.OnInitializedFrame, function(_, frame)
            if not frame then return end
            if next(questTitleByEn) == nil then ns.Guard("розмова", RebuildQuestTitleMap) end
            ns.Guard("розмова", WalkElement, frame, 1)
        end, sb)
    end)
    if ok then
        greetingHooked = true
        ns.Diag("gossip-greeting ScrollBox зачеплено (OnInitializedFrame)")
    end
end

-- Обхід РЕАЛЬНО показаних кадрів ScrollBox (опції/назви квестів). OnInitializedFrame
-- не спрацьовує для перевикористаних з пулу кнопок, а WalkGossip із гейтом IsShown
-- їх ненадійно дістає — тому ітеруємо напряму через :ForEachFrame і walk'аємо
-- кожен елемент БЕЗ гейта (WalkElement). Це й закриває баг «опція англ. до Shift».
local function WalkScrollBox()
    local panel = GossipFrame and GossipFrame.GreetingPanel
    local sb = panel and panel.ScrollBox
    if not sb or type(sb.ForEachFrame) ~= "function" then return end
    if next(questTitleByEn) == nil then ns.Guard("розмова", RebuildQuestTitleMap) end
    sb:ForEachFrame(function(frame)
        ns.Guard("розмова", WalkElement, frame, 1)
    end)
end

-- Збір ТІЛА ВІТАННЯ NPC (панель GreetingPanel). Серверний текст, що НЕ завжди
-- йде через C_GossipInfo.GetText() — пробуємо ВСІ шляхи: GetGreetingText() API,
-- C_GossipInfo.GetText(), і прямий обхід написів панелі. + ДІАГ: пишемо в db.diag,
-- що реально читається з GreetingText (щоб відрізнити secret-рядок від «не дійшли»).
local function CaptureGreeting()
    local panel = GossipFrame and GossipFrame.GreetingPanel
    if not panel or not panel:IsShown() then return end
    -- 1) прямі API
    local apis = {}
    if GetGreetingText then apis[#apis + 1] = GetGreetingText() end
    if C_GossipInfo and C_GossipInfo.GetText then apis[#apis + 1] = C_GossipInfo.GetText() end
    for _, t in ipairs(apis) do
        local s = ns.SafeText and ns.SafeText(t) or t
        if s and s ~= "" and not (ns.gossip and ns.gossip[s]) then CaptureGossip(s) end
    end
    -- 2) прямий обхід написів панелі (translate+capture) + діагностика GreetingText
    local sb = panel.ScrollBox
    if sb and sb.ForEachFrame then
        sb:ForEachFrame(function(frame)
            ns.Guard("розмова", WalkElement, frame, 1)
            if ns.GetCaptureDB and frame then
                pcall(function()
                    local gt = frame.GreetingText or frame.Text
                    if gt and gt.GetText then
                        local raw = gt:GetText()
                        local safe = ns.SafeText and ns.SafeText(raw)
                        local db = ns.GetCaptureDB(); db.diag = db.diag or {}
                        db.diag["greeting: raw=" .. tostring(raw and #raw or "nil")
                            .. " safe=" .. (safe and "ЧИТАЄТЬСЯ" or "NIL(secret?)")] = true
                    end
                end)
            end
        end)
    end
end

-- ПЕРЕНОС РЯДКА: укр. переклад довший за англ. → текст переноситься на 2-й рядок,
-- а висота кнопки ScrollBox порахована по англ. (1 рядок) → 2-й рядок налазить на
-- наступну опцію. Після перекладу міряємо РЕАЛЬНУ висоту тексту (GetStringHeight,
-- ураховує перенос за поточної ширини FontString) і підганяємо висоту рядка, далі
-- просимо ScrollBox перерозкласти (FullUpdate), щоб наступні рядки зсунулись униз.
-- relayoutGuard боронить від рекурсії: FullSet→re-init→OnInitializedFrame(переклад),
-- але НЕ кличе FitGreetingRows знову, тож циклу нема (гірший випадок — no-op).
local relayoutGuard = false
-- ВИМКНЕНО. Підганяння висоти рядків робилося прямо в бліззардівському
-- ScrollBox: row:SetHeight() і потім sb:FullUpdate(). З незахищеного коду це
-- тейнтить рахунок прокрутки, і найближче ж порівняння secret-числа в
-- MathUtil падає — саме таку помилку прислав користувач із CurseForge:
--   MathUtil.lua:81: attempt to compare local 'value' (a secret number value,
--   while execution tainted by 'UALL')
--   ... GetDerivedScrollRange -> GetDerivedScrollOffset -> FullUpdateInternal
-- Тейнт липкий, гейтом у бою не лікується [[bagsearch-setmatches-taint]], а
-- безпечного способу змінити висоту чужого рядка ScrollBox для аддона немає.
-- Тіснуватий рядок краще за помилку, що блокує гравцеві дію.
local FIT_ROWS_ENABLED = false

local function FitGreetingRows()
    if not FIT_ROWS_ENABLED then return end
    if relayoutGuard then return end
    local panel = GossipFrame and GossipFrame.GreetingPanel
    local sb = panel and panel.ScrollBox
    if not sb or type(sb.ForEachFrame) ~= "function" then return end
    local grew = false
    -- найвища (за реальним переносом) висота FontString у рядку
    local function rowTextHeight(fr, depth, best)
    if ns.IsTooltipFrame(fr) then return best end
        if not fr or depth > 4 then return best end
        if fr.GetRegions then
            for _, r in ipairs(ns.Regions(fr)) do
                if r.IsObjectType and r:IsObjectType("FontString") and r.GetStringHeight then
                    local t = r:GetText()
                    if t and t ~= "" then
                        local h = r:GetStringHeight() or 0
                        if h > best then best = h end
                    end
                end
            end
        end
        if fr.GetChildren then
            for _, c in ipairs(ns.Children(fr)) do best = rowTextHeight(c, depth + 1, best) end
        end
        return best
    end
    sb:ForEachFrame(function(row)
        if not (row and row.GetHeight and row.SetHeight) then return end
        local th = rowTextHeight(row, 0, 0)
        if th > 0 then
            local cur = row:GetHeight()
            local needed = math.ceil(th) + 6 -- текст + поле згори/знизу
            if cur + 0.5 < needed then
                row:SetHeight(needed); grew = true
                ns.Diag(("gossip-fit: рядок %.0f>%d (текст %.0f)"):format(cur, needed, th))
            end
        end
    end)
    if grew and type(sb.FullUpdate) == "function" then
        relayoutGuard = true
        pcall(function() sb:FullUpdate(true) end) -- reflow: наступні рядки зсуваються
        relayoutGuard = false
        -- БЕЗ повторного виклику FitGreetingRows: якщо view скидає висоту назад
        -- (фіксований extent) — це був би нескінченний цикл. Один прохід; якщо не
        -- допомогло, діаг gossip-fit покаже висоти й extent-режим для точного фіксу.
    end
end

-- Ім'я NPC у ШАПЦІ вікна (gossip/квест). Вгадування конкретного FontString
-- (_G.GossipFrameTitleText) давало GetText=nil → не той об'єкт. Тому НЕ вгадуємо:
-- ОБХОДИМО контейнер шапки й перекладаємо БУДЬ-ЯКИЙ напис, що збігається з іменем
-- істоти (ns.npcNames). Безпечно — у вікні лише шапка збігається з npcNames (тіло =
-- речення). Гейт world.npcNames. Діаг ttl-fs логує всі короткі написи шапки.
local titleBusy = false
local function TranslateTitleFS(fs)
    if titleBusy or not (fs and fs.GetText and fs.SetText) then return end
    local en = ns.SafeText(fs:GetText())                        -- secret/порожнє → nil
    if not en or en == "" or (ns.HasCyrillic and ns.HasCyrillic(en)) then return end
    -- Ім'я NPC може бути в npcNames АБО в gossip-словнику (капча інколи пише ім'я як
    -- gossip-рядок). Тому шукаємо в обох — інакше gossip-вікно перекладає шапку, а
    -- quest-вікно ні (той самий NPC — дві різні форми). Шапка = один короткий напис,
    -- тож gossip-фолбек безпечний (не зачепить тіло).
    local ua = (ns.npcNames and ns.npcNames[en]) or (ns.gossip and ns.gossip[en])
    if not ua or en == ua then return end
    if not (ns.IsEnabled and ns.IsEnabled("world.npcNames")) then return end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    titleBusy = true
    if ns.Remember then ns.Remember(fs, en, ua, nil, "world.npcNames") end
    fs:SetText(ua)
    titleBusy = false
end
local function WalkTitle(frame, depth)
    if ns.IsTooltipFrame(frame) then return  end
    if not frame or (depth or 0) > 3 then return end
    if frame.GetRegions then
        for _, r in ipairs(ns.Regions(frame)) do
            if r.IsObjectType and r:IsObjectType("FontString") then ns.Guard("розмова", TranslateTitleFS, r) end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do WalkTitle(c, (depth or 0) + 1) end
    end
end
-- ВАЖЛИВО: обходимо ЛИШЕ контейнер ШАПКИ (TitleContainer) — там тільки ім'я NPC.
-- НЕ весь фрейм, щоб НЕ зачепити тіло/опції, де текст міг би випадково збігтися з
-- іменем істоти (саме цього й боявся юзер). Якщо TitleContainer нема — нічого не робимо
-- (діаг нижче покаже структуру, тоді прицілимось точно).
local function DoTitle(name, frame)
    if not (frame and frame:IsShown()) then return end
    -- 1) ПРЯМО глобал-напис: GossipFrameTitleText / QuestFrameTitleText
    local gname = (name == "gossip") and "GossipFrameTitleText" or "QuestFrameTitleText"
    local gfs = _G[gname]
    if gfs and gfs.GetText then ns.Guard("розмова", TranslateTitleFS, gfs) end
    -- 2) і TitleContainer (на випадок, якщо напис там)
    local tc = frame.TitleContainer
    if tc then WalkTitle(tc, 0) end
end
local function RefreshTitles()
    DoTitle("gossip", GossipFrame)
    DoTitle("quest", _G.QuestFrame)
end

local function Refresh()
    if not GossipFrame or not GossipFrame:IsShown() then return end
    RebuildQuestTitleMap() -- свіжа мапа enНазва->questID для цього вікна
    HookGreetingScrollBox() -- раптом панель створилась лише тепер
    ns.Guard("розмова", RefreshTitles) -- ім'я NPC у шапці (обхід ЛИШЕ TitleContainer)
    local ok, err = pcall(WalkGossip, GossipFrame, 1)
    if not ok then ns.Diag("ПОМИЛКА діалогів: " .. tostring(err)) end
    ns.Guard("розмова", WalkScrollBox) -- опції-кнопки з пулу (їх WalkGossip ненадійно дістає)
    ns.Guard("розмова", FitGreetingRows) -- підігнати висоту рядків під довший укр. текст (перенос)
    -- Структуровано збираємо й через API (надійніше за віджети).
    local ok2, err2 = pcall(function()
        local greeting = C_GossipInfo.GetText()
        if greeting and not (ns.gossip and ns.gossip[greeting]) then
            CaptureGossip(greeting)
        end
        for _, opt in ipairs(C_GossipInfo.GetOptions() or {}) do
            if opt.name and not (ns.gossip and ns.gossip[opt.name]) then
                CaptureGossip(opt.name)
            end
        end
    end)
    if not ok2 then ns.Diag("ПОМИЛКА збору діалогів: " .. tostring(err2)) end
end

-- ТІКЕР поки GossipFrame показаний: разові спроби (0/0.2/0.5с) ПРОМАХУВАЛИСЬ, коли
-- сервер оновлював тіло вітання пізніше (вибір опції в діалозі / лаг) — довгий текст
-- Ен'ліана так і не потрапляв ані в переклад, ані в капчу («аддон не каже, що дані
-- зібрані»). Тікер (0.6с) капчить+перекладає, поки вікно відкрите; CaptureGossip
-- дедупить по ключу, тож повторні проходи дешеві. Патерн як у ScrollBox re-walk.
local gossipTicking = false
local function StartGossipTicker()
    if gossipTicking or not (C_Timer and C_Timer.After) then return end
    gossipTicking = true
    local function tick()
        if not (GossipFrame and GossipFrame.IsShown and GossipFrame:IsShown()) then
            gossipTicking = false
            return
        end
        ns.Guard("розмова", Refresh)
        ns.Guard("розмова", CaptureGreeting)
        C_Timer.After(0.6, tick)
    end
    C_Timer.After(0.6, tick)
end

local f = CreateFrame("Frame")
f:RegisterEvent("GOSSIP_SHOW")
f:SetScript("OnEvent", function()
    C_Timer.After(0, Refresh)
    C_Timer.After(0.2, Refresh)
    -- тіло вітання (якщо панель GreetingPanel показана цією подією)
    for _, d in ipairs({ 0, 0.2, 0.5 }) do C_Timer.After(d, CaptureGreeting) end
    -- ім'я NPC у шапці з'являється пізніше → кілька спроб (обхід лише TitleContainer)
    for _, d in ipairs({ 0, 0.3, 0.6, 1.0, 1.5 }) do C_Timer.After(d, RefreshTitles) end
    StartGossipTicker() -- пізні серверні оновлення тіла (вибір опції) — ловити, поки відкрито
end)
HookGreetingScrollBox() -- зачепити ScrollBox одразу, щоб і перше вікно не блимнуло

-- Ім'я NPC у шапці ВІКНА КВЕСТУ — та сама RefreshTitles (вона обходить і QuestFrame.
-- TitleContainer). Та сама «Arator» у деталях/прогресі/нагороді квесту. Лише TitleContainer.
local qtf = CreateFrame("Frame")
qtf:RegisterEvent("QUEST_DETAIL")     -- деталі (прийняти)
qtf:RegisterEvent("QUEST_PROGRESS")   -- прогрес (здача)
qtf:RegisterEvent("QUEST_COMPLETE")   -- нагорода (цей скрін)
qtf:RegisterEvent("QUEST_GREETING")   -- кілька квестів від NPC + тіло вітання
qtf:SetScript("OnEvent", function(_, event)
    for _, d in ipairs({ 0, 0.3, 0.6, 1.0 }) do C_Timer.After(d, RefreshTitles) end
    -- QUEST_GREETING: панель вітання NPC (тіло) — серверний текст, якого НЕ ловить
    -- GOSSIP_SHOW. Без цього репліки NPC із квестами (напр. гарнізонний Foreman
    -- Zipfizzle) ніколи не потрапляли в db.gossip. CaptureGreeting пробує всі шляхи.
    if event == "QUEST_GREETING" then
        for _, d in ipairs({ 0, 0.2, 0.5 }) do C_Timer.After(d, CaptureGreeting) end
    end
end)

-- Shift «показати оригінал» — Core.ns.ToggleOriginal свопає ns.replacements за
-- ТОЧНИМ збігом тексту. Але назви квестів показуються з |c..|r-кодами / ApplyNames,
-- тоді як збережене ua=qua — plain, тож збіг ламається на ре-рендері ScrollBox →
-- після Shift назви ЛИШАЮТЬСЯ англійською. Надійно (як трекер/делви): на зміну
-- Shift просто РЕ-WALK'аємо gossip — TranslateFontString сам гейтує EN/UA за
-- ShowOriginal(), тож утримання Shift лишає оригінал, а відпускання гарантовано
-- повертає переклад, незалежно від кольор-кодів і перепулення кнопок.
local shiftWatcher = CreateFrame("Frame")
shiftWatcher:RegisterEvent("MODIFIER_STATE_CHANGED")
-- Сигнатура OnEvent — (self, event, key). До 07.10.2026 тут стояло function(_, key): у key
-- приходила НАЗВА ПОДІЇ, перевірка на LSHIFT завжди хибна — обробник не спрацьовував
-- ніколи. Клавіша — обрана в налаштуваннях (originalKey), як у Core, а не жорсткий Shift.
shiftWatcher:SetScript("OnEvent", function(_, _, key)
    local chosen = ns.GetSetting and ns.GetSetting("originalKey")
    if not chosen or chosen == "NONE" or type(key) ~= "string" or not key:find(chosen, 1, true) then return end
    local gossipShown = GossipFrame and GossipFrame:IsShown()
    local questShown = _G.QuestFrame and _G.QuestFrame:IsShown()
    if not (gossipShown or questShown) then return end
    if C_Timer then
        C_Timer.After(0, function()        -- поза стеком натискання — taint-safe
            if gossipShown then ns.Guard("розмова", Refresh) end
            ns.Guard("розмова", RefreshTitles)            -- імена NPC у шапці gossip/квесту
        end)
    end
end)
