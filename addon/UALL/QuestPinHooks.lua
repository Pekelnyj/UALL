-- UALL: переклад тултіпа КВЕСТ-ПІНА на карті (назва + рядки цілей).
--
-- ІСТОРІЯ (чому це так обережно). 2026-07-07 переклад пінів робили через
-- TooltipDataProcessor.AddTooltipPostCall(Quest) → SetText на GameTooltip. Але тим
-- самим типом Quest проходять і AreaPOI-піни, а widget-set їм додає AreaPoiUtil:44
-- ПІСЛЯ нашого пост-виклику. Тому гейт widgetSetID тоді не рятував: наш SetText
-- тейнтив execution, далі TextWithState:35 читав secret textHeight → крах
-- «tainted by UALL». Шлях було вимкнено, а у файлі лишено рецепт правильного:
-- хукати САМЕ пін-міксин, а не глобальний тип, і не чіпати AreaPOI.
--
-- ЩО ЗРОБЛЕНО ТУТ (три запобіжники разом):
--   1. Хук на OnMouseEnter КОНКРЕТНИХ пін-міксинів → тип піна відомий за
--      конструкцією, AreaPOI сюди не потрапляє в принципі.
--   2. Робота ВІДКЛАДЕНА на наступний кадр → ми поза їхнім стеком виконання,
--      тобто те, що тейнтило, більше не відбувається всередині їхнього виклику.
--   3. На момент запису перевіряємо widgetSetID: якщо сет усе ж є — не чіпаємо
--      взагалі. Відкладення робить цю перевірку достовірною (сет уже проставлено).
-- Плюс звірка власника: якщо курсор уже зійшов з піна — мовчимо.
local _, ns = ...

-- Міксини квест-пінів мапи. Беремо ті, що існують у цьому клієнті; AreaPOI-міксинів
-- у списку НЕМА і бути не повинно.
local PIN_MIXINS = { "QuestPinMixin", "StorylineQuestPinMixin", "WorldQuestPinMixin" }

local function TranslatePinTooltip(pin)
    local tt = GameTooltip
    if not (tt and tt.IsShown and tt:IsShown()) then return end
    -- Перемикач «показати оригінал» (Shift/del/опція). БЕЗ цієї перевірки ми
    -- повертали переклад одразу після того, як ToggleOriginal поставив англійську,
    -- і виходило блимання замість перемикання.
    if not ns.IsEnabled("quests.title") then return end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    if tt.GetOwner and tt:GetOwner() ~= pin then return end   -- курсор пішов з піна
    if tt.widgetSetID then return end                          -- віджет-сет — не наш випадок
    if not ns.TranslateTooltipLine then return end
    local changed = false
    for i = 1, tt:NumLines() do
        local fs = _G["GameTooltipTextLeft" .. i]
        local text = ns.SafeText(fs and fs:GetText())
        if text and text ~= "" and not ns.HasCyrillic(text) then
            local ua = ns.TranslateTooltipLine(text)
            if ua and ua ~= text then
                local r, g, b, a = fs:GetTextColor()   -- назва жовта, цілі сірі/білі
                fs:SetText(ua)
                if r then fs:SetTextColor(r, g, b, a) end
                ns.Remember(fs, text, ua, nil, "quests.title")              -- Shift «показати оригінал»
                changed = true
            end
        end
    end
    if changed then tt:Show() end                      -- перерахувати розмір під новий текст
end

-- ПЕРЕКЛАД У ДЖЕРЕЛІ, не тікером. Тултіп піна гра перебудовує повторно, тож разовий
-- (та ще й відкладений на кадр) переклад давав блимання англійською. Замість обходу
-- по таймеру вмикаємо ПРАПОРЕЦЬ на час, поки курсор на квест-піні: за ним загальний
-- SetText/AddLine-хук у TrackerHooks пропускає цей тултіп повз тейнт-бар'єр пінів і
-- перекладає рядок ТАМ, ДЕ ЙОГО СТАВЛЯТЬ — синхронно, без лагу в кадр.
-- Бар'єр лишається для всього іншого (AreaPOI тощо): прапорець ставлять ЛИШЕ
-- квест-пін-міксини, а в самому хуку додатково перевіряється widgetSetID.
local hooked = {}
local function HookPinMixins()
    for _, name in ipairs(PIN_MIXINS) do
        local mx = _G[name]
        if not hooked[name] and type(mx) == "table" and type(mx.OnMouseEnter) == "function" then
            hooked[name] = true
            hooksecurefunc(mx, "OnMouseEnter", function(pin)
                ns.questPinTip = pin       -- «цей тултіп — квест-пін, перекладати можна»
                -- Догляд за рядками, які гра допише вже після OnMouseEnter.
                if C_Timer and C_Timer.After and ns.IsEnabled("quests.title") then
                    C_Timer.After(0, function() pcall(TranslatePinTooltip, pin) end)
                end
            end)
            -- ПРАПОРЕЦЬ НЕ СКИДАЄМО на OnMouseLeave. Клік по піну дає цикл
            -- leave→enter, і поки прапорець порожній, гра встигає перебудувати
            -- тултіп англійською (бар'єр у цю мить зачинений) — звідси був спалах
            -- оригіналу при кліку. Скидання й не потрібне: у гейті стоїть звірка
            -- власника тултіпа, тож на чужі тултіпи виняток не поширюється.
            if ns.Diag then ns.Diag("questpin: хук " .. name .. " ✓") end
        end
    end
end

-- Міксини мапи вантажаться разом із Blizzard_WorldMap (на вимогу), тож чіпляємось
-- і одразу, і після завантаження аддона мапи.
HookPinMixins()
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function() pcall(HookPinMixins) end)
