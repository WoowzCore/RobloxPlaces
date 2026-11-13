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
if key == "3" then
		 carSeat.Wheels.RR.Spring.Stiffness = 6200
 		 carSeat.Wheels.RL.Spring.Stiffness = 6200
elseif key == "4" then		 
	carSeat.Wheels.RR.Spring.Stiffness = 11000
	carSeat.Wheels.RL.Spring.Stiffness = 11000
	end
end)


