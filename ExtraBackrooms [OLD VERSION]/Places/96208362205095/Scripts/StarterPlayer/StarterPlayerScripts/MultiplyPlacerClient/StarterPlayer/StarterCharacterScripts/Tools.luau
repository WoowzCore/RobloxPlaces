local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

game:GetService("UserInputService").InputBegan:Connect(function(key, InChat)
	if InChat then return end
	if key.KeyCode == Enum.KeyCode.X then
		game:GetService("ReplicatedStorage").DropTool:FireServer(char:FindFirstChildOfClass("Tool"))
	end
end)

