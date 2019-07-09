SlashCmdList['RELOAD'] = function() ReloadUI() end 
SLASH_RELOAD1 = '/rl'

local soai = CreateFrame("Frame")
_G["soai"] = soai
soai:RegisterEvent("ADDON_LOADED")

--[[ 
OO结构： 
	插件主体： soai, 已经注册到全局变量中
	主Frame： soai.alts , 挂载在 MailFrame 上, 共享父窗体的状态 比如显示和隐藏 可以少写点代码
	按钮： soai.alts.btn0, 前缀固定为btn, 数字从0开始顺下去, btn1, btn2, btn3 ...
	文本： soai.alts.btn0.str, 系统默认使用 FontString 这个类, 我懒得去看基类的代码 就这样吧
]]--

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


		soai.alts = CreateFrame("Frame", nil , MailFrame)
		soai.alts:SetWidth(btn_width)
		soai.alts:SetPoint("TOPLEFT", "MailFrame", "TOPRIGHT")
		soai.alts:SetBackdrop({
					bgFile = "Interface\\Buttons\\WHITE8x8",
				})
		soai.alts:SetBackdropColor(0,0,0,0.8)


		for k, v in pairs(soaiDB) do
			local b1 = CreateFrame("Frame", nil, soai.alts);
			b1:SetSize(btn_width, btn_high);
			b1:SetPoint("TOPLEFT",soai.alts ,"TOPLEFT",0,-btn_high * btn_count);

			b1.str = b1:CreateFontString(nil, "ARTWORK")
			b1.str:SetSize(btn_width-10, btn_high)
			b1.str:SetPoint("TOPLEFT", b1, 5,0)
			b1.str:SetFont("fonts\\ARHei.ttf", 14)
			b1.str:SetJustifyH("LEFT")
			b1.str:SetTextColor(0,1,1)
			b1.str:SetText(k .. " LV." .. v.level .. " " .. v.class)

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

			soai.alts["btn" .. btn_count] = b1

			btn_count = btn_count + 1
		end

		soai.alts:SetHeight(btn_high * btn_count)
	end
end	

soai:SetScript("OnEvent", soai.OnEvent);
