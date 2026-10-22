-- Збір англійських текстів квестів, які гравець зустрічає в грі.
-- Усе, що ще не перекладено, записується у SavedVariables (через
-- ns.GetCaptureDB(), назва змінної залежить від назви аддона).
-- Після виходу з гри файл WTF\...\SavedVariables\<НазваАддона>.lua
-- згодовується пайплайну перекладу (pipeline/parse_capture.py).

local _, ns = ...

-- Публічна збірка: збирача текстів немає взагалі (нічого не реєструємо/не пишемо).
if ns.PUBLIC then return end

-- Сповіщення про збір (моби/квести/книги) — лише якщо увімкнено перемикач
-- "capture.notify" (Налаштування → Збір текстів). САМ ЗБІР працює завжди.
local function notify(msg)
    if ns.GetSetting and ns.GetSetting("capture.notify") and ns.Print then
        ns.Print(msg)
    end
end

-- Зберегти ОДНЕ поле квесту, якщо його ще НЕМАЄ В ПЕРЕКЛАДІ. Кожне поле
-- незалежне: серверні progress/completion часто відсутні навіть тоді, коли
-- title/description/objectives вже перекладені. Раніше це блокувало збір
-- ТЕКСТУ ЗДАЧІ квесту (completion) для всіх перекладених квестів — баг.
-- Запис у capture створюється ЛІНИВО — лише коли реально є що зберегти,
-- тож готові квести не засмічують файл.
local function StoreIfNew(questID, field, text)
    if not questID or questID == 0 or not text or text == "" then return end
    local t = ns.GetQuestTranslation(questID)
    if t and t[field] then return end          -- це поле вже перекладено
    local quests = ns.GetCaptureDB().quests
    local entry = quests[questID]
    if entry and entry[field] then return end  -- вже зібрано цієї сесії
    if not entry then
        entry = {}
        quests[questID] = entry
        notify(("Зібрано квест #%d для перекладу."):format(questID))
    end
    entry[field] = text
end

-- Квести, відкриті в ЖУРНАЛІ (мапа) — вікна NPC немає, тексти беремо
-- з C_QuestLog. Хук той самий, що й у перекладача (QuestInfo_Display).
if type(QuestInfo_Display) == "function" then
    hooksecurefunc("QuestInfo_Display", function()
        pcall(function()
            if not (QuestInfoFrame and QuestInfoFrame.questLog) then return end
            local questID = C_QuestLog.GetSelectedQuest()
            local idx = questID and C_QuestLog.GetLogIndexForQuestID(questID)
            if idx then
                local desc, obj = GetQuestLogQuestText(idx)
                StoreIfNew(questID, "title", C_QuestLog.GetTitleForQuestID(questID))
                StoreIfNew(questID, "description", desc)
                StoreIfNew(questID, "objectives", obj)
            end
        end)
    end)
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("QUEST_DETAIL")
f:RegisterEvent("QUEST_PROGRESS")
f:RegisterEvent("QUEST_COMPLETE")
f:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_LOGIN" then
        -- Ім'я персонажа потрібне пайплайну, щоб замінити його на {NAME}
        -- у зібраних текстах (клієнт підставляє ім'я ще до GetQuestText()).
        ns.GetCaptureDB().meta.playerName = UnitName("player")
        -- ВЕРСІЯ АДДОНА Й БІЛД ГРИ. Без них неможливо сказати, чи помилка в
        -- лозі сталася ДО чи ПІСЛЯ фіксу: збір накопичується в SavedVariables
        -- між сесіями, тож старі рядки лишаються й після оновлення.
        -- Реальний випадок: 11 блокувань UseToy у зборі, і жодного способу
        -- дізнатися, чи тестер уже мав виправлену збірку.
        local meta = ns.GetCaptureDB().meta
        if C_AddOns and C_AddOns.GetAddOnMetadata then
            meta.addonVersion = C_AddOns.GetAddOnMetadata("UALL", "Version")
        end
        if GetBuildInfo then
            local ver, build, _, iface = GetBuildInfo()
            meta.gameVersion, meta.gameBuild, meta.interface = ver, build, iface
        end
        if GetRealmName then meta.realm = GetRealmName() end
        -- прибрати «Unknown», що могли потрапити до фіксу (імʼя ще не довантажилось)
        local npc = ns.GetCaptureDB().npc
        if npc then
            for cid, nm in pairs(npc) do
                if nm == UNKNOWN or nm == "Unknown" then npc[cid] = nil end
            end
        end
        return
    end

    local questID = GetQuestID()

    if event == "QUEST_DETAIL" then
        StoreIfNew(questID, "title", GetTitleText())
        StoreIfNew(questID, "description", GetQuestText())
        StoreIfNew(questID, "objectives", GetObjectiveText())
    elseif event == "QUEST_PROGRESS" then
        StoreIfNew(questID, "title", GetTitleText())
        StoreIfNew(questID, "progress", GetProgressText())
    elseif event == "QUEST_COMPLETE" then
        StoreIfNew(questID, "title", GetTitleText())
        StoreIfNew(questID, "completion", GetRewardText())
    end
end)

