-- WoWUkraine: переклад ЛУТ-повідомлень у чаті (здобич/гроші).
-- Механізм — ChatFrame_AddMessageEventFilter (display-only підміна рядка ПЕРЕД
-- показом), той самий, що BroadcastHooks → secure-фреймів не чіпає, БЕЗ тейнту.
-- Гейт: «Предмети → Назви предметів» (items.name) — лут це переважно предмети.
-- Покриває лише ВЛАСНІ лут/гроші (CHAT_MSG_LOOT/MONEY).

local _, ns = ...

-- Системні лут-фрази (літеральна підстановка; без магічних символів патерна).
local PHRASES = {
    ["You receive loot:"] = "Отримано здобич:",
    ["You receive item:"] = "Отримано предмет:",
    ["You create:"] = "Створено:",
    ["You won:"] = "Виграно:",
    ["Received item:"] = "Отримано предмет:",
    ["You loot"] = "Здобуто", -- «You loot N Gold…» (CHAT_MSG_MONEY)
}
-- Грошові одиниці — лише у CHAT_MSG_MONEY (щоб не чіпати назви предметів у луті).
local MONEY = { ["Gold"] = "золота", ["Silver"] = "срібла", ["Copper"] = "міді" }

-- Shift «показати оригінал» діє на НОВІ рядки чату (вже надруковані — заморожені,
-- історію не перефільтрувати; це нормально для чату).
local function active()
    return ns.IsEnabled and ns.IsEnabled("chat") and ns.IsEnabled("items.name")
        and not (ns.ShowOriginal and ns.ShowOriginal())
end

-- Підмінити назву предмета в лінку |Hitem:ID:…|h[Name]|h на нашу (ns.items[ID]).
local function trLinks(msg)
    if not ns.items then return msg end
    return (msg:gsub("(|Hitem:(%d+):.-|h)%[(.-)%]|h", function(pre, id, name)
        local e = ns.items[tonumber(id)]
        -- ns.items[ID] може бути РЯДКОМ (лише назва) АБО ТАБЛИЦЕЮ {name=,fen=,…}
        -- для предметів із флейвором/ефектами (канон як ItemHooks: entry.name or entry).
        local ua = type(e) == "table" and e.name or e
        if type(ua) == "string" and ua ~= name then
            return pre .. "[" .. ua .. "]|h"
        end
    end))
end

local function trPhrases(msg)
    for en, ua in pairs(PHRASES) do
        msg = msg:gsub(en, ua)
    end
    return msg
end

local function LootFilter(_, _, msg, ...)
    if not active() or type(msg) ~= "string" then return false end
    local nm = trPhrases(trLinks(msg))
    if nm ~= msg then return false, nm, ... end
    return false
end

local function MoneyFilter(_, _, msg, ...)
    if not active() or type(msg) ~= "string" then return false end
    -- ГРОШОВИЙ рядок? (має «N Gold/Silver/Copper»). Потрібно, бо цей фільтр висить
    -- і на CHAT_MSG_SYSTEM (винагорода квесту «Received N Gold…» іде туди, не в MONEY),
    -- а там не можна чіпати інші системні рядки (напр. «Received a friend request»).
    local isMoney = msg:find("%d Gold") or msg:find("%d Silver") or msg:find("%d Copper")
    local nm = trPhrases(msg)
    if isMoney then
        nm = nm:gsub("Received ", "Отримано ") -- винагорода квесту «Received N Gold…»
        for en, ua in pairs(MONEY) do
            nm = nm:gsub("(%d) " .. en, "%1 " .. ua) -- «2 Gold» → «2 золота»
        end
    end
    if nm ~= msg then return false, nm, ... end
    return false
end

-- Валюта: «You receive currency: |Hcurrency:ID:…|h[Name]|h». Окремий гейт «currency»
-- (не items.name), назва з ns.currencies[ID].name.
local function activeCur()
    return ns.IsEnabled and ns.IsEnabled("chat") and ns.IsEnabled("currency")
        and not (ns.ShowOriginal and ns.ShowOriginal())
end
local function CurrencyFilter(_, _, msg, ...)
    if not activeCur() or type(msg) ~= "string" then return false end
    local nm = msg:gsub("You receive currency:", "Отримано валюту:")
    if ns.currencies then
        nm = nm:gsub("(|Hcurrency:(%d+):.-|h)%[(.-)%]|h", function(pre, id, name)
            local e = ns.currencies[tonumber(id)]
            local ua = e and e.name
            if type(ua) == "string" and ua ~= name then
                return pre .. "[" .. ua .. "]|h"
            end
        end)
    end
    if nm ~= msg then return false, nm, ... end
    return false
end

-- === Текстові емоції (CHAT_MSG_TEXT_EMOTE) ===
-- ns.emotes = { ["%s agrees with %s."] = "%s погоджується з %s.", … }
-- Сервер уже підставив імена у %s. Матчимо вхідний рядок за шаблоном,
-- виймаємо імена, вставляємо у UA-шаблон. БЕЗ тейнту (display-only фільтр).
local emoteExact, emotePatterns  -- зібрані ліниво з ns.emotes

