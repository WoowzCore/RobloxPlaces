game.ReplicatedStorage.Tier1.OnClientEvent:Connect(function()
	script.Parent.Head.Armored.Visible = true
	script.Parent:FindFirstChild("Left Arm").Armored.Visible = true
	script.Parent:FindFirstChild("Left Leg").Armored.Visible = true
	script.Parent:FindFirstChild("Right Arm").Armored.Visible = true
	script.Parent:FindFirstChild("Right Leg").Armored.Visible = true
	script.Parent:FindFirstChild("Torso").Armored.Visible = true
	
end)