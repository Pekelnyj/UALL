-- UALL: переклад назв трансмог-сетів у Гардеробі (Blizzard_Collections / Wardrobe).
-- База: ns.transmogSets (TransmogSet) + ns.transmogSetGroups (TransmogSetGroup).
-- КОНТЕКСТНО-ОБМЕЖЕНО: працює ЛИШЕ на WardrobeCollectionFrame і дивиться ЛИШЕ у
-- свої два словники — без запозичень з інших баз [[context-scoped-translation]].
--
-- МЕТОД: ХУК У ТОЧЦІ ДЖЕРЕЛА, НЕ обхід за таймером [[hook-at-source-not-walk]].
-- ВАЖЛИВО (помилка, яку виправили): SetsCollectionFrame та його ScrollBox
-- створюються ЛИШЕ коли вперше показують вкладку «Набори». Тому чіпляти ScrollBox
-- на OnShow усього гардеробу — зарано (його ще нема). Хук ставимо на OnShow САМОГО
-- SetsCollectionFrame + на функцію наповнення списку (UpdateSets/OnSearchUpdate).
-- Тримають переклад без тікера:
--   • OnShow SetsCollectionFrame — walk видимих рядків + деталей;
--   • hook UpdateSets/OnSearchUpdate — повторне наповнення (фільтр/пошук/зміна класу);
--   • OnInitializedFrame ScrollBox — нові рядки під час скролу;
--   • self-heal SetText/SetFormattedText на кожному написі — перевикористання кнопок;
--   • hook DisplaySet — панель деталей (велика назва + підпис).

local _, ns = ...

local function Enabled()
    return (not ns.IsEnabled) or ns.IsEnabled("interface.transmog")
end

local function Shown()
    local f = _G.WardrobeCollectionFrame
    return f and f.IsShown and f:IsShown()
end

local function Lookup(en)
    if not en or en == "" then return nil end
    local ua = (ns.transmogSets and ns.transmogSets[en])
            or (ns.transmogSetGroups and ns.transmogSetGroups[en])
    if ua and ua ~= en then return ua end
    -- хвіст «(x/y)» зустрічається в назвах сетів — зняти й спробувати ще раз
    local base = en:match("^(.-)%s*%(%d+/%d+%)$")
    if base then
        ua = (ns.transmogSets and ns.transmogSets[base])
          or (ns.transmogSetGroups and ns.transmogSetGroups[base])
        if ua and ua ~= base then
            local tail = en:match("(%(%d+/%d+%))$")
            return ua .. " " .. tail
        end
    end
    return nil
end

local applying = false
local function TrFS(fs)
    if applying or not fs or not fs.GetText then return end
    local en = ns.SafeText and ns.SafeText(fs:GetText()) or fs:GetText()
    if not en or en == "" then return end
    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    if ns.HasCyrillic and ns.HasCyrillic(en) then return end
    local ua = Lookup(en)
    if ua and ua ~= en then
        applying = true
        if ns.Remember then ns.Remember(fs, en, ua, nil, "interface.transmog") end
        fs:SetText(ua)
        if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
        applying = false
    end
end

-- self-heal: вішаємо ОДИН раз на конкретний напис; будь-який майбутній SetText
-- Blizzard (скрол ScrollBox / зміна вибраного сету) одразу перекладається.
local hookedFS = {}
local function selfHeal(fs)
    if applying or not Enabled() or not Shown() then return end
    pcall(TrFS, fs)
end
local function HookFS(fs)
    if hookedFS[fs] or type(fs) ~= "table" or type(fs.SetText) ~= "function" then return end
    hookedFS[fs] = true
    hooksecurefunc(fs, "SetText", selfHeal)
    if type(fs.SetFormattedText) == "function" then
        hooksecurefunc(fs, "SetFormattedText", selfHeal)
    end
end

-- Обхід піддерева: переклад поточного тексту + ВІШАННЯ self-heal на кожен напис
-- (щоб без тікера ловити майбутні скиди).
local function Walk(frame, depth)
    if not frame or depth > 9 or type(frame) ~= "table" then return end
    if frame.GetRegions then
        for _, rg in ipairs(ns.Regions(frame)) do
            if rg.IsObjectType and rg:IsObjectType("FontString") then
                HookFS(rg)
                pcall(TrFS, rg)
            end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then Walk(c, depth + 1) end end
    end
end

-- знайти ScrollBox у піддереві (має ForEachFrame + RegisterCallback — це відрізняє
-- його від звичайних фреймів, що теж мають RegisterCallback).
local function FindScrollBox(frame, depth)
    if ns.IsTooltipFrame(frame) then return  end
    if not frame or depth > 6 or type(frame) ~= "table" then return nil end
    if type(frame.ForEachFrame) == "function" and type(frame.RegisterCallback) == "function" then
        return frame
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do
            local sb = FindScrollBox(c, depth + 1)
            if sb then return sb end
        end
    end
    return nil
end

local function SetsFrame()
    local f = _G.WardrobeCollectionFrame
    return f and f.SetsCollectionFrame
end

