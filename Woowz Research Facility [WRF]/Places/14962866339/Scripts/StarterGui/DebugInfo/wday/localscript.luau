local sys = game:GetService("LocalizationService").SystemLocaleId
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

while true do
	local dn = DateTime.now()
	local d = dn:FormatLocalTime("d", sys)
	local days = {
		["1"] = base.t.g("other.wday.monday"),
		["2"] = base.t.g("other.wday.tuesday"),
		["3"] = base.t.g("other.wday.wednesday"),
		["4"] = base.t.g("other.wday.thursday"),
		["5"] = base.t.g("other.wday.friday"),
		["6"] = base.t.g("other.wday.saturday"),
		["7"] = base.t.g("other.wday.sunday"),
		["0"] = base.t.g("other.wday.sunday")
	}
	script.Parent.Text = base.t.g("debug.wday")..days[tostring(d)]
	wait(30)
end