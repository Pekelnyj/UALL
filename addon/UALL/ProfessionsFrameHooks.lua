-- WoWUkraine: переклад ВІКНА КРАФТУ професій (Blizzard_Professions, ProfessionsFrame).
-- Це СУЧАСНЕ вікно ремесла (НЕ книга професій ProfessionsBookFrame): ліва панель —
-- список рецептів (CraftingPage.RecipeList.ScrollBox), права — деталі (SchematicForm).
--
-- Назви рецептів = вихідні ПРЕДМЕТИ (ns.items за itemID) або спели-рецепти (ns.spells,
-- напр. чари/зілля). Лейбли/кнопки/категорії = рядки UI (ns.uiStrings). Display-only,
-- лише SetText видимих FontString → без taint. ScrollBox перемальовує рядки при
-- прокрутці, тож вішаємо InitializedFrameCallback (перемальовка → ре-переклад).

local _, ns = ...

local function ShowOrig() return ns.ShowOriginal and ns.ShowOriginal() end

-- UA-назва рецепта: спершу за вихідним предметом, тоді за самим спелом-рецептом.
-- itemID вихідного предмета рецепта: спершу GetRecipeOutputItemData (звичайний крафт),
-- тоді GetRecipeSchematic().outputItemID (ЗБИРАЛЬНІ рецепти — трави/руда — де перший
-- API повертає nil, бо «вихід» = вузол збору, а не виготовлений предмет).
local function RecipeOutputItemID(recipeID)
    if not (C_TradeSkillUI and type(recipeID) == "number") then return nil end
    if C_TradeSkillUI.GetRecipeOutputItemData then
        local ok, out = pcall(C_TradeSkillUI.GetRecipeOutputItemData, recipeID)
        if ok and type(out) == "table" and out.itemID then return out.itemID end
    end
    if C_TradeSkillUI.GetRecipeSchematic then
        local ok, sch = pcall(C_TradeSkillUI.GetRecipeSchematic, recipeID, false)
        if ok and type(sch) == "table" and sch.outputItemID then return sch.outputItemID end
    end
    return nil
end

local function RecipeUA(recipeID)
    if type(recipeID) ~= "number" then return nil end
    local itemID = RecipeOutputItemID(recipeID)
    if itemID and ns.items then
        local e = ns.items[itemID]
        local ua = (type(e) == "table" and e.name) or (type(e) == "string" and e) or nil
        if ua then return ua, "items.name" end
    end
    local s = ns.spells and ns.spells[recipeID]
    if type(s) == "string" then return s, "spells.name" end
    return nil
end

-- Гра часто додає до назви хвостову іконку якості «… |A:Professions-Icon-Quality-…|a».
-- Для звірки/кешу порівнюємо ТІЛО без неї; хвіст повертаємо після перекладу.
local function SplitQualityTrail(s)
    if not s then return nil, "" end
    local body, trail = s:match("^(.-)(%s*|A.-|a%s*)$")
    if body then return body, trail end
    return s, ""
end

-- КЕШ назв рецептів EN(тіло)→UA, наповнюється з лівого списку (TranslateRecipeRow).
-- Використовується для перекладу НАЗВИ в шапці панелі деталей БЕЗ залежності від
-- внутрішніх полів SchematicForm: у шапці показано ту саму назву, що у вибраному рядку.
local recipeNameMap = {}

-- recipeID рядка списку (дані ScrollBox-вузла).
local function RowRecipeID(frame, elementData)
    if type(frame) == "table" and type(frame.recipeInfo) == "table" and frame.recipeInfo.recipeID then
        return frame.recipeInfo.recipeID
    end
    local data = elementData
    if type(elementData) == "table" and elementData.GetData then
        local ok, d = pcall(elementData.GetData, elementData)
        if ok then data = d end
    end
    if type(data) == "table" then
        local ri = data.recipeInfo or (type(data.data) == "table" and data.data.recipeInfo)
        if type(ri) == "table" and ri.recipeID then return ri.recipeID end
    end
    return nil
end

