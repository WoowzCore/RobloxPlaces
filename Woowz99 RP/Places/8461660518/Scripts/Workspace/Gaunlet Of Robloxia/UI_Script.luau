local Players = game:GetService("Players")
local Local = Players.LocalPlayer
local GUI_Service = Local.PlayerGui
script.Parent.Equipped:Connect(function()
	UI = script.AbilitiesUI:Clone()
	UI.Parent = GUI_Service
end)
script.Parent.Unequipped:Connect(function()
	UI:Destroy()
end)