local function escapePat(s)
    return (s:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1"))
end

-- Збирач шаблонів «%s …» -> (точні, патерни). Був прибитий до ns.emotes;
-- системний чат влаштований так само («%s joins the party.»), тож механізм
-- узагальнено, а не продубльовано.
local function buildTable(src, exact, patterns)
    for en, ua in pairs(src) do
        local _, n = en:gsub("%%s", "")
        if n == 0 then
            exact[en] = ua
        else
            local segs = {}
            local marked = en:gsub("%%s", "\1")
            for seg in (marked .. "\1"):gmatch("(.-)\1") do
                segs[#segs + 1] = escapePat(seg)
            end
            patterns[#patterns + 1] =
                { pat = "^" .. table.concat(segs, "(.+)") .. "$", ua = ua, n = n, lit = #en - 2 * n }
        end
    end
    -- специфічніші перші: довший ЛІТЕРАЛ-якір (щоб «%s …with you.» випередив
    -- генерик «%s …with %s.»), за рівних — менше %s
    table.sort(patterns, function(a, b)
        if a.lit ~= b.lit then return a.lit > b.lit end
        return a.n < b.n
    end)
    return true
end

-- Віддаємо механізм назовні: у broadcast теж є ключі-шаблони «%s …»
-- (повідомлення іграшок приходять на CHAT_MSG_MONSTER_EMOTE), а свій
-- зіставляч там був би тим самим кодом удруге.
ns.BuildPatternTable = buildTable

local function trBy(msg, exact, patterns)
    local ex = exact[msg]
    if ex then return ex end
    for _, p in ipairs(patterns) do
        local caps = { msg:match(p.pat) }
        if caps[1] ~= nil then
            local i = 0
            -- Захоплене (ім'я гравця, лінк предмета, число) вставляємо НАЗАД
            -- без жодної зміни: перекладається лише саме речення
            -- [[player-name-leak-gate]].
            return (p.ua:gsub("%%s", function() i = i + 1; return caps[i] or "" end))
        end
    end
    return nil
end

ns.MatchByPattern = trBy

local function buildEmotes()
    if emoteExact then return true end
    if not ns.emotes then return false end
    emoteExact, emotePatterns = {}, {}
    return buildTable(ns.emotes, emoteExact, emotePatterns)
end

local function trEmote(msg)
    return trBy(msg, emoteExact, emotePatterns)
end

-- === Системний чат (CHAT_MSG_SYSTEM) ===
-- ns.system = { ["%s joins the party."] = "%s приєднується до групи.", … }
-- Ті самі рядки, але зі змінною частиною: ім'я гравця, лінк предмета, число.
-- Саме тому вони НЕ можуть бути звичайними ключами бази — на кожного гравця
-- і кожне число був би окремий рядок. Перекладаємо ШАБЛОН, а підставлене
-- гра лишає своїм.
local sysExact, sysPatterns
local function buildSystem()
    if sysExact then return true end
    if not ns.system then return false end
    sysExact, sysPatterns = {}, {}
    return buildTable(ns.system, sysExact, sysPatterns)
end

local function SystemFilter(_, _, msg, ...)
    if type(msg) ~= "string" then return false end
    if not (ns.IsEnabled and ns.IsEnabled("chat")) then return false end
    if ns.ShowOriginal and ns.ShowOriginal() then return false end
    if not buildSystem() then return false end
    local ok, nm = pcall(trBy, msg, sysExact, sysPatterns)
    if ok and nm and nm ~= msg then return false, nm, ... end
    return false
end

local function EmoteFilter(_, _, msg, ...)
    if type(msg) ~= "string" then return false end
    if not (ns.IsEnabled and ns.IsEnabled("chat")) then return false end
    if ns.ShowOriginal and ns.ShowOriginal() then return false end
    if not buildEmotes() then return false end
    local ok, nm = pcall(trEmote, msg)  -- броня: будь-яка несподівана помилка не флудить
    if ok and nm and nm ~= msg then return false, nm, ... end
    return false
end

pcall(ChatFrame_AddMessageEventFilter, "CHAT_MSG_LOOT", LootFilter)
pcall(ChatFrame_AddMessageEventFilter, "CHAT_MSG_MONEY", MoneyFilter)
-- винагорода квесту «Received N Gold…» іде в CHAT_MSG_SYSTEM, не в MONEY
pcall(ChatFrame_AddMessageEventFilter, "CHAT_MSG_SYSTEM", MoneyFilter)
pcall(ChatFrame_AddMessageEventFilter, "CHAT_MSG_CURRENCY", CurrencyFilter)
pcall(ChatFrame_AddMessageEventFilter, "CHAT_MSG_TEXT_EMOTE", EmoteFilter)
-- Реєструємо ПІСЛЯ MoneyFilter: грошовий рядок він уже опрацював, а решту
-- системних повідомлень («%s joins the party.») забирає SystemFilter.
pcall(ChatFrame_AddMessageEventFilter, "CHAT_MSG_SYSTEM", SystemFilter)
