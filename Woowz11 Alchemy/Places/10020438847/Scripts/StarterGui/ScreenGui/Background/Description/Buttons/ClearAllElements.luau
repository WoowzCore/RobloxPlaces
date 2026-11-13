local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
local Values = PlayerGui:WaitForChild("Values")
local ThisButton = script.Parent.ClearAllElements_b

function Reset()
	game:GetService("ReplicatedStorage"):WaitForChild("ResetElements"):FireServer()
	local addel = script.Parent.Parent.Parent.Parent.Parent.AddElements
	
	local elem_folder = addel.ElementsPlayer
	local new_elem_folder = Instance.new("Folder",addel)
	elem_folder:Remove()
	new_elem_folder.Name = "ElementsPlayer"
	
	local elements_button = addel.Parent.ScreenGui.Background.Elements
	for _, element in pairs(elements_button:GetChildren()) do
		if element.Name ~= "UIGridLayout" then
			element:Remove()
		end
	end
	
	wait(0.05)
	addel.Disabled = true
	wait(0.05)
	addel.Disabled = false
end

ThisButton.MouseButton1Click:Connect(Reset)