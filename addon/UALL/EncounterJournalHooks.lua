-- WoWUkraine: Путівник пригод / Журнал підземель (Encounter Journal, Shift+J →
-- «Підземелля»/«Рейди»). LoadOnDemand (Blizzard_EncounterJournal).
--
-- Інфо-панель у Midnight — динамічні діти ScrollTarget (не глобально-іменовані),
-- тож перекладаємо ОБХОДОМ (Walk) усіх FontString за показаним текстом. Щоб НЕ
-- блимало англійською — Walk тригеримо СИНХРОННО в точках, де Blizzard оновлює
-- вміст: показ вікна, hooksecurefunc на функції показу енкаунтера/інстансу,
-- OnInitializedFrame ScrollBox. Тікер — лише тонка страховка на рідкісні шляхи.
-- Без override → без taint. Підміна за текстом:
--   назви босів ns.journalEncounterNames, лор ns.journalLore,
--   підземелля ns.journalInstances, UI EJ_UI.

local _, ns = ...

local function Active()
    return not (ns.ShowOriginal and ns.ShowOriginal())
end

local EJ_UI = {
    ["Adventure Guide"] = "Путівник пригод",
    -- НИЖНІ ВКЛАДКИ (гра міняє мітки: коротка↔довга форма → journalSections давав ДОВГІ
    -- «Журнал мандрівника»/«Рекомендований вміст», що обрізались і «фліпали»). EJ_UI має
    -- пріоритет над SectionLookup → усі форми вкладки зводимо до ОДНІЄЇ короткої стабільної.
    ["Journeys"] = "Подорожі",
    ["Traveler's Log"] = "Журнал", ["Journal"] = "Журнал",
    ["Suggested Content"] = "Рекомендоване", ["Suggested"] = "Рекомендоване",
    ["Dungeons"] = "Підземелля", ["Raids"] = "Рейди",
    ["Tutorials"] = "Посібники", ["Guides"] = "Посібники",
    ["Home"] = "Головна", ["Search"] = "Пошук", ["Overview"] = "Огляд",
    ["All Slots"] = "Усі слоти", ["Class Filter:"] = "Фільтр класу:",
    ["Bosses"] = "Боси", ["Loot"] = "Здобич",
    ["Two-Hand"] = "Дворучна", ["One-Hand"] = "Одноручна", ["Main Hand"] = "Основна рука",
    ["Off Hand"] = "Друга рука", ["Ranged"] = "Дальній бій",
    ["Head"] = "Голова", ["Neck"] = "Шия", ["Shoulder"] = "Плечі", ["Back"] = "Назад",
    ["Chest"] = "Груди", ["Wrist"] = "Зап'ястя", ["Hands"] = "Кисті", ["Waist"] = "Пояс",
    ["Legs"] = "Ноги", ["Feet"] = "Стопи", ["Finger"] = "Палець", ["Trinket"] = "Дрібничка",
    ["Plate"] = "Латна", ["Mail"] = "Кольчужна", ["Leather"] = "Шкіряна", ["Cloth"] = "Тканинна",
    ["Mace"] = "Булава", ["Sword"] = "Меч", ["Axe"] = "Сокира", ["Dagger"] = "Кинджал",
    ["Staff"] = "Посох", ["Polearm"] = "Древкова", ["Bow"] = "Лук", ["Gun"] = "Рушниця",
    ["Wand"] = "Чарівна паличка", ["Shield"] = "Щит", ["Fist Weapon"] = "Кулачна зброя",
    ["Warglaive"] = "Бойовий глейв", ["Crossbow"] = "Арбалет",
    -- класи (як у ClassSpecHooks CLASS_UA)
    ["Warrior"] = "Воїн", ["Paladin"] = "Паладин", ["Hunter"] = "Мисливець",
    ["Rogue"] = "Розбійник", ["Priest"] = "Жрець", ["Death Knight"] = "Лицар смерті",
    ["Shaman"] = "Шаман", ["Mage"] = "Маг", ["Warlock"] = "Чорнокнижник",
    ["Monk"] = "Монах", ["Druid"] = "Друїд", ["Demon Hunter"] = "Мисливець на демонів",
    ["Evoker"] = "Пробудник",
}

