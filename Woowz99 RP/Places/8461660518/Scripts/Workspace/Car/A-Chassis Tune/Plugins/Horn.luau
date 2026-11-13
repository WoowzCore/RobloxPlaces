--[[
		___      _______                _     
	   / _ |____/ ___/ /  ___ ____ ___ (_)__ 
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/
 						SecondLogic @ Inspare
]]

local mouse = game.Players.LocalPlayer:GetMouse()
local car = script.Parent.Car.Value
local horn = car.DriveSeat:WaitForChild("Horn")
local FE = workspace.FilteringEnabled
local handler = car:WaitForChild("Lights_FE")

mouse.KeyDown:connect(function(key)
	if key=="h" then
		if FE then
			handler:FireServer()
			
		else
			horn:Play()
		end		
	end
end)

game:GetService("UserInputService").InputBegan:connect(function(input,IsRobloxFunction)
	if input.KeyCode ==Enum.KeyCode.ButtonB and input.UserInputState == Enum.UserInputState.Begin then
		if FE then
			handler:FireServer()
		else
			horn:Play()
		end
	end
end)