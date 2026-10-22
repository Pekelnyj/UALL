-- WoWUkraine: переклад реплік/субтитрів (BroadcastText) у грі.
-- Перемикач: «Діалоги NPC → Субтитри і talking heads» (subtitles).
--
-- Покриває:
--   1. Talking heads (портрет + текстова рамка внизу екрана).
--   2. Репліки монстрів/NPC у чаті (say/yell/emote/whisper).
--   3. Бабли над головами (best-effort).
-- База: ns.broadcast = { [англійський текст] = українська }.

local _, ns = ...

-- Ім'я ГРАВЦЯ в субтитрах. Захоплення зберігає літеральне ім'я («Pekelnyj»),
-- але база ключується узагальнено через {NAME} — інакше рядок не зматчиться в
-- інших гравців. Тож перед пошуком міняємо ім'я гравця -> {NAME} (NormName),
-- а в перекладі назад {NAME} -> ім'я гравця (LocName).
local PLAYER
local function P()
    if PLAYER == nil then PLAYER = UnitName("player") or false end
    return PLAYER or nil
end
local function esc(s) return (s:gsub("(%W)", "%%%1")) end  -- екранувати магічні символи патерна
local function NormName(t)
    local p = P()
    if p and t and t:find(p, 1, true) then return (t:gsub(esc(p), "{NAME}")) end
    return t
end
local function LocName(t)
    if t and t:find("{NAME}", 1, true) then
        local p = P()
        if p then return (t:gsub("{NAME}", function() return p end)) end
    end
    return t
end
-- Апостроф: гра може слати «кучерявий» ’ (U+2019) або прямий ' (U+0027), а наші
-- ключі зведено до прямого. Зводимо вхідний текст до прямого, щоб збіг не залежав
-- від варіанта (інакше барки з апострофом лишались англ.). \226\128\153 = ’ у UTF-8.
local function AposNorm(t)
    return (t:gsub("\226\128\153", "'"):gsub("\226\128\152", "'"):gsub("\202\188", "'"))
end

-- ШАБЛОНИ «%s …». Частина реплік приходить із підставленим ім'ям гравця
-- («X sets out a Transmorpher Beacon!» на CHAT_MSG_MONSTER_EMOTE). Точним
-- ключем це не покрити: на кожного гравця був би окремий рядок, і в базі
-- справді осіли десятки таких — з чужими ніками всередині.
-- Тут {NAME} НЕ годиться: хук розгортає його в ім'я ЧИТАЧА, а іграшку вжив
-- хтось інший. Годиться лише %s — ns.MatchByPattern вставляє захоплене
-- назад без змін, тобто перекладає речення й не чіпає ім'я
-- [[player-name-leak-gate]].
-- Механізм спільний із ChatHooks; той файл вантажиться ПІЗНІШЕ, тому
-- звертаємось до нього ліниво, уже в рантаймі.
local bcPatterns
local EMPTY = {}
local function BuildPatterns()
    if bcPatterns then return #bcPatterns > 0 end
    bcPatterns = {}
    if not ns.broadcast or not ns.BuildPatternTable then
        bcPatterns = nil          -- ChatHooks ще не завантажився: спробуємо згодом
        return false
    end
    local src = {}
    for en, ua in pairs(ns.broadcast) do
        if en:find("%%s") then src[en] = ua end
    end
    ns.BuildPatternTable(src, EMPTY, bcPatterns)   -- exact порожній: ns.broadcast і є точна таблиця
    return #bcPatterns > 0
end

