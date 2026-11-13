wait()
local FE = workspace.FilteringEnabled
local car = script.Parent.Car.Value
car.Wheels.RL.SQ:Play()
car.Wheels.RR.SQ:Play()
car.Wheels.FL.SQ:Play()
car.Wheels.FR.SQ:Play()
local handler = car:WaitForChild("Smoke_FE")

while wait(.2) do
	local r1 = Ray.new(car.Wheels.RL.Position,(car.Wheels.RL.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(.05+car.Wheels.RL.Size.x/2))
	local r1hit = 0
	if workspace:FindPartOnRay(r1,car)~=nil then r1hit=1 end

	local r2 = Ray.new(car.Wheels.RL.Position,(car.Wheels.RR.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(.05+car.Wheels.RR.Size.x/2))
	local r2hit = 0
	if workspace:FindPartOnRay(r2,car)~=nil then r2hit=1 end
	
	local f1 = Ray.new(car.Wheels.FL.Position,(car.Wheels.FL.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(.05+car.Wheels.FL.Size.x/2))
	local f1hit = 0
	if workspace:FindPartOnRay(f1,car)~=nil then f1hit=1 end

	local f2 = Ray.new(car.Wheels.FL.Position,(car.Wheels.FR.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(.05+car.Wheels.FR.Size.x/2))
	local f2hit = 0
	if workspace:FindPartOnRay(f2,car)~=nil then f2hit=1 end
	
	local rl = math.min((math.max(math.abs((car.Wheels.RL.RotVelocity.Magnitude*car.Wheels.RL.Size.x/2) - (car.Wheels.RL.Velocity.Magnitude))-8,0)),50)*r1hit
	local rr = math.min((math.max(math.abs((car.Wheels.RR.RotVelocity.Magnitude*car.Wheels.RR.Size.x/2) - (car.Wheels.RR.Velocity.Magnitude))-8,0)),50)*r2hit
	local fl = math.min((math.max(math.abs((car.Wheels.FL.RotVelocity.Magnitude*car.Wheels.FL.Size.x/2) - (car.Wheels.FL.Velocity.Magnitude))-8,0)),50)*f1hit
	local fr = math.min((math.max(math.abs((car.Wheels.FR.RotVelocity.Magnitude*car.Wheels.FR.Size.x/2) - (car.Wheels.FR.Velocity.Magnitude))-8,0)),50)*f2hit
	
	if FE then
		handler:FireServer("UpdateSmoke",rl,rr,fl,fr)
	end
	
	if game.Players.LocalPlayer.Character.Humanoid.Sit == false then
	car.Wheels.RL.SQ:Stop()
	car.Wheels.RR.SQ:Stop()
	car.Wheels.FL.SQ:Stop()
	car.Wheels.FR.SQ:Stop()
	end
end