-- ── КНИГИ (ItemText): серверний текст сторінок — книги, листи, таблички.
-- Немає у відкритих базах Blizzard, лише збір у грі. Збираємо ПОСТОРІНКОВО,
-- поки гравець гортає (подія спрацьовує на кожну сторінку). Дедуп за назвою+
-- сторінкою — повторне читання не дублює. Зберігається у db.books[назва][page].
local bookFrame = CreateFrame("Frame")
bookFrame:RegisterEvent("ITEM_TEXT_READY")
bookFrame:SetScript("OnEvent", function()
    pcall(function()
        local title = ItemTextGetItem()
        local text = ItemTextGetText()
        if not title or title == "" or not text or text == "" then return end
        -- коли зʼявиться база книг (ns.bookTexts) — вже перекладене не збирати
        if ns.bookTexts and ns.bookTexts[text] then return end
        local page = (ItemTextGetPage and ItemTextGetPage()) or 1
        local db = ns.GetCaptureDB()
        db.books = db.books or {}
        local b = db.books[title]
        if not b then b = {} db.books[title] = b end
        if not b[page] then
            b[page] = text
            notify(("Зібрано книгу «%s» (стор. %d)."):format(title, page))
        end
    end)
end)

-- ── ІМЕНА ІСТОТ: моби, яких немає в жодному статичному джерелі (ні wago, ні
-- Blizzard API) — їх дістати можна ЛИШЕ в грі. Записуємо англ. UnitName +
-- creatureID (з GUID) кожного НЕ-гравця, кого гравець наводить/бере в ціль/
-- бачить неймплейт. Збираємо ЛИШЕ неперекладених (нема в ns.npcNames).
-- db.npc[creatureID] = "English Name". Екстракт: pipeline/extract_capture_creatures.py.
local function CaptureUnit(unit)
    if not unit or not UnitExists(unit) or UnitIsPlayer(unit) then return end
    local guid = UnitGUID(unit)
    if not guid then return end
    local kind, _, _, _, _, npcID = strsplit("-", guid)
    if (kind ~= "Creature" and kind ~= "Vehicle") or not npcID then return end
    local db = ns.GetCaptureDB()
    -- СТАТЬ NPC — для ГЕНДЕР-ПРОХОДУ квестів (рід мовця у першоособових описах, де
    -- DE/FR нейтральні). UnitSex: 2=чол, 3=жін, 1=невідомо/без роду. Ловимо для
    -- БУДЬ-ЯКОГО NPC, навіть уже перекладеного (рід потрібен незалежно від імені).
    if UnitSex then
        local sex = UnitSex(unit)
        if sex == 2 or sex == 3 then
            db.npcSex = db.npcSex or {}
            db.npcSex[npcID] = sex
        end
    end
    -- ІМ'Я: SafeText повертає nil для СЕКРЕТНИХ значень (делв-моби Midnight) і порожніх.
    -- БЕЗ запасного "or UnitName" — інакше сире секретне значення впаде на порівнянні.
    local name = ns.SafeText and ns.SafeText(UnitName(unit))
    if not name or name == "" or name == UNKNOWN or name == "Unknown" then return end
    if ns.npcNames and ns.npcNames[name] then return end          -- уже перекладено
    if ns.HasCyrillic and ns.HasCyrillic(name) then return end     -- уже кирилиця
    db.npc = db.npc or {}
    if db.npc[npcID] then return end                               -- уже зібрано
    db.npc[npcID] = name
    ns.npcCapN = (ns.npcCapN or 0) + 1
    notify(("Новий моб #%d: «%s» (#%s)."):format(ns.npcCapN, name, npcID))
