local EBL = require(script.Parent:WaitForChild("EBLibbary"))
local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local humrootpart = chr:WaitForChild("HumanoidRootPart")
local hum = chr:WaitForChild("Humanoid")
local gui = plr.PlayerGui:WaitForChild("Base")
gui.Enabled = true
plr.PlayerGui.CameraOverlay.Enabled = true
local keyboard = require(script.Parent.KeyBoard)
local u = game:GetService("UserInputService")

u.InputBegan:Connect(function(key,chat)
	if chat then return end
	
	if key.KeyCode == Enum.KeyCode.F1 then
		gui.Enabled = not gui.Enabled
	end
	if key.KeyCode == Enum.KeyCode.F3 then
		plr.PlayerGui.CameraOverlay.Enabled = not plr.PlayerGui.CameraOverlay.Enabled
	end
	if key.KeyCode == Enum.KeyCode.F5 then
		plr.PlayerGui.Debug.Enabled = not plr.PlayerGui.Debug.Enabled
	end
end)