-- Напис-назва в рядку рецепта (модерн: .Label; запасний перебір регіонів).
local function RowNameFS(frame)
    if type(frame) ~= "table" then return nil end
    if frame.Label and frame.Label.GetText then return frame.Label end
    if frame.Text and frame.Text.GetText then return frame.Text end
    if frame.GetRegions then
        for _, r in ipairs(ns.Regions(frame)) do
            if r.IsObjectType and r:IsObjectType("FontString") and r.GetText then return r end
        end
    end
    return nil
end

-- ── ГРАБЕР: точний дамп структури рядка рецепта (recipeID, ключі вузла, вихідний
-- предмет, наявність перекладу) у db.profdebug — щоб не гадати, а бачити факти.
local function tkeys(t)
    if type(t) ~= "table" then return tostring(t) end
    local ks = {}
    for k, v in pairs(t) do
        local tv = type(v)
        if tv == "string" or tv == "number" or tv == "boolean" then
            ks[#ks + 1] = tostring(k) .. "=" .. tostring(v)
        else
            ks[#ks + 1] = tostring(k) .. ":" .. tv
        end
    end
    table.sort(ks)
    local s = table.concat(ks, ", ")
    return #s > 400 and s:sub(1, 400) or s
end

local function CaptureRecipeDebug(self, node)
    if not ns.GetCaptureDB then return end
    local fs = RowNameFS(self)
    local en = fs and ns.SafeText(fs:GetText())
    if not en or en == "" or (ns.HasCyrillic and ns.HasCyrillic(en)) then return end
    -- дані вузла
    local data
    if type(node) == "table" and node.GetData then
        local ok, d = pcall(node.GetData, node); if ok then data = d end
    end
    data = data or node
    local ri = type(data) == "table" and (data.recipeInfo or (type(data.data) == "table" and data.data.recipeInfo)) or nil
    local recipeID = (type(ri) == "table" and ri.recipeID) or (type(self) == "table" and self.recipeID) or nil
    -- вихідний предмет (з обома шляхами: крафт + схема для збиральних)
    local outID = recipeID and RecipeOutputItemID(recipeID) or nil
    local itemUA = outID and ns.items and ns.items[outID] and true or false
    local spellUA = recipeID and ns.spells and (type(ns.spells[recipeID]) == "string") or false
    local line = ("recipeID=%s | outItemID=%s | items[out]=%s | spells[rid]=%s | dataKeys={%s} | recipeInfo={%s}"):format(
        tostring(recipeID), tostring(outID), itemUA and "ТАК" or "ні", spellUA and "ТАК" or "ні",
        type(data) == "table" and tkeys(data) or "nil",
        type(ri) == "table" and tkeys(ri) or "nil")
    pcall(function()
        local db = ns.GetCaptureDB(); db.profdebug = db.profdebug or {}; db.profdebug[en] = line
    end)
end

-- Разовий лог: які саме мікс-глобали книги рецептів існують (раптом назву вгадано не так).
local loggedMixins = false
local function LogMixinCandidates()
    if loggedMixins or not ns.GetCaptureDB then return end
    if not _G.ProfessionsFrame then return end -- чекаємо, поки Blizzard_Professions завантажиться
    loggedMixins = true
    local cands = {
        "ProfessionsRecipeListRecipeMixin", "ProfessionsRecipeListMixin",
        "ProfessionsRecipeListElementMixin", "ProfessionsTableConstants",
        "ProfessionsRecipeSchematicFormMixin",
    }
    pcall(function()
        local db = ns.GetCaptureDB(); db.diag = db.diag or {}
        for _, n in ipairs(cands) do
            local g = _G[n]
            local info = type(g)
            if type(g) == "table" then info = info .. " Init=" .. type(g.Init) end
            db.diag["mixin " .. n .. "=" .. info] = true
        end
    end)
end

-- Наша кирилична назва довша за коротку англ. → FontString обрізає її через "…"
-- (ширина FontString розрахована під коротку англ. назву, хоч праворуч у рядку Є місце).
-- Знімаємо обмеження: ширину виставляємо під ПОВНУ довжину тексту
-- (GetUnboundedStringWidth = скільки треба БЕЗ обрізання). Один рядок (word-wrap off).
local function Unclamp(fs)
    if not fs then return end
    -- Списки рецептів і замовлень — це ScrollBox. Зміна ширини напису
    -- всередині нього з незахищеного коду тейнтить рахунок прокрутки, і
    -- Blizzard падає на порівнянні secret-числа в MathUtil
    -- [[bagsearch-setmatches-taint]]. Поза списками — розширюємо як і раніше.
    if ns.InScrollBox and ns.InScrollBox(fs) then return end
    if fs.SetWordWrap then pcall(fs.SetWordWrap, fs, false) end
    if fs.GetUnboundedStringWidth and fs.SetWidth then
        local w = fs:GetUnboundedStringWidth()
        if w and w > 0 then pcall(fs.SetWidth, fs, math.ceil(w) + 2) end
    end
end

-- Лейбли/кнопки/категорії через ns.uiStrings; невідоме (короткі) — у db.profui.
-- SELF-HEAL: панель деталей (SchematicForm.Details.StatLines: «Gathering Details»,
-- «Skill:», «Finesse»…) перемальовується при виборі рецепта — Blizzard ставить EN
-- ПІСЛЯ нашого перекладу (гонка) → лишалось англ., а Shift-відпускання «проявляло»
-- запам'ятований UA (інверсія). Вішаємо hooksecurefunc SetText на ПЕРЕКЛАДНІ лейбли:
-- будь-яка перепідстановка Blizzard одразу перекладається. Рекурсії нема — наш UA
-- кириличний, TranslateLabelFS на ньому достроково виходить.
local hookedLabelFS = setmetatable({}, { __mode = "k" })
local hookLabelFS   -- forward
local function TranslateLabelFS(fs)
    if not (fs and fs.GetText and fs.SetText) then return end
    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
    local en = ns.SafeText(fs:GetText())
    if not en or en == "" or ns.HasCyrillic(en) then return end
    local ua = ns.uiStrings and ns.uiStrings[en]
    if ua then
        if hookLabelFS then hookLabelFS(fs) end   -- self-heal проти гонки перемальовки
        if ns.IsEnabled("interface.professions") and not ShowOrig() then
            if ns.Remember then ns.Remember(fs, en, ua, nil, "interface.professions") end
            fs:SetText(ua)
            Unclamp(fs)
        end
    elseif en:find("%a") and #en < 60 and ns.GetCaptureDB then
        pcall(function()
            local db = ns.GetCaptureDB(); db.profui = db.profui or {}; db.profui[en] = true
        end)
    end
end
function hookLabelFS(fs)
    if hookedLabelFS[fs] or type(fs) ~= "table" or type(fs.SetText) ~= "function" then return end
    hookedLabelFS[fs] = true
    hooksecurefunc(fs, "SetText", function(self) pcall(TranslateLabelFS, self) end)
    if type(fs.SetFormattedText) == "function" then
        hooksecurefunc(fs, "SetFormattedText", function(self) pcall(TranslateLabelFS, self) end)
    end
end

-- Переклад рядка рецепта (за recipeID → ns.items/ns.spells).
local function TranslateRecipeRow(frame, elementData)
    local fs = RowNameFS(frame)
    if not fs then return end
    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
    local id = RowRecipeID(frame, elementData)
    local en = ns.SafeText(fs:GetText())
    local ua, gate = nil, nil
    if id then ua, gate = RecipeUA(id) end
    if ns.GetCaptureDB and en and not ns.HasCyrillic(en) and en ~= "" then
        pcall(function()
            local db = ns.GetCaptureDB(); db.diag = db.diag or {}
            db.diag["recipe |" .. en .. "| id=" .. tostring(id) .. " ua=" .. tostring(ua ~= nil)] = true
        end)
    end
    if ua and gate then
        -- кеш для шапки деталей (навіть якщо зараз показуємо оригінал)
        local body = SplitQualityTrail(en)
        if body and body ~= "" and not ns.HasCyrillic(body) then recipeNameMap[body] = ua end
    end
    if ua and gate and ns.IsEnabled(gate) and not ShowOrig() then
        if en and en ~= ua then
            if ns.Remember then ns.Remember(fs, en, ua, nil, "interface.professions") end
            fs:SetText(ua)
            Unclamp(fs) -- довша кир. назва: зняти "…"-обрізання, використати наявне місце
        end
    elseif not ua then
        TranslateLabelFS(fs) -- категорія/заголовок (не рецепт) → як лейбл
    end
end

-- Загальний обхід лейблів вікна (кнопки, заголовки SchematicForm). Рядки рецептів
-- уже перекладені callback'ом (кирилиця) → пропускаються.
local function WalkLabels(frame, depth)
    if not frame or depth > 5 then return end
    if frame.GetRegions then
        for _, r in ipairs(ns.Regions(frame)) do
            if r.IsObjectType and r:IsObjectType("FontString") then pcall(TranslateLabelFS, r) end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then WalkLabels(c, depth + 1) end end
    end
end

-- ScrollBox списку рецептів: ре-переклад кожного рядка при ініціалізації/перемальовці.
local function HookRecipeList()
    local cp = _G.ProfessionsFrame and _G.ProfessionsFrame.CraftingPage
    local sb = cp and cp.RecipeList and cp.RecipeList.ScrollBox
    if not sb or sb.__ua then return end
    if not (ScrollUtil and ScrollUtil.AddInitializedFrameCallback) then return end
    sb.__ua = true
    ScrollUtil.AddInitializedFrameCallback(sb, function(frame, elementData)
        pcall(CaptureRecipeDebug, frame, elementData)
        pcall(TranslateRecipeRow, frame, elementData)
    end, sb)
    -- перекласти вже показані рядки одразу
    if sb.ForEachFrame then
        pcall(sb.ForEachFrame, sb, function(frame)
            local ed = frame.GetElementData and frame:GetElementData()
            pcall(CaptureRecipeDebug, frame, ed)
            pcall(TranslateRecipeRow, frame, ed)
        end)
    end
    if ns.Diag then ns.Diag("крафт: RecipeList ScrollBox зачеплено") end
end

-- НАЙНАДІЙНІШЕ: хук на сам міксин рядка — точка, де Blizzard ставить назву рецепта,
-- спрацьовує на КОЖЕН рядок при ініціалізації/перевикористанні (надійніше за ScrollUtil).
local mixinHooked = false
local function HookRowMixin()
    local M = _G.ProfessionsRecipeListRecipeMixin
    if mixinHooked or type(M) ~= "table" or type(M.Init) ~= "function" then return end
    mixinHooked = true
    hooksecurefunc(M, "Init", function(self, node)
        pcall(CaptureRecipeDebug, self, node)
        pcall(TranslateRecipeRow, self, node)
    end)
    if ns.Diag then ns.Diag("крафт: ProfessionsRecipeListRecipeMixin:Init зачеплено") end
end

-- ── ОПИС РЕЦЕПТА (флейвор) у SchematicForm. Це опис СПЕЛА (wago Spell.csv, склеєний
-- з $@spelldesc-посилань). Без чисел/формул → перекладаємо ТОЧНИМ збігом показаного
-- тексту через ns.profDesc; невідоме (довге) — у db.profdesc на переклад.
ns.profDesc = ns.profDesc or {}

-- SELF-HEAL і для ОПИСУ: два однакових вікна зразків давали різний результат
-- (Dazzling Thorium — UA, Septarian Nodule — EN) — класична гонка: Blizzard
-- перемальовує опис ПІСЛЯ нашого перекладу. Вішаємо hooksecurefunc SetText на
-- перекладні опис-FS → будь-яка перепідстановка одразу перекладається.
local hookedDescFS = setmetatable({}, { __mode = "k" })
local hookDescFS   -- forward
-- ЗНАННЯ-ЗРАЗКИ (Appendix: Knowledge): опис має хвіст «You may discover N more
-- sample(s) this week.», де N ЗМІННЕ. У profDesc ключ І переклад мають число ЗАШИТЕ
-- (як захопилось, напр. 2) → на іншому N точний збіг падає. Нормалізуємо число до «#»
-- для збігу, кеш нормалізованих ключів будуємо раз (discNormMap).
local function normDiscNum(s) return (s:gsub("(discover )%d+( more sample)", "%1#%2")) end
local discNormMap
local function TranslateDescFS(fs)
    if not (fs and fs.GetText and fs.SetText) then return end
    local en = ns.SafeText(fs:GetText())
    if not en or #en < 40 or ns.HasCyrillic(en) then return end -- лише довгі описи, не лейбли
    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
    local key = en:gsub("\r", "")
    local ua = ns.profDesc[key]
    if not ua then
        local liveN = key:match("discover (%d+) more sample%(s%) this week")
        if liveN then
            if not discNormMap then
                discNormMap = {}
                for pk, pv in pairs(ns.profDesc) do
                    if pk:find("more sample%(s%) this week") then discNormMap[normDiscNum(pk)] = pv end
                end
            end
            local pv = discNormMap[normDiscNum(key)]
            -- підставити ЖИВЕ число замість зашитого в UA («ще N зразок(ків)»)
            if pv then ua = (pv:gsub("(ще )%d+( зразок)", "%1" .. liveN .. "%2")) end
        end
    end
    -- ФОЛБЕК для СКЛЕЄНИХ описів варіантів (база+суфікс якості). Гранулярність різна:
    -- базовий $@spelldesc може бути з кількох абзаців (у profDesc — один ключ), суфікс —
    -- окремий. ЖАДІБНИЙ збіг (ns.ProfDescCompose): найдовший підряд абзаців, що Є ключем.
    if not ua and key:find("\n\n") and ns.ProfDescCompose then
        ua = ns.ProfDescCompose(key)
    end
    if ua then
        if hookDescFS then hookDescFS(fs) end   -- self-heal проти гонки перемальовки
        if not ShowOrig() then
            if ns.Remember then ns.Remember(fs, en, ua, nil, "interface.professions") end
            fs:SetText(ua)
        end
    elseif ns.GetCaptureDB then
        pcall(function()
            local db = ns.GetCaptureDB(); db.profdesc = db.profdesc or {}; db.profdesc[key] = true
        end)
    end
end
function hookDescFS(fs)
    if hookedDescFS[fs] or type(fs) ~= "table" or type(fs.SetText) ~= "function" then return end
    hookedDescFS[fs] = true
    hooksecurefunc(fs, "SetText", function(self) pcall(TranslateDescFS, self) end)
end

-- ── НАЗВА рецепта в ШАПЦІ панелі деталей (жовтий заголовок SchematicForm). У лівому
-- списку назва перекладена (RecipeUA), а в шапці лишалась англ. — окремий FS, який
-- обхід лейблів не чіпав (то не uiStrings, а назва предмета/спела). Дістаємо recipeID
-- з форми, беремо EN-назву в гри й міняємо будь-який FS у формі, чий текст = EN-назві
-- (name-agnostic: не залежимо від точного поля). Self-heal проти гонки перемальовки.
local hookedNameFS = setmetatable({}, { __mode = "k" })
local function FormRecipeID(form)
    if type(form) ~= "table" then return nil end
    local ri = form.currentRecipeInfo
    if type(ri) == "table" and ri.recipeID then return ri.recipeID end
    if type(form.recipeInfo) == "table" and form.recipeInfo.recipeID then return form.recipeInfo.recipeID end
    if type(form.transaction) == "table" and form.transaction.GetRecipeID then
        local ok, id = pcall(form.transaction.GetRecipeID, form.transaction)
        if ok and type(id) == "number" then return id end
    end
    if type(form.recipeSchematic) == "table" and form.recipeSchematic.recipeID then
        return form.recipeSchematic.recipeID
    end
    if type(form.GetRecipeID) == "function" then
        local ok, id = pcall(form.GetRecipeID, form)
        if ok and type(id) == "number" then return id end
    end
    -- запасне: поточний рецепт відкритої CraftingPage
    local cp = _G.ProfessionsFrame and _G.ProfessionsFrame.CraftingPage
    if cp and type(cp.GetCurrentRecipeID) == "function" then
        local ok, id = pcall(cp.GetCurrentRecipeID, cp)
        if ok and type(id) == "number" then return id end
    end
    return nil
end
local function RecipeENName(recipeID)
    if not (C_TradeSkillUI and type(recipeID) == "number") then return nil end
    if C_TradeSkillUI.GetRecipeInfo then
        local ok, info = pcall(C_TradeSkillUI.GetRecipeInfo, recipeID)
        if ok and type(info) == "table" and info.name and info.name ~= "" then return info.name end
    end
    if C_TradeSkillUI.GetRecipeSchematic then
        local ok, sch = pcall(C_TradeSkillUI.GetRecipeSchematic, recipeID, false)
        if ok and type(sch) == "table" and sch.name and sch.name ~= "" then return sch.name end
    end
    return nil
end
local function HandleSchematicName(form)
    if type(form) ~= "table" then return end
    -- 1) якщо є recipeID — долити пару в кеш (на випадок, що рядок ще не намальовано)
    local recipeID = FormRecipeID(form)
    if recipeID then
        local ua = RecipeUA(recipeID)
        local en = recipeID and RecipeENName(recipeID)
        if ua and ua ~= "" and en and not ns.HasCyrillic(en) then
            local body = SplitQualityTrail(en)
            if body and body ~= "" then recipeNameMap[body] = ua end
        end
    end
    -- 2) переклад назви в шапці за КЕШЕМ (EN-тіло → UA), незалежно від полів форми
    local function fix(fs)
        if not (fs and fs.GetText and fs.SetText) then return end
        local cur = ns.SafeText(fs:GetText())
        if not cur or cur == "" or ns.HasCyrillic(cur) then return end
        local body, trail = SplitQualityTrail(cur)
        local ua = body and recipeNameMap[body]
        if not ua then return end
        if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
        local newText = ua .. (trail or "")
        -- self-heal: Blizzard перемальовує шапку при виборі → одразу ре-переклад
        if not hookedNameFS[fs] then
            hookedNameFS[fs] = true
            hooksecurefunc(fs, "SetText", function(self)
                if not ns.HasCyrillic(ns.SafeText(self:GetText()) or "") then pcall(HandleSchematicName, form) end
            end)
        end
        if not ShowOrig() then
            if ns.Remember then ns.Remember(fs, cur, newText, nil, "interface.professions") end
            fs:SetText(newText)
        end
    end
    local function walk(fr, d)
        if not fr or d > 3 then return end
        if fr.GetRegions then
            for _, r in ipairs(ns.Regions(fr)) do
                if r.IsObjectType and r:IsObjectType("FontString") then pcall(fix, r) end
            end
        end
        if fr.GetChildren then for _, c in ipairs(ns.Children(fr)) do if not ns.IsTooltipFrame(c) then walk(c, d + 1) end end end
    end
    walk(form, 0)
