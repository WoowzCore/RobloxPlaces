local Player = script.Parent.Parent.Parent
local Mouse = Player:GetMouse()

function FixCam()
	workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	Player.PlayerGui.PlaneGui:Destroy()
	Mouse.Icon = "" -- This will return to normal cursor bot a black cursor
end

function Forced()
	if Player.Character.Humanoid.Health == 0 then
		FixCam()
	elseif Player.Character.Humanoid.Jump == true then
		FixCam()
	end
end

Player.Character.Humanoid.HealthChanged:Connect(Forced)
Player.Character.Humanoid.Changed:Connect(Forced)
