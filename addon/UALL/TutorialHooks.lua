-- UALL: переклад банерів СИСТЕМИ НАВЧАННЯ (Blizzard_TutorialManager).
-- Джерело: TutorialMainFrame_Frame.ContainerFrame.Text (банер «Mount up by...»).
-- Ці рядки специфічні для туторіалів і НЕ входять у наш датамайн, тож:
--   • перекладаємо словником ns.uiMisc/ns.uiStrings;
--   • незнайомі ЗБИРАЄМО в db.ui (як HelpTip) → доперекладемо оновленням.
-- Звичайні (не forbidden) фрейми; текст оновлюється покроково → self-heal SetText.
-- Guard'и «вже зачеплено» тримаємо у ВЛАСНИХ таблицях (не пишемо в Blizzard-фрейми).

local _, ns = ...

local function Enabled()
    return (not ns.IsEnabled) or ns.IsEnabled("interface.tutorial")
end

-- Відомі фрейми банерів навчання (захисно — імена в Midnight стабільні, але
-- перевіряємо існування).
local FRAMES = { "TutorialMainFrame_Frame", "TutorialPointerFrame" }

local function Lookup(t)
    local ua = (ns.uiMisc and ns.uiMisc[t]) or (ns.uiStrings and ns.uiStrings[t])
    if ua and ua ~= t then return ua end
    return nil
end

local function Capture(t)
    if not (ns.GetCaptureDB and t) then return end
    if #t < 6 or not t:find("%a") then return end            -- код/коротке — пропуск
    if ns.HasCyrillic and ns.HasCyrillic(t) then return end
    local ok, db = pcall(ns.GetCaptureDB)
    if not ok or not db then return end
    db.ui = db.ui or {}
    db.ui[t] = true          -- МОВЧКИ (тутор-рядків багато — не спамимо чат)
end

local applying = false
local hookedFS = setmetatable({}, { __mode = "k" })

local function TrFS(fs)
    if applying or not fs or not fs.GetText then return end
    local t = ns.SafeText and ns.SafeText(fs:GetText()) or fs:GetText()
    if not t or t == "" then return end
    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
    if ns.HasCyrillic and ns.HasCyrillic(t) then return end
    if ns.ShowOriginal and ns.ShowOriginal() then return end
    -- Текст банера буває ОБГОРНУТИЙ кольором |cnNORMAL_FONT_COLOR:...|r (іменований
    -- колір, новий Midnight-синтаксис) або |cAARRGGBB...|r. Для пошуку знімаємо
    -- обгортку, а переклад загортаємо назад тим самим кольором.
    local pre, inner, post = t:match("^(|c[nN][%w_]+:)(.-)(|r)$")
    if not pre then pre, inner, post = t:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)$") end
    inner = inner or t
    local ua = Lookup(inner)
    if ua and ua ~= inner then
        applying = true
        local out = pre and (pre .. ua .. post) or ua
        if ns.Remember then ns.Remember(fs, t, out, nil, "interface.tutorial") end
        fs:SetText(out)
        if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
        applying = false
    else
        Capture(inner)                                        -- незнайоме → у чергу збору
    end
end

-- self-heal: наступний крок навчання перепише .Text без нового Show.
local function selfHeal(fs)
    if applying or not Enabled() then return end
    pcall(TrFS, fs)
end
local function hookFS(fs)
    if hookedFS[fs] or type(fs) ~= "table" or type(fs.SetText) ~= "function" then return end
    hookedFS[fs] = true
    hooksecurefunc(fs, "SetText", selfHeal)
    if type(fs.SetFormattedText) == "function" then
        hooksecurefunc(fs, "SetFormattedText", selfHeal)
    end
end

local function walk(frame, depth)
    if not frame or depth > 6 or type(frame) ~= "table" then return end
    if frame.GetRegions then
        for _, rg in ipairs(ns.Regions(frame)) do
            if rg.IsObjectType and rg:IsObjectType("FontString") then
                hookFS(rg); pcall(TrFS, rg)
            end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then walk(c, depth + 1) end end
    end
end

