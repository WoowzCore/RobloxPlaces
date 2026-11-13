Chassis = script.Parent.MainParts.Main
local animation = script.Parent.AnimationParts

function unAnchor(object)
    for _, child in pairs(object:GetChildren()) do
        if child:IsA("BasePart") or child:IsA("MeshPart") then
           child.Anchored = false
        end
        unAnchor(child)
    end
end

function setup(model,velocity)
	function createmotor(x, y)
		motor = Instance.new("Motor")
		motor.Parent = x 
		motor.Part0 = x
		motor.Part1 = y
		if velocity == "default" then
			motor.MaxVelocity = 0.01
		else
			motor.MaxVelocity = velocity
		end
	end
	
	createmotor(model.A, model.B)
	
	g = model:GetChildren()
	for i = 1, #g do
		wait()
		function weld(x, y)
		weld = Instance.new("ManualWeld") 
		weld.Part0 = x
		weld.Part1 = y
		local HitPos = x.Position
		local C0 = x.CFrame:inverse()
		local C1 = y.CFrame:inverse() 
		weld.C0 = C0 
		weld.C1 = C1 
		weld.Parent = x
		end

		if g[i].Name == "WeldPart" then
			weld(g[i], model.B)
		end
	end
		
	w = Instance.new("ManualWeld")
	w.Parent = Chassis
	w.Part0 = Chassis
	w.Part1 = model.A
	local HitPos = Chassis.Position
	local C0 = Chassis.CFrame:inverse()
	local C1 = model.A.CFrame:inverse() 
	w.C0 = C0 
	w.C1 = C1 
end

function setupInside(model,velocity)
	function createmotor(x, y)
		motor = Instance.new("Motor")
		motor.Parent = x 
		motor.Part0 = x
		motor.Part1 = y
		if velocity == "default" then
			motor.MaxVelocity = 0.005
		else
			motor.MaxVelocity = velocity
		end
	end
	
	createmotor(model.A, model.B)
	
	g = model:GetChildren()
	for i = 1, #g do
		wait()
		function weld(x, y)
		weld = Instance.new("ManualWeld") 
		weld.Part0 = x
		weld.Part1 = y
		local HitPos = x.Position
		local C0 = x.CFrame:inverse()
		local C1 = y.CFrame:inverse() 
		weld.C0 = C0 
		weld.C1 = C1 
		weld.Parent = x
		end

		if g[i].Name == "WeldPart" then
			weld(g[i], model.B)
		end
	end
		
	w = Instance.new("ManualWeld")
	w.Parent = model.Parent.B
	w.Part0 = model.Parent.B
	w.Part1 = model.A
	local HitPos = model.Parent.B.Position
	local C0 = model.Parent.B.CFrame:inverse()
	local C1 = model.A.CFrame:inverse() 
	w.C0 = C0 
	w.C1 = C1 
end

--Setup animation here--
setup(animation.SL1,0.001)
setup(animation.SL2,0.001)
setup(animation.SL3,0.001)
setup(animation.SL4,0.001)
setup(animation.F1,0.001)
setup(animation.F2,0.001)
setup(animation.F3,0.001)
setup(animation.F4,0.001)
setup(animation.FF1,0.001)
setup(animation.FF2,0.001)
setup(animation.FF3,0.001)
setup(animation.FF4,0.001)
setup(animation.S1,0.01)
setup(animation.S2,0.01)
setup(animation.S3,0.01)
setup(animation.S4,0.01)
setup(animation.FLDoor,0.01)
setup(animation.FRDoor,0.01)
setup(animation.RLDoor,0.01)
setup(animation.RRDoor,0.01)
setup(animation.CDoor1,0.01)
setup(animation.CDoor2,0.01)
setup(animation.Engine1)
setup(animation.Engine2)
setup(animation.NGear,0.008)
setup(animation.LGear,0.005)
setup(animation.RGear,0.005)
setup(animation.NGDoorL,0.013)
setup(animation.NGDoorR,0.013)
setup(animation.LGDoor,0.005)
setup(animation.RGDoor,0.005)
setupInside(animation.F1.T,0.001)
setupInside(animation.F2.T,0.001)
setupInside(animation.F3.T,0.001)
setupInside(animation.F4.T,0.001)
setupInside(animation.LGDoor.Door)
setupInside(animation.LGDoor.Door.Door,0.005)
setupInside(animation.RGDoor.Door)
setupInside(animation.RGDoor.Door.Door,0.005)
setupInside(animation.LGear.Gear,0.005)
setupInside(animation.RGear.Gear,0.005)
setupInside(animation.LGear.Gear.Strut,0.025)
setupInside(animation.RGear.Gear.Strut,0.025)
setupInside(animation.NGear.Wheel)
setupInside(animation.LGear.Gear.Wheel)
setupInside(animation.RGear.Gear.Wheel)
setup(animation.RThrust)
wait(2)
animation.NGDoorL.A.Motor.DesiredAngle = 1.35
animation.NGDoorR.A.Motor.DesiredAngle = 1.35
animation.LGDoor.A.Motor.DesiredAngle = 1.5
animation.RGDoor.A.Motor.DesiredAngle = 1.5
animation.LGDoor.Door.Door.A.Motor.DesiredAngle = 1
animation.RGDoor.Door.Door.A.Motor.DesiredAngle = 1
animation.Engine1.A.Motor.DesiredAngle = 100e100
animation.Engine2.A.Motor.DesiredAngle = 100e100
animation.NGear.Wheel.A.Motor.C1 = animation.NGear.Wheel.A.Motor.C1 * CFrame.new(0,-0.6,0)
animation.LGear.Gear.Wheel.A.Motor.C1 = animation.LGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,-0.6,0)
animation.RGear.Gear.Wheel.A.Motor.C1 = animation.RGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,-0.6,0)
animation.LGDoor.Door.A.Motor.C1 = animation.LGDoor.Door.A.Motor.C1 * CFrame.new(-1.45,0,0)
animation.RGDoor.Door.A.Motor.C1 = animation.RGDoor.Door.A.Motor.C1 * CFrame.new(-1.45,0,0)
script.Parent.Weld.Disabled = false
unAnchor(script.Parent.AnimationParts)