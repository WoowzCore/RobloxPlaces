local myplaceid = 14492839796
local function GetVersion()
	local desc = game:GetService("MarketplaceService"):GetProductInfo(myplaceid).Description
	local mainwords = string.split(desc:gsub("%c+", "~"),"~")
	
	local placeversion = "No Found :("
	for i, word in pairs(mainwords) do
		if word:match("Version:") then
			placeversion = word:gsub("Version: ","")
		end
	end
	
	return placeversion
end
script.Parent.Text = GetVersion()