end

-- тултіп (наведення) — у Midnight через TooltipDataProcessor (чистий пост-виклик)
if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall
   and Enum and Enum.TooltipDataType then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tt)
        if tt ~= GameTooltip then return end
        pcall(function()
            local _, unit = tt:GetUnit()
            CaptureUnit(unit)
        end)
    end)
end

-- ціль / наведення / неймплейти
local npcCap = CreateFrame("Frame")
npcCap:RegisterEvent("PLAYER_TARGET_CHANGED")
npcCap:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
npcCap:RegisterEvent("NAME_PLATE_UNIT_ADDED")
npcCap:RegisterEvent("UNIT_NAME_UPDATE")   -- ловить імʼя, коли воно довантажилось
npcCap:SetScript("OnEvent", function(_, event, unit)
    if event == "PLAYER_TARGET_CHANGED" then
        pcall(CaptureUnit, "target")
    elseif event == "UPDATE_MOUSEOVER_UNIT" then
        pcall(CaptureUnit, "mouseover")
    else  -- NAME_PLATE_UNIT_ADDED / UNIT_NAME_UPDATE: юніт у arg1
        pcall(CaptureUnit, unit)
    end
end)

-- ── НАГОРОДИ ВИЗНАННЯ (Renown): назви+описи нагород треку фракцій (Путівник →
-- Подорожі → Renown). Blizzard НЕ віддає це через Game Data API — лише в грі через
-- C_MajorFactions. Перевага: дані дістаються БЕЗ гортання UI — проходимо всі
-- фракції × рівні одним свипом. Усе під pcall (dev-інструмент). Зберігаємо у
-- db.renown[англ.назва] = англ.опис (або true, якщо опису нема). Дедуп за назвою.
local renownDone = {}  -- fid -> true, щоб не повторювати свип щоразу

