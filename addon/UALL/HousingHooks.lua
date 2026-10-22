-- UALL: система ЖИТЛА (Housing, Midnight) — HousingDashboardFrame і Каталог.
-- Рядки UI Житла — це GlobalStrings (HOUSING_*, HOUSE_EDITOR_*), які ми НЕ
-- перевизначаємо (тейнт). Тож перекладаємо ХУКОМ: обходимо фрейми Житла й
-- підмінюємо видимий текст FontString за збігом у ns.housingUI (ключ = EN-текст).
--
-- Обмеження: перекладаються лише СТАТИЧНІ рядки. Рядки з форматом (%s/%d:
-- "Level %s", "%s's House", лічильники сховища) обхід-за-текстом не ловить —
-- гра підставляє значення в рантаймі; вони лишаються англійськими (борг).
--
-- |n у GlobalStrings — перенос рядка; GetText інколи віддає "|n", інколи "\n",
-- тож пробуємо обидві нормалізації ключа.

local _, ns = ...

local function Gate()
    return ns.IsEnabled("housing") and not (ns.ShowOriginal and ns.ShowOriginal())
end

-- lookup: спершу UI-рядки Житла (ns.housingUI, з нормалізацією |n<->\n), потім
-- назви декору (ns.housing) — вони в каталозі/на превʼю. Обидва гейтяться "housing".
-- ШАБЛОНИ (07.10.2026): рядки з %s/%d («Level %s», «%s's House», «Placed Decor: %d/%d»,
-- «Edit House (%s)») гра складає в рантаймі, тож точний пошук їх не знаходив і вони
-- лишались англійськими. Ключі з форматом у ns.housingUI один раз розбираємо на
-- Lua-шаблони; значення (імена, числа, клавіші) переносимо в укр. рядок за порядком
-- (%1$s — за номером). Промахи теж кешуємо: таймери («Moving out in: …») оновлюються.
local function Escape(str)
    return (str:gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0"))
end

local formats
local function BuildFormats()
    formats = {}
    for en, ua in pairs(ns.housingUI or {}) do
        if type(en) == "string" and type(ua) == "string" and en:find("%%%d*%$?[sd]") then
            local parts, order, pos = { "^" }, {}, 1
            while true do
                local s, e, num = en:find("%%(%d*)%$?[sd]", pos)
                if not s then break end
                parts[#parts + 1] = Escape(en:sub(pos, s - 1)) .. "(.-)"
                order[#order + 1] = tonumber(num) or (#order + 1)
                pos = e + 1
            end
            parts[#parts + 1] = Escape(en:sub(pos)) .. "$"
            formats[#formats + 1] = { pat = table.concat(parts), ua = ua, order = order }
        end
    end
end

local fmtCache, fmtCacheN = {}, 0
local function FormatLookup(text)
    if not formats then BuildFormats() end
    local cached = fmtCache[text]
    if cached ~= nil then return cached or nil end
    local result = false
    for _, f in ipairs(formats) do
        local caps = { text:match(f.pat) }
        if caps[1] ~= nil then
            local vals = {}
            for i, v in ipairs(caps) do vals[f.order[i] or i] = v end
            local k = 0
            result = (f.ua:gsub("%%(%d*)%$?[sd]", function(num)
                k = k + 1
                return vals[tonumber(num) or k] or ""
            end))
            break
        end
    end
    if fmtCacheN > 500 then fmtCache, fmtCacheN = {}, 0 end
    fmtCache[text] = result
    fmtCacheN = fmtCacheN + 1
    return result or nil
end
ns.HousingFormatLookup = FormatLookup   -- для перевірки поза грою

local function Lookup(text)
    if not text then return nil end
    local d = ns.housingUI
    if d then
        local ua = d[text] or d[text:gsub("\n", "|n")] or d[text:gsub("|n", "\n")]
        if ua then return ua end
        ua = FormatLookup(text) or FormatLookup((text:gsub("\n", "|n")))
        if ua then return ua end
    end
    if ns.housing then return ns.housing[text] end
    return nil
end

local function TranslateFS(fs)
    if not (fs and fs.GetText and fs.SetText) then return end
    local text = ns.SafeText and ns.SafeText(fs:GetText())   -- секрет → nil
    if not text or text == "" then return end
    if ns.HasCyrillic and ns.HasCyrillic(text) then return end
    local ua = Lookup(text)
    if not ua or ua == text then return end
    if ns.Remember then ns.Remember(fs, text, ua, nil, "housing") end
    fs:SetText(ua)
    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
end

local function Walk(frame, depth)
    if not frame or depth > 8 then return end
    if ns.IsTooltipFrame and ns.IsTooltipFrame(frame) then return end
    if frame.GetRegions then
        for _, r in ipairs(ns.Regions(frame)) do
            if r.IsObjectType and r:IsObjectType("FontString") then
                TranslateFS(r)
            end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do
            Walk(c, depth + 1)
        end
    end
end

-- Фрейми Житла, які варто обходити (усі можуть з'явитися не одразу).
-- HousingDashboardFrame — панель+каталог; HouseEditorFrame — редактор дому
-- (той самий каталог, але контейнер StoragePanel і власні тултіпи).
local ROOTS = {
    "HousingDashboardFrame",
    "HousingCatalogFrame",
    "HouseEditorFrame",
    "HousingMarketFrame",
    "HousingControlsFrame",   -- плавучий бар керування (декор-режим, без панелі)
}

local function AnyHousingShown()
    for _, n in ipairs(ROOTS) do
        local fr = _G[n]
        if fr and fr.IsShown and fr:IsShown() then return true end
    end
    return false
end

-- Вміст каталогу/сховища populate-иться при перемиканні вкладки/гортанні/кліку.
-- НЕ ТІКЕР (б'ється з рендером Blizzard → миготіння). Чіпляємось ПІСЛЯ оновлень
-- Blizzard через hooksecurefunc. Контейнер: CatalogContent (панель) АБО
-- StoragePanel (редактор дому). Дедуп — per-frame.
local dynHooked = {}
local function HookDynamic(f, name)
    if dynHooked[name] then return end
    local cc = f.CatalogContent or f.StoragePanel
    if not cc then return end
    dynHooked[name] = true
    local function reWalk(sub) return function() if Gate() then Walk(sub or cc, 1) end end end
    local sb = cc.OptionsContainer and cc.OptionsContainer.ScrollBox
    if sb and sb.Update then hooksecurefunc(sb, "Update", reWalk(cc)) end     -- сітка (гортання/фільтр)
    if cc.Categories and cc.Categories.Update then hooksecurefunc(cc.Categories, "Update", reWalk(cc.Categories)) end
    if cc.PreviewFrame and cc.PreviewFrame.HookScript then cc.PreviewFrame:HookScript("OnShow", reWalk(cc.PreviewFrame)) end
    if cc.HookScript then cc:HookScript("OnShow", reWalk(cc)) end             -- показ вкладки
end

local hooked = {}
local function HookRoot(name)
    if hooked[name] then return end
    local f = _G[name]
    if not (f and f.HookScript) then return end
    hooked[name] = true
    -- Заголовок фрейму Blizzard ПЕРЕВСТАНОВЛЮЄ при перемиканні вкладок (різні
    -- FRAMETITLE-глобали, усі = "Housing Dashboard"). Без тікера він застрягав
    -- англійським. Чіпляємось на SetTitle → перекладаємо ПІСЛЯ Blizzard.
    if f.SetTitle then
        hooksecurefunc(f, "SetTitle", function(self)
            if not Gate() then return end
            local tc = self.TitleContainer
            local tfs = (tc and (tc.TitleText or tc.Text)) or self.TitleText
            if tfs then TranslateFS(tfs) else Walk(self, 1) end
        end)
    end
    local function kick()
        if not Gate() then return end
        Walk(f, 1)
        C_Timer.After(0, function() if f:IsShown() then Walk(f, 1); HookDynamic(f, name) end end)
        C_Timer.After(0.15, function() if f:IsShown() then Walk(f, 1) end end)
    end
    f:HookScript("OnShow", kick)
    if f:IsShown() then kick() end
end

-- ПАНЕЛЬ РІВНЯ ДОМУ (07.10.2026, з гри): «Pekelnyj's House» і картки нагород («Room
-- Placement Budget», «Initial Room Collection») гра ставить ПІСЛЯ нашого обходу на OnShow —
-- коли приходять дані дому (HousingUpgradeFrameMixin:OnHouseSelected / SetRewards,
-- Blizzard_HousingDashboardHouseUpgrade.lua). Картки беруться з пулу, тож перекладаємо
-- одразу після SetRewards — ще до відкладеного RewardsFrame:MarkDirty, і розкладка
-- рахується вже під український текст.
local upgradeHooked = false
local function HookUpgradeFrame()
    if upgradeHooked then return end
    local d = _G.HousingDashboardFrame
    local content = d and d.HouseInfoContent and d.HouseInfoContent.ContentFrame
    local upg = content and content.HouseUpgradeFrame
    if type(upg) ~= "table" then return end
    upgradeHooked = true
    if type(upg.OnHouseSelected) == "function" then
        hooksecurefunc(upg, "OnHouseSelected", function(self)
            if Gate() then ns.Guard("житло", Walk, self, 1) end
        end)
    end
    if type(upg.SetRewards) == "function" then
        hooksecurefunc(upg, "SetRewards", function(self)
            if Gate() and self.RewardsFrame then ns.Guard("житло", Walk, self.RewardsFrame, 1) end
        end)
    end
end

local function TryHookAll()
    for _, name in ipairs(ROOTS) do HookRoot(name) end
    HookUpgradeFrame()
end

local ev = CreateFrame("Frame")
ev:RegisterEvent("ADDON_LOADED")
ev:RegisterEvent("PLAYER_ENTERING_WORLD")
ev:SetScript("OnEvent", function(_, event, arg)
    if event == "ADDON_LOADED" and type(arg) == "string" and arg:find("Housing") then
        TryHookAll()
    else
        TryHookAll()
    end
end)
TryHookAll()

-- ТУЛТІП ДЕКОРУ (наведення в каталозі / на предмет). Назва декору лежить у
-- ns.housing, а не в ns.items, тож ItemHooks її не перекладає. Обходимо рядки
-- тултіпа й підміняємо будь-який, що збігається з ns.housing (назва) або
-- ns.housingUI (хром). Гейт "housing". Тултіпи наш загальний обхід НЕ чіпає
-- навмисно (тейнт-безпека), тож для декору — окремий шлях.
local function TranslateTooltipLine(fs)
    if not (fs and fs.GetText and fs.SetText) then return end
    local raw = ns.SafeText and ns.SafeText(fs:GetText())
    if not raw or raw == "" then return end
    if ns.HasCyrillic and ns.HasCyrillic(raw) then return end
    local ua = (ns.housing and ns.housing[raw]) or Lookup(raw)
    local prefix, suffix = "", ""
    if not ua then
        -- запасний: зняти інлайн-кольори (|cFF..|r / |cn..:|r) і спробувати ще,
        -- зберігши обгортку — інакше кольорова назва стала б білою.
        local stripped = raw:gsub("|c........", ""):gsub("|cn[%a_]+:", ""):gsub("|r", "")
        if stripped ~= raw then
            ua = (ns.housing and ns.housing[stripped]) or Lookup(stripped)
            if ua then
                local p = raw:match("^(|c........)") or raw:match("^(|cn[%a_]+:)")
                if p and raw:find("|r", 1, true) then prefix = p; suffix = "|r" end
            end
        end
    end
    if not ua or ua == raw then return end
    -- ЗБЕРЕГТИ vertex-колір (рідкість): SetText/шрифт його скидають у білий.
    local r, g, b = fs:GetTextColor()
    -- НЕ ns.Remember: тултіп-рядки ефемерні (Blizzard перебудовує тултіп щокадру);
    -- Shift обробляється через Gate у TranslateTooltip, а не центральним відкатом.
    fs:SetText(prefix .. ua .. suffix)
    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
    if r then fs:SetTextColor(r, g, b) end
end

local function TranslateTooltip(tt, onlyFirst)
    if not Gate() then return end
    if type(tt) ~= "table" or not (tt.GetName and tt.NumLines) then return end
    -- ЗАБОРОНЕНИЙ ОБ'ЄКТ. У колбек тултіпа прилітає й ЗАХИЩЕНИЙ фрейм, і тоді
    -- будь-який виклик методу на ньому кидає «calling 'GetName' on bad self
    -- (Attempt to access forbidden object from code tainted by an AddOn)» —
    -- тестер зловив це 4 рази за сесію на публічній 0.1.9 (10.10). IsForbidden
    -- питаємо ПЕРШИМ і через pcall, ДО будь-якого іншого доступу, бо на такому
    -- об'єкті кидає навіть він сам [[unit-frame-taint-order]].
    if tt.IsForbidden then
        local ok, forbidden = pcall(tt.IsForbidden, tt)
        if not ok or forbidden then return end
    end
    local okName, name = pcall(tt.GetName, tt)
    if not okName or not name then return end
    local okNum, lines = pcall(tt.NumLines, tt)
    if not okNum or not lines then return end
    local n = onlyFirst and 1 or lines
    for i = 1, n do
        TranslateTooltipLine(_G[name .. "TextLeft" .. i])
    end
end

-- 1) Item-тултіпи (декор має itemID) — назву (рядок 1) за ns.housing.
if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall
   and Enum and Enum.TooltipDataType and Enum.TooltipDataType.Item then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tt)
        TranslateTooltip(tt, true)
    end)
end

-- 2) Кастомний тултіп каталогу (категорії «Різне»/«Акценти», назви). Чіпляємось
--    ПІСЛЯ Blizzard через hooksecurefunc на SetText/Show/AddLine — інакше йде
--    «боротьба»: наш OnShow біжить ДО фінального тексту Blizzard, і англійська
--    перемагає. Тепер наш переклад лягає ОСТАННІМ. Скоуп — лише поки відкрита
--    панель житла; guard від повторного входу.
local ttGuard = false
local function TT_Post(tt)
    if ttGuard then return end
    if not AnyHousingShown() then return end   -- панель АБО редактор дому АБО ринок
    ttGuard = true
    TranslateTooltip(tt, false)
    ttGuard = false
end
if _G.GameTooltip then
    if _G.GameTooltip.SetText then hooksecurefunc(_G.GameTooltip, "SetText", TT_Post) end
    if _G.GameTooltip.AddLine then hooksecurefunc(_G.GameTooltip, "AddLine", TT_Post) end
    if _G.GameTooltip.Show    then hooksecurefunc(_G.GameTooltip, "Show",    TT_Post) end
end

-- Shift «показати оригінал» повертає англійські написи й вертає переклад —
-- централізовано в Core через ns.Remember/ns.ToggleOriginal (див. Core.lua).
