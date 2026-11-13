--//Script created by Brer_Bear on 1st of July 2018
--//Do not copy or edit without permission.

--//Variables
local InUse = false


--//Functions
function CheckName(Object)
	local NameFound = false
	for _,Name in pairs({"LeftFoot", "LeftHand", "LeftLowerArm", "LeftLowerLeg", "LeftUpperArm", "LeftUpperLeg", "LowerTorso", "RightFoot", "RightHand", "RightLowerArm", "RightLowerLeg", "RightUpperArm", "RightUpperLeg", "UpperTorso", "Head"}) do
		if string.lower(Object.Name) == string.lower(Name) then
			NameFound = true
		end
	end
	if NameFound then
		return true
	end
end

function AddWeld(Target, Object)
	if Target and Object then
		local Weld = Instance.new("WeldConstraint", Object)
		Weld.Part0 = Target
		Weld.Part1 = Object
	end
end

function LockPlayer(Player, Value)
	local Humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
	if Player and Humanoid then
		if Value == true then
			Humanoid.PlatformStand = true
			Player.Character:FindFirstChild("HumanoidRootPart").Anchored = true
			wait(0.5)
		elseif Value == false then
			Humanoid.PlatformStand = false
			Player.Character:FindFirstChild("HumanoidRootPart").Anchored = false
		end
	end
end


--//Main script
script.Parent:WaitForChild("ClickDetector").MouseClick:connect(function(Player)
	if not InUse and game:GetService("Players"):FindFirstChild(Player.Name) and Player.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 and Player.Character.Humanoid.Health > 0 and not Player.Character:FindFirstChild("GotCostume") then
		InUse = true
		Player:ClearCharacterAppearance()
		local CostumeLabel = Instance.new("BoolValue", Player.Character)
		CostumeLabel.Name = "GotCostume"
		LockPlayer(Player, true)
		local OldCFrame = Player.Character:FindFirstChild("HumanoidRootPart").CFrame
		Player.Character:SetPrimaryPartCFrame(script.Parent.Parent:FindFirstChild("Position").CFrame)
		for _,BodyPart in pairs(Player.Character:GetChildren()) do
			if BodyPart:IsA("BasePart") and CheckName(BodyPart) then
				if BodyPart.Name == "Head" then
					BodyPart.Transparency = 0.99
				else
					BodyPart.Transparency = 1
				end
				local Face = BodyPart:FindFirstChildOfClass("Decal")
				if Face then
					Face:Destroy()
				end
				local CostumeObject = script.Parent.Parent.Parent.Costume:FindFirstChild(BodyPart.Name)
				if CostumeObject then
					local ClonedCostumeObject = CostumeObject:Clone()
					ClonedCostumeObject.Parent = Player.Character
					for _,CostumeObjectPart in pairs(ClonedCostumeObject:GetChildren()) do
						if CostumeObjectPart:IsA("BasePart") then
							CostumeObjectPart.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
							AddWeld(BodyPart, CostumeObjectPart)
							CostumeObjectPart.Anchored = false
							CostumeObjectPart.CanCollide = false
							CostumeObjectPart.Locked = true
						end
					end
				else
					warn("A piece of costume is missing:", BodyPart.Name)
				end
			end
			wait()
		end
		Player.Character:SetPrimaryPartCFrame(OldCFrame)
		LockPlayer(Player, false)
		InUse = false
	end
end)