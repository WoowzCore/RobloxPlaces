local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

while wait() do
	local date = os.date("!*t")
	local s = date.sec
	local m = date.min
	local h = (date.hour+3)%24
	local d = date.wday
	if date.hour>21 then
		d = d + 1
	end
	local emoji = ""
	local ytro = 8
	if d == 6 or d == 7 then
		ytro = 10
	end
	if h >= 23 or h < ytro then
		emoji = "😴"
	end
	script.Parent.Text = base.t.g("debug.woowztime")..tostring(h)..":"..tostring(m)..":"..tostring(s).." "..emoji
end