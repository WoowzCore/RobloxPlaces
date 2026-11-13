game.ReplicatedStorage.Checkpoint.OnClientInvoke = function(hit,spawn)
	local player = game:GetService("Players").LocalPlayer
	local checkpointData = game.ServerStorage:FindFirstChild("CheckpointData")
	if not checkpointData then
		checkpointData = Instance.new("Model", game.ServerStorage)
		checkpointData.Name = "CheckpointData"
	end

	local checkpoint = checkpointData:FindFirstChild(tostring(player.userId))
	if not checkpoint then
		checkpoint = Instance.new("ObjectValue", checkpointData)
		checkpoint.Name = tostring(player.userId)

		player.CharacterAdded:connect(function(character)
			wait()
			character:WaitForChild("HumanoidRootPart").CFrame = game.ServerStorage.CheckpointData[tostring(player.userId)].Value.CFrame + Vector3.new(0, 4, 0)
		end)
	end
	
	local char = player.Character or player.CharacterAdded:Wait()
	local hum = char:WaitForChild'Humanoid'
	hum.Health += hum.MaxHealth
	spawn.BrickColor = BrickColor.new(0,255,0)
	checkpoint.Value = spawn
end
