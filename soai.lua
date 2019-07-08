SlashCmdList['RELOAD'] = function() ReloadUI() end 
SLASH_RELOAD1 = '/rl'

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
alts:SetWidth(250)
alts:SetHeight(MailFrame:GetHeight())
alts:SetPoint("TOPLEFT", "MailFrame", "TOPRIGHT")
alts:SetBackdrop({
			bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]],
		})
alts:SetBackdropColor(0,0,0,1)


local b1 = CreateFrame("Button", nil , alts, "StaticPopupButtonTemplate");
b1:SetSize(246, 30);
b1:SetPoint("TOPLEFT","F_alts","TOPLEFT",2,0);
b1:SetText(playername .. "-" .. realm);
b1:SetScript("OnClick", function()
	SendMailNameEditBox:SetText(b1:GetText())
	end)