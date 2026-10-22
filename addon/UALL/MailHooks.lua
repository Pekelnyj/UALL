-- WoWUkraine: переклад поштових листів (поштова скринька / Open Mail).
-- Текст листів від NPC і системи — СЕРВЕРНИЙ (немає у відкритих базах Blizzard,
-- як балачки/делви), тож збираємо в грі (db.mail) і підставляємо переклад з
-- ns.mail (тема/тіло) та ns.npcNames (відправник). Display-only (лише SetText
-- видимих FontString) → без taint, як у BookHooks.
--
-- ⚠️ ЛИСТИ ГРАВЦІВ не чіпаємо: збір гейтиться MailKind()=="npc" (canReply=false),
-- а підміна й так працює лише на ТОЧНОМУ збігу зі словником — особисте листування
-- гравців у словник не потрапляє, тож лишається недоторканим.

local _, ns = ...
ns.mail = ns.mail or {} -- щоб працювало, навіть якщо Mail.lua ще порожній

local busy = false

local function notify(msg)
    if ns.GetSetting and ns.GetSetting("capture.notify") and ns.Print then ns.Print(msg) end
end

-- Тип відкритого листа за даними інбоксу:
--   "player"  — можна відповісти (особистий лист гравця) → НЕ збираємо, не чіпаємо;
--   "invoice" — рахунок аукціону (динамічний текст щоразу інший) → НЕ збираємо;
--   "npc"     — NPC/системний (відповісти не можна) → збираємо й перекладаємо.
local function MailKind()
    local ok, canReply, isInvoice = pcall(function()
        local idx = InboxFrame and InboxFrame.openMailID
        if not idx then return end
        local _, _, _, _, _, _, _, _, _, _, _, cr = GetInboxHeaderInfo(idx)
        local _, _, _, inv = GetInboxText(idx)
        return cr, inv
    end)
    if ok then
        if isInvoice then return "invoice" end
        if canReply == true then return "player" end
        if canReply == false then return "npc" end
    end
    -- фолбек: вимкнена кнопка «Відповісти» = NPC/системна пошта
    local btn = _G.OpenMailReplyButton
    if btn and btn.IsEnabled and not btn:IsEnabled() then return "npc" end
    return nil -- не певні → не збираємо (приватність)
end

-- Ключ пошуку: гра дає переноси як \r\n, база згенерована з \n (генератор зрізає \r).
local function NormKey(text)
    local raw = ns.SafeText and ns.SafeText(text) or text
    if not raw or raw == "" then return nil end
    return (raw:gsub("\r", ""))
end

-- Підміна одного напису. kind: "body" / "subject" / "sender".
local function Translate(self, kind, text)
    if busy then return end
    local en = NormKey(text)
    if not en then return end
    -- знайти переклад (відправник — спершу через канонічні імена NPC)
    local ua
    if kind == "sender" then
        ua = (ns.npcNames and ns.npcNames[en]) or ns.mail[en]
    else
        ua = ns.mail[en]
    end
    -- ЗБІР неперекладеного (працює завжди, як у книг) — лише NPC/системна пошта
    if not ua and ns.GetCaptureDB and en:find("%a")
       and not (ns.HasCyrillic and ns.HasCyrillic(en)) and MailKind() == "npc" then
        local db = ns.GetCaptureDB()
        db.mail = db.mail or {}
        local bucket = (kind == "subject" and "subjects")
            or (kind == "sender" and "senders") or "bodies"
        db.mail[bucket] = db.mail[bucket] or {}
        if not db.mail[bucket][en] then
            db.mail[bucket][en] = true
            if kind == "body" then notify("Зібрано поштовий лист.") end
        end
    end
    -- ПІДМІНА (гейт опції + Shift-оригінал)
    if ua and ua ~= en and ns.IsEnabled and ns.IsEnabled("mail")
       and not (ns.ShowOriginal and ns.ShowOriginal()) then
        busy = true
        if ns.Remember then ns.Remember(self, en, ua, true, "mail") end -- solo: не пул
        self:SetText(ua)
        busy = false
    end
end

-- Пін SetText конкретного FontString (один раз). Текст, який ставить Blizzard,
-- приходить аргументом — це англ. оригінал (як у BookHooks).
local pinned = {}
local function Pin(fs, kind)
    if not fs or pinned[fs] or type(fs.SetText) ~= "function" then return end
    pinned[fs] = true
    hooksecurefunc(fs, "SetText", function(self, text) pcall(Translate, self, kind, text) end)
    if fs.GetText then pcall(Translate, fs, kind, fs:GetText()) end -- поточний текст
end

local FS = {
    { "OpenMailBodyText", "body" },
    { "OpenMailSubject", "subject" },
    { "OpenMailSender", "sender" },
}

local function HookMail()
    for _, e in ipairs(FS) do Pin(_G[e[1]], e[2]) end
end

HookMail() -- якщо фрейми вже існують на момент завантаження

-- Пошта — LoadOnDemand-частина інтерфейсу; фрейми зʼявляються при першому відкритті.
-- На MAIL_SHOW/оновлення інбоксу пінимо (якщо ще ні) і перекладаємо поточні написи:
-- Blizzard міг поставити текст ще до нашого піна.
local f = CreateFrame("Frame")
f:RegisterEvent("MAIL_SHOW")
f:RegisterEvent("MAIL_INBOX_UPDATE")
f:SetScript("OnEvent", function()
    HookMail()
    local function run()
        for _, e in ipairs(FS) do
            local fs = _G[e[1]]
            if fs and fs.GetText then pcall(Translate, fs, e[2], fs:GetText()) end
        end
    end
    if C_Timer and C_Timer.After then C_Timer.After(0, run) else run() end
end)
