local graphic = UserSettings():GetService("UserGameSettings").SavedQualityLevel.Value
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

while wait() do
	local g = graphic
	if g == 0 then
		g = base.t.g("other.auto")
	end
	script.Parent.Text = base.t.g("debug.graphic")..g
end