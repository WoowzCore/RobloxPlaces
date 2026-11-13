-- ORIGINAL HPREADER BY RIKONE2
-- EDITED BY BOBNOOBINGTON
-- CLICK THE GUI TO TOGGLE BETWEEN HORSEPOWER/TORQUE READINGS

local car = script.Parent.Parent.Car.Value
local player=game.Players.LocalPlayer
local mouse = player:GetMouse()
local MaxHP = 0
local MaxTQ = 0

script.Parent:WaitForChild("Button")

script.Parent.Button.MouseButton1Click:connect(function()
	   script.Parent.HP.Visible = not script.Parent.HP.Visible
	   script.Parent.MAXHP.Visible = not script.Parent.MAXHP.Visible
	   script.Parent.TQ.Visible = not script.Parent.TQ.Visible
	   script.Parent.MAXTQ.Visible = not script.Parent.MAXTQ.Visible
end)

while wait() do
	if math.floor(script.Parent.Parent.Values.Horsepower.Value) > MaxHP then
		MaxHP = math.floor(script.Parent.Parent.Values.Horsepower.Value)
	end
	script.Parent.HP.Text ="HP: ".. math.floor(script.Parent.Parent.Values.Horsepower.Value)
	script.Parent.MAXHP.Text = "MaxHP: " .. MaxHP
	
	if math.floor(script.Parent.Parent.Values.Torque.Value) > MaxTQ then
		MaxTQ = math.floor(script.Parent.Parent.Values.Torque.Value)
	end
	script.Parent.TQ.Text ="TQ: ".. math.floor(script.Parent.Parent.Values.Torque.Value)
	script.Parent.MAXTQ.Text = "MaxTQ: " .. MaxTQ
end