-- NAME-AGNOSTIC: `_G["TutorialMainFrame_Frame"]` може бути НЕ тим ключем (фрейм
-- анонімний, а це лише debug-ім'я зі стека). Тому не покладаємось на _G — скануємо
-- EnumerateFrames і чіпляємо будь-який фрейм, чиє ім'я/debug-ім'я містить "Tutorial".
-- Guard у НАШІЙ слабкій таблиці (не пишемо маркери в Blizzard-фрейм → taint).
local hookedFrames = setmetatable({}, { __mode = "k" })

local function frameName(f)
    local ok, n = pcall(function()
        return (f.GetName and f:GetName()) or (f.GetDebugName and f:GetDebugName())
    end)
    return (ok and type(n) == "string") and n or nil
end

local function HookOne(f)
    if not f or hookedFrames[f] or type(f) ~= "table" or not f.HookScript then return end
    hookedFrames[f] = true
    f:HookScript("OnShow", function(self)
        -- текст банера інколи ставлять ПІСЛЯ Show → кілька відкладених спроб (не тікер).
        for _, d in ipairs({ 0, 0.05, 0.2 }) do
            C_Timer.After(d, function()
                if self.IsShown and self:IsShown() then pcall(walk, self, 1) end
            end)
        end
    end)
    pcall(walk, f, 1)                                         -- якщо вже показаний
end

-- Обхід EnumerateFrames() проходить ДЕСЯТКИ ТИСЯЧ фреймів. Раніше він
-- запускався на КОЖЕН ADDON_LOADED, ще й з трьома дострілами, тому аддони з
-- лінивим довантаженням (Plumber вантажить модулі при відкритті вікна) давали
-- «script ran too long» і зависання на десятки секунд.
-- Тому: (1) один прохід замість замикання на кожен фрейм, (2) дебаунс — хоч
-- скільки подій прилетить, скан заплановано лише один.
local scanQueued = false

local function ScanTutorialFrames()
    scanQueued = false
    if not Enabled() or not EnumerateFrames then return end
    local f = EnumerateFrames()
    while f do
        -- без pcall-замикання на кожній ітерації: frameName уже захищений,
        -- а HookOne сам перевіряє тип і наявність HookScript
        --
        -- ПОШУК ТЕЖ ПІД pcall. Раніше захищено було лише сам виклик
        -- frameName(f), а `n:find(...)` виконувався ВЖЕ ПОЗА ним — тобто
        -- заслін стояв на крок раніше, ніж треба. Якщо гра поверне secret-
        -- рядок, індексування падає: «attempt to index local 'n' (a secret
        -- string value, while execution tainted by 'UALL')» — 4 такі помилки
        -- у зборі 28.08 [[combat-secret-strings]].
        -- pcall(string.find, n, ...) не створює замикання на ітерацію, тож
        -- свідома економія з коментаря вище лишається чинною.
        local ok, n = pcall(frameName, f)
        if ok and n then
            local okFind, hit = pcall(string.find, n, "Tutorial", 1, true)
            if okFind and hit then HookOne(f) end
        end
        f = EnumerateFrames(f)
    end
end

local ScanRaw = ScanTutorialFrames
ScanTutorialFrames = function() ns.Prof("обхід фреймів", ScanRaw) end

local function QueueScan(delay)
    if scanQueued then return end
    scanQueued = true
    C_Timer.After(delay or 1, ScanTutorialFrames)
end

-- НЕ скануємо синхронно на завантаженні: фреймів навчання тоді ще нема,
-- а обхід коштує чверть секунди просто в момент входу в гру.
QueueScan(3)

-- ВИМІРЯНО профайлером: один обхід EnumerateFrames коштує ~273 мс (макс 362).
-- Це видимий ривок, тож обхід має бути ВИНЯТКОМ, а не звичкою:
--   • на ADDON_LOADED реагуємо ЛИШЕ на завантаження самого туторіал-модуля
--     Blizzard — решта аддонів фреймів навчання не створює;
--   • щойно потрібні фрейми знайдено, сканування припиняємо назавжди:
--     вони створюються один раз і живуть до кінця сесії, а нові підхопить
--     HookScript("OnShow") вже зачепленого фрейма.
local ev = CreateFrame("Frame")
ev:RegisterEvent("ADDON_LOADED")
ev:RegisterEvent("PLAYER_ENTERING_WORLD")
ev:SetScript("OnEvent", function(_, event, arg1)
    if next(hookedFrames) then return end        -- уже знайшли — більше не шукаємо
    if event == "PLAYER_ENTERING_WORLD" then
        QueueScan(2)
    elseif type(arg1) == "string" and arg1:find("Tutorial") then
        QueueScan(1)                             -- завантажився модуль навчання
    end
end)
