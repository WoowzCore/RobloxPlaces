local sys = game:GetService("LocalizationService").SystemLocaleId
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))
while wait() do
	local dn = DateTime.now()
	local s = dn:FormatLocalTime("ss", sys)
	local m = dn:FormatLocalTime("mm", sys)
	local h = dn:FormatLocalTime("HH", sys)
	script.Parent.Text = base.t.g("debug.time")..h..":"..m..":"..s
end