-- WoWUkraine: назви класів і спеціалізацій у вікні талантів/спеків.
-- Перемикач: «Світ та інше → Назви класів і спеціалізацій» (classes).
--
-- Підхід: назви спеків — абстрактні поняття-іменники (як у de/fr:
-- Schutz/Vergeltung), тому рід персонажа не впливає. Підміна — лише
-- видимий текст (SetText), жодних замін API — без taint.

local _, ns = ...

-- EN -> UA. Спільні назви (Holy, Protection, Frost...) однакові для всіх класів.
local SPEC_UA = {
    ["Arcane"] = "Таємна магія",
    ["Fire"] = "Вогонь",
    ["Frost"] = "Лід",
    ["Holy"] = "Святість",
    ["Protection"] = "Захист",
    ["Retribution"] = "Відплата",
    ["Arms"] = "Зброя",
    ["Fury"] = "Лють",
    ["Balance"] = "Рівновага",
    ["Feral"] = "Дикість",
    ["Guardian"] = "Хранитель",
    ["Restoration"] = "Відновлення",
    ["Blood"] = "Кров",
    ["Unholy"] = "Нечестя",
    ["Beast Mastery"] = "Влада над звірами",
    ["Marksmanship"] = "Влучність",
    ["Survival"] = "Виживання",
    ["Discipline"] = "Дисципліна",
    ["Shadow"] = "Тінь",
    ["Assassination"] = "Убивство",
    ["Outlaw"] = "Беззаконня",
    ["Subtlety"] = "Омана",
    ["Elemental"] = "Стихії",
    ["Enhancement"] = "Посилення",
    ["Affliction"] = "Страждання",
    ["Demonology"] = "Демонологія",
    ["Destruction"] = "Руйнування",
    ["Brewmaster"] = "Броварство",
    ["Windwalker"] = "Хода вітру",
    ["Mistweaver"] = "Ткання туману",
    ["Havoc"] = "Спустошення",
    ["Vengeance"] = "Помста",
    ["Devastation"] = "Нищення",
    ["Preservation"] = "Збереження",
    ["Augmentation"] = "Підсилення",
    ["Initial"] = "Початкова",
}

local CLASS_UA = {
    ["Warrior"] = "Воїн",
    ["Paladin"] = "Паладин",
    ["Hunter"] = "Мисливець",
    ["Rogue"] = "Розбійник",
    ["Priest"] = "Жрець",
    ["Death Knight"] = "Лицар смерті",
    ["Shaman"] = "Шаман",
    ["Mage"] = "Маг",
    ["Warlock"] = "Чорнокнижник",
    ["Monk"] = "Монах",
    ["Druid"] = "Друїд",
    ["Demon Hunter"] = "Мисливець на демонів",
    ["Evoker"] = "Пробудник",
}

-- Заголовок дерева талантів пише клас КАПСОМ ("PALADIN") —
-- string.upper не знає кирилиці, тож капс-форми задано явно.
local CLASS_UA_UPPER = {
    ["WARRIOR"] = "ВОЇН",
    ["PALADIN"] = "ПАЛАДИН",
    ["HUNTER"] = "МИСЛИВЕЦЬ",
    ["ROGUE"] = "РОЗБІЙНИК",
    ["PRIEST"] = "ЖРЕЦЬ",
    ["DEATH KNIGHT"] = "ЛИЦАР СМЕРТІ",
    ["SHAMAN"] = "ШАМАН",
    ["MAGE"] = "МАГ",
    ["WARLOCK"] = "ЧОРНОКНИЖНИК",
    ["MONK"] = "МОНАХ",
    ["DRUID"] = "ДРУЇД",
    ["DEMON HUNTER"] = "МИСЛИВЕЦЬ НА ДЕМОНІВ",
    ["EVOKER"] = "ПРОБУДНИК",
}

local LOOKUP = {}
for en, ua in pairs(SPEC_UA) do
    LOOKUP[en] = ua
    LOOKUP[en:upper()] = ua -- англійський капс шукається надійно
