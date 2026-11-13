local sys = game:GetService("LocalizationService").SystemLocaleId
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

while wait() do
	local dn = DateTime.now()
	local day = dn:FormatLocalTime("DD", sys)
	local mounth = dn:FormatLocalTime("MM", sys)
	local year = dn:FormatLocalTime("YYYY", sys)
	script.Parent.Text = base.t.g("debug.date")..day.."."..mounth.."."..year
end