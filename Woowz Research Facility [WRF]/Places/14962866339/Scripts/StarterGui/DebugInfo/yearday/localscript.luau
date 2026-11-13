local sys = game:GetService("LocalizationService").SystemLocaleId
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

while true do
	local dn = DateTime.now()
	local d = dn:FormatLocalTime("DDD", sys)

	script.Parent.Text = base.t.g("debug.yday")..d.."/365"
	wait(30)
end