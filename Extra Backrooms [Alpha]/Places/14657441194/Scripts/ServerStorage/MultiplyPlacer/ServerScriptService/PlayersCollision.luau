local PS = game:GetService("PhysicsService")
local Players = game:GetService("Players")

local PCG = "Players"
game:GetService("PhysicsService"):RegisterCollisionGroup(PCG)
game:GetService("PhysicsService"):CollisionGroupSetCollidable(PCG,PCG,false)

local function SetHumanoid(char)
	local hum = char:WaitForChild("Humanoid")
	hum.AutoJumpEnabled = false
	hum.HealthDisplayDistance = 6
	hum.NameOcclusion = Enum.NameOcclusion.OccludeAll
	hum.BreakJointsOnDeath = false
end

local function ChangePlayer(char,ply)
	local havedescription = false
	for _, part in pairs(char:GetDescendants()) do
		
		if part:IsA("HumanoidDescription") then havedescription = true end
		
		if part.Name == "Health" then
			part:Destroy()
		end

		if part.Name == "HumanoidRootPart"  then
			for _2, v2 in pairs(part:GetChildren()) do
				if v2.Name == "Climbing"
					or v2.Name == "Died"
					or v2.Name == "FreeFalling"
					or v2.Name == "GettingUp"
					or v2.Name == "Jumping"
					or v2.Name == "Landing"
					or v2.Name == "Running"
					or v2.Name == "Splash"
					or v2.Name == "Swimming" then
					v2:Destroy()
				end
			end
		end
		
		if part:IsA("Part") then
			part.CollisionGroup = PCG
			part.Material = Enum.Material.Wood
			part.MaterialVariant = "Humanoid"
		elseif part:IsA("Accessory") then
			part.Handle.Material = Enum.Material.Wood
			part.Handle.MaterialVariant = "Humanoid"
		elseif part:IsA("ParticleEmitter") then
			part:Destroy()
		end
	end
	
	SetHumanoid(char)
	
	if havedescription == false then
		ply:LoadCharacter()
	end
	
	game:GetService("ReplicatedStorage").ChangeCharacter:FireClient(ply)
end

for _, plr in pairs(game.Players:GetPlayers()) do
	ChangePlayer(plr.Character or plr.CharacterAdded:Wait(),plr)
end

local function playeradded(player)
	player.CharacterAppearanceLoaded:Connect(function(char)
		if char then
			ChangePlayer(char,player)
			game:GetService("ReplicatedStorage").UpdateIgnoreListCamera:FireAllClients()
		end
	end)
end

for _, player in game.Players:GetPlayers() do
	task.spawn(function()
		playeradded(player)
	end)
end

game.Players.PlayerAdded:Connect(playeradded)

wait(1)
game:GetService("PhysicsService"):CollisionGroupSetCollidable(PCG,"Tools",false)