-- WoWUkraine: підміна англійських текстів квестів українськими.
-- Працює поверх стандартного UI: після того, як Blizzard-код заповнив
-- віджети, замінюємо текст, якщо переклад є в базі (ns.quests).

local _, ns = ...

-- Поточний questID залежно від контексту (вікно NPC чи журнал квестів).
local function CurrentQuestID()
    if QuestInfoFrame and QuestInfoFrame.questLog then
        return C_QuestLog.GetSelectedQuest()
    end
    return GetQuestID()
end

-- Плейсхолдери гравця в перекладах: {name}, {class}, {race}
-- (так їх рендерить wago.tools із токенів Blizzard $n/$c/$r).
-- {class:v}/{race:v} — кличний відмінок (звертання), розмічається в базі.
local CLASS_UA = {
    WARRIOR = { "воїн", "воїне" },
    PALADIN = { "паладин", "паладине" },
    HUNTER = { "мисливець", "мисливцю" },
    ROGUE = { "розбійник", "розбійнику" },
    PRIEST = { "жрець", "жерче" },
    DEATHKNIGHT = { "лицар смерті", "лицарю смерті" },
    SHAMAN = { "шаман", "шамане" },
    MAGE = { "маг", "магу" },
    WARLOCK = { "чорнокнижник", "чорнокнижнику" },
    MONK = { "монах", "монаху" },
    DRUID = { "друїд", "друїде" },
    DEMONHUNTER = { "мисливець на демонів", "мисливцю на демонів" },
    EVOKER = { "пробудник", "пробуднику" },
}
local RACE_UA = {
    Human = { "людина", "людино" },
    Dwarf = { "дворф", "дворфе" },
    NightElf = { "нічний ельф", "нічний ельфе" },
    Gnome = { "гном", "гноме" },
    Draenei = { "дреней", "дренею" },
    Worgen = { "ворґен", "ворґене" },
    Pandaren = { "пандарен", "пандарене" },
    Orc = { "орк", "орку" },
    Scourge = { "нежить", "нежите" },
    Tauren = { "таурен", "таурене" },
    Troll = { "троль", "тролю" },
    BloodElf = { "кровний ельф", "кровний ельфе" },
    Goblin = { "ґоблін", "ґобліне" },
    Nightborne = { "ночеродний", "ночеродний" },
    HighmountainTauren = { "таурен Крутогір'я", "таурене Крутогір'я" },
    VoidElf = { "ельф Порожнечі", "ельфе Порожнечі" },
    LightforgedDraenei = { "загартований Світлом дреней", "загартований Світлом дренею" },
    ZandalariTroll = { "зандаларський троль", "зандаларський тролю" },
    KulTiran = { "кул-тирасець", "кул-тирасцю" },
    DarkIronDwarf = { "темнозалізний дворф", "темнозалізний дворфе" },
    Vulpera = { "вульпера", "вульперо" },
    MagharOrc = { "маґхарський орк", "маґхарський орку" },
    Mechagnome = { "мехагном", "мехагноме" },
    Dracthyr = { "драктир", "драктире" },
    EarthenDwarf = { "землянин", "землянине" },
    Earthen = { "землянин", "землянине" },
}

local function Localize(text)
    if not text then return nil end
    local _, classToken = UnitClass("player")
    local _, raceToken = UnitRace("player")
    local class = CLASS_UA[classToken or ""] or { "герой", "герою" }
    local race = RACE_UA[raceToken or ""] or { "мандрівник", "мандрівнику" }
    text = text:gsub("%{[Nn][Aa][Mm][Ee]%}", UnitName("player") or "")
    -- Клас — через ns.ApplyPlayerClass (враховує СТАТЬ: паладинко/паладине), щоб
    -- квест і broadcast давали однакову форму. Запаска — локальний masc-only набір.
    if ns.ApplyPlayerClass then
        text = ns.ApplyPlayerClass(text)
    else
        text = text:gsub("%{class:v%}", class[2]):gsub("%{class%}", class[1])
    end
    text = text:gsub("%{race:v%}", race[2]):gsub("%{race%}", race[1])
    text = ns.ApplyPlayerGender(text)  -- $p(чол:жін) → за статтю гравця
    return ns.ApplyNames(text) -- опція «оригінальні імена» (Wrathion замість Вратіон)
