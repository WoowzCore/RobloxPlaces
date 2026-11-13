parts = script.Parent; --Parts Model For The Tank
ignoreList = {script.Parent}; --Table Which The Rays Will Ignore
radius = 0.1; --Kill Radius For HE Rounds (2*Radius Is Hurt Zone)

damage = 540 + math.random(-15,15)
Pen = 458 + math.random(-20,20)

makeRays = false;



--Remove Old Rays
if workspace:findFirstChild("Rays") then
	workspace:findFirstChild("Rays"):remove();
end
--Make New Model For Rays If Enabled
if makeRays then
	m = Instance.new("Model");
	m.Name = "Rays";
	m.Parent = workspace;
end

--Function For Making New Ray Bricks
function makeRay(cframe, size)
	local p						= Instance.new("Part")
	p.Name						= "RayPart"
	p.BrickColor				= BrickColor.new("Bright red")
	p.Transparency				= 0.5
	p.Anchored					= true
	p.CanCollide				= false
	p.TopSurface				= Enum.SurfaceType.Smooth
	p.BottomSurface				= Enum.SurfaceType.Smooth
	p.formFactor				= Enum.FormFactor.Custom
	p.CFrame					= cframe
	p.Size						= size
	p.Parent					= m
	ignoreList[#ignoreList+1]	= p
end

		local flash = parts.Parent.Gun.Muzzle:clone()
		
	    
		flash.Parent = game.Workspace
		
		
		flash.Anchored = true

		parts.Parent.Gun.Muzzle.Sound:Play();
		local FL				= flash.PointLight:clone()
		FL.Parent				= flash
		FL.Enabled = true
		local Flashy = flash.Flash:clone()
		Flashy.Parent = flash
		Flashy.Enabled = true
		game.Debris:AddItem(FL, .07)
		game.Debris:AddItem(Flashy, 2)
		game.Debris:AddItem(flash, .08)

round					= Instance.new("Part", user)
round.Name				= "RayPart"
round.Transparency		= 0
round.Anchored			= true
round.CanCollide		= true
round.TopSurface		= Enum.SurfaceType.Smooth
round.BottomSurface		= Enum.SurfaceType.Smooth
round.Material			= Enum.Material.Neon
round.formFactor		= Enum.FormFactor.Custom
round.BrickColor		= BrickColor.new("Daisy orange")
yOffset					= -0.2

local PL				= Instance.new("PointLight")
PL.Parent				= round
PL.Brightness			= 50
PL.Color				= Color3.new(255, 255, 0)
PL.Range				= 10
PL.Shadows				= true


--Offset For Each New Ray For The Bullet's Trajectory
local offset			= (parts.Parent.Gun.Muzzle.CFrame*CFrame.new(math.random(-4.3,4.3)/3,100,math.random(-4.3,4.3)/3).p
							- parts.Parent.Gun.Muzzle.Position).unit
							*script.Parent.Stats.GunVelocity.Value
local point1			= parts.Parent.Gun.Muzzle.Position
--Loop For Making Rays For The Bullet's Trajectory

local fallOfShot = 4.75

for i = 1, 120 do
	local thisOffset = offset + Vector3.new(0, yOffset*(i-fallOfShot), 0)
	local travelRay = Ray.new(point1,thisOffset)
	local hit, position = workspace:FindPartOnRay(travelRay, parts.Parent)

	local distance 		= (position - point1).magnitude
	round.Size				= Vector3.new(1.1, distance, 1.1)
	round.CFrame			= CFrame.new(position, point1)
								* CFrame.new(0, 0, -distance/2)
								* CFrame.Angles(math.rad(90),0,0)
	round.Parent			= workspace
	point1					= point1 + thisOffset
	
	

	if hit then
		round:remove()
		local e = Instance.new("Explosion")
		e.BlastRadius = 5
		e.BlastPressure = 10
		e.Position = position
		e.Parent = workspace
		e.DestroyJointRadiusPercent = 0
		
		

			if hit and hit.Parent then
		if hit.Parent:FindFirstChild("Humanoid") then
			return hit.Parent.Humanoid
		elseif hit.Parent.Parent:FindFirstChild("Humanoid") then
			return hit.Parent.Parent.Humanoid
		
		elseif (hit.Parent.Name ==  "Hull") or (hit.Parent.Name ==  "Turret") or (hit.Parent.Name ==  "Gun") or (hit.Parent.Name ==  "Parts") then
			print("You Have Damaged a Vehicle")
			local HitSound = hit.Parent:findFirstChild("Pen"):Clone()
			HitSound.Parent = hit
			HitSound:Play()
			hit.Parent.Parent:findFirstChild("Damage").Value = hit.Parent.Parent:findFirstChild("Damage").Value - damage
			if hit.Parent.Parent:findFirstChild("Damage").Value<1 and hit.Parent.Parent:findFirstChild("Destroyed").Value == false then
				
			local DestroyScript = hit.Parent.Parent:findFirstChild("DestroyScript"):clone()
			DestroyScript.Parent = hit.Parent.Parent
			DestroyScript.Disabled = false		
		
			print("Vehicle Disabled")
		
		
			end

		elseif hit.Name == "Left Arm" or hit.Name == "Left Leg" or hit.Name == "Right Arm" or hit.Name == "Right Leg" or hit.Name == "Torso" or hit.Name == "HumanoidRootPart" then
			hit.Parent:findFirstChild("Humanoid").Health = hit.Parent:findFirstChild("Humanoid").Health - damage
			print("Direct Hit a Player lmao")
			
		elseif hit.Parent.Name == "Face" then
			hit.Parent.Parent:findFirstChild("Humanoid").Health = hit.Parent.Parent:findFirstChild("Humanoid").Health - dealingdamage
			print("Direct Hit a Morph of a Player lmao")
			
				
			
		end
		end

		

		local players = game.Players:getChildren()
		for i = 1, #players do
		
			
			-- if players[i].TeamColor ~= script.Parent.Parent.Tank.Value then --if he's not an ally
				character = players[i].Character
				torso = character:findFirstChild'Torso'
				if character and torso then
						
						torsoPos = torso.Position
						origPos = round.Position
						
						local ray = Ray.new(origPos, torsoPos-origPos)
						local hit, position = game.Workspace:FindPartOnRayWithIgnoreList(ray,ignoreList)
						if hit then
							if hit.Parent == character then
								human = hit.Parent:findFirstChild("Humanoid")
								human2 = hit.Parent.Parent:findFirstChild("Humanoid")
								if human then
									distance = (position-origPos).magnitude
--									print("Distance from "..character.Name.." = "..distance)
									if distance <= 2*radius then
										torso.Velocity = (torso.Position - position).unit * 100;
										human:takeDamage(100-(distance-radius)*(100/radius))
										
										-- If player died
--										if human.Health <= 0 then
--											torso.Velocity = (torso.Position - position).unit * 10;
--											print("Dead");
--										end
										
										print("Took "..(100-(distance-radius)*(100/radius)).." Damage")
									end
								elseif human2 then
									distance = (position-origPos).magnitude
--									print("Distance from "..character.Name.." = "..distance)
									if distance <= 2*radius then
										torso.Velocity = (torso.Position - position).unit * 100;
										human:takeDamage(100-(distance-radius)*(100/radius))
										
										-- If player died
--										if human.Health <= 0 then
--											torso.Velocity = (torso.Position - position).unit * 10;
--											print("Dead");
--										end
										
										print("Took "..(100-(distance-radius)*(100/radius)).." Damage")
									end
								end
--							else print("Didn't hit Target")
							end
							if makeRays then
								makeRay(CFrame.new(origPos, position)
									* CFrame.new(0, 0, -distance/2), Vector3.new(0.2, 0.2, distance))
							end
						end
					end
				end
			
		
	
	
		
		round:remove()
		
		break
	end
	wait()
end
if round then
	round:remove()
end
script:remove()