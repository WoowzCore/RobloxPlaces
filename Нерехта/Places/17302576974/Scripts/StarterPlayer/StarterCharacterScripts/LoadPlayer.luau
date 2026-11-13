local RS = game:GetService("ReplicatedStorage")

local Character = script.Parent
local PlayerData = require(Character:WaitForChild("PlayerData"))

function ChangeCharacter()
	for _, part in pairs(Character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CastShadow = false
		end
		
		if(part:IsA("Sound"))then
			part:Destroy()
		end
		
		if (part.Name == "Torso" or part.Name == "Left Arm" or part.Name == "Right Arm" or part.Name == "Left Leg" or part.Name == "Right Leg") then
			local ChangeTransparency = function()
				part.LocalTransparencyModifier = part.Transparency
			end
			ChangeTransparency()
			part:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(ChangeTransparency)
		end
	end	
end

function StartPlayerData(died)
	script.Parent:WaitForChild("PlayerData").LoadAnimations:Fire()
	ChangeCharacter()
	PlayerData.StartPlayerData(died)
end
RS.StartPlayerData.OnClientEvent:Connect(StartPlayerData)