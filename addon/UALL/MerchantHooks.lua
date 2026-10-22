-- UALL: назви предметів у вікні ТОРГОВЦЯ (слоти MerchantItem<N>Name) + викуп (Buyback).
-- Перемикач «Предмети → Назви у вікні торговця» (items.merchant). Показуємо українську
-- назву з ns.items[itemID] (LoD-база предметів); Shift повертає оригінал (ns.Remember).
-- Тейнт-безпечно: лише видимий SetText на звичайних FontString-ах вікна торговця,
-- синхронно ПІСЛЯ того, як Blizzard сам виставив текст (hooksecurefunc/події).
local _, ns = ...

local function Active()
    return ns.IsEnabled and ns.IsEnabled("items.merchant")
        and not (ns.ShowOriginal and ns.ShowOriginal())
        and ns.items ~= nil -- LoD-база предметів завантажена (опції items.*)
end

local function UAName(itemID)
    local e = itemID and ns.items and ns.items[itemID]
    if not e then return nil end
    return type(e) == "table" and e.name or e
end

local function ItemIDAt(index, buybackSlot)
    if buybackSlot then
        local link = GetBuybackItemLink and GetBuybackItemLink(buybackSlot)
        return link and tonumber(link:match("item:(%d+)"))
    end
    if GetMerchantItemID then
        local ok, id = pcall(GetMerchantItemID, index)
        if ok and id then return id end
    end
    if GetMerchantItemLink then
        local ok, link = pcall(GetMerchantItemLink, index)
        if ok and link then return tonumber(link:match("item:(%d+)")) end
    end
    return nil
end

local busy = false
local function Paint()
    if busy or not Active() then return end
    local mf = _G.MerchantFrame
    if not (mf and mf.IsShown and mf:IsShown()) then return end
    if mf.IsForbidden and mf:IsForbidden() then return end
    local perPage = _G.MERCHANT_ITEMS_PER_PAGE or 10
    local page = mf.page or 1
    local buyback = mf.selectedTab == 2
    busy = true
    for i = 1, perPage + 2 do -- +2: запас, якщо шаблон дасть більше слотів
        local fs = _G["MerchantItem" .. i .. "Name"]
        if fs and fs.GetText then
            local en = ns.SafeText and ns.SafeText(fs:GetText())
            if en and en ~= "" and not (ns.HasCyrillic and ns.HasCyrillic(en)) then
                local itemID = buyback and ItemIDAt(nil, i)
                    or ItemIDAt((page - 1) * perPage + i)
                local ua = UAName(itemID)
                if ua and ua ~= en then
                    if ns.Remember then ns.Remember(fs, en, ua, nil, "items.merchant") end
                    fs:SetText(ua)
                    if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
                end
            end
        end
    end
    busy = false
end

-- Blizzard перезаповнює слоти в MerchantFrame_Update (сторінки/вкладки/оновлення
-- товару) — хук після нього синхронний і надійний. Події — страховка (лінива
-- ініціалізація, серверні оновлення асортименту).
if type(MerchantFrame_Update) == "function" then
    hooksecurefunc("MerchantFrame_Update", Paint)
end
local ev = CreateFrame("Frame")
ev:RegisterEvent("MERCHANT_SHOW")
ev:RegisterEvent("MERCHANT_UPDATE")
ev:SetScript("OnEvent", function()
    Paint()
    if C_Timer and C_Timer.After then C_Timer.After(0.2, Paint) end
end)
