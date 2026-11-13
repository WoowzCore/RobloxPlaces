local car = script.Parent.Car.Value

script:WaitForChild("Start1")
script:WaitForChild("Start2")

for i,v in pairs(car.DriveSeat:GetChildren()) do
	for _,a in pairs(script:GetChildren()) do
		if v.Name==a.Name then v:Stop() wait() v:Destroy() end
	end
end
for i,v in pairs(script:GetChildren()) do
	v.Parent=car.DriveSeat
end

car.DriveSeat.Start1:Play(433787093)
wait(7.4)
car.DriveSeat.Start2:Play(250165211)
script.Parent.IsOn.Value=true
wait(.6)
car.DriveSeat.Start1:Stop(433787093)
car.DriveSeat.Start2:Stop(250165211)