-- Пошук перекладу: точний → апостроф-нормалізований → за {NAME}-ключем (з обома
-- варіантами апострофа) → за %s-шаблоном.
-- Результат локалізуємо (підставляємо ім'я гравця назад).
local function Lookup(text)
    if not ns.broadcast or not text then return nil end
    local ua = ns.broadcast[text]
    if ua == nil then
        local an = AposNorm(text)
        if an ~= text then ua = ns.broadcast[an] end
    end
    if ua == nil then
        local nm = NormName(text)
        if nm ~= text then ua = ns.broadcast[nm] or ns.broadcast[AposNorm(nm)] end
    end
    if ua == nil and BuildPatterns() then
        -- на СИРОМУ тексті: у шаблоні ім'я має лишитися таким, як його дала гра
        local ok, m = pcall(ns.MatchByPattern, text, EMPTY, bcPatterns)
        if ok then ua = m end
    end
    if not ua then return nil end
    ua = LocName(ua)
    -- СТАТЬ ГРАВЦЯ: розгортаємо $p(чол:жін) у репліках/субтитрах (раніше не робилось —
    -- токен світився сирим у чаті: «ти $p(дозволив:дозволила)»). Покриває всіх викликачів
    -- Lookup (чат-фільтр, система, субтитри, чат-баблки). [[player-gender-token]]
    if ns.ApplyPlayerGender then ua = ns.ApplyPlayerGender(ua) end
    return ua
end
ns.BroadcastLookup = Lookup

local function Tr(text)
    text = ns.SafeText(text)
    if not text then return nil end
    if not ns.IsEnabled("subtitles") or ns.ShowOriginal() then return nil end
    return Lookup(text)
end

-- ЗБІР неперекладених субтитрів: репліки монстрів/босів, яких немає в базі,
-- записуємо в CaptureDB.broadcast (як spellCapture/objLines). Збираємо
-- НЕЗАЛЕЖНО від перемикача «субтитри» — щоб база росла, поки гравець грає.
-- Потім парсимо, перекладаємо, доливаємо в ns.broadcast.
-- Зберігаємо ще й МОВЦЯ (ім'я NPC): для субтитрів англійська не маркує рід,
-- а de/fr субтитрів немає — тож мовець потрібен, щоб перекладач визначив рід
-- («Arator did» -> «зробив», не «зробила»). Значення = ім'я мовця (або true).
-- Сповіщення в чаті про новий зібраний діалог — лише якщо увімкнено «capture.notify»
-- (Налаштування → Збір текстів). Той самий перемикач, що для мобів/квестів/книг.
local bcCapN = 0
local function notify(msg)
    if ns.GetSetting and ns.GetSetting("capture.notify") and ns.Print then ns.Print(msg) end
end

local function CaptureBroadcast(text, speaker)
    text = ns.SafeText(text)
    if not text or text == "" then return end
    if Lookup(text) then return end -- уже в базі (зокрема за {NAME}-ключем)
    if not ns.GetCaptureDB then return end
    pcall(function()
        local db = ns.GetCaptureDB()
        db.broadcast = db.broadcast or {}
        if db.broadcast[text] == nil then
            db.broadcast[text] = ns.SafeText(speaker) or true
            bcCapN = bcCapN + 1
            -- збираємо лише неперекладені (англ.) репліки → текст ASCII, sub безпечний
            local who = ns.SafeText(speaker)
            local short = #text > 50 and (text:sub(1, 50) .. "…") or text
            notify(("Зібрано новий діалог #%d%s: «%s»"):format(
                bcCapN, who and (" — " .. who) or "", short))
        end
    end)
end

-- 1) РЕПЛІКИ В ЧАТІ: фільтр повідомлень підміняє текст до показу.
local CHAT_EVENTS = {
    "CHAT_MSG_MONSTER_SAY", "CHAT_MSG_MONSTER_YELL",
    "CHAT_MSG_MONSTER_EMOTE", "CHAT_MSG_MONSTER_WHISPER",
    "CHAT_MSG_MONSTER_PARTY", "CHAT_MSG_RAID_BOSS_EMOTE",
    "CHAT_MSG_RAID_BOSS_WHISPER",
}
local function ChatFilter(_, _, msg, sender, ...)
    local text = ns.SafeText(msg)
    if not text then return false end
    -- Окремий перемикач: репліки NPC у чаті («Valeera says…») незалежно від
    -- луту/грошей (chat) і субтитрів-бабл (subtitles) — на прохання тестерів.
    if ns.IsEnabled("chat.npc") and not ns.ShowOriginal() then
        local ua = Lookup(text)
        if ua then return false, ua, sender, ... end -- підміна на переклад
    end
    CaptureBroadcast(text, sender) -- неперекладений субтитр + мовець -> збір (сам пропустить відоме)
    return false
end
for _, ev in ipairs(CHAT_EVENTS) do
    pcall(ChatFrame_AddMessageEventFilter, ev, ChatFilter)
end

-- 1b) СИСТЕМНІ НОТИФІКАЦІЇ (CHAT_MSG_SYSTEM): сповіщення гри в чаті, що НЕ є
-- реплікою монстра — напр. збір гліфа неба (Skyriding Glyph), PvP-попередження
-- «вартові стежать», відкриття/закриття тощо. Той самий механізм: відомий рядок
-- підміняємо з ns.broadcast, невідомий — у ОКРЕМИЙ кошик db.system (щоб не змішувати
-- з реплічними субтитрами; чистимо й перекладаємо хвилею). Шум (онлайн/офлайн,
-- кидки кубика, числа) фільтруємо: лишаємо лише рядки з достатнім текстом і без
-- цифр-плейсхолдерів — решта однаково не перекладається.
local function CaptureSystem(text)
    text = ns.SafeText(text)
    if not text or text == "" then return end
    if Lookup(text) then return end
    if not text:find("%a") or ns.HasCyrillic(text) then return end
    if not ns.GetCaptureDB then return end
    pcall(function()
        local db = ns.GetCaptureDB()
        db.system = db.system or {}
        if db.system[text] == nil then db.system[text] = true end
    end)
