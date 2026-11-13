local ms = game:GetService("MarketplaceService")
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

s,e = pcall(function()
	local information = ms:GetProductInfo(14962866339)
	local dt = DateTime
	local dif = os.difftime(os.time(), dt.fromIsoDate(information.Created).UnixTimestamp )
	local days = math.floor(dif/86400)
	script.Parent.Text = base.t.g("debug.placeage")..days.." "..base.t.g("other.days")
end)