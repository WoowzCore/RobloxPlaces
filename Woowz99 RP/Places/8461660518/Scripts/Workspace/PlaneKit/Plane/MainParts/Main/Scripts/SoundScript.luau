local OnFE = script.Parent.Parent.FE.OnFE
local OffFE = script.Parent.Parent.FE.OffFE
local SpeedUpFE = script.Parent.Parent.FE.SpeedUpFE
local SlowDownFE = script.Parent.Parent.FE.SlowDownFE
local ThrottleValue = 0
local Throttle = script.Parent.Parent.Variables.Throttle
local OnValue = script.Parent.Parent.Variables.On

function On()
	OnValue.Value = true
end

function Off()
	OnValue.Value = false
	ThrottleValue = 0
	Throttle.Value = ThrottleValue
end

function SpeedUp()
	if ThrottleValue ~= 100 then
		ThrottleValue = ThrottleValue + 1
		Throttle.Value = ThrottleValue
	end
end

function SlowDown()
	if ThrottleValue ~= 0 then
		ThrottleValue = ThrottleValue - 1
		Throttle.Value = ThrottleValue
	end
end

OnFE.OnServerEvent:Connect(On)
OffFE.OnServerEvent:Connect(Off)
SpeedUpFE.OnServerEvent:Connect(SpeedUp)
SlowDownFE.OnServerEvent:Connect(SlowDown)