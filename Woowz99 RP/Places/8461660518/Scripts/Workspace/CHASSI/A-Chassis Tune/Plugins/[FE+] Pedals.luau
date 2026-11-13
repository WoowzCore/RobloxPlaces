local car = script.Parent.Car.Value
local handler = car:WaitForChild("PedalsFE")

script.Parent.Values.Throttle.Changed:connect(function()
	script.Pedal:Play()
	local gas = script.Parent.Values.Throttle.Value^1*math.rad(45)
	handler:FireServer("PedalUpdate","Gas",gas)
end)
script.Parent.Values.Brake.Changed:connect(function()
	script.Pedal:Play()
	local bp = script.Parent.Values.Brake.Value^1*math.rad(45)
	handler:FireServer("PedalUpdate","Brake",bp)
end)

