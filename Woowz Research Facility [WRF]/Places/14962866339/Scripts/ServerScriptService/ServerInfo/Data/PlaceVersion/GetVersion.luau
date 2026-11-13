local holliday = script.Parent.Parent.Holiday.Value

local emojis = {
	["Halloween"] = {"🎃","💀","👻","😈","🕸"},
	["Easter"] = {"🥚","🐇","⛪","🐰"},
	["Christmas"] = {"🎄","❄️","⭐","☃️","🎁"},
	[""] = {""}
}

local s,e = pcall(function()
	local emoji = emojis[holliday][math.random(1,#emojis[holliday])]
	local space = " "
	if emoji == "" then space = "" end
	script.Parent.Value = string.match(game:GetService("MarketplaceService"):GetProductInfo(14962866339).Description, "[^\n]*")	.. space .. emoji
end)
if s == false then
	script.Parent.Value = "Bad connection 😕"
end