end

-- Пара «оригінал/переклад» для кожного зміненого напису — щоб клавіша
-- «показати оригінал» перемикала текст наживо (слабкі ключі — без витоків).
local originals = ns.replacements -- спільний центральний реєстр (Shift свопає його)

local function SetTextIfShown(fontString, text)
    if fontString and text and text ~= "" and fontString:IsShown() then
        local localized = Localize(text)
        local current = ns.SafeText(fontString:GetText())
        if current ~= localized then
            originals[fontString] = { en = current, ua = localized }
        end
        fontString:SetText(localized)
    end
end

-- Перемикає всі видимі змінені написи між оригіналом і перекладом.
-- Обережно: чіпає напис, лише якщо там зараз САМЕ наша пара текстів —
-- якщо гра вже перемалювала віджет під інший квест, не втручаємось.
local function ApplyOriginalState()
    local showOriginal = ns.ShowOriginal()
    for fs, pair in pairs(originals) do
        if fs.IsShown and fs:IsShown() and pair.en then
            local current = ns.SafeText(fs:GetText())
            if showOriginal and current == pair.ua then
                fs:SetText(pair.en)
            elseif not showOriginal and current == pair.en then
                fs:SetText(pair.ua)
            end
        end
    end
end

-- Shift «показати оригінал» тепер централізовано в Core (ns.ToggleOriginal
-- свопає спільний реєстр ns.replacements, куди реєструє й цей модуль).

-- Статичні заголовки вікна квесту (однакові для всіх квестів).
-- Заміна за точним збігом англійського рядка — якщо Blizzard змінить
-- формулювання, ми просто лишимо оригінал, нічого не зламавши.
local UI_LABELS = {
    ["Description"] = "Опис",
    ["Quest Objectives"] = "Цілі квесту",
    ["Rewards"] = "Нагороди",
    ["You will receive:"] = "Ви отримаєте:",
    ["You will also receive:"] = "Ви також отримаєте:",
    ["You will be able to choose one of these rewards:"]
        = "Ви зможете обрати одну з цих нагород:",
    ["You shall be granted the title:"] = "Вам буде даровано титул:",
    ["Requirements"] = "Вимоги",
    ["Completion"] = "Завершення",
    -- Вікно прогресу здачі (варіанти регістру/двокрапки — точний збіг).
    ["Required Items:"] = "Потрібні предмети:",
    ["Required items:"] = "Потрібні предмети:",
    ["Required Items"] = "Потрібні предмети",
    ["Required Money:"] = "Потрібні гроші:",
    -- Кнопки вікна прогресу.
    ["Continue"] = "Продовжити",
    ["Cancel"] = "Скасувати",
    ["Complete Quest"] = "Завершити квест",
}

local function TranslateLabel(fontString)
    -- Деякі Blizzard-«заголовки» — це Frame без GetText: пропускаємо їх,
    -- інакше виклик неіснуючого методу вбиває весь переклад квесту.
    if not fontString or type(fontString.GetText) ~= "function" then return end
    local current = ns.SafeText(fontString:GetText())
    local ua = current and UI_LABELS[current]
    if ua then
        originals[fontString] = { en = current, ua = ua }
        fontString:SetText(ua)
    end
end

