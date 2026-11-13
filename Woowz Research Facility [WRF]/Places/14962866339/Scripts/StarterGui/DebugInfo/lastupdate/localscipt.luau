local ms = game:GetService("MarketplaceService")
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

s,e = pcall(function()
	local information = ms:GetProductInfo(14962866339)
	local function upd()
		local dt = DateTime
		local dif = os.difftime( os.time(), dt.fromIsoDate(information.Updated).UnixTimestamp )
		local result = ""
		local hours = math.floor(dif/3600)
		local days = math.floor(hours/24)
		if days	~= 0 then
			result = days.." "..base.t.g("other.days")
		else
			if hours ~= 0 then
				result = hours.." "..base.t.g("other.hours")
			else
				result = math.floor(dif/60).." "..base.t.g("other.minutes")
			end
		end
		script.Parent.Text = base.t.g("debug.lastupdate")..result
	end
	upd()

	while wait(5) do
		upd()
	end
end)
