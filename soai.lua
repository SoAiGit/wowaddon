SlashCmdList['RELOAD'] = function() ReloadUI() end 
SLASH_RELOAD1 = '/rl'

local soai = CreateFrame("Frame")
soai:RegisterEvent("ADDON_LOADED")

--[[ 
OO结构： 
	插件主体： soai, 已经注册到全局变量中
	主Frame： soai.alts , 挂载在 MailFrame 上, 共享父窗体的状态 比如显示和隐藏 可以少写点代码
	按钮： soai.alts.btn0, 前缀固定为btn, 数字从0开始顺下去, btn1, btn2, btn3 ...
	文本： soai.alts.btn0.str, 系统默认使用 FontString 这个类, 我懒得去看基类的代码 就这样吧
]]--

local class_cn = {}
class_cn["WARRIOR"] = "|cFFC79C6E战士|r"
class_cn["DEMONHUNTER"] = "|cFFA330C9DH|r"
class_cn["PALADIN"] = "|cFFF58CBA圣骑|r"
class_cn["MONK"] = "|cFF00FF96武僧|r"
class_cn["WARLOCK"] = "|cFF8787ED术士|r"
class_cn["HUNTER"] = "|cFFABD473猎人|r"
class_cn["ROGUE"] = "|cFFFFF569盗贼|r"
class_cn["SHAMAN"] = "|cFF0070DE萨满|r"
class_cn["MAGE"] = "|cFF40C7EB法师|r"
class_cn["PRIEST"] = "|cFFFFFFFF牧师|r"
class_cn["DRUID"] = "|cFFFF7D0A小德|r"
class_cn["DEATHKNIGHT"] = "|cFFC41F3B死骑|r"


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

		local btn_high = 25
		local btn_width = 400
		local btn_count = 0
		local font_size = 16

		if not realm or not faction or not playername or not level or not class or realm=="格瑞姆巴托" then return end

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
			b1.str:SetFont("fonts\\ARHei.ttf", font_size)
			b1.str:SetJustifyH("LEFT")
			local temp_ps = v.ps or ""
			b1.str:SetText(k .. "(" .. class_cn[v.class] .. "): " .. temp_ps)

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
