-- UALL: переклад бойових улюбленців — описи/джерела (ns.battlePets) та назви/описи
-- здібностей (ns.battlePetAbilities). Показуються в тултіпах Журналу улюбленців і
-- в інтерфейсі бою. КОНТЕКСТНО-ОБМЕЖЕНО: перекладаємо лише коли відкритий Журнал
-- улюбленців АБО йде бій, і лише зі своїх двох словників [[context-scoped-translation]].
-- Точний збіг рядка тултіпа. Розмітку/формули не чіпаємо (вони в самому тексті).

local _, ns = ...

local function Enabled()
    return (not ns.IsEnabled) or ns.IsEnabled("interface.petBattle")
end

-- контекст: журнал улюбленців або активний бій улюбленців
local function PetContext()
    local pj = _G.PetJournal
    if pj and pj.IsShown and pj:IsShown() then return true end
    if _G.PetBattleFrame and _G.PetBattleFrame.IsShown and _G.PetBattleFrame:IsShown() then return true end
    if C_PetBattles and C_PetBattles.IsInBattle and C_PetBattles.IsInBattle() then return true end
    return false
end

local function Lookup(en)
    local ua = (ns.battlePets and ns.battlePets[en])
            or (ns.battlePetAbilities and ns.battlePetAbilities[en])
    if ua and ua ~= en then return ua end
    return nil
end

local function TrFS(fs)
    if not fs or not fs.GetText then return end
    local en = ns.SafeText and ns.SafeText(fs:GetText()) or fs:GetText()
    if not en or en == "" then return end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    if ns.HasCyrillic and ns.HasCyrillic(en) then return end
    local ua = Lookup(en)
    if ua then
        if ns.Remember then ns.Remember(fs, en, ua, nil, "interface.petBattle") end
        fs:SetText(ua)
        if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
    end
end

local function TrTip(tt)
    if not (Enabled() and tt and tt.NumLines and PetContext()) then return end
    local name = tt.GetName and tt:GetName()
    for i = 1, tt:NumLines() do
        local fs = (name and _G[name .. "TextLeft" .. i]) or (tt.GetLeftLine and tt:GetLeftLine(i))
        if fs then pcall(TrFS, fs) end
    end
end

-- Walk вікна (журнал/бій) — підписи здібностей, що не в тултіпі
local function Walk(frame, depth)
    if not frame or depth > 9 or type(frame) ~= "table" or not frame.IsShown or not frame:IsShown() then return end
    if frame.GetRegions then
        for _, rg in ipairs(ns.Regions(frame)) do
            if rg.IsObjectType and rg:IsObjectType("FontString") then pcall(TrFS, rg) end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then Walk(c, depth + 1) end end
    end
end

local ticking = false
local function StartTicker()
    if ticking or not (C_Timer and C_Timer.After) then return end
    ticking = true
    local function tick()
        if not PetContext() then ticking = false; return end
        if Enabled() then
            if _G.PetBattleFrame then pcall(Walk, _G.PetBattleFrame, 1) end
        end
        C_Timer.After(0.3, tick)
    end
    C_Timer.After(0.05, tick)
end

-- тултіпи
for _, tip in ipairs({ _G.GameTooltip, _G.PetBattlePrimaryAbilityTooltip, _G.PetBattlePrimaryUnitTooltip }) do
    if tip and tip.HookScript then
        tip:HookScript("OnShow", function(self)
            if C_Timer and C_Timer.After then
                C_Timer.After(0.02, function() pcall(TrTip, self) end)
            else pcall(TrTip, self) end
        end)
    end
end

local ev = CreateFrame("Frame")
ev:RegisterEvent("PET_BATTLE_OPENING_START")
ev:SetScript("OnEvent", function() StartTicker() end)
