local Pickup = script.Parent
local tool = script.Parent.Parent.Parent
local EBL = require(game:GetService("ServerScriptService"):WaitForChild("EBLibbary"))

Pickup.Triggered:Connect(function(plr)
	EBL.GetItem(plr,tool)
end)

while wait() do
	local char = tool.Parent
	local hum = char:FindFirstChildOfClass("Humanoid")
	local backpack = nil
	if char:IsA("Backpack") then
		backpack = char
	end
	if hum or backpack then
		Pickup.Enabled = false
	else
		wait(0.1)
		if not hum or backpack then
			Pickup.Enabled = true
		end
	end
end