local function MajorFactionIDs()
    local C = C_MajorFactions
    if not C then return nil end
    -- різні версії: без аргументу / за доповненням
    local ok, ids = pcall(function()
        if C.GetMajorFactionIDs then return C.GetMajorFactionIDs() end
    end)
    if ok and type(ids) == "table" and #ids > 0 then return ids end
    -- перебір по доповненнях (Dragonflight=9 .. далі), збираємо все
    local all = {}
    for exp = 9, 12 do
        local ok2, list = pcall(function()
            return C.GetMajorFactionIDs and C.GetMajorFactionIDs(exp)
        end)
        if ok2 and type(list) == "table" then
            for _, id in ipairs(list) do all[#all + 1] = id end
        end
    end
    return #all > 0 and all or nil
end

local function CaptureFactionRenown(fid)
    local C = C_MajorFactions
    if not C or not C.GetRenownRewardsForLevel or renownDone[fid] then return end
    local maxLevel = 0
    pcall(function()
        local levels = C.GetRenownLevels and C.GetRenownLevels(fid)
        if type(levels) == "table" then
            for _, lv in ipairs(levels) do
                local n = type(lv) == "table" and lv.level or lv
                if type(n) == "number" and n > maxLevel then maxLevel = n end
            end
        end
    end)
    if maxLevel == 0 then maxLevel = 40 end  -- запас, якщо рівні не дістались
    local db = ns.GetCaptureDB()
    db.renown = db.renown or {}
    local added = 0
    for level = 1, maxLevel do
        pcall(function()
            local rewards = C.GetRenownRewardsForLevel(fid, level)
            if type(rewards) ~= "table" then return end
            for _, r in ipairs(rewards) do
                local name = r and r.name and ns.SafeText(r.name)
                if name and name ~= "" and not ns.HasCyrillic(name)
                   and not (ns.renownRewards and ns.renownRewards[name]) then
                    if db.renown[name] == nil then
                        local desc = r.description and ns.SafeText(r.description)
                        db.renown[name] = (desc and desc ~= "") and desc or true
                        added = added + 1
                    end
                end
            end
        end)
    end
    renownDone[fid] = true
    if added > 0 then
        notify(("Зібрано %d нагород визнання для перекладу."):format(added))
    end
end

local function SweepRenown()
    local ids = MajorFactionIDs()
    if not ids then return end
    for _, fid in ipairs(ids) do
        pcall(CaptureFactionRenown, fid)
    end
end

local renownCap = CreateFrame("Frame")
renownCap:RegisterEvent("PLAYER_ENTERING_WORLD")
renownCap:RegisterEvent("MAJOR_FACTION_RENOWN_LEVEL_CHANGED")
renownCap:RegisterEvent("MAJOR_FACTION_UNLOCKED")
renownCap:SetScript("OnEvent", function()
    -- відкладаємо: дані фракцій довантажуються після входу у світ
    if C_Timer and C_Timer.After then
        C_Timer.After(3, SweepRenown)
    else
        SweepRenown()
    end
end)

-- ── ПОЗНАЧКИ МІНІМАПИ: назви NPC/об'єктів/типів із тултіпів позначок мінімапи
-- (поштові скриньки, точки інтересу, NPC-маркери). У статичних базах їх немає —
-- лише збір у грі. Коли ВЛАСНИК GameTooltip належить мінімапі — збираємо рядки.
-- db.minimap[англ.рядок] = true. Квести/предмети/відоме відсіює Python-екстрактор.
local function MinimapOwned(frame)
    local n = 0
    while frame and n < 10 do
        if frame == Minimap or frame == MinimapCluster then return true end
        local ok, p = pcall(frame.GetParent, frame)
        if not ok then return false end
        frame = p; n = n + 1
    end
    return false
end

-- Рядок = назва ЗАВАНТАЖЕНОГО аддона? (страховка проти чужих мінімап-кнопок,
-- чий власник не має характерного імені LibDBIcon).
local function IsAddonName(s)
    if not (C_AddOns and C_AddOns.GetAddOnInfo) then return false end
    local ok, name = pcall(C_AddOns.GetAddOnInfo, s)
    return ok and name == s  -- точний збіг із назвою наявного аддона
end

local function CaptureMinimapTooltip()
    local tt = GameTooltip
    if not tt or not tt.IsShown or not tt:IsShown() then return end
    local owner = tt.GetOwner and tt:GetOwner()
    if not owner or not MinimapOwned(owner) then return end
    -- Кнопки ЧУЖИХ аддонів на мінімапі (LibDBIcon/MinimapButton) НЕ є ігровими POI-
    -- позначками — їхній тултіп = назва аддона (напр. «BtWQuests»). Власник таких —
    -- фрейм із характерним іменем; пропускаємо, щоб не збирати чужий мотлох.
    local oname = (owner.GetName and owner:GetName()) or ""
    if oname:find("LibDBIcon", 1, true) or oname:find("MinimapButton", 1, true)
       or oname:find("MinimapIcon", 1, true) or oname:find("MinimapFrame", 1, true) then
        return
    end
    local db = ns.GetCaptureDB()
    db.minimap = db.minimap or {}
    for i = 1, tt:NumLines() do
        local fs = _G["GameTooltipTextLeft" .. i]
        local t = ns.SafeText and ns.SafeText(fs and fs:GetText())
        -- лише змістовні рядки: 2..80 символів, є літера, НЕ маркер цілі «- »,
        -- НЕ кирилиця (вже наше), НЕ відоме ім'я NPC.
        if t and #t >= 2 and #t <= 80 and t:find("%a")
           and not t:match("^%s*[%-•]")
           and not ns.HasCyrillic(t)
           and not (ns.npcNames and ns.npcNames[t])
           and not IsAddonName(t)
           and not db.minimap[t] then
            db.minimap[t] = true
            ns.minimapCapN = (ns.minimapCapN or 0) + 1
            notify(("Позначка мінімапи #%d: «%s»."):format(ns.minimapCapN, t))
        end
    end
end

if GameTooltip then
    -- OnShow + наступний кадр (рядки позначки можуть дописуватись після показу).
    GameTooltip:HookScript("OnShow", function()
        pcall(CaptureMinimapTooltip)
        if C_Timer and C_Timer.After then
            C_Timer.After(0, function() pcall(CaptureMinimapTooltip) end)
        end
    end)
end
