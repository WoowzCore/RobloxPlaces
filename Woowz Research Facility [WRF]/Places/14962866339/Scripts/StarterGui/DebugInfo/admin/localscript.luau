local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

while wait() do
	local result = base.t.Get("other.regular")
	if base.Admin then
		result = base.t.Get("other.admin")
	end
	if base.MainAdmin then
		result = base.t.Get("other.mainadmin")
	end
	if base.Dev then
		result = base.t.Get("other.dev")
	end
	script.Parent.Text = base.t.Get("debug.admin")..result
end