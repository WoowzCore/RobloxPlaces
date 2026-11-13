local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

function getFlagEmoji(region)
	local regionalIndicators = {a = "🇦",b = "🇧",c = "🇨",d = "🇩",e = "🇪",f = "🇫",g = "🇬",h = "🇭",i = "🇮",	j = "🇯",k = "🇰",l = "🇱",m = "🇲",n = "🇳",o = "🇴",p = "🇵",q = "🇶",r = "🇷",s = "🇸",t = "🇹",u = "🇺",v = "🇻",w = "🇼",x = "🇽",y = "🇾",z = "🇿",
	}
	local regionID = string.lower(region)
	local l1 = string.sub(regionID ,1,1)
	local l2 = string.sub(regionID ,2,2)
	return regionalIndicators[l1]..regionalIndicators[l2]
end

local result, code = pcall(game:GetService("LocalizationService").GetCountryRegionForPlayerAsync, game:GetService("LocalizationService"), game:GetService("Players").LocalPlayer)
if result then
	local flag = getFlagEmoji(code)
	if flag == nil then flag = "🏴‍☠️" end
	script.Parent.Text = base.t.g("debug.region")..code.." "..flag
end