local Armor = script.Parent.Parent
Armor.PrimaryPart = Armor:WaitForChild("Torso")
local ProximityPrompt = script.Parent


--/Welds
function WeldParts(part0,part1)
	local newWeld = Instance.new("Weld")
	newWeld.Part0 = part0
	newWeld.Part1 = part1
	newWeld.C0 = CFrame.new()
	newWeld.C1 = part1.CFrame:toObjectSpace(part0.CFrame)
	newWeld.Parent = part0
end


--//Main Function
ProximityPrompt.Triggered:Connect(function(Player)
	local Character = Player.Character
	local Torso = Character:WaitForChild("Torso")
	ProximityPrompt.ActionText = "Wear"
	if Character:FindFirstChild(script.Parent.Parent.Name) then
		Character[script.Parent.Parent.Name]:Destroy()
	else
		local NewArmor = Armor:Clone()
		NewArmor:SetPrimaryPartCFrame(Torso.CFrame)
		NewArmor.PrimaryPart:Destroy()
		ProximityPrompt.ActionText = "Take off"
		for _, part in pairs (NewArmor:GetChildren()) do
			if part:IsA("BasePart") then
				WeldParts(Torso, part)
				part.CanCollide = false
				part.Anchored = false
			end
		end
		NewArmor.Parent = Character
	end
end)