-- Зняти розмітку показаного тексту до «сирого» вигляду API-секцій: кольори |c|r,
-- лінки |H..|h[видимий]|h -> [видимий], текстури |T|t/|A|a. Так показаний текст
-- огляду/механік збігається з англ. ключем у ns.journalSections.
local function StripLinks(s)
    if not s then return s end
    s = s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|cn[%a_]+:", ""):gsub("|r", "")
    s = s:gsub("|H.-|h(.-)|h", "%1")
    s = s:gsub("|T.-|t", ""):gsub("|A.-|a", "")
    return s
end

-- «Слова» опису: зняти розмітку, $-коди ($s1/$@spellname123/$d/$bullet;), числа,
-- розділові — лишити лише слова в нижньому регістрі. EN-ШАБЛОН ($-коди) і ПОКАЗАНИЙ
-- текст (живі числа) зводяться до ОДНАКОВОЇ послідовності слів → контент-матч описів
-- абілок БЕЗ залежності від фрейм-структури (Midnight прибрав глобальні хедери).
local function WordsKey(s)
    if not s then return "" end
    s = StripLinks(s)
    s = s:gsub("%$bullet;", " "):gsub("%$@?%w*", " ")
    s = s:gsub("[%d]", " "):gsub("[%p]", " ")
    s = s:lower():gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
    return s
end

