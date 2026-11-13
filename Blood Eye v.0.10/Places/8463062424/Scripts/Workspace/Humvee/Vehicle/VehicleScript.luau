local bin = script.Parent
local seat = nil
local Fire = true
local Aim = true
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

function PlaneCheck()
	if bin.Vehicle.Value ~= nil then
		if bin.Vehicle.Value:FindFirstChild("Turret") then
			local turret = bin.Vehicle.Value:FindFirstChild("Turret")
			seat = turret.Body
			return true
		end
	end
seat = nil
end

function Key(key)
	bin.Key:FireServer(key, player:GetMouse())
end

--Workspace.CurrentCamera.CameraType="Track"
mouse.Button1Down:connect(function() bin.keyDown:FireServer(player:GetMouse()) end)
mouse.Button1Up:connect(function() bin.keyUp:FireServer() end)
mouse.KeyDown:connect(function(key) bin.Key:FireServer(key) end)
mouse.Move:Connect(function() bin.Moved:FireServer(player:GetMouse().Hit) end)


bin.Unequipped:connect(function(mouse)
Aim = false
--Workspace.CurrentCamera.CameraSubject=game.Players.LocalPlayer.Character.Humanoid
--Workspace.CurrentCamera.CameraType="Custom"
bin.Name = "Vehicle"
end)

game.Players.LocalPlayer.Character.Humanoid.Changed:connect(function()
	if game.Players.LocalPlayer.Character.Humanoid.Jump then
		script.Parent:remove()
	end
end)
