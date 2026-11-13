wait(2)
local UIS = game:GetService("UserInputService")
local SG = game:GetService("StarterGui")
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local PlayerData = require(Character:WaitForChild("PlayerData"))
local UI = PlayerData.UI

SG:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,false)
--SG:SetCoreGuiEnabled(Enum.CoreGuiType.Health,false)
SG:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)
SG:SetCoreGuiEnabled(Enum.CoreGuiType.Captures,false)
SG:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu,false)

game:GetService("RunService").RenderStepped:Connect(function()
	if (PlayerData.PlayerLoaded) then
		local ColorPickItem = Color3.new(1,1,1)
		if PlayerData.PickedItem ~= nil then
			ColorPickItem = Color3.new(1,0.5,0)
		end
		UI:WaitForChild("Center").Enabled = not PlayerData.UnlockMouse
		UI.Center.Dot.ImageColor3 = ColorPickItem
		UI:WaitForChild("Backpack").Enabled = (PlayerData.Keys[Enum.KeyCode.Q] and PlayerData.PickedItem==nil)
		PlayerData.UnlockMouse = UI.Backpack.Enabled
		
		UIS.MouseIconEnabled = PlayerData.UnlockMouse
	end
end)