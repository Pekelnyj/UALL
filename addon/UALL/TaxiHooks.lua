-- UALL: переклад назв точок польоту (TaxiNodes) на мапі польотів.
-- Назви показуються на ТУЛТІПІ при наведенні на пін — тож хукаємо GameTooltip,
-- але ЛИШЕ коли відкрита FlightMapFrame (контекстний гейт), і дивимось ЛИШЕ у
-- ns.taxiNodes [[context-scoped-translation]]. Точний збіг (назви місць).

local _, ns = ...

local function Enabled()
    return (not ns.IsEnabled) or ns.IsEnabled("interface.taxi")
end

local function FlightShown()
    local f = _G.FlightMapFrame
    return f and f.IsShown and f:IsShown()
end

local function TrTip(tt)
    if not (Enabled() and ns.taxiNodes and tt and tt.NumLines) then return end
    if not FlightShown() then return end                 -- КОНТЕКСТ: лише мапа польотів
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    local name = tt.GetName and tt:GetName()
    for i = 1, tt:NumLines() do
        local fs = (name and _G[name .. "TextLeft" .. i])
                or (tt.GetLeftLine and tt:GetLeftLine(i))
        local en = fs and (ns.SafeText and ns.SafeText(fs:GetText()) or fs:GetText())
        if en and en ~= "" and not (ns.HasCyrillic and ns.HasCyrillic(en)) then
            local ua = ns.taxiNodes[en]
            if ua and ua ~= en then
                local r, g, b = fs:GetTextColor()
                if ns.Remember then ns.Remember(fs, en, ua, nil, "interface.taxi") end
                fs:SetText(ua)
                if r then fs:SetTextColor(r, g, b) end
                if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
            end
        end
    end
end

if _G.GameTooltip and _G.GameTooltip.HookScript then
    _G.GameTooltip:HookScript("OnShow", TrTip)
    -- деякі тултіпи доповнюються після OnShow — підстрахуємось ще тіком
    if C_Timer and C_Timer.After then
        _G.GameTooltip:HookScript("OnShow", function(self)
            C_Timer.After(0.02, function() pcall(TrTip, self) end)
        end)
    end
end
