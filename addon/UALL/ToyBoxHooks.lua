-- WoWUkraine: переклад назв ІГРАШОК у Скрині іграшок (Collections → Toys).
-- Іграшки — це предмети, тож назва береться з ns.items[itemID] (LoD-база предметів).
-- Скриня — сітка іконок (ToyBox.iconsFrame.spellButtons); текст лише в тултіпі при
-- наведенні. Тому хукаємо OnEnter кожної кнопки й перекладаємо 1-й рядок GameTooltip.
-- Гейт: interface.menu (як інші UI-хуки колекцій); Shift показує оригінал.
local _, ns = ...

-- Знайти itemID іграшки на кнопці (поле залежить від версії клієнта).
local function ButtonToyID(btn)
    if type(btn) ~= "table" then return nil end
    local id = btn.itemID or btn.toyID
    if not id and btn.GetElementData then
        local ok, ed = pcall(btn.GetElementData, btn)
        if ok and type(ed) == "table" then id = ed.itemID or ed.toyID or ed.itemId end
    end
    return type(id) == "number" and id or nil
end

local function ToyNameUA(itemID)
    local e = ns.items and ns.items[itemID]
    if type(e) == "table" then return e.name end
    return type(e) == "string" and e or nil
end

-- Чи є цей itemID іграшкою (щоб на тултіпах предметів чіпати ЛИШЕ іграшки —
-- решту предметів обслуговує ItemHooks під власними перемикачами items.*).
local function IsToy(id)
    if not (C_ToyBox and C_ToyBox.GetToyInfo and id) then return false end
    local ok, info = pcall(C_ToyBox.GetToyInfo, id)
    return ok and info ~= nil
end

