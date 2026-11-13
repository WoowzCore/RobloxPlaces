local RS = game:GetService("ReplicatedStorage")
local PlayerService = game:GetService("Players")

function ChangeCharacter(Character)
	for _, part in pairs(Character:GetDescendants()) do
		local name = part.Name
		if(name == "Animate" or name == "Health") then
			part:Destroy()
		end
		
		if(part:IsA("Accessory"))then
			if not (part.AccessoryType == Enum.AccessoryType.Face or part.AccessoryType == Enum.AccessoryType.Hat or part.AccessoryType == Enum.AccessoryType.Hair) then
				part:Destroy()
			end
		end
		
		if(part.Name == "Head" or part.Name == "Torso" or part.Name == "Left Arm" or part.Name == "Right Arm" or part.Name == "Left Leg" or part.Name == "Right Leg")then
			part.MaterialVariant = "Human"
		end
	end
end

function MakeCharacterToCorpse(Character)
	for _, part in pairs(Character:GetDescendants()) do
		if(part:IsA("BaseScript")) then
			part:Destroy()
		end
	end
end

function LoadPlayer(Player,died)
	if workspace.PlayersInfo:FindFirstChild(Player.UserId)==nil then
		local playerfolder = Instance.new("Folder")
		playerfolder.Parent = workspace.PlayersInfo
		playerfolder.Name = Player.UserId
		
		local backpack = Instance.new("Folder")
		backpack.Parent = playerfolder
		backpack.Name = "Backpack"
	end
	if (died) then
		MakeCharacterToCorpse(Player.Character or Player.CharacterAdded:Wait())
	end
	Player:LoadCharacter()
	local Character = Player.Character or Player.CharacterAdded:Wait()
	local Humanoid = Character:WaitForChild("Humanoid")
	wait(1)
	ChangeCharacter(Character)
	RS.StartPlayerData:FireClient(Player,died or false)
end
RS.LoadPlayer.OnServerEvent:Connect(LoadPlayer)

PlayerService.PlayerAdded:Connect(LoadPlayer)