end

local function SystemFilter(_, _, msg, ...)
    local text = ns.SafeText(msg)
    if not text then return false end
    if ns.IsEnabled("chat") and ns.IsEnabled("subtitles") and not ns.ShowOriginal() then
        local ua = Lookup(text)
        if ua then return false, ua, ... end   -- підміна на переклад
    end
    CaptureSystem(text)
    return false
end
pcall(ChatFrame_AddMessageEventFilter, "CHAT_MSG_SYSTEM", SystemFilter)

-- 2) TALKING HEADS: після появи перекладаємо текст і ім'я мовця.
-- У Midnight структуру ЗМІНЕНО: текст тепер TalkingHeadFrame.TextFrame.Text
-- (раніше .MainFrame.TalkBox.TextFrame.Text), ім'я — TalkingHeadFrame.NameFrame.Name.
-- Пробуємо обидва шляхи (нові поля + старі як запобіжник).
local function TranslateTalkingHead()
    local th = TalkingHeadFrame
    if not th then return end
    local fs = (th.TextFrame and th.TextFrame.Text)
        or (th.MainFrame and th.MainFrame.TalkBox and th.MainFrame.TalkBox.TextFrame
            and th.MainFrame.TalkBox.TextFrame.Text)
    if fs then
        if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end -- кир. шрифт (інакше □ на ґ/і/ї/є)
        local text = ns.SafeText(fs:GetText())
        if text and not ns.HasCyrillic(text) then -- не чіпати вже перекладене
            local ua = Tr(text)
            if ua then
                local disp = ns.ApplyNames(ua)
                ns.Remember(fs, text, disp, nil, "subtitles")  -- реєструємо пару → Shift свопає ОПИС в обидва боки
                if not ns.ShowOriginal() then fs:SetText(disp) end  -- при Shift лишаємо оригінал
            else CaptureBroadcast(text) end
        end
    end
    -- ІМ'Я мовця — з ns.npcNames, лише коли ввімкнено «Імена NPC і монстрів».
    local nameFS = (th.NameFrame and th.NameFrame.Name)
        or (th.MainFrame and th.MainFrame.TalkBox and th.MainFrame.TalkBox.NameFrame
            and th.MainFrame.TalkBox.NameFrame.Name)
    if nameFS and ns.ApplyCyrFont then ns.ApplyCyrFont(nameFS) end -- кир. шрифт для імені
    if nameFS and ns.npcNames and ns.IsEnabled("world.npcNames") and not ns.ShowOriginal() then
        local nm = ns.SafeText(nameFS:GetText())
        local nua = nm and not ns.HasCyrillic(nm) and ns.npcNames[nm]
        if nua and nua ~= nm then
            local r, g, b, a = nameFS:GetTextColor()
            ns.Remember(nameFS, nm, nua, nil, "world.npcNames")
            nameFS:SetText(nua)
            if r then nameFS:SetTextColor(r, g, b, a) end
        end
    end
end

