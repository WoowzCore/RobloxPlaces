script:WaitForChild("Horn")
local mouse = game.Players.LocalPlayer:GetMouse()
car = script.Parent.Car.Value
if not car.DriveSeat:FindFirstChild("Horn") then
script.Horn:Clone().Parent = car.DriveSeat
end
car.DriveSeat:WaitForChild("Horn")

mouse.KeyDown:connect(function (key)
key = string.lower(key)
	if key == "h" then
		car.DriveSeat.Horn:Play()
	end
end)

mouse.KeyUp:connect(function (key)
key = string.lower(key)
	if key == "h" then
		car.DriveSeat.Horn:Stop()
	end
end)