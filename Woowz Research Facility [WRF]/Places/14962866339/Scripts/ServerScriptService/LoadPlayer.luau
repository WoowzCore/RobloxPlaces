local base = require(script.Parent.Base)
local players = game:GetService("Players")
local rps = game:GetService("ReplicatedStorage")
local ss = game:GetService("ServerStorage")

local function ApplyCharacter(plr)
	if plr == nil then return end
	while plr.Parent ~= game.Players do
		wait()
	end
	plr:LoadCharacter()
	rps.DataStorage.Set:Fire(plr)
	local chr = plr.Character or plr.CharacterAdded:Wait()
	
	local hum = chr:WaitForChild("Humanoid")
	hum.BreakJointsOnDeath = false
	hum.RequiresNeck = false
	chr:WaitForChild("Animate"):Destroy()
	local oldanimator = chr:WaitForChild("Humanoid"):WaitForChild("Animator")
	local animator = Instance.new("Animator")
	animator.PreferLodEnabled = false
	animator.Name = oldanimator.Name
	animator.Parent = oldanimator.Parent
	oldanimator:Destroy()
	
	local function GraphicalPartChange(part)
		if part:IsA("ParticleEmitter") then
			part:Destroy()
		end

		if part:IsA("BasePart") then
			if part.Parent:IsA("Model") or part.Parent:IsA("Accessory") then
				part.MaterialVariant = "Humanoid"
			end
		end
	end
	
	local function createAttachment(parent,name,pos,rot)
		if rot == nil then
			rot = Vector3.zero
		end
		local at = Instance.new("Attachment")
		at.Name = name
		at.Parent = parent
		at.CFrame = CFrame.new(pos) * CFrame.Angles(math.rad(rot.X),math.rad(rot.Y),math.rad(rot.Z))
	end
	for _, part in pairs(chr:GetDescendants()) do
		GraphicalPartChange(part)
		if part.Name == "Torso" then
			part.CollisionGroup = "Players"
			createAttachment(part,"RagdollH",Vector3.new(0, 1, 0),Vector3.new(0,0,90))
			createAttachment(part,"RagdollAL",Vector3.new(-1, 0.6, 0))
			createAttachment(part,"RagdollAR",Vector3.new(1, 0.6, 0))
			createAttachment(part,"RagdollLL",Vector3.new(-0.5, -1, 0),Vector3.new(0,0,-90))
			createAttachment(part,"RagdollLR",Vector3.new(0.5, -1, 0),Vector3.new(0,0,-90))
		end
		if part.Name == "Head" then
			createAttachment(part,"RagdollH",Vector3.new(0, -0.5, 0),Vector3.new(0,0,90))

			local data_nickname = Instance.new("Part",part)
			data_nickname.CFrame = CFrame.new(part.Position + Vector3.new(0,2.5,0))
			data_nickname.Anchored = false
			data_nickname.Size = Vector3.new(0.1,0.1,0.1)
			data_nickname.Transparency = 1
			data_nickname.CanCollide = false
			data_nickname.CanTouch = false
			data_nickname.Name = "Nickname_Data"
			local data_nickname_weld = Instance.new("WeldConstraint",data_nickname)
			data_nickname_weld.Part0 = part
			data_nickname_weld.Part1 = data_nickname
		end
		if part.Name == "Left Arm" then
			createAttachment(part,"RagdollAL",Vector3.new(0.5, 0.5, 0))
		end
		if part.Name == "Left Leg" then
			createAttachment(part,"RagdollLL",Vector3.new(0, 1, 0),Vector3.new(0,0,-90))
		end
		if part.Name == "Right Arm" then
			createAttachment(part,"RagdollAR",Vector3.new(-0.5, 0.5, 0))
		end
		if part.Name == "Right Leg" then
			createAttachment(part,"RagdollLR",Vector3.new(0, 1, 0),Vector3.new(0,0,-90))
		end

		if part.Name == "HumanoidRootPart" then
			part.CanCollide = true
		end
		
		if part.Name == "Health" or part.Name == "Animate" or part.Name == "Climbing" or part.Name == "Died" or part.Name == "FreeFailing" or part.Name == "GettingUp" or part.Name == "Jumping" or part.Name == "Landing" or part.Name == "Running" or part.Name == "Splash" or part.Name == "Swimming" then
			part:Destroy()
		end
		
		if part.Name == "HumanoidRootPart" or part.Name == "Head" or part.Name == "Torso" or part.Name == "Right Arm" or part.Name == "Left Arm" or part.Name == "Right Leg" or part.Name == "Left Leg" then
			part.CollisionGroup = "PlayerBase"
		end
	end

	base.MakeDummyCrashable(chr)
	
	rps.UpdateCharacter:FireClient(plr,chr)
	local checkadmin,dev = base.CheckAdmin(plr.UserId)
	if dev then checkadmin = "dev" end
	rps.UpdateAdmin:FireClient(plr,checkadmin)
	
	if game:GetService("Lighting").StartItem.Value ~= nil then
		local startitem = game:GetService("Lighting").StartItem.Value
		base.GetItemToBackpack(startitem,plr)
	end
	
	base.SendSirensToPlayers()
	
	task.wait(2)
	for _, part in pairs(chr:GetDescendants()) do
		GraphicalPartChange(part)
	end
	task.wait(2)
	for _, part in pairs(chr:GetDescendants()) do
		GraphicalPartChange(part)
	end
	task.wait(2)
	for _, part in pairs(chr:GetDescendants()) do
		GraphicalPartChange(part)
	end
	task.wait(2)
	for _, part in pairs(chr:GetDescendants()) do
		GraphicalPartChange(part)
	end
end

players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(chr)
		chr:WaitForChild('Humanoid').Died:Wait()
		base.DropBackpack(plr)
		task.wait(players.RespawnTime)
		ApplyCharacter(plr)
	end)
	
	task.wait(3)
	ApplyCharacter(plr)
end)

rps.ApplyCharacter.Event:Connect(function(p)
	ApplyCharacter(p)
end)