end
for en, ua in pairs(CLASS_UA) do LOOKUP[en] = ua end
for en, ua in pairs(CLASS_UA_UPPER) do LOOKUP[en] = ua end

-- Пам'ятаємо оригінал кожного зміненого напису, щоб клавіша
-- «показати оригінал» працювала і тут (слабкі ключі — без витоків).
local originals = setmetatable({}, { __mode = "k" })

local function TranslateFontString(fs)
    local text = ns.SafeText(fs:GetText()) -- секретні значення -> nil
    -- LOOKUP = класи/спеки; fallback = загальні UI-словники, де лежать НАЗВИ
    -- ГЕРОЙСЬКИХ ДЕРЕВ (HeroSpecLabel: «Rider of the Apocalypse» тощо). Капс на
    -- екрані робить шрифт — у GetText зазвичай нормальний регістр, тож збіг прямий.
    local ua = text and (LOOKUP[text]
        or (ns.uiMisc and ns.uiMisc[text])
        or (ns.uiStrings and ns.uiStrings[text]))
    if ua and ua ~= text and not (ns.HasCyrillic and ns.HasCyrillic(text)) then
        originals[fs] = text
        ns.Remember(fs, text, ua, nil, "classes") -- центральний реєстр для Shift «показати оригінал»
        fs:SetText(ua)
    end
end

local function WalkRegions(frame, depth)
    if ns.IsTooltipFrame(frame) then return  end
    if not frame or depth > 7 then return end
    for _, region in ipairs(ns.Regions(frame)) do
        if region.IsObjectType and region:IsObjectType("FontString") then
            TranslateFontString(region)
        end
    end
    for _, child in ipairs(ns.Children(frame)) do
        WalkRegions(child, depth + 1)
    end
end

-- Повертає англійський текст усім написам, які ми міняли
-- (тільки якщо там досі стоїть наша підміна — інакше не чіпаємо).
local function RestoreOriginals()
    for fs, en in pairs(originals) do
        if fs.GetText and ns.SafeText(fs:GetText()) == LOOKUP[en] then
            fs:SetText(en)
        end
    end
end

local function Refresh(frame)
    if not ns.IsEnabled("classes") then return end
    if ns.ShowOriginal() then
        RestoreOriginals()
    else
        WalkRegions(frame, 1)
    end
end

-- Вікно талантів (Blizzard_PlayerSpells, вантажиться на вимогу). Зміряно через
-- /fstack: три підкадри-вкладки — SpecFrame / TalentsFrame / SpellBookFrame.
-- Переклад керується ПОДІЯМИ і показом вкладок, а не вічним тікером:
--   • показ вікна / перемикання вкладки -> переклад у момент показу;
--   • реальна зміна спеку/талантів -> подія.
-- ЄДИНИЙ виняток — вкладка «Спеціалізація»: назва спеку праворуч міняється при
-- ЖИВОМУ перегляді іншого спеку БЕЗ події (як бабли). Тож короткий поллінг
-- лишаємо ТІЛЬКИ поки показано саме SpecFrame; на інших вкладках його нема.
local function Kick(root)
    root = root or _G.PlayerSpellsFrame
    if not root then return end
    Refresh(root)
    C_Timer.After(0, function() Refresh(root) end)
    C_Timer.After(0.15, function() Refresh(root) end)
end

local specTicker
local function WatchSpecPreview(specFrame)
    specFrame:HookScript("OnShow", function()
        if specTicker then specTicker:Cancel() end
        specTicker = C_Timer.NewTicker(0.3, function()
            if specFrame:IsShown() then
                Refresh(_G.PlayerSpellsFrame)
            else
                specTicker:Cancel(); specTicker = nil
            end
        end)
    end)
    specFrame:HookScript("OnHide", function()
        if specTicker then specTicker:Cancel(); specTicker = nil end
    end)
end

