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

local class_cn = {}
class_cn["WARRIOR"] = "战士"
class_cn["DEMONHUNTER"] = "DH"
class_cn["PALADIN"] = "圣骑"
class_cn["MONK"] = "武僧"
class_cn["WARLOCK"] = "术士"
class_cn["HUNTER"] = "猎人"
class_cn["ROGUE"] = "盗贼"
class_cn["SHAMAN"] = "萨满"
class_cn["MAGE"] = "法师"
class_cn["PRIEST"] = "牧师"
class_cn["DRUID"] = "小德"
class_cn["DEATHKNIGHT"] = "死骑"


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

		soaiDB[playername .. "-" .. realm] = soaiDB[playername .. "-" .. realm] or {}
		local temp = soaiDB[playername .. "-" .. realm]
		temp.playername = playername
		temp.realm = realm
		temp.faction = faction
		temp.level = level
		temp.class = class
		
		SlashCmdList['SO'] = function(ps) 
			temp.ps = tostring(ps); 
			print(temp.ps);
		end 
		SLASH_SO1 = '/so'

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
			b1.str:SetFont("fonts\\ARHei.ttf", 16)
			b1.str:SetJustifyH("LEFT")
			local temp_ps = v.ps or ""
			b1.str:SetText(k .. " > " .. temp_ps)

			b1:SetScript("OnMouseUp", function(f)
				SendMailNameEditBox:SetText(k)
				SendMailNameEditBox:HighlightText()
				end)
			b1:SetScript("OnEnter", function(f)
				f:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8",})
				f:SetBackdropColor(0,0.63,0.9,0.6)
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
