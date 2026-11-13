local FE = workspace.FilteringEnabled
local car = script.Parent.Car.Value
local _Tune = require(car["A-Chassis Tune"])
local on = 0

script:WaitForChild("Supercharger")

for i,v in pairs(car.DriveSeat:GetChildren()) do
	for _,a in pairs(script:GetChildren()) do
		if v.Name==a.Name then v:Stop() wait() v:Destroy() end
	end
end
for i,v in pairs(script:GetChildren()) do
	v.Parent=car.DriveSeat
end

car.DriveSeat.Supercharger:Play()

while wait() do
	local _RPM = script.Parent.Values.RPM.Value
	
	if not script.Parent.IsOn.Value then on=math.max(on-.015,0) else on=1 end
	car.DriveSeat.Supercharger.Pitch = (car.DriveSeat.Supercharger.SetPitch.Value + car.DriveSeat.Supercharger.SetRev.Value*_RPM/_Tune.Redline)*on^2
end
