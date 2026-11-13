local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

while wait() do
	local result = base.t.g("other.no")
	if base.VisibleGUI then
		result = base.t.g("other.yes")
	end
	script.Parent.Text = base.t.g("debug.visibleui")..result
end