end

local function HandleSchematicDesc(form)
    if type(form) ~= "table" then return end
    if form.Description and form.Description.GetText then pcall(TranslateDescFS, form.Description) end
    -- перебір (опис може бути у скрол-фонті з іншим іменем); гейт за довжиною всередині
    local function walk(fr, d)
        if not fr or d > 3 then return end
        if fr.GetRegions then
            for _, r in ipairs(ns.Regions(fr)) do
                if r.IsObjectType and r:IsObjectType("FontString") then pcall(TranslateDescFS, r) end
            end
        end
        if fr.GetChildren then for _, c in ipairs(ns.Children(fr)) do if not ns.IsTooltipFrame(c) then walk(c, d + 1) end end end
    end
    walk(form, 0)
end

-- ── РЕАГЕНТИ у SchematicForm. Суто ID: гра дає реагенти рецепта через
-- GetRecipeSchematic().reagentSlotSchematics[i].reagents[j].itemID → ns.items[itemID].
-- Будуємо map лише З РЕАГЕНТІВ ЦЬОГО рецепта (EN-назва→UA) і міняємо назви в формі
-- (з опційним лічильником-префіксом «0/5 »). Map специфічний → без колізій зі словами.
local function HandleSchematicReagents(form)
    if type(form) ~= "table" or not (C_TradeSkillUI and C_TradeSkillUI.GetRecipeSchematic) then return end
    local recipeID = FormRecipeID(form)
    if not recipeID then return end
    local ok, sch = pcall(C_TradeSkillUI.GetRecipeSchematic, recipeID, false)
    if not ok or type(sch) ~= "table" or type(sch.reagentSlotSchematics) ~= "table" then return end
    local map, any = {}, false
    for _, slot in ipairs(sch.reagentSlotSchematics) do
        if type(slot.reagents) == "table" then
            for _, rg in ipairs(slot.reagents) do
                local iid = rg.itemID
                local e = iid and ns.items and ns.items[iid]
                local ua = (type(e) == "table" and e.name) or (type(e) == "string" and e) or nil
                local en = iid and C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(iid)
                if ua and en and en ~= "" and not ns.HasCyrillic(en) then
                    map[en] = ua; any = true
                elseif iid and C_Item and C_Item.RequestLoadItemDataByID then
                    pcall(C_Item.RequestLoadItemDataByID, iid) -- EN-назва ще не в кеші → підвантажити
                end
            end
        end
    end
    if not any then return end
    local function fix(fs)
        if not (fs and fs.GetText and fs.SetText) then return end
        local cur = ns.SafeText(fs:GetText())
        if not cur or cur == "" or ns.HasCyrillic(cur) then return end
        local pre, nm = cur:match("^(%s*%d+%s*/%s*%d+%s*)(.+)$") -- «0/5 Name» → зберегти лічильник
        local ua = map[nm or cur]
        if not ua then return end
        if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
        local newText = (pre or "") .. ua
        if not ShowOrig() then
            if ns.Remember then ns.Remember(fs, cur, newText, nil, "interface.professions") end
            fs:SetText(newText)
        end
    end
    local function walk(fr, d)
        if not fr or d > 4 then return end
        if fr.GetRegions then
            for _, r in ipairs(ns.Regions(fr)) do
                if r.IsObjectType and r:IsObjectType("FontString") then pcall(fix, r) end
            end
        end
        if fr.GetChildren then for _, c in ipairs(ns.Children(fr)) do if not ns.IsTooltipFrame(c) then walk(c, d + 1) end end end
    end
    walk(form, 0)