-- Зворотний індекс EN-шаблонів описів → spellID (будуємо ЛІНИВО, раз). Префікс
-- слів-ключа (стабільна проза на початку, до умовних гілок $?[..]).
local descByWords
local function BuildDescIndex()
    descByWords = {}
    if not ns.spellDescIndex or not ns.descTemplates then return end
    -- СПИСОК кандидатів на префікс (різні спели мають однаковий початок — 1627 колізій).
    -- Дедуп за idx (один шаблон = один рендер), щоб список був короткий.
    for spellID, idx in pairs(ns.spellDescIndex) do
        local t = ns.descTemplates[idx]
        if t and t.en then
            local k = WordsKey(t.en):sub(1, 48)
            if #k >= 16 then
                local lst = descByWords[k]
                if not lst then lst = { seen = {} }; descByWords[k] = lst end
                if not lst.seen[idx] then lst.seen[idx] = true; lst[#lst + 1] = spellID end
            end
        end
    end
end
local function AbilityDescLookup(text)
    if not ns.RenderDescription or not text or #text < 50 then return nil end
    if not descByWords then BuildDescIndex() end
    local k = WordsKey(text):sub(1, 48)
    if #k < 16 then return nil end
    local cands = descByWords[k]
    if not cands then return nil end
    local rtext = text:gsub("\r\n", "\n")
    -- пробуємо кожного кандидата; RenderDescription сам валідує (MatchAndFill) →
    -- правильний шаблон зійдеться, чужий поверне nil. Так колізії префіксів не шкодять.
    for _, spellID in ipairs(cands) do
        local ok, ua = pcall(ns.RenderDescription, spellID, rtext)
        if ok and ua and ua ~= text and ns.HasCyrillic(ua) then return ua end
    end
    return nil
end

-- Згорнути пробіли/переноси/лінки — для матчу лору/опису інстансу, який гра показує
-- з іншими переносами (\n\n замість \r\n\r\n) або розбитим по абзацах окремими FontString.
local function CollapseWS(s)
    s = StripLinks(s)
    s = s:gsub("|n", " "):gsub("[\r\n]+", " "):gsub("%s+", " ")
    return s:gsub("^%s+", ""):gsub("%s+$", "")
end

-- Назви підземель/рейдів підпорядковані опції groupfinder.names — так само, як у
-- шукачі груп (Tier3Hooks/UIHooks) і в тултіпах значків сезону (TrackerHooks).
-- Гейт саме на НАЗВІ інстансу: лор, описи боїв і написи журналу перекладаються
-- далі, ними керують інші опції. Без цього вимикач не діяв на Довідник підземель.
local function InstNamesOn()
    return (not ns.IsEnabled) or ns.IsEnabled("groupfinder.names")
end

local function Lookup(text)
    if not text then return nil end
    local trimmed = text:gsub("^%s+", ""):gsub("%s+$", "")
    local norm = CollapseWS(text)
    -- «Boss: X» / «Class Filter: X» — мітка + назва (бос із journalEncounterNames)
    local bx = text:match("^Boss:%s*(.+)$")
    if bx then return "Бос: " .. ((ns.journalEncounterNames and ns.journalEncounterNames[bx]) or bx) end
    local cf = text:match("^Class Filter:%s*(.+)$")
    if cf then return "Фільтр класу: " .. (EJ_UI[cf] or cf) end
    local inst = nil
    if InstNamesOn() and ns.journalInstances then inst = ns.journalInstances[text] end
    return (ns.journalEncounterNames and ns.journalEncounterNames[text])
        or inst
        or EJ_UI[text]
        or (ns.journalLore and (ns.journalLore[text] or ns.journalLore[trimmed]))
        or (ns.journalLoreNorm and ns.journalLoreNorm[norm])
        or (ns.journalInstanceDesc and (ns.journalInstanceDesc[text] or ns.journalInstanceDesc[trimmed]))
        or (ns.journalInstanceDescNorm and ns.journalInstanceDescNorm[norm])
end

-- ── Рушій секцій (огляд/механіки). Текст у грі відрізняється від API лише
-- ЧИСЛАМИ (API має «0»/інші, гра — реальні) + розмітка ($bullet;/|n/лінки).
-- КАНОН: зняти лінки, $bullet;, переноси, числа→«#» — спільний ключ матчу.
local function Numbers(s)
    local out = {}
    for n in s:gmatch("%d[%d,%.]*") do out[#out + 1] = n end
    return out
end
local function Canon(s)
    s = StripLinks(s)
    s = s:gsub("%$bullet;", "")
    s = s:gsub("|n", " "):gsub("[\r\n]+", " ")
    s = s:gsub("%d[%d,%.]*", "#")
    s = s:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
    return s
end
-- Знайти переклад секції + підставити РЕАЛЬНІ числа з показаного (позиційно) +
-- ВІДНОВИТИ |H-лінки здібностей (обгорнути перекладені [назви] обгортками з
-- оригіналу позиційно — щоб лишались клікабельними посиланнями на спел).
local function SectionLookup(text)
    if not ns.journalSections or not text:find("%a") then return nil end
    local ua = ns.journalSections[Canon(text)]
    if not ua then return nil end
    local disp = Numbers(StripLinks(text))      -- реальні числа з гри (без лінк-ID)
    local uaN = Numbers(ua)                      -- числа в перекладі (з API, напр. «0»)
    if #uaN == #disp and #disp > 0 then
        local i = 0
        ua = ua:gsub("%d[%d,%.]*", function() i = i + 1; return disp[i] end)
    end
    ua = ua:gsub("%$bullet;", ""):gsub("\r", "") -- прибрати буліт-маркер і CR
    -- зібрати |H-лінки оригіналу по порядку: префікс ...|h, [назва], суфікс |h|r
    local wraps = {}
    for pre, suf in text:gmatch("(|c%x%x%x%x%x%x%x%x|H.-|h)%[.-%](|h|?r?)") do
        wraps[#wraps + 1] = { pre = pre, suf = suf }
    end
    if #wraps > 0 then
        local n = 0
        local rebuilt = ua:gsub("%[.-%]", function(br)
            n = n + 1
            local w = wraps[n]
            return w and (w.pre .. br .. w.suf) or br
        end)
        -- застосовуємо лише якщо к-сть дужок збіглася з лінками (інакше плоский текст)
        local _, brc = ua:gsub("%[.-%]", "")
        if brc == #wraps then ua = rebuilt end
    end
    return ua
end

local function TranslateFS(fs)
    if not fs or type(fs.GetText) ~= "function" then return end
    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end -- кир. гліфи (ґ/і/ї/є), без taint
    local text = ns.SafeText(fs:GetText())
    if not text or ns.HasCyrillic(text) then return end -- порожнє/секретне/вже наше
    local ua = Lookup(text) or SectionLookup(text) or AbilityDescLookup(text)
    if ua then
        -- РЕЄСТРУЄМО пару ЗАВЖДИ (навіть під Shift) — інакше вміст, що перемалювався під
        -- УТРИМАНИМ Shift (напр. перемикання карток «Рекомендоване»), не вертається на UA
        -- після відпускання: ns.ToggleOriginal не має пари ([[shift-toggle-needs-displayed-text]]).
        -- SetText — ЛИШЕ коли показуємо переклад (Active); під Shift лишаємо оригінал.
        ns.Remember(fs, text, ua)
        if Active() then
            local r, g, b, a = fs:GetTextColor()
            fs:SetText(ua)
            -- КОЛІР: SetText і так зберігає SetTextColor. ПЕРЕзастосування шкідливе для
            -- ВКЛАДОК (*Tab): у мить перемикання стану колір буває білим → ми його
            -- «замикали» (Рекомендоване ставало білим). Для вкладок лишаємо Blizzard
            -- керувати кольором станів; для решти EJ-тексту — відновлюємо.
            local par = fs.GetParent and fs:GetParent()
            local pn = par and par.GetName and par:GetName()
            if r and not (pn and pn:find("Tab")) then fs:SetTextColor(r, g, b, a) end
        end
    elseif text:find("%a") and ns.GetCaptureDB then
        -- ЗБИРАЧ ПОКРИТТЯ: КОЖЕН показаний журнал-рядок, для якого НЕ знайшлося
        -- перекладу (і дірка в даних, і баг матчу). Ключ=сирий текст (||-екран),
        -- значення=довжина (бачу, чи це ОДИН повний опис чи РОЗБИТІ рядки-шматки).
        -- Браузиш журнал → /reload → читаю db.ejmiss. Кап 400, щоб не роздути файл.
        local db = ns.GetCaptureDB()
        db.ejmiss = db.ejmiss or {}
        db.ejmissN = db.ejmissN or 0
        local key = text:gsub("|", "||")
        if db.ejmiss[key] == nil and db.ejmissN < 400 then
            db.ejmiss[key] = #text
            db.ejmissN = db.ejmissN + 1
        end
    end
end

local function Walk(frame, depth)
    if not frame or depth > 10 then return end
    if frame.GetRegions then
        for _, r in ipairs(ns.Regions(frame)) do
            if r.IsObjectType and r:IsObjectType("FontString") then pcall(TranslateFS, r) end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then Walk(c, depth + 1) end end
    end
end

-- Описи абілок = описи СПЕЛІВ (EncounterJournalInfoHeader<N>.Description). Беремо
-- spellID із секції й застосовуємо ns.RenderDescription — він підставляє числа/
-- назви з ПОКАЗАНОГО англ. тексту в український шаблон (як у тултіпах спелів).
local ejApplying = false
local hookedDesc = setmetatable({}, { __mode = "k" })

-- Переклад ОДНОГО опису-абілки (хедер h + його FontString desc).
local function TranslateOneHeader(h, desc)
    if not (desc and desc.GetText) then return end
    local txt = ns.SafeText(desc:GetText())
    if not (txt and txt:find("%a") and not ns.HasCyrillic(txt)) then return end
    local h2 = h or (desc.GetParent and desc:GetParent())
    local sid = h2 and (h2.sectionID or (h2.button and h2.button.sectionID))
    local spellID = h2 and h2.spellID
    if not spellID and sid and C_EncounterJournal and C_EncounterJournal.GetSectionInfo then
        local ok, info = pcall(C_EncounterJournal.GetSectionInfo, sid)
        spellID = ok and info and info.spellID
    end
    if not spellID and h2 then
        local function scan(f, d)
            if not f or d > 4 or spellID then return end
            if f.GetRegions then
                for _, r in ipairs(ns.Regions(f)) do
                    local t = r.GetText and r:GetText()
                    local id = t and t:match("|Hspell:(%d+)")
                    if id then spellID = tonumber(id); return end
                end
            end
            if f.GetChildren then
                for _, c in ipairs(ns.Children(f)) do if not ns.IsTooltipFrame(c) then scan(c, d + 1) end end
            end
        end
        scan(h2, 0)
    end
    if spellID and spellID > 0 then
        if ns.ApplyCyrFont then ns.ApplyCyrFont(desc) end
        local ok, ua = pcall(ns.RenderDescription, spellID, txt)
        if ok and ua and ua ~= txt and ns.HasCyrillic(ua) then
            ns.Remember(desc, txt, ua)
            ejApplying = true
            pcall(desc.SetText, desc, ua)
            ejApplying = false
        end
    end
end

-- САМОЗЦІЛЕННЯ (як gossip): hooksecurefunc на SetText опису. Щойно EJ ставить англ.
-- при РОЗГОРТАННІ під-секції абілки чи скролі — переклад повертається МИТТЄВО, без
-- Refresh/тікера. HasCyrillic у TranslateOneHeader боронить від рекурсії, ejApplying — дубль.
local function HookDesc(desc)
    if not desc or hookedDesc[desc] or type(desc.SetText) ~= "function" then return end
    hookedDesc[desc] = true
    hooksecurefunc(desc, "SetText", function(self)
        if ejApplying or not Active() or not ns.RenderDescription then return end
        TranslateOneHeader(nil, self)
    end)
end

local function TranslateAbilityDescriptions()
    if not Active() or not ns.RenderDescription then return end
    for i = 1, 40 do  -- БЕЗ break: хедери розріджені / можуть починатись не з 1
        local h = _G["EncounterJournalInfoHeader" .. i]
        local desc = (h and h.Description) or _G["EncounterJournalInfoHeader" .. i .. "Description"]
        if desc and desc.GetText then
            HookDesc(desc)            -- одноразово: далі сам тримає переклад
            TranslateOneHeader(h, desc)
        end
    end
end

-- «Рекомендоване»: ОКРЕМИЙ кошик db.ejsuggest (щоб рядки панелі не тонули в спільному
-- db.ejmiss). ХУК У ТОЧЦІ ДЖЕРЕЛА (НЕ тікер!): ліва картка ротується/гортається ◄►
-- БЕЗ події, тому на КОЖЕН Name-FontString вішаємо hooksecurefunc("SetText") — щойно
-- Blizzard ставить новий текст (поява/гортання), наш хук відразу перекладає або збирає.
-- Walk потрібен ЛИШЕ раз — знайти й зачепити FontString'и; далі самозцілення тримає
-- все без опитування. (Принцип «хук методу, не обхід за таймером».)
local Refresh -- forward (хук OnClick стрілок кличе її після гортання)
local sugHooked = setmetatable({}, { __mode = "k" })
local sugApplying = false
local function SuggestFS(fs)
    if not fs or type(fs.GetText) ~= "function" then return end
    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
    if not Active() then return end
    local text = ns.SafeText(fs:GetText())
    if not text or ns.HasCyrillic(text) then return end
    local ua = Lookup(text) or SectionLookup(text)
    if ua then
        local r, g, b, a = fs:GetTextColor()
        ns.Remember(fs, text, ua)
        sugApplying = true; fs:SetText(ua); sugApplying = false
        if r then fs:SetTextColor(r, g, b, a) end
    elseif text:find("%a") and ns.GetCaptureDB then
        local db = ns.GetCaptureDB()
        db.ejsuggest = db.ejsuggest or {}
        db.ejsuggestN = db.ejsuggestN or 0
        local key = text:gsub("|", "||")
        if db.ejsuggest[key] == nil and db.ejsuggestN < 300 then
            db.ejsuggest[key] = #text
            db.ejsuggestN = db.ejsuggestN + 1
        end
    end
end
-- Зачепити SetText FontString'а (одноразово): самозцілення при ротації/гортанні картки.
local function HookSuggestFS(fs)
    if sugHooked[fs] or type(fs.SetText) ~= "function" then return end
    sugHooked[fs] = true
    hooksecurefunc(fs, "SetText", function(self)
        if sugApplying then return end       -- наш власний SetText — не зациклюватись
        sugApplying = true
        pcall(SuggestFS, self)
        sugApplying = false
    end)
end
-- КНОПКА: лейбл («Join Raid», «Join the Fight!») ставиться через Button:SetText —
-- це ОБХОДИТЬ хук FontString'а, тож чіпляємо SetText самої кнопки (теж точка джерела).
-- Стрілки ◄► гортають картку — на їх OnClick робимо відкладений Refresh (НЕ тікер,
-- разовий After(0) після події), щоб новий суджест зачепився й переклався.
local function TranslateButton(self)
    if not Active() then return end
    local t = ns.SafeText(self:GetText())
    if not t or ns.HasCyrillic(t) then return end
    local ua = Lookup(t) or SectionLookup(t)
    if ua then
        ns.Remember(self, t, ua)
        sugApplying = true; self:SetText(ua); sugApplying = false
    elseif t:find("%a") and ns.GetCaptureDB then
        local db = ns.GetCaptureDB()
        db.ejsuggest = db.ejsuggest or {}
        local key = t:gsub("|", "||")
        if db.ejsuggest[key] == nil and (db.ejsuggestN or 0) < 300 then
            db.ejsuggest[key] = #t; db.ejsuggestN = (db.ejsuggestN or 0) + 1
        end
    end
end
local function HookSuggestButton(btn)
    if sugHooked[btn] or type(btn.SetText) ~= "function" or type(btn.GetText) ~= "function" then return end
    sugHooked[btn] = true
    hooksecurefunc(btn, "SetText", function(self)
        if sugApplying then return end
        sugApplying = true; pcall(TranslateButton, self); sugApplying = false
    end)
    if btn.HookScript then -- стрілки гортання: після кліку перечепити/перекласти новий суджест
        btn:HookScript("OnClick", function() if C_Timer then C_Timer.After(0, function() pcall(Refresh) end) end end)
    end
    pcall(TranslateButton, btn) -- поточний лейбл одразу
end
local function WalkSuggest(frame, depth)
    if not frame or depth > 8 then return end
    if frame.IsObjectType and frame:IsObjectType("Button") then HookSuggestButton(frame) end
    if frame.GetRegions then
        for _, r in ipairs(ns.Regions(frame)) do
            if r.IsObjectType and r:IsObjectType("FontString") then
                HookSuggestFS(r)         -- надалі самозціляється БЕЗ тікера
                pcall(SuggestFS, r)
            end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then WalkSuggest(c, depth + 1) end end
    end
end

function Refresh() -- forward-оголошено вище (local Refresh)
    local ej = _G.EncounterJournal
    if not ej or not ej.IsShown or not ej:IsShown() then return end
    -- СПЕРШУ описи абілок (спел-шаблони через |Hspell-хедер), ТОДІ Walk — щоб
    -- Walk не логував у db.ejmiss те, що цей прохід перекладе (інакше збирач бреше).
    pcall(TranslateAbilityDescriptions)
    pcall(Walk, ej, 0)
    -- прицільно: overview-скрол боса (його FontString-и можуть бути глибше/окремо)
    local ov = _G.EncounterJournalEncounterFrameInfoOverviewScrollFrame
    if ov then pcall(Walk, ov, 0) end
    local info = _G.EncounterJournalEncounterFrameInfo
    if info then pcall(Walk, info, 0) end
    -- «Рекомендоване» (Adventure Guide → Suggested Content): картки-пропозиції
    -- (бонус-івент/Trading Post/Player Housing) + заголовок/кнопка. Динамічні рядки
    -- йдуть у db.ejmiss (збір), статика — у словник журналу. Окремий Walk, бо панель
    -- може бути сиблінгом EncounterJournal або наповнюватись пізніше.
    local sug = _G.EncounterJournalSuggestFrame
    if sug then pcall(WalkSuggest, sug, 0) end -- окремий кошик db.ejsuggest
end

-- ЛУТ: назву предмета беремо за itemID із ns.items, замінюємо ПІДРЯДОК англ.назви
-- (зберігаючи колір рідкості/лінк |Hitem). itemID — поле елемента або з |Hitem-лінка.
local function PlainRepl(s, find, repl)
    find = find:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
    repl = repl:gsub("%%", "%%%%")
    return (s:gsub(find, repl))
end
local function TranslateLootElement(frame)
    if not frame or not Active() then return end
    -- дані лута через GetData()/GetElementData() (loot-info з itemID/link/name).
    local data
    for _, fn in ipairs({ "GetData", "GetElementData" }) do
        if not data and frame[fn] then
            local ok, d = pcall(frame[fn], frame)
            if ok and type(d) == "table" then data = d end
        end
    end
    -- GetData() дає {index=N} — itemID беремо через C_EncounterJournal.GetLootInfoByIndex.
    local itemID, lootName = data and (data.itemID or data.itemId), nil
    local idx = data and (data.index or data.lootIndex)
    if not itemID and idx and C_EncounterJournal and C_EncounterJournal.GetLootInfoByIndex then
        local ok, info = pcall(C_EncounterJournal.GetLootInfoByIndex, idx)
        if ok and info then itemID = info.itemID; lootName = info.name end
    end
    local entry = itemID and ns.items and ns.items[itemID]
    -- entry може бути РЯДКОМ (лише назва) АБО таблицею {name=...,fen,fua} (як в ItemHooks)
    local ua = entry and (type(entry) == "table" and entry.name or entry)
    if type(ua) ~= "string" then ua = nil end
    if not ua then
        if ns.GetCaptureDB then -- ДІАГНОСТИКА: index + що дає GetLootInfoByIndex
            local db = ns.GetCaptureDB()
            db.ejloot = db.ejloot or {}
            if (db.ejlootN or 0) < 6 then
                local li = "—"
                if idx and C_EncounterJournal then
                    for _, fn in ipairs({ "GetLootInfoByIndex", "GetLootInfo" }) do
                        if C_EncounterJournal[fn] then
                            local ok, info = pcall(C_EncounterJournal[fn], idx)
                            li = fn .. "(" .. tostring(idx) .. ")=" ..
                                (ok and (type(info) == "table"
                                    and ("itemID=" .. tostring(info.itemID) .. " name=" .. tostring(info.name))
                                    or tostring(info)) or ("ERR:" .. tostring(info)))
                            break
                        end
                    end
                end
                db.ejloot["d" .. (db.ejlootN or 0)] = ("idx=%s itemID=%s | %s"):format(
                    tostring(idx), tostring(itemID), li)
                db.ejlootN = (db.ejlootN or 0) + 1
            end
        end
        return
    end
    local en = lootName or (C_Item and C_Item.GetItemNameByID
        and C_Item.GetItemNameByID(itemID))
    -- FontString назви: frame.name (з дампа), або обхід.
    local fs = (frame.name and frame.name.GetText) and frame.name
    if fs then
        local raw = ns.SafeText(fs:GetText())
        if raw and not ns.HasCyrillic(raw) then
            if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
            local shown = (en and en ~= "" and raw:find(en, 1, true)) and PlainRepl(raw, en, ua) or ua
            ns.Remember(fs, raw, shown)
            fs:SetText(shown)
        end
    end
end

-- ScrollBox: щойно елемент (бос/лут) ініціалізується — перекладаємо його СИНХРОННО.
-- lootCb=true → ще й TranslateLootElement (назва предмета за itemID).
local function HookScrollBox(sb, lootCb)
    if not sb or type(sb.RegisterCallback) ~= "function" then return end
    local evt = ScrollBoxListViewMixin and ScrollBoxListViewMixin.Event
    if not evt or not evt.OnInitializedFrame then return end
    pcall(function()
        sb:RegisterCallback(evt.OnInitializedFrame, function(_, frame)
            if frame then
                pcall(Walk, frame, 0)
                if lootCb then pcall(TranslateLootElement, frame) end
            end
        end, sb)
    end)
end

local scrollHooked = false
local function HookScrollBoxes()
    if scrollHooked then return end
    local info = _G.EncounterJournalEncounterFrameInfo
    if not info then return end
    HookScrollBox(info.BossesScrollBox)
    if info.LootContainer then HookScrollBox(info.LootContainer.ScrollBox, true) end
    -- опис підземелля (lore) — окремий ScrollBox у InstanceFrame
    local inst = _G.EncounterJournalEncounterFrameInstanceFrame
    if inst and inst.LoreScrollingFont then HookScrollBox(inst.LoreScrollingFont.ScrollBox) end
    scrollHooked = true
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(_, _, name)
    if name ~= "Blizzard_EncounterJournal" then return end
    -- LoadOnDemand: база журналу (ns.journal*) винесена в UALL_Journal — вантажимо
    -- ЇЇ саме тут, коли відкрили Encounter Journal (перед хуками, що читають ns.journal*).
    -- Доти вона не в RAM (журнал відкривають рідко) → економія ~5.5M.
    if C_AddOns and C_AddOns.LoadAddOn and not (ns.journalSections and next(ns.journalSections)) then
        pcall(C_AddOns.LoadAddOn, "UALL_Journal")
    end
    local ej = _G.EncounterJournal
    if not ej then return end
    -- СИНХРОННІ тригери (один раз на оновлення вмісту, БЕЗ тікера/опитування):
    -- хукаємо функції показу — Walk виконується одразу після того, як Blizzard
    -- поставив текст, у тому ж кадрі → без блимання й без боротьби з клієнтом.
    for _, fn in ipairs({
        "EncounterJournal_DisplayEncounter", "EncounterJournal_DisplayInstance",
        "EncounterJournal_LootUpdate", "EncounterJournal_DisplayInstances",
        "EncounterJournal_SetTab", "EncounterJournal_UpdateButtonState",
        "EncounterJournal_UpdateSuggestions", -- панель «Рекомендоване» (картки-пропозиції)
    }) do
        if type(_G[fn]) == "function" then
            hooksecurefunc(fn, function() HookScrollBoxes(); Refresh() end)
        end
    end
    -- Підстраховка: хук показу самої панелі «Рекомендоване» (як OnShow EJ).
    local sug = _G.EncounterJournalSuggestFrame
    if sug and sug.HookScript then sug:HookScript("OnShow", function() Refresh() end) end
    ej:HookScript("OnShow", function() HookScrollBoxes(); Refresh() end)
    HookScrollBoxes()
    if ej:IsShown() then Refresh() end
    if ns.Diag then ns.Diag("EJ: Encounter Journal зачеплено (sync, без тікера)") end
    loader:UnregisterEvent("ADDON_LOADED")
end)
