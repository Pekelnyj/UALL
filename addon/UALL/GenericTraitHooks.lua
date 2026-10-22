-- UALL: переклад generic-трейт-дерев (GenericTraitFrame / Blizzard_AutoCommitTraitFrame).
-- Напр. «Loa Blessings» (Zul'Aman, система Дундуна/Рясності). Дані: назви вузлів у
-- ns.uiStrings, описи — у ns.profDesc. Заголовок + статичні написи перекладаємо walk'ом;
-- ТУЛТІПИ вузлів — СИНХРОННО з OnEnter кнопки (тейнт-безпечно, з гейтом widget-set —
-- урок [[tooltip-widget-taint]]: async/widget-тултіпи тейнтять LayoutFrame secret-number).
local _, ns = ...

local function Enabled()
    return (not ns.IsEnabled) or ns.IsEnabled("interface.genericTraits")
end

-- переклад одного FontString через словники трейтів (назви=uiStrings, описи=profDesc)
local function TrFS(fs)
    if not (fs and fs.GetText and fs.SetText) then return end
    local en = ns.SafeText and ns.SafeText(fs:GetText()) or nil
    if not en or en == "" or (ns.HasCyrillic and ns.HasCyrillic(en)) then return end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    local ua = (ns.uiStrings and ns.uiStrings[en]) or (ns.profDesc and ns.profDesc[en])
        or (ns.TraitTemplateTry and ns.TraitTemplateTry(en)) -- шаблони TraitDefinition ($ev1/$en1)
    if ua and ua ~= en then
        if ns.Remember then ns.Remember(fs, en, ua, nil, "interface.genericTraits") end
        fs:SetText(ua)
        if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
    end
end

-- Динамічні службові рядки тултіпа вузла (Rank 10/50 тощо): патерн → шаблон.
local TT_PATTERNS = {
    { "^Rank (%d+)/(%d+)$", "Ранг %s/%s" },
    { "^Next major bonus at Rank (%d+):$", "Наступний великий бонус на ранзі %s:" },
}

-- тултіп вузла: перекласти рядки GameTooltip (назва+опис) у тому ж кадрі (OnEnter).
-- Гейт widget-set — не чіпати widget-тултіпи (інакше тейнт, як у POI).
local function TrNodeTooltip()
    if not Enabled() then return end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    local tt = _G.GameTooltip
    if not (tt and tt.NumLines and tt.IsShown and tt:IsShown()) then return end
    if tt.widgetSetID ~= nil or tt.widgetSet ~= nil then return end
    local name = tt.GetName and tt:GetName()
    for i = 1, tt:NumLines() do
        local fs = (name and _G[name .. "TextLeft" .. i]) or (tt.GetLeftLine and tt:GetLeftLine(i))
        if fs then
            pcall(TrFS, fs)
            -- патерни для динамічних рядків (словник їх не покриє)
            pcall(function()
                local en = ns.SafeText and ns.SafeText(fs:GetText())
                if not en or (ns.HasCyrillic and ns.HasCyrillic(en)) then return end
                for _, p in ipairs(TT_PATTERNS) do
                    local a, b = en:match(p[1])
                    if a then
                        local ua = b and p[2]:format(a, b) or p[2]:format(a)
                        ns.Remember(fs, en, ua, nil, "interface.genericTraits")
                        fs:SetText(ua)
                        if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
                        return
                    end
                end
            end)
        end
    end
end

-- walk дерева: перекласти статичні написи (заголовок) + зачепити OnEnter кнопок-вузлів.
local hookedBtns = setmetatable({}, { __mode = "k" })
local function walk(frame, depth)
    if not frame or depth > 7 or type(frame) ~= "table" then return end
    if frame.GetRegions then
        for _, r in ipairs(ns.Regions(frame)) do
            if r.IsObjectType and r:IsObjectType("FontString") then pcall(TrFS, r) end
        end
    end
    if frame.HookScript and not hookedBtns[frame] and frame.GetObjectType
        and frame:GetObjectType() == "Button" then
        hookedBtns[frame] = true
        pcall(frame.HookScript, frame, "OnEnter", TrNodeTooltip)
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then walk(c, depth + 1) end end
    end
end

-- цілі: GenericTraitFrame (Зул'Аман/Лоа) + сторінка СПЕЦІАЛІЗАЦІЙ професій
-- (ProfessionsFrame.SpecPage — вузли дерева профспеців; назви вже в ns.uiStrings).
local function Targets()
    local t = { _G.GenericTraitFrame }
    local pf = _G.ProfessionsFrame
    if pf and pf.SpecPage then t[#t + 1] = pf.SpecPage end
    return t
end

local function Refresh()
    for _, f in ipairs(Targets()) do
        if f and f.IsShown and f:IsShown() and Enabled() then pcall(walk, f, 0) end
    end
end

local function Install()
    for _, f in ipairs(Targets()) do
        if f and f.HookScript and not f.__uall_trait then
            f.__uall_trait = true
            f:HookScript("OnShow", function()
                if C_Timer and C_Timer.After then
                    for _, d in ipairs({ 0, 0.1, 0.3 }) do C_Timer.After(d, Refresh) end
                else
                    Refresh()
                end
            end)
        end
    end
end
Install()

-- фрейм вантажиться ліниво (Blizzard_SharedTalentUI/AutoCommitTraitFrame) → ретрай на подіях
local ev = CreateFrame("Frame")
ev:RegisterEvent("ADDON_LOADED")
ev:RegisterEvent("PLAYER_LOGIN")
ev:SetScript("OnEvent", function() Install() end)
