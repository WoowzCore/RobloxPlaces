local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
local Values = PlayerGui:WaitForChild("Values")
local ThisButton = script.Parent.ChangeLanguage_b

function ChangeLanguage()
	Values.Rus.Value = not Values.Rus.Value
	if Values.Rus.Value then
		ThisButton.Image = "rbxassetid://10030147781"
	else
		ThisButton.Image = "rbxassetid://10031203284"
	end
end

ThisButton.MouseButton1Click:Connect(ChangeLanguage)