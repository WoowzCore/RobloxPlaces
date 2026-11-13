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
if key == "1" then
		 carSeat.Wheels.FR.Spring.Stiffness = 6200
 		 carSeat.Wheels.FL.Spring.Stiffness = 6200
elseif key == "2" then		 
	carSeat.Wheels.FR.Spring.Stiffness = 11000
	carSeat.Wheels.FL.Spring.Stiffness = 11000
	end
end)