-- Заголовки перекладаються для БУДЬ-ЯКОГО квесту (не лише з базою перекладу).
local function TranslateQuestFrameLabels()
    if not ns.IsEnabled("quests.ui") then return end
    TranslateLabel(QuestInfoDescriptionHeader)
    TranslateLabel(QuestInfoObjectivesHeader)
    -- Вікно розмови з NPC.
    TranslateLabel(QuestInfoRewardsFrame and QuestInfoRewardsFrame.Header)
    TranslateLabel(QuestInfoRewardsFrame and QuestInfoRewardsFrame.ItemChooseText)
    TranslateLabel(QuestInfoRewardsFrame and QuestInfoRewardsFrame.ItemReceiveText)
    TranslateLabel(QuestInfoRewardsFrame and QuestInfoRewardsFrame.PlayerTitleText)
    -- Деталі квесту в журналі (мапа) — власний набір віджетів.
    TranslateLabel(MapQuestInfoRewardsFrame and MapQuestInfoRewardsFrame.Header)
    TranslateLabel(MapQuestInfoRewardsFrame and MapQuestInfoRewardsFrame.ItemChooseText)
    TranslateLabel(MapQuestInfoRewardsFrame and MapQuestInfoRewardsFrame.ItemReceiveText)
    TranslateLabel(MapQuestInfoRewardsFrame and MapQuestInfoRewardsFrame.PlayerTitleText)
    local details = QuestMapFrame and QuestMapFrame.DetailsFrame
    if details and details.RewardsFrameContainer then
        TranslateLabel(details.RewardsFrameContainer.RewardsFrame
            and details.RewardsFrameContainer.RewardsFrame.Label)
    end
    if details and details.RewardsFrame then
        TranslateLabel(details.RewardsFrame.Label)
    end
end

-- Назви предметів-НАГОРОД у вікні здачі (QuestInfoRewardsFrame.RewardButtons):
-- тултіп уже перекладає, а слот — ні. Беремо itemID через GetQuestItemLink за
-- типом/ID кнопки -> ns.items[itemID]. Гейт той самий, що й тултіп (items.name).
local function TranslateRewardItemNames()
    if ns.ShowOriginal() then return end
    local rf = QuestInfoRewardsFrame
    local buttons = rf and rf.RewardButtons
    if type(buttons) ~= "table" then return end
    local wantItems = ns.IsEnabled("items.name") and GetQuestItemLink
    for _, btn in ipairs(buttons) do
        local nameFS = btn and btn.IsShown and btn:IsShown() and btn.Name
        local cur = nameFS and ns.SafeText(nameFS:GetText())
        -- Гард: якщо текст УЖЕ перекладено (кирилиця), не чіпати — інакше на
        -- повторному проході валюту приймає за предмет (петля, дубль назв).
        if cur and not (ns.HasCyrillic and ns.HasCyrillic(cur)) then
            local c = ns.currencyByName and ns.currencyByName[cur]
            if c and c.name and cur ~= c.name then
                -- ВАЛЮТА — за назвою (завжди, не гейтимо items.name).
                originals[nameFS] = { en = cur, ua = c.name }
                nameFS:SetText(c.name)
            elseif wantItems and btn.type and btn.GetID then
                -- ПРЕДМЕТ — за itemID (гейт items.name, як у тултіпі).
                local ok, link = pcall(GetQuestItemLink, btn.type, btn:GetID())
                local itemID = ok and link and tonumber(link:match("item:(%d+)"))
                local entry = itemID and ns.items and ns.items[itemID]
                local uaName = entry and (type(entry) == "table" and entry.name or entry)
                if uaName and cur ~= uaName then
                    originals[nameFS] = { en = cur, ua = uaName }
                    nameFS:SetText(uaName)
                end
            end
        end
    end
end

-- Вікно деталей квесту (прийняття), журнал квестів і вікно нагород (здача)
-- заповнюються через QuestInfo_Display — перехоплюємо після нього.
-- Кожен тип тексту має ВЛАСНИЙ перемикач у налаштуваннях (ns.IsEnabled).
-- Стан віджета одним словом — для діагностичного логу.
local function WidgetState(fs)
    if not fs then return "nil" end
    return fs:IsShown() and "видимий" or "схований"
end

