-- WoWUkraine: переклад титульної сторінки професій (книга професій, ProfessionsBookFrame).
-- Тут НЕ окрема база — усе вже є: назви абілок (кнопки) = ЗАКЛЯТТЯ (ns.spells за spellID),
-- назви/заголовки професій = рядки UI (ns.uiStrings, як меню). Display-only → без taint.
--
-- За /fstack кнопки класичні: PrimaryProfession{1,2}SpellButton{Top,Bottom} і
-- SecondaryProfession{1..4}SpellButton{Left,Right}; у кожної .SpellName (FontString) і
-- .spellID. Заголовок професії — у фреймі PrimaryProfessionN/SecondaryProfessionN.professionName.

local _, ns = ...

local function ShowOrig() return ns.ShowOriginal and ns.ShowOriginal() end

-- Назва абілки на кнопці: беремо spellID кнопки → ns.spells (переклади заклять уже є).
local function TranslateSpellButton(btn)
    if type(btn) ~= "table" then return end
    local fs = btn.SpellName
    if not (fs and fs.GetText and fs.SetText) then return end
    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end -- кир. шрифт (узгоджено з рештою)
    local id = btn.spellID or btn.spellId or (btn.GetSpellID and select(1, btn:GetSpellID()))
    local en = ns.SafeText(fs:GetText())
    local ua = (type(id) == "number") and ns.spells and ns.spells[id] or nil
    -- ДІАГНОСТИКА: чому абілка не переклалась (id=nil → не той шлях; ua=nil → нема в базі).
    if ns.GetCaptureDB and en and not ns.HasCyrillic(en) and en ~= "" then
        pcall(function()
            local db = ns.GetCaptureDB(); db.diag = db.diag or {}
            db.diag["prof-btn |" .. en .. "| id=" .. tostring(id) .. " ua=" .. tostring(ua ~= nil)] = true
        end)
    end
    if ua and type(ua) == "string" and ns.IsEnabled("spells.name") and not ShowOrig() then
        if en and en ~= ua then
            if ns.Remember then ns.Remember(fs, en, ua, nil, "spells.name") end
            fs:SetText(ua)
        end
    end
end

-- Заголовок/лейбл UI (назва професії, «Journal» тощо): ns.uiStrings, невідоме — у db.ui.
local function TranslateLabelFS(fs)
    if not (fs and fs.GetText and fs.SetText) then return end
    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end -- кир. шрифт: інакше □ на «і/ї» у декор. заголовках професій
    local en = ns.SafeText(fs:GetText())
    if not en or en == "" or ns.HasCyrillic(en) then return end
    local ua = ns.uiStrings and ns.uiStrings[en]
    if ua then
        if ns.IsEnabled("interface.professions") and not ShowOrig() then
            if ns.Remember then ns.Remember(fs, en, ua, nil, "interface.professions") end
            fs:SetText(ua)
        end
    elseif en:find("%a") and #en < 80 and ns.GetCaptureDB then
        pcall(function()
            local db = ns.GetCaptureDB(); db.ui = db.ui or {}; db.ui[en] = true
        end)
    end
end

-- Перелік кнопок-абілок (класичні глобали зі /fstack).
local BUTTONS = {}
for i = 1, 2 do
    for _, pos in ipairs({ "Top", "Bottom" }) do
        BUTTONS[#BUTTONS + 1] = "PrimaryProfession" .. i .. "SpellButton" .. pos
    end
end
for i = 1, 4 do
    for _, pos in ipairs({ "Left", "Right" }) do
        BUTTONS[#BUTTONS + 1] = "SecondaryProfession" .. i .. "SpellButton" .. pos
    end
end
local HEADERS = { "PrimaryProfession1", "PrimaryProfession2",
                  "SecondaryProfession1", "SecondaryProfession2",
                  "SecondaryProfession3", "SecondaryProfession4" }

-- Загальний обхід FontString-ів сторінки (лейбли, ранг) — після кнопок, тож уже
-- перекладені (кирилиця) написи пропускаються.
local function WalkLabels(frame, depth)
    if not frame or depth > 4 then return end
    if frame.GetRegions then
        for _, r in ipairs(ns.Regions(frame)) do
            if r.IsObjectType and r:IsObjectType("FontString") then TranslateLabelFS(r) end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then WalkLabels(c, depth + 1) end end
    end
end

local function ApplyAll()
    -- 1) спершу абілки (spellID → ns.spells)
    for _, base in ipairs(BUTTONS) do
        local b = _G[base]
        if b then pcall(TranslateSpellButton, b) end
    end
    -- 2) заголовки професій (.professionName) явно
    for _, h in ipairs(HEADERS) do
        local f = _G[h]
        if f and f.professionName then pcall(TranslateLabelFS, f.professionName) end
    end
    -- 3) решта лейблів сторінки
    local pbf = _G.ProfessionsBookFrame
    if pbf then pcall(WalkLabels, pbf, 0) end
end

local hooked = false
local function InstallHooks()
    if hooked then return end
    local pbf = _G.ProfessionsBookFrame
    if not pbf or not pbf.HookScript then return end
    hooked = true
    pbf:HookScript("OnShow", function()
        ApplyAll()
        if C_Timer then C_Timer.After(0, ApplyAll) end -- після того, як Blizzard заповнить
    end)
    -- якщо вже показана на момент гачка
    if pbf.IsShown and pbf:IsShown() then ApplyAll() end
    if ns.Diag then ns.Diag("проф: ProfessionsBookFrame зачеплено") end
end

InstallHooks() -- якщо фрейм уже існує

-- ProfessionsBookFrame — LoadOnDemand (Blizzard_ProfessionsBook), зʼявляється при
-- першому відкритті книги професій. Пробуємо причепитись на вхід і на ADDON_LOADED.
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, _, addon)
    InstallHooks()
end)