-- КНИГА ЗАКЛЯТЬ (PlayerSpellsFrame.SpellBookFrame). ОДИН прохід EnumerateFrames
-- на кожному оновленні (OnShow + PagedContent OnUpdate) перекладає ДВІ речі:
--   • кнопки заклять (HasValidData=true) — НАЗВУ за spellID (ns.spells ключ=ЧИСЛО);
--   • заголовки груп (HasValidData=false) — frame.Text за текстом (клас/спек у LOOKUP).
-- ЧОМУ разом: коли ми SetText'имо назви, Blizzard перемальовує книгу і скидає
-- заголовки назад в англійську; тож заголовки треба перезастосовувати В ТОМУ Ж
-- колбеку, а не лише при відкритті (інакше вони блимають в англійську). Midnight
-- 12.x: назву перенесено з frame.Name у frame.TextContainer.Name — беремо обидва.
-- Гейти окремі: назви — spells.name; заголовки — classes (як у решті цього файлу).
local function TranslateSpellBookNames()
    local psf = _G.PlayerSpellsFrame
    local paged = psf and psf.SpellBookFrame and psf.SpellBookFrame.PagedSpellsFrame
    if not (paged and paged.EnumerateFrames) then return end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    local doNames = ns.IsEnabled("spells.name")
    local doHeaders = ns.IsEnabled("classes")
    if not (doNames or doHeaders) then return end
    for _, f in paged:EnumerateFrames() do
        if type(f) == "table" and f.HasValidData then
            local ok, valid = pcall(f.HasValidData, f)
            if ok and valid and f.spellBookItemInfo then
                if doNames then
                    local nameFS = (f.TextContainer and f.TextContainer.Name) or f.Name
                    local id = f.spellBookItemInfo.spellID
                    local ua = id and ns.spells and ns.spells[tonumber(id)]
                    local cur = ua and nameFS and ns.SafeText and ns.SafeText(nameFS:GetText())
                    if ua and cur and not (ns.HasCyrillic and ns.HasCyrillic(cur)) and ua ~= cur then
                        if ns.Remember then ns.Remember(nameFS, cur, ua, nil, "spells.name") end
                        nameFS:SetText(ua)
                        if ns.ApplyCyrFont then ns.ApplyCyrFont(nameFS) end
                    end
                end
            elseif ok and not valid and doHeaders and f.Text then
                -- заголовок групи: клас/спек через LOOKUP + загальні UI-словники
                TranslateFontString(f.Text)
            end
        end
    end
end
-- Реєстрація один раз: показ книги + гортання (PagedContentFrame OnUpdate).
local sbnHooked = false
local function SetupSpellBookNames()
    if sbnHooked then return end
    local sbf = _G.PlayerSpellsFrame and _G.PlayerSpellsFrame.SpellBookFrame
    local paged = sbf and sbf.PagedSpellsFrame
    if not paged then return end
    sbnHooked = true
    sbf:HookScript("OnShow", function() C_Timer.After(0, TranslateSpellBookNames) end)
    if paged.RegisterCallback and PagedContentFrameBaseMixin and PagedContentFrameBaseMixin.Event then
        pcall(paged.RegisterCallback, paged, PagedContentFrameBaseMixin.Event.OnUpdate,
              TranslateSpellBookNames)
    end
    TranslateSpellBookNames()
end

local function StartWatching(frame)
    frame:HookScript("OnShow", function() Kick(frame) end)
    ns.Guard("спеціалізації", SetupSpellBookNames)  -- назви заклять у книзі (окремо від заголовків)
    -- Перемикання вкладок: відповідний підкадр показується — перекладаємо тоді.
    for _, key in ipairs({ "SpecFrame", "TalentsFrame", "SpellBookFrame" }) do
        local sub = frame[key]
        if sub and sub.HookScript then
            sub:HookScript("OnShow", function() Kick(frame) end)
            if key == "SpecFrame" then WatchSpecPreview(sub) end
            -- назви заклять: ретрай реєстрації + переклад при показі книги
            if key == "SpellBookFrame" then
                sub:HookScript("OnShow", function()
                    ns.Guard("спеціалізації", SetupSpellBookNames)
                    C_Timer.After(0, TranslateSpellBookNames)
                end)
            end
        end
    end
    if frame:IsShown() then Kick(frame) end
    -- Shift «показати оригінал» — централізовано в Core (ns.ToggleOriginal).
end