local function TranslateQuestInfo()
    local questID = CurrentQuestID()
    local t = ns.GetQuestTranslation(questID)
    local total = 0
    if ns.quests then for _ in pairs(ns.quests) do total = total + 1 end end
    ns.Diag(("QuestInfo: id=%s | у базі %d | переклад=%s | оригінал-клавіша=%s"):format(
        tostring(questID), total, t and "Є" or "НЕМАЄ", tostring(ns.ShowOriginal())))
    ns.Diag(("віджети: title=%s desc=%s obj=%s | desc='%s'"):format(
        WidgetState(QuestInfoTitleHeader), WidgetState(QuestInfoDescriptionText),
        WidgetState(QuestInfoObjectivesText),
        QuestInfoDescriptionText and tostring(QuestInfoDescriptionText:GetText()):sub(1, 60) or "-"))
    if ns.debug then
        ns.Print(("квест: id=%s | у базі %d | переклад: %s"):format(
            tostring(questID), total, t and "Є" or "НЕМАЄ"))
    end

    if ns.ShowOriginal() then return end -- клавіша «показати оригінал»

    -- СПЕРШУ основний текст квесту — він найважливіший.
    if t then
        if ns.IsEnabled("quests.title") then
            SetTextIfShown(QuestInfoTitleHeader, t.title)
        end
        if ns.IsEnabled("quests.text") then
            SetTextIfShown(QuestInfoDescriptionText, t.description)
            SetTextIfShown(QuestInfoRewardText, t.completion)
        end
        if ns.IsEnabled("quests.objectives") then
            SetTextIfShown(QuestInfoObjectivesText, t.objectives)
        end
    end

    -- Службові заголовки («Нагороди» тощо) — ПІСЛЯ тексту й у власному
    -- pcall: збій на якомусь Blizzard-віджеті не блокує переклад квесту.
    local ok, err = pcall(TranslateQuestFrameLabels)
    if not ok then ns.Diag("ПОМИЛКА заголовків: " .. tostring(err)) end
    ns.Guard("завдання", TranslateRewardItemNames) -- назви предметів-нагород у слотах
end

-- ХУКИ НА САМИХ ВІДЖЕТАХ: Blizzard переставляє тексти вікна квеста
-- кілька разів (зокрема коли дані доїжджають із сервера) — і не кожен
-- раз через QuestInfo_Display. Хук на SetText конкретного віджета
-- перекриває АНГЛІЙСЬКИЙ текст українським у тому ж виклику — на екран
-- він не потрапляє. (Те саме рішення, що для трекера.)
local applying = false
local function HookQuestWidget(fs, settingKey, field, idFn)
    if not fs or type(fs.SetText) ~= "function" then return end
    hooksecurefunc(fs, "SetText", function(self)
        if applying then return end
        local ok, err = pcall(function()
            if ns.ShowOriginal() then return end
            if not ns.IsEnabled(settingKey) then return end
            local t = ns.GetQuestTranslation(idFn())
            local ua = t and t[field]
            if not ua then return end
            local localized = Localize(ua)
            local current = ns.SafeText(self:GetText())
            if current ~= localized then
                originals[self] = { en = current, ua = localized }
                applying = true
                self:SetText(localized)
                applying = false
            end
        end)
        applying = false
        if not ok then
            ns.Diag("ПОМИЛКА віджет-хука: " .. tostring(err))
        end
    end)
end

local function NpcQuestID() return GetQuestID() end

local widgetsHooked = false
local function HookAllQuestWidgets()
    if widgetsHooked then return end
    widgetsHooked = true
    HookQuestWidget(QuestInfoTitleHeader, "quests.title", "title", CurrentQuestID)
    HookQuestWidget(QuestInfoDescriptionText, "quests.text", "description", CurrentQuestID)
    HookQuestWidget(QuestInfoObjectivesText, "quests.objectives", "objectives", CurrentQuestID)
    HookQuestWidget(QuestInfoRewardText, "quests.text", "completion", CurrentQuestID)
    HookQuestWidget(QuestProgressTitleText, "quests.title", "title", NpcQuestID)
    HookQuestWidget(QuestProgressText, "quests.text", "progress", NpcQuestID)
end
-- Віджети існують уже на момент завантаження аддона; якщо ні —
-- добираємо при вході у світ.
HookAllQuestWidgets()
if not (QuestInfoTitleHeader and QuestProgressText) then
    widgetsHooked = false
    local hookFrame = CreateFrame("Frame")
    hookFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    hookFrame:SetScript("OnEvent", function(self)
        HookAllQuestWidgets()
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
    end)
end

