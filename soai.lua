SlashCmdList['RELOAD'] = function() ReloadUI() end 
SLASH_RELOAD1 = '/rl'

local soai = CreateFrame("Frame")
_G["soai"] = soai
soai:RegisterEvent("ADDON_LOADED")


function soai:OnEvent(event, arg1)
	if event == "ADDON_LOADED" and arg1 == "soai" then
		print ("soai addon load")
		if soaiDB  == nil then
			soaiDB = {}
			print ("找不到配置文件")
		end	
		local realm = GetRealmName()
		local faction = UnitFactionGroup("player")
		local playername = UnitName("player")
		local level = UnitLevel("player")
		local _, class = UnitClass("player")

		local btn_high = 60
		local btn_count = 0

		if not realm or not faction or not playername or not level or not class then return end

		soaiDB[playername .. "-" .. realm] = {}
		local temp = soaiDB[playername .. "-" .. realm]
		temp.playername = playername
		temp.realm = realm
		temp.faction = faction
		temp.level = level
		temp.class = class

		local alts = CreateFrame("Frame", "F_alts", MailFrame)
		alts:SetWidth(250)
		alts:SetPoint("TOPLEFT", "MailFrame", "TOPRIGHT")
		alts:SetBackdrop({
					bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]],
				})
		alts:SetBackdropColor(0,0,0,1)

		for k, v in pairs(soaiDB) do
			local b1 = CreateFrame("Button", nil , alts, "StaticPopupButtonTemplate");
			b1:SetSize(246, btn_high);
			b1:SetPoint("TOPLEFT","F_alts","TOPLEFT",2,-btn_high * btn_count);
			btn_count = btn_count + 1
			b1:SetText(k .. "\n" .. "LV." .. v.level .. "   " .. v.class);
			b1:SetScript("OnClick", function()
				SendMailNameEditBox:SetText(k)
				SendMailNameEditBox:HighlightText()
				end)
		end
		alts:SetHeight(btn_high * btn_count)
	end
end	

soai:SetScript("OnEvent", soai.OnEvent);
