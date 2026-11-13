repeat wait() until script.Parent.Parent.Vehicle.Value~=nil
repeat Wait() until game.Players.LocalPlayer and game.Players.LocalPlayer:GetMouse()

local Gui = script.Parent

local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

local Camera = workspace.CurrentCamera

local AimPart = script.Parent.Parent.Vehicle.Value.AimPart

local BarrelView = script.Parent.BarrelView

local View = false

Gui.Crosshair1.MouseButton1Down:connect(function()
	Gui.Crosshair1.BorderColor3 = Color3.new(1, 1, 1)
	Gui.Crosshair2.BorderColor3 = Color3.new(0, 0, 0)
	Gui.Parent.Crosshairs.Image = Gui.Crosshair1.Image
end)

Gui.Crosshair2.MouseButton1Down:connect(function()
	Gui.Crosshair2.BorderColor3 = Color3.new(1, 1, 1)
	Gui.Crosshair1.BorderColor3 = Color3.new(0, 0, 0)
	Gui.Parent.Crosshairs.Image = Gui.Crosshair2.Image
end)

BarrelView.MouseButton1Down:connect(function()
	if not View then
		View = true
		Camera.CameraType = "Scriptable"
		BarrelView.Text = "NORMAL VIEW"
		Gui.Parent.Crosshairs.Visible = true
	else
		View = false
		Camera.CameraType = "Custom"
		BarrelView.Text = "CLICK FOR FIRST PERSON"
		Gui.Parent.Crosshairs.Visible = false
	end
end)

Mouse.Move:connect(function()
	if View then
		Camera.CoordinateFrame = AimPart.CFrame
	end
	if not Gui or Gui.Parent == nil then
		Camera.CameraType = "Custom"
		script:Destroy()
	end
end)
Mouse.Idle:connect(function()
	if View then
		Camera.CoordinateFrame = AimPart.CFrame
	end
	if not Gui or Gui.Parent == nil then
		Camera.CameraType = "Custom"
		script:Destroy()
	end
end)

