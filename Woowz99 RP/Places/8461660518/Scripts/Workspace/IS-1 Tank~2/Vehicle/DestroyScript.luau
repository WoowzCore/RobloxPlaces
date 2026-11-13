-- Variables

if script.Parent.Damage.Value < 1 then

local Vehicle = script.Parent
print("Vehicle Destroy Script Enabled")

local Engine = Vehicle.Parts.Engine

Vehicle:findFirstChild("Destroyed").Value = true

			
	-- Seat Variables
	Vehicle.Parts:findFirstChild("VehicleSeat").Disabled = true
	
	-- End of Seat Variables
	
-- Start of Destroyed Animation
	-- Start of Flag Popping Animation
	Vehicle.Turret.Rod.Transparency = 0
	Vehicle.Turret.Rod.Hatch:Play()
	wait(1)
	
	Vehicle.Turret.Flag.Transparency = 0
	Vehicle.Turret.Flag.Pop:Play()
	Vehicle.Turret.Flag.Pop2:Play()

	wait()
	
	Vehicle.Turret.Flag.Pop.Volume = 0
	Vehicle.Turret.Flag.Pop2.Volume = 0
	Vehicle.Turret.Rod.Hatch.Volume = 0
	
	-- End of Flag Popping
	
	-- Start of Explosion Thingy
	local Explo = Instance.new ("Sound")
	Explo.SoundId = "rbxassetid://689314212"
	Explo.PlayOnRemove = false
	Explo.Parent = Engine
	Explo:play()
					
			
	wait()
	local Explosion = Instance.new("Explosion")
	Explosion.BlastRadius = 5
	Explosion.BlastPressure = 1
	Explosion.Parent = game.Workspace
	Explosion.Position = Engine.Position
	Explosion.DestroyJointRadiusPercent = 0
	
	-- 	End of Explosion Thingy
	
	-- Deletion of Velocities
	
	Engine.Parent.VehicleSeat.Throttle = Engine.Parent.VehicleSeat.Throttle
	Engine.Parent.VehicleSeat.MaxSpeed = Engine.Parent.VehicleSeat.MaxSpeed
	Engine.Parent.VehicleSeat.Steer = Engine.Parent.VehicleSeat.Steer
	
	Engine.BodyAngularVelocity:Destroy()
	Engine.BodyGyro:Destroy()
	Engine.BodyVelocity:Destroy()
	
	print("BodyAngularVelocity,BodyGyro,BodyVelocity Deleted, Enemy Tank Disabled")
	
	-- Generation of Fire
			
	local fi = Instance.new("Fire")
	fi.Heat = 25
	fi.Size = 10
	fi.Parent = Engine
	
	local Smokey = script.DisabledVehicleSmoke:Clone()
	Smokey.Parent = Engine
	Smokey.Name = "DSmoke"
	Smokey.Enabled = true
	print("End of DestroyScript")
	end

-- End of Destroyed Animation