-- ПЕРЕКЛАД ТУЛТІПА ІГРАШКИ. Головний шлях — хук МЕТОДУ GameTooltip:SetToyByItemID
-- (його кличе кнопка Скрині): itemID приходить ПРЯМИМ аргументом, тултіп уже
-- наповнено — надійно (як SetMountBySpellID для маунтів, де data.id у пост-виклику
-- був не тим ID). Пост-виклик типу Item лишаємо як страховку. Гейт — колекційне
-- меню (interface.menu): іграшки перекладаються НЕЗАЛЕЖНО від опцій items.*.
local function TranslateToyTooltip(tt, id, allowShow)
    if tt ~= GameTooltip then return end
    if not ns.IsEnabled or not ns.IsEnabled("interface.toybox") then return end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    if not id then return end
    local entry = ns.items and ns.items[id]
    if not entry then return end
    local ua = type(entry) == "table" and entry.name or (type(entry) == "string" and entry)
    local fen = type(entry) == "table" and entry.fen
    local fua = type(entry) == "table" and entry.fua
    -- ефект «Use:» — шаблон {en, ua}; живі числа підставляє ns.RenderTemplate.
    local eff = ns.toyEffects and ns.toyEffects[id]
    -- рядок 1 = назва
    local fs = _G["GameTooltipTextLeft1"]
    local en = fs and ns.SafeText and ns.SafeText(fs:GetText())
    if ua and en and not (ns.HasCyrillic and ns.HasCyrillic(en)) and ua ~= en then
        if ns.Remember then ns.Remember(fs, en, ua, nil, "interface.toybox") end
        fs:SetText(ua)
    end
    -- рядки 2+ : ефект «Use:» (eff) + флейвор (e.fua) + «як здобути» (ns.toySource)
    local PREF = { ITEM_SPELL_TRIGGER_ONUSE, ITEM_SPELL_TRIGGER_ONEQUIP,
                   ITEM_SPELL_TRIGGER_ONPROC, ITEM_SPELL_TRIGGER_ONLEARN }
    if tt.NumLines then
        for i = 2, tt:NumLines() do
            local lf = _G["GameTooltipTextLeft" .. i]
            local lt = lf and ns.SafeText and ns.SafeText(lf:GetText())
            if lt and not (ns.HasCyrillic and ns.HasCyrillic(lt)) then
                local key = lt:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
                             :gsub("^%s+", ""):gsub("%s+$", "")
                local newt
                -- ефект: відрізаємо префікс Use:/Equip:, рендеримо решту як шаблон,
                -- лишаючи префікс на місці (як TranslateItemEffects для предметів).
                if eff and eff.en and ns.RenderTemplate then
                    local rendered = lt:gsub("\r\n", "\n")
                    local core = rendered
                    for _, p in ipairs(PREF) do
                        if p and core:sub(1, #p) == p then core = core:sub(#p + 1); break end
                    end
                    core = core:gsub("^%s+", "")
                    local head = rendered:sub(1, #rendered - #core)
                    -- відрізати хвіст «(N Min Cooldown)» — у шаблоні його немає, інакше
                    -- MatchAndFill не збігається (тому досі йшли лише іграшки без кулдауна).
                    local tail = ""
                    local body, cd = core:match("^(.-)(%s*%([^()]*[Cc]ooldown[^()]*%))$")
                    if body and cd then core, tail = body, cd end
                    local ueff = ns.RenderTemplate(eff, core)
                    if ueff and ueff ~= core then newt = head .. ueff .. tail end
                end
                if not newt and fen and fua and (key == fen or key == '"' .. fen .. '"') then
                    newt = (key ~= fen) and ('"' .. fua .. '"') or fua
                elseif not newt and ns.toySource and ns.toySource[key] then
                    newt = ns.toySource[key]
                end
                if newt and newt ~= lt then
                    local r, g, b, a = lf:GetTextColor()
                    if ns.Remember then ns.Remember(lf, lt, newt, nil, "interface.toybox") end
                    lf:SetText(newt)
                    if r then lf:SetTextColor(r, g, b, a) end
                end
            end
        end
    end
    -- Show() лише з шляху хука методу (allowShow) — перерахувати розмір під довші
    -- укр. рядки. У пост-виклику Show() спричинив би рекурсію (Show → ProcessLines
    -- → знову пост-виклик), тому там НЕ викликаємо.
    if allowShow and tt.Show then tt:Show() end
end

-- ПІДПИС У СІТЦІ: кожна кнопка іграшки має FontString-назву (btn.name). Її треба
-- перекладати ОКРЕМО від тултіпа — це те, що видно на сторінці Скрині одразу.
local function ButtonLabelFS(btn)
    return btn.name or btn.Name or (btn.GetName and _G[(btn:GetName() or "") .. "Name"]) or nil
end

local function TranslateToyLabel(btn)
    local id = ButtonToyID(btn)
    local fs = ButtonLabelFS(btn)
    if not id or not fs or not fs.GetText then return end
    if not ns.IsEnabled or not ns.IsEnabled("interface.toybox") then return end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    local en = ns.SafeText and ns.SafeText(fs:GetText()) or fs:GetText()
    if not en or en == "" or (ns.HasCyrillic and ns.HasCyrillic(en)) then return end
    local ua = ToyNameUA(id)
    if not ua or ua == "" or ua == en then return end
    if ns.Remember then ns.Remember(fs, en, ua, nil, "interface.toybox") end
    fs:SetText(ua)
    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
end

local hooked = setmetatable({}, { __mode = "k" })

-- ТЕЙНТ: кнопка іграшки — SecureActionButton (type="toy"). hooksecurefunc на МЕТОДІ
-- її підпису (lfs.SetText) підміняє метод на самому віджеті, тож наш код виконується
-- ВСЕРЕДИНІ блізардівської функції оновлення кнопки — а вона там-таки ставить атрибути
-- кнопки. Через це решта тіла тієї функції вважається зіпсованою і гра блокує
-- використання іграшки («blocked from an action only available to the Blizzard UI»).
-- Той самий клас, що SetMatchesSearch на кнопках торб.
-- Тому підписи перекладаємо ЛИШЕ поза блізардівським викликом — своїм обходом.
local function HookToyButtons()
    local tb = _G.ToyBox
    if not (tb and tb.iconsFrame) then return end
    for _, btn in ipairs(ns.Children(tb.iconsFrame)) do
        if type(btn) == "table" then pcall(TranslateToyLabel, btn) end
    end
end

-- Сітка перевикористовує кнопки на прокрутці, а події для цього немає.
-- Тікер на 0.3 с давав видиме блимання: кадр із англійським підписом устигав
-- промалюватись. Тому йдемо ПОКАДРОВО, поки Скриня показана — затримка стає
-- меншою за кадр і оку невидима.
-- Ціна мала: для кожної з ~18 кнопок це GetText + перевірка на кирилицю, і
-- лише коли вікно відкрите. Запис іде тільки тоді, коли підпис англійський.
local driver = CreateFrame("Frame")
driver:Hide()
driver:SetScript("OnUpdate", function(self)
    local tb = _G.ToyBox
    if not (tb and tb.IsVisible and tb:IsVisible()) then self:Hide(); return end
    ns.Prof("скриня іграшок", HookToyButtons)
end)

local function StartSweep()
    driver:Show()
end

-- Скриня вантажиться на вимогу (Blizzard_Collections). Ловимо появу + прокрутку
-- (сітка перевикористовує кнопки, тож перечіпляємо після оновлення).
local function Install()
    local tb = _G.ToyBox
    if not tb then return end
    -- Іграшки беруть назви з ns.items (LoD-база предметів). Вона вантажиться лише за
    -- опцій items.* (typово items.flavor=ON, тож зазвичай уже є). Форсуємо завантаження
    -- на відкриття Скрині, щоб іграшки перекладались навіть із вимкненими предметами.
    if (not ns.items or not next(ns.items)) and C_AddOns and C_AddOns.LoadAddOn then
        pcall(C_AddOns.LoadAddOn, "UALL_Items")
    end
    HookToyButtons()
    -- HookScript на самій панелі безпечний (це не захищена кнопка). А от
    -- hooksecurefunc(tb, "UpdateProgressBar") прибрано: він так само підміняв метод
    -- на об'єкті Скрині, з якого йде оновлення захищених кнопок.
    if tb.iconsFrame and tb.iconsFrame.HookScript and not hooked[tb.iconsFrame] then
        hooked[tb.iconsFrame] = true
        tb.iconsFrame:HookScript("OnShow", function() HookToyButtons(); StartSweep() end)
    end
    if tb.HookScript and not hooked[tb] then
        hooked[tb] = true
        tb:HookScript("OnShow", function() HookToyButtons(); StartSweep() end)
    end
    if tb.IsVisible and tb:IsVisible() then StartSweep() end
end

-- ГОЛОВНИЙ ШЛЯХ: хук методу GameTooltip:SetToyByItemID — кнопка Скрині кличе саме
-- його, itemID приходить прямим аргументом, тултіп уже наповнено. allowShow=true —
-- бо це НЕ пост-виклик, Show() безпечний і потрібен, щоб тултіп підріс під укр. текст.
if GameTooltip and type(GameTooltip.SetToyByItemID) == "function" then
    hooksecurefunc(GameTooltip, "SetToyByItemID", function(self, itemID)
        pcall(TranslateToyTooltip, self, itemID, true)
    end)
end

-- СТРАХОВКА: пост-виклик типу Item. Спрацьовує на ВСІХ предметах, тож всередині
-- гейт IsToy(data.id) — щоб на звичайних предметах не втручатись (то ItemHooks).
-- Якщо SetToyByItemID уже переклав → тут побачимо кирилицю й пропустимо.
if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall
   and Enum and Enum.TooltipDataType and Enum.TooltipDataType.Item then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item,
        function(tt, data)
            local id = data and data.id
            if id and IsToy(id) then pcall(TranslateToyTooltip, tt, id) end
        end)
end

local ev = CreateFrame("Frame")
ev:RegisterEvent("ADDON_LOADED")
ev:SetScript("OnEvent", function(_, _, name)
    if name == "Blizzard_Collections" then Install() end
end)
if _G.ToyBox then Install() end
