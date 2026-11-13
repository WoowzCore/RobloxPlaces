local plrs = game:GetService("Players")
local startcharacterscript = game:GetService("StarterPlayer").StarterCharacterScripts

local function restartcharacter(plr)
	local charClone = script.Parent.StarterCharacter:Clone()
	charClone.Name = plr.Name
	plr.Character = charClone
	charClone.Parent = workspace
	local spawnlocation = Vector3.zero
	local spawns = {}
	for _, p in pairs(workspace:GetDescendants()) do
		if p:IsA("SpawnLocation") then
			table.insert(spawns,p)
		end
	end
	if #spawns ~= 0 then
		spawnlocation = spawns[math.random(1,#spawns)].Position
	end
	
	charClone.HumanoidRootPart.CFrame = CFrame.new(spawnlocation)
	for _, p in pairs(startcharacterscript:GetChildren()) do
		p:Clone().Parent = charClone
	end

	local chr = plr.Character or plr.CharacterAdded:Wait()
	chr:WaitForChild("Humanoid").Died:Connect(function()
		wait(5)
		restartcharacter(plr)
	end)
end

plrs.PlayerAdded:Connect(function(plr)
	restartcharacter(plr)
end)