local thWatcher = CreateFrame("Frame")
thWatcher:RegisterEvent("TALKINGHEAD_REQUESTED")
thWatcher:RegisterEvent("TALKINGHEAD_CLOSE")
thWatcher:SetScript("OnEvent", function(_, event)
    if event == "TALKINGHEAD_CLOSE" then return end
    -- Текст з'являється з невеликою затримкою (анімація рамки).
    C_Timer.After(0.05, TranslateTalkingHead)
    C_Timer.After(0.3, TranslateTalkingHead)
end)
-- Якщо вікно talking head вантажиться на вимогу.
local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(_, _, name)
    if name == "Blizzard_TalkingHeadUI" and TalkingHeadFrame then
        -- PlayCurrent міг зникнути в Midnight — хукаємо лише якщо є; інакше
        -- запобіжник через OnShow (подія TALKINGHEAD_REQUESTED все одно покриває).
        if type(TalkingHeadFrame.PlayCurrent) == "function" then
            hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function()
                C_Timer.After(0.05, TranslateTalkingHead)
            end)
        else
            TalkingHeadFrame:HookScript("OnShow", function()
                C_Timer.After(0.05, TranslateTalkingHead)
            end)
        end
    end
end)

-- 3) БАБЛИ НАД ГОЛОВАМИ: бабл створює клієнт ОДРАЗУ після події монстрової
-- репліки (тих самих CHAT_MSG_MONSTER_*). Текст бабла ставиться РАЗ при
-- створенні, тож замість вічного тікера перекладаємо лише за подією —
-- кілька дрібних спроб, поки клієнт домалює бабл (як Talking Head).
-- FontString балабки лежить на РІЗНІЙ глибині залежно від патчу (Midnight додав
-- вкладеність: bubble → дитина → .String). Тож шукаємо РЕКУРСИВНО по регіонах і
-- дітях — не покладаємось на «першу дитину». Перекладаємо КОЖЕН знайдений FontString.
local function TranslateBubbleFS(frame, depth)
    if not frame or depth > 4 then return end
    if frame.GetRegions then
        for _, rg in ipairs(ns.Regions(frame)) do
            if rg.IsObjectType and rg:IsObjectType("FontString") and rg.GetText then
                local t = ns.SafeText(rg:GetText())
                if t and t ~= "" and not ns.HasCyrillic(t) then -- вже наше — пропустити
                    local ua = Tr(t)
                    if ua then
                        -- Реєструємо підміну для Shift (до 07.10.2026 її не було, і Shift на
                        -- хмарці нічого не повертав); ua — ПОКАЗАНИЙ рядок, з іменами
                        -- [[shift-toggle-needs-displayed-text]].
                        local shown = ns.ApplyNames(ua)
                        ns.Remember(rg, t, shown, nil, "subtitles")
                        rg:SetText(shown)
                        if ns.ApplyCyrFont then ns.ApplyCyrFont(rg) end
                    end
                end
            end
        end
    end
    if frame.GetChildren then
        for _, c in ipairs(ns.Children(frame)) do if not ns.IsTooltipFrame(c) then TranslateBubbleFS(c, depth + 1) end end
    end
end
local function TranslateBubbles()
    if not ns.IsEnabled("subtitles") or ns.ShowOriginal() then return end
    if not C_ChatBubbles or not C_ChatBubbles.GetAllChatBubbles then return end
    for _, bubble in ipairs(C_ChatBubbles.GetAllChatBubbles() or {}) do
        ns.Guard("репліки", TranslateBubbleFS, bubble, 0)
    end
end

local bubbleWatcher = CreateFrame("Frame")
for _, ev in ipairs(CHAT_EVENTS) do
    pcall(bubbleWatcher.RegisterEvent, bubbleWatcher, ev)
end
bubbleWatcher:SetScript("OnEvent", function()
    -- Бабл домальовується за кадр-два після репліки — кілька дрібних спроб.
    C_Timer.After(0, TranslateBubbles)
    C_Timer.After(0.15, TranslateBubbles)
    C_Timer.After(0.4, TranslateBubbles)
end)

