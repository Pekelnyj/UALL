-- UALL: переклад назв предметів у ВІКНІ ЛУТу (LootFrame). Назва береться за слотом:
-- GetLootSlotLink(slot) -> itemID -> ns.items[itemID].name. Матчимо FontString у кнопці
-- за EN-назвою (GetLootSlotInfo) → без сліпого тексту, без колізій. Не тейнтить (звичайні
-- FontString кнопок, не widget). LoD: ns.items — база предметів. Гейт «items.name».
local _, ns = ...

local function Enabled()
    return (not ns.IsEnabled) or ns.IsEnabled("items.name")
end

-- слот кнопки лутy (модерн ScrollBox: .slotIndex або в elementData)
local function BtnSlot(btn)
    if type(btn) ~= "table" then return nil end
    if type(btn.slotIndex) == "number" then return btn.slotIndex end
    if btn.GetElementData then
        local ok, ed = pcall(btn.GetElementData, btn)
        if ok and type(ed) == "table" then
            if type(ed.slotIndex) == "number" then return ed.slotIndex end
            if ed.GetData then
                local ok2, d = pcall(ed.GetData, ed)
                if ok2 and type(d) == "table" and type(d.slotIndex) == "number" then return d.slotIndex end
            end
        end
    end
    return nil
end

local function UAForSlot(slot)
    if type(slot) ~= "number" or not GetLootSlotLink then return nil end
    local ok, link = pcall(GetLootSlotLink, slot)
    if not ok or not link then return nil end
    local iid = C_Item and C_Item.GetItemInfoInstant and select(1, C_Item.GetItemInfoInstant(link))
    if not iid then return nil end
    local e = ns.items and ns.items[iid]
    return (type(e) == "table" and e.name) or (type(e) == "string" and e) or nil
end

-- перекласти FontString у кнопці, чий текст = EN-назва предмета цього слота
local function TrLootButton(btn)
    if not Enabled() or (ns.ShowOriginal and ns.ShowOriginal()) then return end
    local slot = BtnSlot(btn)
    if not slot then return end
    local ua = UAForSlot(slot)
    if not ua then return end
    local enName
    if GetLootSlotInfo then
        local ok, _, nm = pcall(GetLootSlotInfo, slot)
        if ok then enName = nm end
    end
    if not enName or enName == "" or enName == ua then return end
    local function fix(fs)
        if not (fs and fs.GetText and fs.SetText) then return end
        local cur = ns.SafeText and ns.SafeText(fs:GetText()) or nil
        if cur == enName then
            if ns.Remember then ns.Remember(fs, cur, ua, nil, "items.name") end
            fs:SetText(ua)
            if ns.ApplyCyrFont then ns.ApplyCyrFont(fs) end
        end
    end
    local function walk(f, d)
        if not f or d > 4 or type(f) ~= "table" then return end
        if f.GetRegions then
            for _, r in ipairs(ns.Regions(f)) do
                if r.IsObjectType and r:IsObjectType("FontString") then pcall(fix, r) end
            end
        end
        if f.GetChildren then for _, c in ipairs(ns.Children(f)) do if not ns.IsTooltipFrame(c) then walk(c, d + 1) end end end
    end
    walk(btn, 0)
end

local function RefreshLoot()
    local lf = _G.LootFrame
    local sb = lf and lf.ScrollBox
    if not (sb and Enabled()) then return end
    if sb.ForEachFrame then pcall(sb.ForEachFrame, sb, TrLootButton) end
end

local sbHooked = false
local function HookLoot()
    local lf = _G.LootFrame
    local sb = lf and lf.ScrollBox
    if sb and not sbHooked and ScrollUtil and ScrollUtil.AddInitializedFrameCallback then
        sbHooked = true
        pcall(ScrollUtil.AddInitializedFrameCallback, sb, function(frame) pcall(TrLootButton, frame) end, sb)
    end
end

local ev = CreateFrame("Frame")
ev:RegisterEvent("LOOT_OPENED")
ev:RegisterEvent("LOOT_SLOT_CHANGED")
ev:RegisterEvent("PLAYER_LOGIN")
ev:SetScript("OnEvent", function()
    HookLoot()
    if C_Timer and C_Timer.After then
        for _, d in ipairs({ 0, 0.05, 0.2 }) do C_Timer.After(d, RefreshLoot) end
    else
        RefreshLoot()
    end
end)