local function TranslateSets()
    if not Enabled() then return end
    local sf = SetsFrame()
    if sf then pcall(Walk, sf, 1) end
end

-- OnInitializedFrame ScrollBox набору: переклад кожного рядка під час скролу.
-- Реєструємо ЛИШЕ коли ScrollBox уже існує (вкладку «Набори» показано).
local sbHooked = false
local function HookSetsScrollBox()
    if sbHooked then return end
    local sf = SetsFrame()
    if not sf then return end
    local sb = (sf.ListContainer and sf.ListContainer.ScrollBox) or FindScrollBox(sf, 0)
    if not sb or type(sb.RegisterCallback) ~= "function" then return end
    local evt = ScrollBoxListViewMixin and ScrollBoxListViewMixin.Event
    if not evt or not evt.OnInitializedFrame then return end
    local ok = pcall(function()
        sb:RegisterCallback(evt.OnInitializedFrame, function(_, frame)
            if frame and Enabled() then pcall(Walk, frame, 1) end
        end, sb)
    end)
    if ok then
        sbHooked = true
        if ns.Diag then ns.Diag("transmog: Sets ScrollBox зачеплено (OnInitializedFrame)") end
    end
end

-- Хуки на саму вкладку наборів: ставимо, щойно SetsCollectionFrame існує.
local setsHooked = false
local function HookSetsFrame()
    if setsHooked then return end
    local sf = SetsFrame()
    if not sf then return end
    setsHooked = true

    -- OnShow вкладки: ScrollBox уже створено, рядки наповнено → walk + реєстрація.
    if sf.HookScript then
        sf:HookScript("OnShow", function()
            HookSetsScrollBox()
            TranslateSets()
        end)
    end

    -- Функції наповнення списку (фільтр/пошук/зміна класу/первинне заповнення).
    for _, m in ipairs({ "UpdateSets", "OnSearchUpdate", "Refresh" }) do
        if type(sf[m]) == "function" then
            hooksecurefunc(sf, m, function()
                if Enabled() then pcall(Walk, sf.ListContainer or sf, 1) end
            end)
        end
    end

    -- Панель деталей (велика назва + підпис під моделлю).
    if type(sf.DisplaySet) == "function" then
        hooksecurefunc(sf, "DisplaySet", function()
            if Enabled() and sf.DetailsFrame then pcall(Walk, sf.DetailsFrame, 1) end
        end)
    end

    if ns.Diag then ns.Diag("transmog: SetsCollectionFrame зачеплено") end

    -- якщо вкладку вже показано на момент чіпляння — перекласти негайно
    if sf.IsShown and sf:IsShown() then
        HookSetsScrollBox()
        TranslateSets()
    end
end

local function OnWardrobeShow()
    HookSetsFrame()   -- SetsCollectionFrame міг створитися лише тепер
    TranslateSets()
end

-- ── НАЗВА ОБРАЗУ в тултіпі Образів (модель без item-лінка — лише текст).
-- Розв'язка ЗА ID (не за текстом): власник тултіпа = кнопка моделі з visualInfo;
-- visualID → джерела образу → itemID → ns.items[itemID] (LoD-база предметів).
-- Звіряємо sourceInfo.name з показаним текстом, щоб узяти САМЕ показане джерело.
function ns.WardrobeNameUA(text)
    local tt = _G.GameTooltip
    local owner = tt and tt.GetOwner and tt:GetOwner()
    -- Вкладка НАБОРІВ: кнопка-піс має sourceInfo з готовим itemID — прямий шлях
    local si0 = owner and owner.sourceInfo
    if si0 and si0.itemID and ns.items then
        local ua = ns.items[si0.itemID]
        if type(ua) == "table" then ua = ua.name end
        if type(ua) == "string" and ua ~= "" then return ua end
    end
    local vi = owner and owner.visualInfo
    local vid = vi and vi.visualID
    if not vid or not (C_TransmogCollection and C_TransmogCollection.GetAllAppearanceSources) then return nil end
    local ok, sources = pcall(C_TransmogCollection.GetAllAppearanceSources, vid)
    if not ok or type(sources) ~= "table" then return nil end
    for _, sID in ipairs(sources) do
        local ok2, si = pcall(C_TransmogCollection.GetSourceInfo, sID)
        if ok2 and si and si.itemID and ns.items then
            local ua = ns.items[si.itemID]
            if type(ua) == "table" then ua = ua.name end
            -- ім'я джерела збігається з показаним (або єдине джерело) → наш переклад
            if type(ua) == "string" and ua ~= "" and (si.name == text or #sources == 1) then
                return ua
            end
        end
    end
end

local function HookShow()
    local f = _G.WardrobeCollectionFrame
    if f and f.HookScript and not f.__uall_tmog then
        f.__uall_tmog = true
        f:HookScript("OnShow", OnWardrobeShow)
        if f:IsShown() then OnWardrobeShow() end
    end
end
HookShow()

local ev = CreateFrame("Frame")
ev:RegisterEvent("ADDON_LOADED")
ev:SetScript("OnEvent", function(_, _, name)
    if name == "Blizzard_Collections" then HookShow(); OnWardrobeShow() end
end)
