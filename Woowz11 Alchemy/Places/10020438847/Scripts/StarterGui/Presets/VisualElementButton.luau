local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
local Values = PlayerGui:WaitForChild("Values")

local ThisButton = script.Parent
local Number = 1

if ThisButton.Name == "Element_com_2" then
	Number = 2
end

function ClearCom()
	local var = nil
	if Number == 1 then
		var = Values.com_1
	else
		var = Values.com_2
	end
	var.Value = "empty"
	Values.Select_Element.Value = "empty"
end

ThisButton.MouseButton1Click:Connect(ClearCom)