-- 4) КІНЕМАТИК / MOVIE-СУБТИТРИ. Текст малюється у SubtitlesFrame.Subtitles (пул
-- FontString). ПОКАЗ: ПІНИМО SetText кожного FontString — коли рушій малює субтитр,
-- наш хук перекладає РЕНДЕРНИЙ текст через broadcast-базу. Надійніше за подію: не
-- залежить від таймінгу й від того, який FontString показано; ловить і ВШИТОГО мовця
-- («[Ім'я] текст» — мовець у самому рядку, бо SUBTITLE_FORMAT тут не вживається).
-- ЗБІР: подія SHOW_SUBTITLE дає чистий message+sender → db.broadcast. Без taint.
local subBusy = false
-- Ім'я мовця в титрах («Illidan:», «[Illidan]» або окремим рядком). База імен —
-- LoD UALL_NpcNames, що вантажиться лише з увімкненим world.npcNames (типово ВИМК),
-- тож без довантаження мовець ЗАВЖДИ лишався англійським. Вантажимо на вимогу —
-- разово, при першому субтитрі з непокритим ім'ям.
local npcLoadTried
local function SpeakerUA(who)
    if not who or who == "" or #who > 40 then return nil end
    if not ns.npcNames and not npcLoadTried then
        npcLoadTried = true
        local load = (C_AddOns and C_AddOns.LoadAddOn) or LoadAddOn
        if load then pcall(load, "UALL_NpcNames") end
    end
    return ns.npcNames and ns.npcNames[who] or nil
end
local function PinSubtitleFS(fs)
    if not fs or fs.__wuSub or type(fs.SetText) ~= "function" then return end
    fs.__wuSub = true
    hooksecurefunc(fs, "SetText", function(self, text)
        if subBusy then return end
        if not ns.IsEnabled("subtitles") or ns.ShowOriginal() then return end
        local t = ns.SafeText(text)
        if not t or t == "" then return end
        local ua = Lookup(t)
        if not ua then
            -- рядок = САМЕ ім'я мовця (SubtitlesFrame інколи малює його окремо)
            ua = SpeakerUA(t)
        end
        if not ua then
            -- Субтитр часто має префікс мовця: «[Мовець] репліка» (кінематики) або
            -- «Мовець: репліка». Якщо повного ключа нема — відрізаємо префікс,
            -- перекладаємо репліку, мовця беремо з npcNames; роздільник зберігаємо.
            local who, rest = t:match("^%[(.-)%]%s*(.+)$")
            local bracket = rest ~= nil
            if not rest then who, rest = t:match("^(.-):%s+(.+)$") end
            if rest then
                local ru = Lookup(rest)
                if ru then
                    local wn = SpeakerUA(who) or who
                    ua = bracket and ("[" .. wn .. "] " .. ru) or (wn .. ": " .. ru)
                end
            end
        end
        -- Додатково: якщо рядок починається з «[АнглІм'я]», а npcNames має переклад —
        -- підставити укр. ім'я мовця. Покриває комбіновані ключі, де репліка вже
        -- українська, а дужкове ім'я лишилось англ. (SubtitlesFrame малює його окремо).
        do
            local cand = ua or t
            local fixed = cand:gsub("^%[([^%]]+)%]", function(n)
                local u = SpeakerUA(n); return u and ("[" .. u .. "]") or nil
            end)
            if fixed ~= cand then ua = fixed end
        end
        if ua and ua ~= t then
            subBusy = true
            self:SetText(ns.ApplyNames and ns.ApplyNames(ua) or ua)
            subBusy = false
        end
    end)
end
local function PinAllSubtitles()
    if not (SubtitlesFrame and SubtitlesFrame.Subtitles) then return end
    for _, fs in pairs(SubtitlesFrame.Subtitles) do
        if type(fs) == "table" then PinSubtitleFS(fs) end
    end
end
PinAllSubtitles()

local function OnShowSubtitle(message, sender)
    PinAllSubtitles() -- пул FontString міг дорости
    local msg = ns.SafeText(message)
    if not msg or msg == "" then return end
    if not Lookup(msg) then CaptureBroadcast(msg, sender) end
    -- ДІАГНОСТИКА точних аргументів показу (мовець окремо чи вшитий у текст?)
    if ns.GetCaptureDB and not (ns.HasCyrillic and ns.HasCyrillic(msg)) then
        pcall(function()
            local db = ns.GetCaptureDB(); db.diag = db.diag or {}
            db.diag["sub msg=|" .. msg:sub(1, 55) .. "| sender=|" .. tostring(sender) .. "|"] = true
        end)
    end
end

local subWatcher = CreateFrame("Frame")
subWatcher:RegisterEvent("SHOW_SUBTITLE")
subWatcher:RegisterEvent("PLAYER_LOGIN")
subWatcher:RegisterEvent("CINEMATIC_START")
subWatcher:RegisterEvent("PLAY_MOVIE")
subWatcher:SetScript("OnEvent", function(_, ev, message, sender)
    if ev == "SHOW_SUBTITLE" then ns.Guard("репліки", OnShowSubtitle, message, sender) else ns.Guard("репліки", PinAllSubtitles) end
end)
