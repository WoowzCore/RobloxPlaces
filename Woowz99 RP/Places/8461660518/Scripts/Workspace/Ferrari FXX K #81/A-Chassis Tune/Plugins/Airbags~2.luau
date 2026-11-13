--//INSPARE//--
local player = game.Players.LocalPlayer
local lightOn = false
--local HUB = script.Parent.HUB
--local limitButton = HUB.Limiter

local carSeat = script.Parent.Car.Value
local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:connect(function (key)
key = string.lower(key)
--//Shifting//-
if key == "6" then
		 carSeat.Wheels.FR.Spring.Stiffness = 9000
 		 carSeat.Wheels.FL.Spring.Stiffness = 9000
elseif key == "5" then		 
	carSeat.Wheels.FR.Spring.Stiffness = 3500
	carSeat.Wheels.FL.Spring.Stiffness = 3500
	end
end)


