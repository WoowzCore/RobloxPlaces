local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hum = chr:WaitForChild("Humanoid")
local base = require(chr:WaitForChild("PlayerBase"))

while wait() do
	local result = base.t.g("other.no")
	if hum.Sit then
		result = base.t.g("other.no")
	end
	script.Parent.Text = base.t.g("debug.sit")..result
end