-- Реальна зміна спеку/талантів — подієво (без поллінгу).
local sev = CreateFrame("Frame")
sev:RegisterEvent("ACTIVE_PLAYER_SPECIALIZATION_CHANGED")
sev:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
sev:RegisterEvent("TRAIT_CONFIG_UPDATED")
sev:SetScript("OnEvent", function()
    if _G.PlayerSpellsFrame and _G.PlayerSpellsFrame:IsShown() then
        Kick(_G.PlayerSpellsFrame)
    end
end)

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, _, name)
    if name == "Blizzard_PlayerSpells" and PlayerSpellsFrame then
        StartWatching(PlayerSpellsFrame)
    end
end)
-- Якщо вікно вже завантажене на момент логіну (рідко, але буває).
if PlayerSpellsFrame then
    StartWatching(PlayerSpellsFrame)
end

-- ВІКНО ПЕРСОНАЖА (C): рядок "Level 80 Blood Elf Paladin" —
-- перекладаємо по словах (рівень, раса, клас, спек), формат Blizzard
-- не чіпаємо, тож будь-який варіант рядка лишається валідним.
local RACE_DISPLAY_UA = {
    ["Human"] = "людина", ["Dwarf"] = "дворф", ["Night Elf"] = "нічний ельф",
    ["Gnome"] = "гном", ["Draenei"] = "дреней", ["Worgen"] = "ворґен",
    ["Pandaren"] = "пандарен", ["Orc"] = "орк", ["Undead"] = "нежить",
    ["Tauren"] = "таурен", ["Troll"] = "троль", ["Blood Elf"] = "кровний ельф",
    ["Goblin"] = "ґоблін", ["Nightborne"] = "ночеродний",
    ["Highmountain Tauren"] = "таурен Крутогір'я",
    ["Void Elf"] = "ельф Порожнечі",
    ["Lightforged Draenei"] = "світлокутий дреней",
    ["Zandalari Troll"] = "зандаларський троль",
    ["Kul Tiran"] = "кул-тирасець", ["Dark Iron Dwarf"] = "темнозалізний дворф",
    ["Vulpera"] = "вульпера", ["Mag'har Orc"] = "маґхарський орк",
    ["Mechagnome"] = "мехагном", ["Dracthyr"] = "драктир",
    ["Earthen"] = "землянин",
}

local charOriginal -- оригінальний рядок для клавіші «показати оригінал»

local function TranslateCharacterLevel()
    if not CharacterLevelText then return end
    if not ns.IsEnabled("classes") then return end
    local text = ns.SafeText(CharacterLevelText:GetText())
    if not text then return end
    if ns.ShowOriginal() then
        if charOriginal then CharacterLevelText:SetText(charOriginal) end
        return
    end
    if text:find("Рівень", 1, true) then return end -- уже перекладено
    charOriginal = text
    local ua = text:gsub("Level (%d+)", "Рівень %1")
    -- Довші назви першими, щоб "Blood Elf" не став "кровним Elf".
    for en, u in pairs(RACE_DISPLAY_UA) do
        if #en > 9 then ua = ua:gsub(en, u) end
    end
    for en, u in pairs(RACE_DISPLAY_UA) do
        if #en <= 9 then ua = ua:gsub(en, u) end
    end
    for en, u in pairs(SPEC_UA) do
        ua = ua:gsub(en, u)
    end
    for en, u in pairs(CLASS_UA) do
        ua = ua:gsub(en, u:lower())
    end
    CharacterLevelText:SetText(ua)
    ns.Remember(CharacterLevelText, text, ua, nil, "classes") -- центральний реєстр для Shift
end

if type(PaperDollFrame_SetLevel) == "function" then
    hooksecurefunc("PaperDollFrame_SetLevel", function()
        ns.Guard("спеціалізації", TranslateCharacterLevel)
    end)
end
if CharacterFrame then
    CharacterFrame:HookScript("OnShow", function()
        ns.Guard("спеціалізації", TranslateCharacterLevel)
    end)
end

-- Shift «показати оригінал» — централізовано в Core (ns.ToggleOriginal).
