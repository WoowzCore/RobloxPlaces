function getFlagEmoji(region)
	local regionalIndicators = {a = "🇦",b = "🇧",c = "🇨",d = "🇩",e = "🇪",f = "🇫",g = "🇬",h = "🇭",i = "🇮",	j = "🇯",k = "🇰",l = "🇱",m = "🇲",n = "🇳",o = "🇴",p = "🇵",q = "🇶",r = "🇷",s = "🇸",t = "🇹",u = "🇺",v = "🇻",w = "🇼",x = "🇽",y = "🇾",z = "🇿",
	}
	local regionID = string.lower(region)
	local l1 = string.sub(regionID ,1,1)
	local l2 = string.sub(regionID ,2,2)
	return regionalIndicators[l1]..regionalIndicators[l2]
end

local plr = game:GetService("Players").LocalPlayer
local setting = require(plr:WaitForChild("PlayerScripts").Settings)

local result, code = pcall(game:GetService("LocalizationService").GetCountryRegionForPlayerAsync, game:GetService("LocalizationService"), game:GetService("Players").LocalPlayer)
local flag = ""
if result then
	flag = getFlagEmoji(code)
	if flag == nil then flag = "" end
end

while wait() do
	if result then
		local f = flag
		if setting.Privacity.ShowFlag == false then
			f = ""
		end
		script.Parent.Text = f.." "..code
	end
end