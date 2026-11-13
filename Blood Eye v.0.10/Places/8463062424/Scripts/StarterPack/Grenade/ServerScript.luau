local tool = script.Parent
local config = tool:WaitForChild("Configurations")

-- Uber l33t maths to calcluate the angle needed to throw a projectile a distance, given the altitude of the end point and the projectile's velocity
function AngleOfReach(distance, altitude, velocity)
	local gravity = workspace.Gravity
	local theta = math.atan((velocity^2 + math.sqrt(velocity^4 -gravity*(gravity*distance^2 + 2*altitude*velocity^2)))/(gravity*distance))
	if theta ~= theta then
		theta = math.pi/4
	end
	return(theta)
end

-- A simple function to explode a specified part
function Explode(part)
	local explosion = Instance.new("Explosion", workspace)
	explosion.Position = part.Position
	explosion.BlastRadius = config.ExplosionRadius.Value
	part:Destroy()
end

script.Parent.Throw.OnServerEvent:connect(function(player, mousePosition)
	local handlePos = Vector3.new(tool.Handle.Position.X, 0, tool.Handle.Position.Z) -- remove Y from the equation, it's not needed
	local mousePos = Vector3.new(mousePosition.X, 0, mousePosition.Z) -- ditto
	local distance = (handlePos - mousePos).magnitude -- Get the distance between the handle and the mouse
	local altitude = mousePosition.Y - tool.Handle.Position.Y
	local angle = AngleOfReach(distance, altitude, config.GrenadeVelocity.Value) -- Calculate the angle
	
	tool.Handle.Transparency = 1
	local grenade = tool.Handle:Clone()
	grenade.Parent = workspace
	grenade.Transparency = 0
	grenade.CanCollide = true
	grenade.CFrame = tool.Handle.CFrame
	grenade.Velocity = (CFrame.new(grenade.Position, Vector3.new(mousePosition.X, grenade.Position.Y, mousePosition.Z)) * CFrame.Angles(angle, 0, 0)).lookVector * config.GrenadeVelocity.Value -- Throwing 'n stuff, it probably didn't need to be this long
	spawn(function()
		if config.ExplodeOnTouch.Value then
			grenade.Touched:connect(function(hit)
				if hit.Parent ~= tool.Parent and hit.CanCollide then -- Make sure what we're hitting is collidable
					Explode(grenade)
				end
			end)
		else	
			wait(config.FuseTime.Value)
			Explode(grenade)
		end
	end)
	wait(config.Cooldown.Value)
	tool.Handle.Transparency = 0
end)