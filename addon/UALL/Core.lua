-- Ядро аддона — спільний простір імен і службові функції.
-- Код не залежить від назви аддона: ім'я приходить через ADDON_NAME,
-- глобальна змінна SavedVariables — це ADDON_NAME .. "CaptureDB"
-- (має збігатися з рядком ## SavedVariables: у .toc).

local ADDON_NAME, ns = ...

ns.version = C_AddOns.GetAddOnMetadata(ADDON_NAME, "Version") or "?"
ns.svName = ADDON_NAME .. "CaptureDB"

-- ПУБЛІЧНА vs ТЕСТЕРСЬКА збірка. У dev/тестерській — false (усі збирачі текстів
-- працюють: GetCaptureDB пише в SavedVariables, Diag/лог помилок/детектор taint,
-- секція «Збір текстів», Capture.lua). Публічну збірку для CurseForge генерує
-- pipeline/build_public.py — він ставить це в true й прибирає UALLCaptureDB зі
-- SavedVariables у .toc, тож збір НЕ працює і нічого не зберігається на диск.
-- РЯДОК НИЖЧЕ ПЕРЕПИСУЄ build_public.py — не міняй формат.
ns.PUBLIC = false -- @BUILD-PUBLIC-FLAG@

-- Спільний простір імен для LoadOnDemand-під-аддонів (UALL_Items тощо):
-- вони не отримують той самий `...`-ns, тож читають його з цього глобала.
_G.WoWUkraineNS = ns

-- ПРОФАЙЛЕР періодичних точок. Тестери скаржаться на фризи, а гадати, який
-- саме обхід їсть кадр, — марно: у нас п'ять тікерів і хук SetText, і жоден
-- не має періоду 30 с, який описує користувач. Тому міряємо.
-- ns.Prof("мітка", функція, ...) — рахує час виклику, тримає суму/макс/лічильник.
-- Дані в UALLPerfDB (SavedVariables), показ — /uall perf. У публічній збірці
-- вимкнено гейтом ns.PUBLIC, тож на гравців це не лягає.
-- БЕЗПЕЧНИЙ ОБХІД ФРЕЙМІВ. У Midnight частина об'єктів захищена, і звернення
-- до GetRegions/GetChildren кидає «Attempt to access forbidden object from code
-- tainted by an AddOn» — тестери ловили це 23 рази за сесію. IsForbidden треба
-- питати ПЕРШИМ, до будь-якого доступу [[unit-frame-taint-order]].
-- Кожен хук раніше мав власну копію обходу, тому баг сидів у десятьох файлах
-- одночасно. Тепер джерело одне.
local EMPTY = {}

local function safeParts(frame, method)
    if type(frame) ~= "table" or not frame[method] then return EMPTY end
    if frame.IsForbidden then
        local ok, forbidden = pcall(frame.IsForbidden, frame)
        if not ok or forbidden then return EMPTY end
    end
    local ok, list = pcall(function() return { frame[method](frame) } end)
    return ok and list or EMPTY
end

function ns.Regions(frame)  return safeParts(frame, "GetRegions")  end
function ns.Children(frame) return safeParts(frame, "GetChildren") end

ns.perf = {}
function ns.Prof(label, fn, ...)
    if ns.PUBLIC or not debugprofilestop then return fn(...) end
    local t0 = debugprofilestop()
    local a, b, c = fn(...)
    local dt = debugprofilestop() - t0
    local e = ns.perf[label]
    if not e then
        e = { n = 0, sum = 0, max = 0 }
        ns.perf[label] = e
    end
    e.n = e.n + 1
    e.sum = e.sum + dt
    if dt > e.max then
        e.max = dt
        e.maxAt = date("%H:%M:%S")
    end
    return a, b, c
end

-- ЛІЧИЛЬНИК ПОМИЛОК ХУКІВ (07.10.2026, перенесено з Forever). Досі точки входу хуків були
-- в голих pcall: помилка зникала, гравець бачив англійський текст, а ми — нічого. ns.Guard —
-- той самий pcall, але з лічильником і останньою помилкою на модуль; /uall errors показує.
-- Порядку всередині функцій не змінює (SafeText лишається першим) і після помилки модуль
-- просто виходить — як і з голим pcall.
ns.hookErrors = {}
function ns.Guard(module, fn, ...)
    local ok, a, b, c = pcall(fn, ...)
    if ok then return a, b, c end
    local e = ns.hookErrors[module]
    if not e then
        e = { n = 0 }
        ns.hookErrors[module] = e
    end
    e.n = e.n + 1
    e.last = (tostring(a):gsub("^.-([%w_]+%.lua:%d+:)", "%1"))   -- без довгого шляху
    e.at = date("%H:%M:%S")
end

-- Рядок для діагностики модуля: «помилок не було» або «помилок 3, остання …».
function ns.ErrorLine(module)
    local e = ns.hookErrors[module]
    if not e then return "помилок не було" end
    return ("|cffff6060помилок %d|r, остання о %s: %s"):format(e.n, e.at or "?", e.last or "?")
end

local PREFIX = "|cff0057b7" .. ADDON_NAME .. "|r: "

function ns.Print(msg)
    DEFAULT_CHAT_FRAME:AddMessage(PREFIX .. tostring(msg))
end

-- SavedVariables-таблиця збору текстів (створюється за потреби).
function ns.GetCaptureDB()
    if ns.PUBLIC then
        -- Публічна збірка: збирачів немає. Віддаємо «ВСЕ ВЖЕ ЗІБРАНО»-таблицю:
        -- читання БУДЬ-ЯКОГО ключа → true, тож колекторний патерн «if not db.x[key]
        -- then db.x[key]=v; notify(...)» СКРІЗЬ бачить key як наявний → нічого не
        -- пише й НЕ сповіщає в чат; записи ігноруються (нічого не накопичується в
        -- пам'яті, UALLCaptureDB немає у SavedVariables → нічого на диск). Один
        -- центральний гейт замість правок у 23 хуках; жодних падінь на db.x.y=...
        if not ns.__nullDB then
            local allTrue = setmetatable({}, {
                __index = function() return true end, __newindex = function() end })
            ns.__nullDB = setmetatable({}, {
                __index = function() return allTrue end, __newindex = function() end })
        end
        return ns.__nullDB
    end
    local db = _G[ns.svName]
    if not db then
        db = {}
        _G[ns.svName] = db
    end
    db.quests = db.quests or {}
    db.meta = db.meta or {}
    return db
end

-- Діагностичний лог у SavedVariables — читається з диска без скріншотів.
-- Тримаємо останні 40 записів, щоб файл не розпухав.
function ns.Diag(msg)
    if ns.PUBLIC then return end
    local db = ns.GetCaptureDB()
    db.diag = db.diag or {}
    table.insert(db.diag, date("%H:%M:%S ") .. tostring(msg))
    if #db.diag > 40 then table.remove(db.diag, 1) end
end

-- ОКРЕМИЙ постійний лог ПОМИЛОК — його НЕ витісняє звичайна діагностика.
-- Сюди потрапляє кожна Lua-помилка, навіть якщо трекер щось спамить.
--
-- ВЕРСІЯ І ДАТА В КОЖНОМУ РЯДКУ. Раніше стояв лише час («15:52:12»), а версію
-- аддона писали один раз у meta — при вході в гру. Збір же накопичується між
-- сесіями й оновленнями, тож рядок міг лягти ще до фіксу, а meta показувала
-- останній логін. На практиці це закрило питання намертво: у зборах видно
-- 11 блокувань UseToy, і сказати, це регресія чи слід старої збірки,
-- неможливо. Тепер кожен рядок датований і підписаний версією.
local _ver
local function AddonVer()
    -- Кешуємо ЛИШЕ справжнє значення. Якщо перша помилка сталася до того, як
    -- C_AddOns став доступний, кеш із «?» застряг би назавжди — і рядки до
    -- кінця сесії лишилися б без версії, тобто саме без того, заради чого
    -- усе це й робиться.
    if _ver then return _ver end
    local v = C_AddOns and C_AddOns.GetAddOnMetadata
        and C_AddOns.GetAddOnMetadata("UALL", "Version")
    if v then _ver = v end
    return v or "?"
end

-- ЧИЯ ПОМИЛКА. Перевірка шукала лише «WoWUkraine» — стару назву аддона. Після
-- перейменування на UALL кожен НАШ рядок діставав мітку «[?чужа]», тобто лог
-- прямо збивав з пантелику: у зборі 28.08 усі 34 блокування були наші, а
-- позначені як сторонні [[sv-rename-uall-bridge]].
-- Шукаємо в тих формах, у яких гра підписує аддон, а не голе «UALL», щоб не
-- зарахувати собі чуже ім'я, де ці літери трапляються всередині слова.
function ns.IsOurError(s)
    if type(s) ~= "string" then return false end
    return s:find("WoWUkraine", 1, true) ~= nil
        or s == "UALL"
        or s:find("AddOns/UALL/", 1, true) ~= nil
        or s:find("AddOns\\UALL\\", 1, true) ~= nil
        or s:find(": UALL ", 1, true) ~= nil
        or s:find("'UALL'", 1, true) ~= nil
end

local ERR_KEEP = 120
function ns.LogError(msg)
    local db = ns.GetCaptureDB()
    db.errors = db.errors or {}
    table.insert(db.errors, date("%Y-%m-%d %H:%M:%S ") .. "v" .. AddonVer()
                 .. " " .. tostring(msg))
    -- Лічильник УСІХ помилок, а не лише збережених: вікно було 30, і в обох
    -- зборах лежало рівно 30 — тобто частину викинуло, а скільки саме,
    -- дізнатися не було як. Вікно розширено, і тепер видно втрати.
    db.errorsTotal = (db.errorsTotal or 0) + 1
    while #db.errors > ERR_KEEP do table.remove(db.errors, 1) end
end

-- Безпечне читання тексту віджета. У WoW 11.0+ частина текстів трекера
-- та захищеного UI — «СЕКРЕТНІ ЗНАЧЕННЯ»: їх НЕ МОЖНА порівнювати чи
-- читати з аддона (інакше "attempt to compare a secret string value" і
-- лавина помилок/краш — саме це валило аддон у делвах/сценаріях).
-- Повертає звичайний непорожній рядок АБО nil (секретне/порожнє/нема).
function ns.SafeText(v)
    if v == nil then return nil end
    local ok, isEmpty = pcall(function() return v == "" end)
    if not ok then return nil end -- секретне значення — не чіпаємо
    if isEmpty then return nil end
    return v
end

-- ШВИДКА перевірка кирилиці (байтова, без декодування UTF-8): провідні байти
-- кириличних літер — 0xD0/0xD1 (а-я,і,ї,є) і 0xD2 (ґ). Клієнт enUS, тож БУДЬ-ЯКА
-- кирилиця в тексті означає, що це ВЖЕ НАШ переклад → не перекладати повторно
-- й не збирати назад (інакше марні цикли + засмічення бази укр. рядками).
function ns.HasCyrillic(s)
    return type(s) == "string" and s:find("[\208\209\210]") ~= nil
end

-- ЄДИНИЙ реєстр УСІХ наших підмін тексту: fontString -> {en, ua}. КОЖНЕ місце,
-- де ми замінюємо англійський текст на український, реєструє пару сюди.
-- Це робить «показати оригінал» element-agnostic: аддону БАЙДУЖЕ, що за віджет
-- (моб/предмет/квест/діалог) — Shift просто тимчасово повертає збережений
-- оригінал УСЮДИ одразу, відпускання — назад на переклад. Слабкі ключі — без
-- витоків (віджети, яких уже нема, прибираються GC).
ns.replacements = setmetatable({}, { __mode = "k" })
-- solo=true — елемент НЕ з пулу (єдиний, напр. SimpleHTML книги), і не має
-- читабельного GetText; ToggleOriginal свопатиме його напряму за станом Shift.
-- ОБРІЗАННЯ «...»: Blizzard розраховує ширину напису під АНГЛІЙСЬКИЙ рядок, а наш
-- переклад майже завжди довший — рушій мовчки ріже й дописує «...» («Рен'дорейський
-- книж... 100%», «Рівень ...»). Це не наше обрізання (ми ріжемо символом «…»).
-- Після підстановки даємо напису рівно стільки ширини, скільки треба. Тільки
-- РОЗШИРЮЄМО, ніколи не звужуємо; усе в pcall — виклики бувають на secret/forbidden.
-- Два різні випадки, і плутати їх не можна:
--   • напис ВІЛЬНИЙ по ширині (один горизонтальний якір) — просто розширюємо;
--   • напис ЗАТИСНУТИЙ якорями з обох боків (напр. «Level N» у блоці сценарію/
--     делву, де праворуч упритул іконки афіксів) — рушій рахує ширину з якорів і
--     SetWidth МОВЧКИ ІГНОРУЄ. Розширення тут неможливе за визначенням, тож
--     підганяємо кегль: зменшуємо на пункт, доки рядок не влізе (до 8).
local origFont = setmetatable({}, { __mode = "k" })

local function pc(fn, ...)                    -- pcall із поверненням значення
    local ok, v = pcall(fn, ...)
    if ok then return v end
end

-- true, якщо ширину диктують якорі (є прив'язка і зліва, і справа).
local function HorizBounded(fs)
    local n = pc(fs.GetNumPoints, fs)
    if not n or n < 2 then return false end
    local left, right = false, false
    for i = 1, n do
        local p = pc(fs.GetPoint, fs, i)
        if type(p) == "string" then
            if p:find("LEFT") then left = true end
            if p:find("RIGHT") then right = true end
        end
    end
    return left and right
end

local MIN_SIZE = 8

local function SafeGetFont(fs)
    local ok, path, size, flags = pcall(fs.GetFont, fs)
    if ok then return path, size, flags end
end

-- ЧИ ЖИВЕ ОБ'ЄКТ УСЕРЕДИНІ ScrollBox?
--
-- ScrollBox сам рахує висоту вмісту (GetDerivedScrollRange -> Clamp). Якщо ми
-- з НЕЗАХИЩЕНОГО коду міняємо ширину, кегль або висоту чогось усередині нього,
-- ці обчислення стають тейнтованими, і найближче ж порівняння secret-числа в
-- MathUtil падає з «attempt to compare local 'value' (a secret number value,
-- while execution tainted by 'UALL')». Тейнт липкий, гейт у бою не рятує
-- [[bagsearch-setmatches-taint]], тож єдиний надійний спосіб — не чіпати.
--
-- Пізнаємо ScrollBox за його ж методами, а не за іменем: імена фреймів
-- Blizzard міняє щопатчу, а міксин лишається.
local scrollAncestor = setmetatable({}, { __mode = "k" })

function ns.InScrollBox(f)
    if type(f) ~= "table" then return false end
    local cached = scrollAncestor[f]
    if cached ~= nil then return cached end
    local p, depth, found = f, 0, false
    while p and depth < 12 do
        if type(p) == "table"
            and (rawget(p, "GetDerivedScrollRange") or p.GetDerivedScrollRange)
            and (rawget(p, "ForEachFrame") or p.ForEachFrame) then
            found = true
            break
        end
        local ok, up = pcall(function() return p.GetParent and p:GetParent() end)
        if not ok then break end
        p, depth = up, depth + 1
    end
    scrollAncestor[f] = found
    return found
end

function ns.UnclipIfTruncated(fs)
    if not (fs and fs.IsTruncated and fs.GetFont) then return end
    -- Усередині ScrollBox ширину й кегль НЕ чіпаємо: це тейнтить рахунок
    -- прокрутки. Краще обрізаний напис, ніж помилка, що блокує дію гравцеві.
    if ns.InScrollBox(fs) then return end

    local path, size, flags = SafeGetFont(fs)
    if not (path and size) then return end

    -- Повертаємо ПОЧАТКОВИЙ КЕГЛЬ — і лише його: шлях та прапорці беремо
    -- поточні, бо ApplyCyrFont міг тим часом підмінити шрифт на кириличний, і
    -- відкочувати його не можна. Без цього повторні проходи зменшували б напис
    -- крок за кроком до нечитабельного.
    local base = origFont[fs]
    if base and base > size then
        pcall(fs.SetFont, fs, path, base, flags)
        size = base
    end

    if not pc(fs.IsTruncated, fs) then return end

    -- Випадок 1: ширина вільна — розширюємо під текст.
    if not HorizBounded(fs) then
        local need = pc(fs.GetUnboundedStringWidth, fs)
        if need and need > 0 then
            local cur = pc(fs.GetWidth, fs)
            if cur and need + 2 <= cur then return end
            pcall(fs.SetWidth, fs, need + 2)
        else
            pcall(fs.SetWidth, fs, 0)   -- 0 = авторозмір за текстом
        end
        return
    end

    -- Випадок 2: слот затиснутий якорями — SetWidth тут no-op, підганяємо кегль.
    local avail = pc(fs.GetWidth, fs)
    if not (avail and avail > 0) or size <= MIN_SIZE then return end
    origFont[fs] = origFont[fs] or size
    for s = size - 1, MIN_SIZE, -1 do
        if not pcall(fs.SetFont, fs, path, s, flags) then return end
        local w = pc(fs.GetUnboundedStringWidth, fs)
        if not w or w <= avail then return end
    end
end

-- ОБЕРНЕНИЙ РЕЖИМ (07.10.2026, перенесено з Forever): модулі підміняють як завжди, а цей
-- хук одразу повертає на напис оригінал — пара лишається в реєстрі, і клавіша
-- (ToggleOriginal) показує переклад. Модулі кличуть Remember то перед SetText(ua), то
-- після — тож і хук на SetText, і перевірка поточного тексту. Повернутий напис позначаємо
-- в ns.__uaFlipped: ToggleOriginal відновлює переклад лише «своїм» написам.
-- ns.__reverting: поки МИ ставимо оригінал (Reverse, ToggleOriginal), ns.ShowOriginal()
-- каже модулям «не перекладати» — інакше їхні власні піни на SetText того ж напису
-- одразу переклали б його знову, і на екрані лишилась би українська.
local reverseHooked = setmetatable({}, { __mode = "k" })

local function Reversed()
    return ns.GetSetting and ns.GetSetting("reverseOriginal")
end

local function Flipped()
    if not ns.__uaFlipped then ns.__uaFlipped = setmetatable({}, { __mode = "k" }) end
    return ns.__uaFlipped
end

local function Reverse(fs)
    local p = ns.replacements[fs]
    if ns.__reverting or not p or p.solo or not (ns.DisplayOriginal and ns.DisplayOriginal()) then return end
    local ok, cur = pcall(fs.GetText, fs)
    if not ok or ns.SafeText(cur) ~= p.ua then return end
    ns.__reverting = true
    pcall(fs.SetText, fs, p.en)
    ns.__reverting = false
    Flipped()[fs] = true
end

local function ReverseHook(fs)
    if reverseHooked[fs] or type(fs) ~= "table" or type(fs.SetText) ~= "function"
        or type(fs.GetText) ~= "function" then return end
    reverseHooked[fs] = true
    hooksecurefunc(fs, "SetText", function(self)
        if Reversed() then Reverse(self) end
    end)
end

-- key (07.10.2026) — ключ модуля з Settings.lua: знята галочка одразу повертає англійську
-- саме написам цього модуля (ns.ModuleChanged), без /reload.
function ns.Remember(fs, en, ua, solo, key)
    if fs and type(en) == "string" and type(ua) == "string" and en ~= ua then
        local p = { en = en, ua = ua, solo = solo, key = key }
        ns.replacements[fs] = p
        if Reversed() then
            if solo then
                -- сторінка книги (SimpleHTML) без GetText: модуль ставить переклад одразу
                -- після Remember, тож оригінал повертаємо в наступному кадрі
                C_Timer.After(0, function()
                    if ns.replacements[fs] == p and Reversed() and ns.DisplayOriginal() then
                        pcall(fs.SetText, fs, p.en)
                    end
                end)
            else
                pcall(ReverseHook, fs)
                pcall(Reverse, fs)
            end
        end
    end
end

-- Галочку модуля змінили (панель налаштувань чи /uall on|off): написи ЦЬОГО модуля одразу
-- англійські (вимкнули) або знову українські (увімкнули) — без /reload. Чіпаємо лише ті,
-- чий поточний текст — саме наша пара (пули перевикористовуються). Поки ставимо оригінал,
-- ns.__reverting не дає пінам модуля перекласти назад.
function ns.ModuleChanged(key)
    if not key then return end
    local showUA = ns.IsEnabled(key) and not (ns.DisplayOriginal and ns.DisplayOriginal())
    for fs, p in pairs(ns.replacements) do
        if p.key == key then
            if p.solo then
                -- SimpleHTML без GetText: лише повертаємо оригінал, і лише видимій сторінці
                if not showUA and fs.IsShown and fs:IsShown() then pcall(fs.SetText, fs, p.en) end
            else
                local ok, cur = pcall(fs.GetText, fs)
                cur = ok and ns.SafeText(cur) or nil
                if not showUA and cur == p.ua then
                    ns.__reverting = true
                    pcall(fs.SetText, fs, p.en)
                    ns.__reverting = false
                elseif showUA and cur == p.en then
                    pcall(fs.SetText, fs, p.ua)
                end
            end
        end
    end
    local tip = _G.GameTooltip
    if tip and tip.IsShown and tip:IsShown() then pcall(tip.Show, tip) end
end

-- Обернений режим увімкнули посеред гри: хуки на вже записані підміни.
function ns.ReverseRefresh()
    if not Reversed() then return end
    for fs, p in pairs(ns.replacements) do
        if not p.solo then pcall(ReverseHook, fs) end
    end
end

-- Свопає зареєстровані віджети між оригіналом і перекладом за станом Shift.
-- ОБОРОТНО: на «показати оригінал» запам'ятовуємо, які саме віджети МИ змінили
-- ua→en, і на відпусканні відновлюємо ЛИШЕ їх. НЕ можна на відпусканні тупо
-- ставити ua всім англ. парам — інакше Shift насильно українізує навіть те, що
-- вимкнене в опціях і має лишатися англійським (баг: «вимкнув усе, а Shift робить
-- квести укр.»). Чіпаємо лише ті, чий ПОТОЧНИЙ текст саме наша пара (пули).
function ns.ToggleOriginal()
    local show = (ns.DisplayOriginal or ns.ShowOriginal)()   -- що має бути НА ЕКРАНІ
    local flipped = ns.__uaFlipped
    if not flipped then flipped = setmetatable({}, { __mode = "k" }); ns.__uaFlipped = flipped end
    for fs, p in pairs(ns.replacements) do
        if p.solo then
            -- solo (SimpleHTML книги): показуємо en лише поки тримається Shift, інакше ua
            -- (книга видима ЛИШЕ коли її модуль активний, тож тут насильної укр. нема).
            if fs.SetText then pcall(fs.SetText, fs, show and p.en or p.ua) end
        elseif fs.GetText and fs.SetText then
            local ok, cur = pcall(fs.GetText, fs)
            cur = ok and ns.SafeText(cur) or nil
            if show then
                -- показати оригінал: en лише для тих, що ЗАРАЗ українською (наш переклад)
                if cur == p.ua then
                    ns.__reverting = true            -- піни модулів не перекладуть назад
                    pcall(fs.SetText, fs, p.en)
                    ns.__reverting = false
                    flipped[fs] = true
                end
            else
                -- відновити ua ЛИШЕ для тих, що ми самі щойно перевели на en
                if flipped[fs] and cur == p.en then pcall(fs.SetText, fs, p.ua) end
                flipped[fs] = nil
            end
        end
    end
end

-- Гаряча клавіша-ПЕРЕМИКАЧ «показати оригінал». На відміну від утримання
-- модифікатора (Shift/Ctrl/Alt часто зайняті в гравця → переклад блимає в кожному
-- комбо), це ФІКСОВАНИЙ стан: натиснув раз — оригінал, ще раз — переклад. Клавішу
-- гравець призначає сам у «Гра → Призначення клавіш» (можна акорд: Shift+T).
-- ns.originalToggled враховує ns.ShowOriginal(), тож охоплює весь реєстр підмін.
-- Виклики: клавіша з «Гра → Призначення клавіш → WoWUkraine» (Bindings.xml), слеш
-- «/uall toggle» або макро «/run UALL_ToggleOriginalHotkey()». (Прив'язку відновлено:
--  Bindings.xml + глобалі BINDING_HEADER/NAME нижче — без заголовка розділ був безіменний
--  і його не знаходили, звідси хибний висновок «не працює» у f1401c5.)
function UALL_ToggleOriginalHotkey()
    ns.originalToggled = not ns.originalToggled
    -- ПЕРСИСТИМО стан перемикача між сесіями (db.showOriginal). Це НЕЗАЛЕЖНИЙ від
    -- майстра «Увімкнути переклад» шлях показу оригіналу — окрема клавіша-перемикач
    -- у «Призначенні клавіш» (чекбокс-дубль прибрано; ShowOriginal зважає й на майстер).
    local db = ns.GetSettingsDB and ns.GetSettingsDB()
    if db then db.showOriginal = ns.originalToggled end
    if C_Timer and C_Timer.After then
        C_Timer.After(0, ns.ToggleOriginal) -- поза стеком натискання — taint-safe
    else
        ns.ToggleOriginal()
    end
end

-- Заголовки/підписи дій на екрані «Гра → Призначення клавіш» (Bindings.xml з
-- category="ADDONS" → секція «Аддони», як BtWQuests). Це НАШІ власні глобалі
-- (Blizzard їх не має), тож secure-код їх не читає — тейнту немає (на відміну від
-- override чужих BINDING_* [[globalstrings-interface-taint]]).
_G.BINDING_HEADER_UALL = "UALL"
_G.BINDING_NAME_UALL_TOGGLE_ORIGINAL = "Вимкнути весь переклад (перемикач)"
_G.BINDING_NAME_UALL_SHOW_ORIGINAL_HOLD = "Показати оригінал (утримання)"

-- УТРИМАННЯ оригіналу на ДОВІЛЬНІЙ клавіші (переназначувана заміна модифікатора
-- Shift/Ctrl/Alt). WoW не дає addon-біндингу події key-up, тож ловимо клавішу самі:
-- кадр із EnableKeyboard + PropagateKeyboardInput(true) СПОСТЕРІГАЄ натиск/відпускання
-- (клавішу НЕ їсть — рух/дії гравця цілі), і коли натиснута клавіша = та, що гравець
-- призначив біндингу UALL_SHOW_ORIGINAL_HOLD, вмикаємо ns.holdOriginal (ShowOriginal
-- враховує його). Поки редагується текст (чат) — не спрацьовує (кадр не отримує клавіш).
do
    local hf = CreateFrame("Frame", nil, UIParent)
    hf:EnableKeyboard(true)
    hf:SetPropagateKeyboardInput(true)
    local function boundKey()
        return GetBindingKey and GetBindingKey("UALL_SHOW_ORIGINAL_HOLD")
    end
    local function setHold(on)
        if ns.holdOriginal == on then return end
        ns.holdOriginal = on
        if C_Timer and C_Timer.After then C_Timer.After(0, ns.ToggleOriginal)
        else ns.ToggleOriginal() end
    end
    hf:SetScript("OnKeyDown", function(_, key)
        local bk = boundKey()
        if bk and key == bk then setHold(true) end
    end)
    hf:SetScript("OnKeyUp", function(_, key)
        local bk = boundKey()
        if bk and key == bk then setHold(false) end
    end)
end

-- ОПЦІЯ «оригінальні імена»: міняє кириличні імена персонажів (усі відмінки)
-- на латинський оригінал. ns.nameForms = { ["Вратіон"]="Wrathion", ... } —
-- стем ловить ПОЧАТОК слова, кириличне відмінкове закінчення відкидається
-- (латиниця лишається без відмінка: «Щоденник Wrathion»). Текст зберігається
-- ОДИН раз — дублювати не треба, заміна йде на льоту перед показом.
local nameCache = {}
local nameCacheN = 0
function ns.ApplyNames(text)
    if type(text) ~= "string" or not ns.nameForms then return text end
    if not ns.IsEnabled("names.original") then return text end
    local cached = nameCache[text]
    if cached ~= nil then return cached end
    local result = text:gsub("%S+", function(tok)
        -- відрізати ASCII-пунктуацію спереду/ззаду (кирилиця/«» — не %p)
        local lead, core, trail = tok:match("^(%p*)(.-)(%p*)$")
        if not core or core == "" then return nil end
        for stem, eng in pairs(ns.nameForms) do
            if core:sub(1, #stem) == stem then
                return lead .. eng .. trail
            end
        end
        return nil -- слово без імені — без змін
    end)
    if nameCacheN > 4000 then nameCache = {}; nameCacheN = 0 end
    nameCache[text] = result
    nameCacheN = nameCacheN + 1
    return result
end

-- СТАТЬ ГРАВЦЯ: токен $p(чол:жін) у наших перекладах розгортається за UnitSex
-- (2=чол, 3=жін, 1=невідомо→чол). REST API прибрав Blizzard-$g, тож кодуємо рід
-- гравця цим токеном у місцях звертання («ти зібра$p(в:ла)», «$p(друже:подруго)»).
-- Display-only, без тейнту. Викликати на КОЖЕН наш рядок перед показом.
function ns.ApplyPlayerGender(text)
    if type(text) ~= "string" then return text end
    if not text:find("$p(", 1, true) then return text end   -- швидкий вихід
    local female = (UnitSex and UnitSex("player")) == 3
    return (text:gsub("%$p%(([^:%)]*):([^%)]*)%)", function(m, f)
        return female and f or m
    end))
end

-- GameTooltip:SetOwner ПЕРЕПАРЕНТОВУЄ тултіп у фрейм-власник → БУДЬ-ЯКИЙ обхід
-- дітей відкритого вікна може дістатись рядків тултіпа і SetText-нути їх, тейнтячи
-- secret-шари layout (LayoutFrame:491, SharedTooltipTemplates:213). Тому КОЖНА
-- дитяча рекурсія зобов'язана питати цей заслін [[tooltip-reparent-walk-leak]].
function ns.IsTooltipFrame(f)
    if f == GameTooltip then return true end
    if type(f) == "table" and f.GetObjectType then
        local ok, t = pcall(f.GetObjectType, f)
        return ok and t == "GameTooltip"
    end
    return false
end

-- Повертає таблицю перекладу квесту за questID або nil.
function ns.GetQuestTranslation(questID)
    return questID and ns.quests and ns.quests[questID] or nil
end

-- Підрахунок записів у таблиці з нечисловими/розрідженими ключами.
local function CountKeys(t)
    local n = 0
    if t then
        for _ in pairs(t) do n = n + 1 end
    end
    return n
end

-- Слеш-команда /<назва аддона маленькими літерами> — статистика і керування.
local SLASH_KEY = ADDON_NAME:upper()
local slashCommand = "/" .. ADDON_NAME:lower()
_G["SLASH_" .. SLASH_KEY .. "1"] = slashCommand
_G["SLASH_" .. SLASH_KEY .. "2"] = "/wu"   -- короткі аліаси
_G["SLASH_" .. SLASH_KEY .. "3"] = "/wuk"
-- /uall list | on <ключ> | off <ключ> | errors (07.10.2026, перенесено з Forever): вимикачі
-- працюють і без панелі налаштувань, а тестер копіює рядок помилки замість «щось англійською».
local function FindOption(key)
    for _, section in ipairs(ns.optionSections or {}) do
        for _, opt in ipairs(section.options) do
            if opt.key:lower() == key then return opt end
        end
    end
end

local function SwitchCommand(cmd, rest)
    if cmd == "errors" then
        local names = {}
        for module in pairs(ns.hookErrors) do names[#names + 1] = module end
        table.sort(names)
        if #names == 0 then ns.Print("помилок у хуках не було") return end
        for _, module in ipairs(names) do ns.Print(module .. ": " .. ns.ErrorLine(module)) end
        return
    end
    if cmd == "list" then
        for _, section in ipairs(ns.optionSections or {}) do
            local parts = {}
            for _, opt in ipairs(section.options) do
                if type(opt.default) == "boolean" then
                    local on = ns.GetSetting(opt.key)
                    parts[#parts + 1] = (on and "|cff40ff40" or "|cffff6060") .. opt.key .. "|r"
                        .. (opt.active and "" or " (скоро)")
                end
            end
            if #parts > 0 then ns.Print(section.header .. ": " .. table.concat(parts, ", ")) end
        end
        ns.Print("зелене — увімкнено, червоне — вимкнено. /uall off <ключ>, /uall on <ключ>, /uall errors")
        return
    end
    local opt = FindOption(rest)
    if not opt or type(opt.default) ~= "boolean" then
        ns.Print(("немає такого вимикача: «%s». Список — /uall list"):format(rest))
        return
    end
    ns.GetSettingsDB()[opt.key] = (cmd == "on")
    if opt.onChange then pcall(opt.onChange) end
    pcall(ns.ModuleChanged, opt.key)
    ns.Print(("%s: %s."):format(opt.key, cmd == "on" and "|cff40ff40увімкнено|r" or "|cffff6060вимкнено|r"))
end

SlashCmdList[SLASH_KEY] = function(arg)
    arg = (arg or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
    local cmd, rest = arg:match("^(%S+)%s*(.-)$")
    if cmd == "list" or cmd == "on" or cmd == "off" or cmd == "errors" then
        return SwitchCommand(cmd, rest or "")
    end
    if arg == "stats" or arg == "" then
        local translated = CountKeys(ns.quests)
        if ns.PUBLIC then
            ns.Print(("Перекладено квестів: %d."):format(translated))
        else
            local captured = CountKeys(ns.GetCaptureDB().quests)
            ns.Print(("Перекладено квестів: %d. Зібрано для перекладу: %d."):format(translated, captured))
        end
    elseif arg == "perf" then
        if ns.PUBLIC then
            ns.Print("Профайлер доступний лише в тестерській збірці.")
            return
        end
        local rows = {}
        for label, e in pairs(ns.perf) do rows[#rows + 1] = { label, e } end
        table.sort(rows, function(x, y) return x[2].max > y[2].max end)
        if #rows == 0 then
            ns.Print("Профайлер порожній — жодна точка ще не спрацювала.")
            return
        end
        local st = ns.__uiLookupStats
        if st and (st.hit + st.miss) > 0 then
            -- кеш пошуку UI-рядків: промах = повний ланцюг (6 патернів,
            -- ~14 словників), влучання = один пошук у хеші
            ns.Print(("кеш UI-пошуку: влучань %d | промахів %d (%.0f%% зекономлено)")
                :format(st.hit, st.miss, 100 * st.hit / (st.hit + st.miss)))
        end
        ns.Print("точка | викликів | сума мс | СЕР мс | МАКС мс | коли макс")
        for _, r in ipairs(rows) do
            local L, e = r[1], r[2]
            ns.Print(("%s | %d | %.0f | %.2f | %.1f | %s")
                :format(L, e.n, e.sum, e.sum / e.n, e.max, e.maxAt or "-"))
        end
    elseif arg == "perfreset" then
        ns.perf = {}
        if ns.__uiLookupStats then
            ns.__uiLookupStats.hit, ns.__uiLookupStats.miss = 0, 0
        end
        ns.Print("Профайлер очищено.")
    elseif arg == "options" or arg == "opt" then
        ns.OpenOptions()
    elseif arg == "toggle" or arg == "orig" or arg == "оригінал" then
        UALL_ToggleOriginalHotkey()
        ns.Print("Перемкнуто: " .. (ns.originalToggled and "ОРИГІНАЛ" or "переклад"))
    elseif arg == "welcome" or arg == "info" or arg == "про" then
        if ns.ShowWelcome then ns.ShowWelcome() else ns.Print("Вікно недоступне.") end
    elseif not ns.PUBLIC and arg == "debug" then
        ns.debug = not ns.debug
        ns.Print("Діагностика: " .. (ns.debug and "УВІМКНЕНО (наведи на спел і дивись чат)" or "вимкнено"))
        ns.Print(("Хук тултіпів: %s | спелів у базі: %d | spells.name: %s | enabled: %s"):format(
            tostring(ns.spellHooksRegistered), CountKeys(ns.spells),
            tostring(ns.IsEnabled("spells.name")), tostring(ns.IsEnabled("enabled"))))
        ns.Print(("Описів у базі: %d шаблонів / %d спелів | spells.description: %s%s"):format(
            CountKeys(ns.descTemplates), CountKeys(ns.spellDescIndex),
            tostring(ns.IsEnabled("spells.description")),
            CountKeys(ns.descTemplates) == 0
                and " | БАЗА ОПИСІВ НЕ ЗАВАНТАЖЕНА — потрібен ПОВНИЙ перезапуск гри (не /reload)!" or ""))
    elseif not ns.PUBLIC and (arg == "lvl" or arg == "рівень") then
        -- ДІАГНОСТИКА «Рівень ...»: три гіпотези поспіль (ширина, кегль, момент
        -- виміру) виявилися хибними, бо жодну не міряли. Ця команда друкує
        -- ФАКТИЧНИЙ стан напису .Level у блоці сценарію, щоб більше не гадати.
        local function findLevel(f, d)
            if not f or d > 6 or type(f) ~= "table" then return nil end
            if f.Level and f.Level.GetText then return f.Level end
            if f.GetChildren then
                for _, c in ipairs(ns.Children(f)) do
                    local r = findLevel(c, d + 1)
                    if r then return r end
                end
            end
        end
        local root = _G.ScenarioObjectiveTracker and _G.ScenarioObjectiveTracker.ContentsFrame
        local fs = root and findLevel(root, 0)
        if not fs then
            ns.Print("Напис .Level не знайдено — зайди в підземелля з ключем і повтори.")
            return
        end
        local function num(v) return type(v) == "number" and ("%.1f"):format(v) or tostring(v) end
        local okT, txt = pcall(fs.GetText, fs)
        local _, cut = pcall(fs.IsTruncated, fs)
        local _, w = pcall(fs.GetWidth, fs)
        local _, sw = pcall(fs.GetStringWidth, fs)
        local _, uw = pcall(fs.GetUnboundedStringWidth, fs)
        local _, path, size = pcall(fs.GetFont, fs)
        local _, np = pcall(fs.GetNumPoints, fs)
        local pts = {}
        for i = 1, (np or 0) do
            local ok, p, _, rp = pcall(fs.GetPoint, fs, i)
            if ok then pts[#pts + 1] = tostring(p) .. "→" .. tostring(rp) end
        end
        local par = fs.GetParent and fs:GetParent()
        local _, pw = par and pcall(par.GetWidth, par)
        ns.Print(("текст=«%s» обрізано=%s"):format(okT and tostring(txt) or "?", tostring(cut)))
        ns.Print(("ширина=%s рядок=%s безмежний=%s батько=%s"):format(num(w), num(sw), num(uw), num(pw)))
        ns.Print(("кегль=%s якорів=%d [%s]"):format(num(size), np or 0, table.concat(pts, " ")))
    elseif not ns.PUBLIC and (arg == "tip" or arg == "тултіп") then
        -- ДІАГНОСТИКА ТУЛТІПА: наведи на елемент і виконай /uall tip.
        -- Друкує ВСЕ, від чого залежить наш переклад: власника (за ним працює
        -- тейнт-бар'єр пінів мапи), наявність widget-set і СИРІ рядки з кодами
        -- (| → ||), плюс чи знаходить наш словник кожен рядок. Саме цього бракувало,
        -- щоб зрозуміти, чому окремі тултіпи пінів лишаються англійськими.
        local tt = GameTooltip
        if not (tt and tt.IsShown and tt:IsShown()) then
            ns.Print("Тултіп не показаний — наведи на елемент і виконай команду ще раз.")
            return
        end
        local owner = tt.GetOwner and tt:GetOwner()
        local oname = "—"
        if owner then
            local ok, n = pcall(function() return owner.GetName and owner:GetName() end)
            oname = (ok and n) or "<без імені>"
            local p, d = owner.GetParent and owner:GetParent(), 0
            while p and d < 4 do
                local ok2, pn = pcall(function() return p.GetName and p:GetName() end)
                oname = oname .. " ← " .. ((ok2 and pn) or "?")
                p = p.GetParent and p:GetParent(); d = d + 1
            end
        end
        ns.Print(("ТУЛТІП: рядків %d | widgetSetID: %s"):format(
            tt:NumLines(), tostring(tt.widgetSetID)))
        ns.Print("власник: " .. oname)
        for i = 1, tt:NumLines() do
            local fs = _G["GameTooltipTextLeft" .. i]
            local raw = fs and fs.GetText and fs:GetText()
            raw = ns.SafeText and ns.SafeText(raw) or raw
            if raw then
                local hit = (ns.questObjectives and ns.questObjectives[raw]) and "questObjectives"
                    or (ns.uiTooltips and ns.uiTooltips[raw]) and "uiTooltips"
                    or (ns.scenario and ns.scenario[raw]) and "scenario"
                    or "—"
                ns.Print(("[%d] <%s> словник: %s"):format(i, (raw:gsub("|", "||")), hit))
            end
        end
    elseif not ns.PUBLIC and (arg == "helptip" or arg == "підказка") then
        -- ТЕСТ HelpTip-хука: показати підказку з відомим рядком (є в uiMisc) →
        -- має зʼявитись українською. Перевірка без скидання туторіалів.
        if HelpTip and HelpTip.Show then
            local info = {
                text = "Click to view Mission Details.",
                buttonStyle = HelpTip.ButtonStyle and HelpTip.ButtonStyle.Close,
                targetPoint = HelpTip.Point and HelpTip.Point.TopEdgeCenter,
            }
            pcall(HelpTip.Show, HelpTip, UIParent, info, UIParent)
            ns.Print("Тестова підказка показана по центру екрана — має бути українською.")
        else
            ns.Print("HelpTip недоступний у цьому клієнті.")
        end
    elseif not ns.PUBLIC and arg == "dumpgs" then
        -- Дамп GlobalStrings (інтерфейс гри) у SavedVariables для перекладу.
        -- Проходимо _G, беремо глобали ВЕЛИКИМИ-літерами зі строковим значенням —
        -- це і є рядки інтерфейсу (ADD_FRIEND, SEND_MESSAGE, ...). Авторитетно для
        -- ЦІЄЇ версії гри. Екстракт: pipeline/extract_globalstrings.py.
        local db = ns.GetCaptureDB()
        db.globalStrings = {}
        local n = 0
        for k, v in pairs(_G) do
            if type(k) == "string" and type(v) == "string"
               and #v >= 1 and #v <= 400
               and k:match("^[A-Z][A-Z0-9_]*$") and not ns.HasCyrillic(v) then
                db.globalStrings[k] = v
                n = n + 1
            end
        end
        ns.Print(("GlobalStrings зібрано: %d. Зроби /reload, потім надішли файл UALL.lua."):format(n))
    elseif not ns.PUBLIC and arg:match("^find") then
        -- Діагностика: знайти ВСІ видимі написи з даним текстом і вивести їх
        -- фрейм-ланцюжок (щоб зрозуміти, який фрейм рендерить неперекладене ім'я).
        local needle = arg:gsub("^find%s*", "")
        if needle == "" then
            ns.Print("Вжиток: " .. slashCommand .. " find <текст> (напр. fidoficus)")
            return
        end
        local function chain(f)
            local s, d = {}, 0
            while f and d < 8 do
                s[#s + 1] = (f.GetName and f:GetName())
                    or (f.GetObjectType and f:GetObjectType()) or "?"
                f = f.GetParent and f:GetParent(); d = d + 1
            end
            return table.concat(s, " < ")
        end
        local count = 0
        local f = EnumerateFrames()
        while f do
            if f.GetRegions and (not f.IsShown or f:IsShown()) then
                for _, r in ipairs(ns.Regions(f)) do
                    if r.IsObjectType and r:IsObjectType("FontString") then
                        local okT, raw = pcall(r.GetText, r)
                        local t = okT and ns.SafeText(raw) or nil -- nil для secret
                        if t and t:lower():find(needle, 1, true) then
                            count = count + 1
                            ns.Print(("[%d] «%s» @ %s"):format(count, t:sub(1, 45), chain(r:GetParent())))
                        end
                    end
                end
            end
            f = EnumerateFrames(f)
        end
        ns.Print(("Знайдено написів «%s»: %d"):format(needle, count))
    elseif not ns.PUBLIC and (arg == "sb" or arg == "spellbook") then
        -- Діагностика книги заклять: САМ перекладаємо всі кнопки й рахуємо зміни —
        -- це вирішує, чи проблема в тригері (не викликалось), чи в перезаписі назв.
        local psf = _G.PlayerSpellsFrame
        local paged = psf and psf.SpellBookFrame and psf.SpellBookFrame.PagedSpellsFrame
        if not (paged and paged.EnumerateFrames) then ns.Print("Книга не відкрита."); return end
        local mix = _G.PagedContentFrameBaseMixin or _G.PagedContentFrameMixin
        ns.Print(("Mixin=%s Event.OnUpdate=%s RegisterCallback=%s"):format(
            tostring(mix), tostring(mix and mix.Event and mix.Event.OnUpdate),
            tostring(paged.RegisterCallback ~= nil)))
        local c, changed, noua = 0, 0, 0
        for _, f in paged:EnumerateFrames() do
            local okV, valid = pcall(function() return f.HasValidData and f:HasValidData() end)
            if okV and valid and f.spellBookItemInfo then
                c = c + 1
                local id = f.spellBookItemInfo.spellID
                local ua = id and ns.spells and ns.spells[tonumber(id)]
                local fs = (f.TextContainer and f.TextContainer.Name) or f.Name
                if not ua then noua = noua + 1
                elseif fs and fs.GetText then
                    local cur = ns.SafeText(fs:GetText())
                    if cur and not ns.HasCyrillic(cur) and ua ~= cur then
                        fs:SetText(ua); if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
                        changed = changed + 1
                    end
                end
            end
        end
        ns.Print(("валідних=%d | ПЕРЕКЛАВ ЗАРАЗ=%d | без UA в базі=%d"):format(c, changed, noua))
        ns.Print("Дивись у книгу: якщо стало українською — питання лише в тригері.")
    elseif not ns.PUBLIC and arg == "barks" then
        -- Діагностика барків: яка ПОДІЯ (чи бабл без події) кидає репліку напарника.
        -- Логує мовленнєві події + новий текст чат-баблів. Повтор — вимкнути.
        if ns._barkDiag then
            ns._barkDiag:UnregisterAllEvents()
            if ns._barkTicker then ns._barkTicker:Cancel(); ns._barkTicker = nil end
            ns._barkDiag = nil
            ns.Print("Діагностика барків: ВИМКНЕНО.")
        else
            local f = CreateFrame("Frame"); ns._barkDiag = f
            local EVENTS = {
                "CHAT_MSG_MONSTER_SAY","CHAT_MSG_MONSTER_YELL","CHAT_MSG_MONSTER_EMOTE",
                "CHAT_MSG_MONSTER_WHISPER","CHAT_MSG_MONSTER_PARTY","CHAT_MSG_RAID_BOSS_EMOTE",
                "CHAT_MSG_RAID_BOSS_WHISPER","CHAT_MSG_SAY","CHAT_MSG_YELL","CHAT_MSG_PARTY",
                "CHAT_MSG_PARTY_LEADER","SHOW_SUBTITLE","UNIT_SPELLCAST_SUCCEEDED",
            }
            for _, e in ipairs(EVENTS) do pcall(f.RegisterEvent, f, e) end
            f:SetScript("OnEvent", function(_, ev, a1, a2)
                local msg = ns.SafeText(a1)
                if msg and #tostring(msg) > 3 then
                    ns.Print(("|cff00ff00%s|r | %s | %s"):format(ev, tostring(ns.SafeText(a2) or "?"), tostring(msg):sub(1, 60)))
                end
            end)
            local seen = {}
            ns._barkTicker = C_Timer.NewTicker(0.3, function()
                if not (C_ChatBubbles and C_ChatBubbles.GetAllChatBubbles) then return end
                for _, b in ipairs(C_ChatBubbles.GetAllChatBubbles() or {}) do
                    local function scan(fr, d)
                        if not fr or d > 4 then return end
                        if fr.GetRegions then for _, rg in ipairs(ns.Regions(fr)) do
                            if rg.IsObjectType and rg:IsObjectType("FontString") and rg.GetText then
                                local t = ns.SafeText(rg:GetText())
                                if t and #t > 3 and not seen[t] then
                                    seen[t] = true
                                    ns.Print(("|cffffff00BUBBLE(без події?)|r | %s"):format(t:sub(1, 60)))
                                end
                            end
                        end end
                        if fr.GetChildren then for _, c in ipairs(ns.Children(fr)) do scan(c, d + 1) end end
                    end
                    pcall(scan, b, 0)
                end
            end)
            ns.Print("Діагностика барків: УВІМКНЕНО. Зайди в делв/фоловер-підземелля, дочекайся барка «Henry…» — рядок покаже ПОДІЮ (зелене) або BUBBLE(без події). Повтори /uall barks, щоб вимкнути.")
        end
    elseif not ns.PUBLIC and arg == "clear" then
        local db = ns.GetCaptureDB()
        db.quests = {}
        db.errors = nil; db.diag = nil; db.uierr = nil -- скинути журнали для чистої перевірки
        db.ejdebug = nil; db.ejdebugN = nil; db.ejtext = nil -- діагностика журналу
        db.ejloot = nil; db.ejlootN = nil; db.ejhdr = nil
        ns.Print("Зібрані тексти й журнали (errors/diag/ej) очищено.")
    else
        ns.Print(("Команди: %s stats — статистика, %s options — що перекладати, %s clear — очистити зібране."):format(
            slashCommand, slashCommand, slashCommand))
    end
end

-- ЗБИРАЧ ПОМИЛОК/TAINT — лише dev/тестерська. У публічній НЕ перехоплюємо
-- глобальний обробник помилок і НЕ слухаємо ADDON_ACTION_* (щоб не конфліктувати
-- з BugSack/іншими та не збирати нічого на диск).
if not ns.PUBLIC then
-- Кожна Lua-помилка з нашого аддона автоматично пишеться в діагностичний
-- лог (SavedVariables) — її можна прочитати з диска без скріншотів.
-- Чужі помилки передаємо стандартному обробнику без змін.
local origHandler = geterrorhandler()
local errorsLogged = 0
seterrorhandler(function(err)
    pcall(function()
        -- Логуємо БУДЬ-ЯКУ помилку (не лише з нашим іменем у тексті): крах
        -- у делві міг блеймити Blizzard-файл через taint, але причина — ми.
        -- АЛЕ позначаємо походження: якщо в тексті немає «WoWUkraine» — це
        -- найімовірніше ЧУЖИЙ аддон/Blizzard (наш taint гра підписує нашим
        -- іменем). Префікс «[?]» рятує від хибних діагнозів (як було з
        -- SetCooldown — він не наш, а ми гналися за привидом у шрифтах).
        if errorsLogged < ERR_KEEP then
            errorsLogged = errorsLogged + 1
            local s = tostring(err)
            ns.LogError((ns.IsOurError(s) and "" or "[?чужа] ") .. s:sub(1, 400))
        end
    end)
    if origHandler then return origHandler(err) end
end)

-- ДЕТЕКТОР TAINT: попап «вимкнути аддони / кнопки не тиснуться» = НЕ Lua-помилка
-- (seterrorhandler його НЕ ловить, тому лог порожній), а ADDON_ACTION_BLOCKED/
-- FORBIDDEN — аддон зачепив захищену/заборонену дію. Логуємо ІМ'Я аддона +
-- функцію: якщо винні МИ (WoWUkraine), у db.errors буде точна назва дії — і
-- видно, що саме виправляти, без здогадок.
local taintWatch = CreateFrame("Frame")
taintWatch:RegisterEvent("ADDON_ACTION_BLOCKED")
taintWatch:RegisterEvent("ADDON_ACTION_FORBIDDEN")
taintWatch:SetScript("OnEvent", function(_, event, addon, func)
    pcall(function()
        local mark = ns.IsOurError(tostring(addon)) and "‼НАШ" or "[?чужа]"
        ns.LogError(("%s %s: %s -> %s"):format(mark, event,
            tostring(addon), tostring(func)))
    end)
end)
end -- if not ns.PUBLIC (збирач помилок/taint)

-- ЄДИНИЙ обробник Shift «показати оригінал» для ВСЬОГО аддона (раніше було 6
-- розрізнених у модулях). Логіка проста й element-agnostic: тимчасово прибрати
-- НАШУ кирилицю (ns.ToggleOriginal свопає весь реєстр підмін) і показати оригінал.
local modWatcher = CreateFrame("Frame")
modWatcher:RegisterEvent("MODIFIER_STATE_CHANGED")
modWatcher:SetScript("OnEvent", function(_, _, key)
    local chosen = ns.GetSetting and ns.GetSetting("originalKey")
    if not chosen or chosen == "NONE" then return end
    -- key приходить як LSHIFT/RSHIFT/LCTRL/... — звіряємо за входженням.
    if not key:find(chosen, 1, true) then return end
    -- ВІДКЛАДАЄМО на наступний кадр: Shift — модифікатор ЗАХИЩЕНИХ дій
    -- (лут/клік/каст). Синхронна UI-робота тут заражала їх ("Interface action
    -- failed because of an AddOn"). C_Timer.After(0) виносить роботу в чистий
    -- кадр, поза стеком захищеної дії — taint не поширюється.
    -- ОДИН своп усіх наших підмін (моби/предмети/квести/діалоги/…). Цього
    -- ДОСТАТНЬО: усі переклади зареєстровані в ns.replacements.
    -- НЕ перевикликаємо OnEnter власника тултіпа: для ЗАХИЩЕНИХ фреймів (кнопки
    -- дій) виклик їхнього OnEnter з нашого коду ЗАРАЖАЄ їх — звідси «кнопки не
    -- тиснуться» і попап «вимкнути аддони». Своп тексту цього не робить.
    C_Timer.After(0, ns.ToggleOriginal)
end)

-- LoadOnDemand: великі необов'язкові бази вантажимо ЛИШЕ коли потрібні (економія RAM).
-- Предмети (UALL_Items) — лише коли увімкнено будь-яку опцію items.*.
-- Перемикання опції ON застосується на наступний /reload (тоді й вантажиться).
function ns.LoadItemsIfNeeded()
    if not (C_AddOns and C_AddOns.LoadAddOn) then return end
    if ns.items and next(ns.items) then return end -- уже завантажено
    if ns.IsEnabled("items.name") or ns.IsEnabled("items.flavor")
       or ns.IsEnabled("items.effects") or ns.IsEnabled("items.statsSlots") then
        pcall(C_AddOns.LoadAddOn, "UALL_Items")
    end
end

-- Імена NPC (UALL_NpcNames) — лише коли увімкнено world.npcNames (типово ВИМК,
-- тож для більшості гравців ця база (~1.4M) взагалі не вантажиться).
function ns.LoadNpcNamesIfNeeded()
    if not (C_AddOns and C_AddOns.LoadAddOn) then return end
    if ns.npcNames and next(ns.npcNames) then return end
    if ns.IsEnabled("world.npcNames") then
        pcall(C_AddOns.LoadAddOn, "UALL_NpcNames")
        -- Якщо опція ввімкнена, а база так і не завантажилась — під-аддон вимкнено
        -- у списку або щойно доданий (новий аддон реєструється лише після ПОВНОГО
        -- перезапуску гри). Підкажемо гравцеві ОДИН раз, щоб не гадав, чому імена англ.
        if not (ns.npcNames and next(ns.npcNames)) and not ns._npcNamesWarned then
            ns._npcNamesWarned = true
            ns.Print("|cffff6060Імена NPC увімкнено, але базу «UALL (Імена NPC)» "
                .. "не завантажено. Увімкни її у списку аддонів і ПЕРЕЗАЙДИ в гру "
                .. "(новий аддон реєструється лише після повного перезапуску, не /reload).|r")
        end
    end
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(self, event, name)
    if name ~= ADDON_NAME then return end
    ns.GetCaptureDB()
    ns.LoadItemsIfNeeded()    -- предмети-LoD за опцією
    ns.LoadNpcNamesIfNeeded() -- імена NPC-LoD за опцією (Journal — при відкритті EJ)
    -- (Прибрано вітальний рядок у чат при кожному вході — зайвий шум.
    -- Статистика доступна за «/uall stats», версія — у вітальному вікні.)
    ns.Diag(("завантаження: v%s | квестів у базі %d | enabled=%s"):format(
        ns.version, CountKeys(ns.quests), tostring(ns.IsEnabled("enabled"))))
    self:UnregisterEvent("ADDON_LOADED")
end)
