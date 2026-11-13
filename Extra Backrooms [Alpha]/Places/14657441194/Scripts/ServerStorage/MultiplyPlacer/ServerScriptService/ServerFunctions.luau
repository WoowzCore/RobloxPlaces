local HeadsRotations = {}
local ArmsRotations = {}

local EBL = require(game:GetService("ServerScriptService"):WaitForChild("EBLibbary"))

game.Players.PlayerRemoving:Connect(function(plr)
	if HeadsRotations[plr.UserId] ~= nil then
		HeadsRotations[plr.UserId] = "LEAVED"
	end
	
	if ArmsRotations[plr.UserId] ~= nil then
		ArmsRotations[plr.UserId] = "LEAVED"
	end
end)

game.ReplicatedStorage.ChangeHeadRotation.OnServerInvoke = function(player, neck)
	HeadsRotations[player.UserId] = neck
	return HeadsRotations
end

game.ReplicatedStorage.ChangeArmsPosition.OnServerInvoke = function(player, shoulder)
	ArmsRotations[player.UserId] = shoulder
	return ArmsRotations
end

game.ReplicatedStorage.PlaySound.OnServerEvent:Connect(EBL.PlaySound)

local function GetItemDropPosition(player,tool)
	local arm = player.Character:FindFirstChild("Right Arm")
	if arm == nil then
		arm = player.Character:WaitForChild("HumanoidRootPart")
	end
	return arm.Position + Vector3.new(0,-1,0)
end

local function DropItem(player,tool)
	if tool then
		tool.Parent = game.Workspace
		tool.Handle.CFrame = CFrame.new(GetItemDropPosition(player,tool))
	end	
end

game.ReplicatedStorage.DropTool.OnServerEvent:Connect(DropItem)

local function playeradded(plr)
	local weaponFolder = Instance.new("Folder")
	weaponFolder.Name = "BackpackSaved"
	weaponFolder.Parent = plr
	local fisttime = false
	local toolinarm = nil
	local function charadded(char)
		fisttime = true
		local backpack = plr.Backpack
		local function UpdateFolder()	
			weaponFolder:ClearAllChildren()
			for i, childOfBP in pairs(backpack:GetChildren()) do
				if childOfBP:IsA("Tool") then
					childOfBP:Clone().Parent = weaponFolder
				end
			end

			local armtool = char:FindFirstChildOfClass("Tool")
			if armtool ~= nil then
				toolinarm = armtool
			end
		end
		char.Humanoid.Died:Connect(function()
			UpdateFolder()
			for i, weapon in pairs(weaponFolder:GetChildren()) do
				DropItem(plr,weapon)
			end
			if toolinarm ~= nil then
				local i = EBL.SpawnItem(toolinarm.Name,Vector3.new(-1000,-1000,-1000))
				EBL.ChangeItemPosition(i,GetItemDropPosition(plr,i))
				local values = EBL.ConvertToolToString(toolinarm)
				EBL.SetValuesToItem(i,values)
			end
			toolinarm = nil
		end)
	end
	plr.CharacterAdded:Connect(charadded)
	if fisttime == false then
		charadded(plr.Character or plr.CharacterAdded:Wait())
	end
end

for _, player in game.Players:GetPlayers() do
	task.spawn(function()
		playeradded(player)
	end)
end

game.Players.PlayerAdded:Connect(playeradded)