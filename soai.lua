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

local alts = CreateFrame("Frame", "F_alts", MailFrame)
alts:SetWidth(25)
alts:SetHeight(25)
alts:SetPoint("TOPLEFT", "MailFrame", "TOPRIGHT")
alts::SetBackdrop({
			bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]],
			edgeFile = [[Interface\DialogFrame\UI-DialogBox-Border]],
			tile = true, tileSize = 16, edgeSize = 16,
			insets = { left = 3, right = 3, top = 5, bottom = 3 }
		})
alts:SetBackdropColor(0,0,0,1)		