end

local schemHooked = false
local function HookSchematic()
    local M = _G.ProfessionsRecipeSchematicFormMixin
    if schemHooked or type(M) ~= "table" or type(M.Init) ~= "function" then return end
    schemHooked = true
    local function doAll(self)
        pcall(HandleSchematicName, self)
        pcall(HandleSchematicDesc, self)
        pcall(HandleSchematicReagents, self)
    end
    hooksecurefunc(M, "Init", function(self)
        doAll(self)
        -- ретраї: назва/реагенти малюються не миттєво + EN-назва предмета вантажиться async
        if C_Timer then
            for _, d in ipairs({ 0, 0.15, 0.4 }) do C_Timer.After(d, function() pcall(doAll, self) end) end
        end
    end)
    if ns.Diag then ns.Diag("крафт: SchematicForm:Init зачеплено (назва+опис+реагенти)") end
end

local hooked = false
local function Install()
    LogMixinCandidates()
    HookRowMixin()
    HookSchematic()
    local pf = _G.ProfessionsFrame
    if not pf then return end
    HookRecipeList()
    if not hooked and pf.HookScript then
        hooked = true
        pf:HookScript("OnShow", function(self)
            HookRecipeList()
            if C_Timer then C_Timer.After(0, function() pcall(WalkLabels, self, 0); HookRecipeList() end) end
        end)
        if ns.Diag then ns.Diag("крафт: ProfessionsFrame зачеплено") end
    end
end

Install() -- якщо вже завантажено

-- ProfessionsFrame — LoadOnDemand (Blizzard_Professions). Чіпляємось на вхід і ADDON_LOADED.
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function() Install() end)