-- Якщо всередині щось упало — кажемо про це в чат, а не мовчки
-- лишаємо квест англійською (перші 3 рази, щоб не спамити).
local errorsShown = 0
local function OnQuestInfoDisplay()
    local ok, err = pcall(TranslateQuestInfo)
    if not ok then
        ns.Diag("ПОМИЛКА: " .. tostring(err))
        if ns.debug and errorsShown < 3 then
            errorsShown = errorsShown + 1
            ns.Print("ПОМИЛКА перекладу квесту: " .. tostring(err))
        end
    end
end

-- Якщо Blizzard прибере/перейменує QuestInfo_Display, файл не повинен
-- померти на hooksecurefunc — перевіряємо наявність явно.
if type(QuestInfo_Display) == "function" then
    hooksecurefunc("QuestInfo_Display", OnQuestInfoDisplay)
end

-- Запасний шлях: події вікна квесту в NPC. C_Timer.After(0) — щоб наш
-- код виконався ПІСЛЯ того, як Blizzard заповнить віджети.
local questEvents = CreateFrame("Frame")
questEvents:RegisterEvent("QUEST_DETAIL")
questEvents:RegisterEvent("QUEST_COMPLETE")
questEvents:SetScript("OnEvent", function(_, event)
    ns.Diag("подія: " .. event)
    C_Timer.After(0, OnQuestInfoDisplay)
end)

ns.Diag(("QuestHooks завантажено | QuestInfo_Display: %s"):format(type(QuestInfo_Display)))

-- Вікно прогресу ("повернися, коли зробиш") має окремий шлях оновлення.
local progressFrame = CreateFrame("Frame")
progressFrame:RegisterEvent("QUEST_PROGRESS")
progressFrame:SetScript("OnEvent", function()
    local ok, err = pcall(function()
        if ns.ShowOriginal() then return end

        local t = ns.GetQuestTranslation(GetQuestID())
        if t then
            if ns.IsEnabled("quests.title") then
                SetTextIfShown(QuestProgressTitleText, t.title)
            end
            if ns.IsEnabled("quests.text") then
                SetTextIfShown(QuestProgressText, t.progress)
            end
        end

        if ns.IsEnabled("quests.ui") then
            TranslateLabel(QuestProgressRequiredItemsText)
            -- Кнопки вікна прогресу (текст у FontString кнопки). Імена різняться
            -- між версіями — пробуємо відомі; кожну захищено (немає -> пропуск).
            local function btnFS(b) return b and b.GetFontString and b:GetFontString() end
            for _, name in ipairs({ "QuestFrameCompleteButton", "QuestFrameGoodbyeButton",
                                    "QuestFrameCancelButton" }) do
                TranslateLabel(btnFS(_G[name]))
            end
        end

        -- Назви required-предметів у слотах: тултіп уже перекладає назву, а слот
        -- ні. Беремо itemID через GetQuestItemLink -> ns.items[itemID]. Гейт той
        -- самий, що й у тултіпі (items.name), щоб поведінка збігалась.
        if ns.IsEnabled("items.name") and GetQuestItemLink then
            for i = 1, 6 do
                local btn = _G["QuestProgressItem" .. i]
                local nameFS = btn and (btn.Name or _G["QuestProgressItem" .. i .. "Name"])
                if btn and btn:IsShown() and nameFS and nameFS.SetText then
                    local link = GetQuestItemLink("required", i)
                    local itemID = link and tonumber(link:match("item:(%d+)"))
                    local entry = itemID and ns.items and ns.items[itemID]
                    local uaName = entry and (type(entry) == "table" and entry.name or entry)
                    local cur = uaName and ns.SafeText(nameFS:GetText())
                    if uaName and cur and cur ~= uaName then
                        originals[nameFS] = { en = cur, ua = uaName }
                        nameFS:SetText(uaName)
                    end
                end
            end
        end
    end)
    if not ok then
        if ns.Diag then ns.Diag("ПОМИЛКА прогресу: " .. tostring(err)) end
        if ns.debug and errorsShown < 3 then
            errorsShown = errorsShown + 1
            ns.Print("ПОМИЛКА перекладу прогресу: " .. tostring(err))
        end
    end
end)
