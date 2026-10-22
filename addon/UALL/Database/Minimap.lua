-- WoWUkraine: переклади написів ПОЗНАЧОК МІНІМАПИ (типи: Mailbox тощо, імена точок).
-- Автоген pipeline/generate_db.py. ns.minimapLabels — мапа англ.рядок->укр.
-- Тултіп-перекладач (TrackerHooks) підставляє за показаним текстом. Один переклад
-- «Mailbox» покриває ВСІ поштові скриньки в грі (зіставлення за рядком).
local _, ns = ...
ns.minimapLabels = {
    ["Mailbox"] = "Поштова скринька",
    ["Flight Master"] = "Розпорядник польотів",
    ["Innkeeper"] = "Шинкар",
    ["Auctioneer"] = "Аукціоніст",
    ["Banker"] = "Банкір",
    ["Stable Master"] = "Стайничий",
    ["Battlemaster"] = "Розпорядник битв",
    ["Barber"] = "Перукар",
    ["Void Storage"] = "Сховище Порожнечі",
    ["Transmogrifier"] = "Трансмогрифікатор",
    ["Guild Master"] = "Гільдмайстер",
    ["Repair"] = "Ремонт",
}

-- безпечні глобали ярликів POI (display, не secure)
local _G = _G
_G["MINIMAP_TRACKING_REPAIR"] = "Ремонт"
_G["MINIMAP_TRACKING_BATTLEMASTER"] = "Розпорядник битв"
_G["MINIMAP_TRACKING_TRANSMOGRIFIER"] = "Трансмогрифікатор"
_G["MINIMAP_TRACKING_STABLEMASTER"] = "Стайничий"
_G["MINIMAP_TRACKING_FLIGHTMASTER"] = "Розпорядник польотів"
_G["MINIMAP_TRACKING_MAILBOX"] = "Поштова скринька"
_G["MINIMAP_TRACKING_BANKER"] = "Банкір"
_G["MINIMAP_TRACKING_INNKEEPER"] = "Шинкар"
_G["MINIMAP_TRACKING_BARBER"] = "Перукар"
_G["MINIMAP_TRACKING_AUCTIONEER"] = "Аукціоніст"
