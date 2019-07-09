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

		local btn_high = 30
		local btn_width = 300
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
		alts:SetWidth(btn_width)
		alts:SetPoint("TOPLEFT", "MailFrame", "TOPRIGHT")
		alts:SetBackdrop({
					bgFile = "Interface\\Buttons\\WHITE8x8",
				})
		alts:SetBackdropColor(0,0,0,0.8)

		for k, v in pairs(soaiDB) do
			local b1 = CreateFrame("Frame", "abtn"..btn_count, alts);
			b1:SetSize(btn_width, btn_high);
			b1:SetPoint("TOPLEFT","F_alts","TOPLEFT",0,-btn_high * btn_count);

			local str = b1:CreateFontString("astr"..btn_count, "ARTWORK")
			str:SetSize(btn_width-10, btn_high)
			str:SetPoint("TOPLEFT", "abtn"..btn_count,5,0)
			str:SetFont("fonts\\ARHei.ttf", 14)
			str:SetJustifyH("LEFT")
			str:SetTextColor(0,1,1)
			str:SetText(k .. " LV." .. v.level .. " " .. v.class)

			b1:SetScript("OnMouseUp", function(f)
				SendMailNameEditBox:SetText(k)
				SendMailNameEditBox:HighlightText()
				end)
			b1:SetScript("OnEnter", function(f)
				f:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8",})
				f:SetBackdropColor(0,0.6,0.6,0.3)
				end)
			b1:SetScript("OnLeave", function(f)
				f:SetBackdrop(nil)
				end)	
			btn_count = btn_count + 1
		end

		alts:SetHeight(btn_high * btn_count)
	end
end	

soai:SetScript("OnEvent", soai.OnEvent);
