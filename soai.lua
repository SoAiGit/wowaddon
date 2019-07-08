soai = {}
_G["soai"] = soai

if soaiDB == nil then
	soaiDB = {}
end

local realm = GetRealmName()
local faction = UnitFactionGroup("player")
local playername = UnitName("player")
local level = UnitLevel("player")
local _, class = UnitClass("player")

if not realm or not faction or not playername or not level or not class then return end

soaiDB[playername .. "-" .. realm] = {}
temp = soaiDB[playername .. "-" .. realm]
temp.playername = playername
temp.realm = realm
temp.faction = faction
temp.level = level
temp.class = class

for k, v in pairs(soaiDB) do
    print(k, v)
end

-- SendMailNameEditBox:SetText(XXXXX)
-- SendMailNameEditBox:HighlightText()