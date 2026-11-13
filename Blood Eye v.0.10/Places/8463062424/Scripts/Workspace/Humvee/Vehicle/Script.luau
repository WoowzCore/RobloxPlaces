local bin = script.Parent
local seat = nil
local Fire = true
local Aim = true

local creator = Instance.new("ObjectValue")
creator.Name = "creator"
creator.Value = bin.Parent.Parent
function PlaneCheck()
	if bin.Vehicle.Value ~= nil then
		if bin.Vehicle.Value:FindFirstChild("Turret") then
			local turret = bin.Vehicle.Value:FindFirstChild("Turret")
			seat = turret.Body
			return true
		end
	end
seat = nil
end

local firing = false

local gunSpecs = {
	bulletMass			= 1;
	bulletSpeed			= 3500; -- studs/sec
	accuracy       	= 60;
	verticalRecoil		= 5;
	horizontalRecoil	= 5;
}
local mem_da = 0
local mem_ea = 0 
local turnspeed = 0.2
local g = 50
local trajectoryd = 0
local up = 0
ROF = 0.1
BaseDamage = 45
reloading = false

function tagHumanoid(humanoid)
	if plr~=nil then
		local tag=Instance.new("ObjectValue")
		tag.Value=plr
		tag.Name="creator"
		tag.Parent=humanoid
		delay(2,function()
			if tag~=nil then
				tag.Parent=nil
			end
		end)
	end
end

	function movecframe(p,pos)
		p.Parent=game.Lighting
		p.Position=pos
		p.Parent=game.Workspace
	end
	
	 function rayCast(pos, dir, ignore)
		return workspace:FindPartOnRayWithIgnoreList(Ray.new(pos, dir.unit * math.min(dir.magnitude, 999)), ignore)
	end
	
	 function calculateTrajectory(velocity, gravity, mass, t)
		return velocity*t + gravity*mass*t*t
	end
	
	 function createPart(name, parent, delete)
		local part = Instance.new("Part")
		part.BottomSurface = "Smooth"
		part.TopSurface = "Smooth"
		part.FormFactor = "Custom"
		part.CanCollide = false
		part.Name = name
		part.Size = Vector3.new(0.2, 0.2, 0.2)
		part.Parent = parent
		if delete then
			game.Debris:AddItem(part)
		end
		return part
	end
	 function createWeld (p0, p1, c0, c1)
		local weld = Instance.new("Weld")
		weld.Part0 = p0
		weld.Part1 = p1
		weld.C0 = c0 or CFrame.new(0, 0, 0)
		weld.C1 = c1 or CFrame.new(0, 0, 0)
		weld.Parent = p0
		return weld
	end

	 function placePartWithMesh(part, mesh, pos0, pos1)
		local frame = CFrame.new((pos0 + pos1) / 2, pos1)
		part.CFrame = frame - frame.p
		mesh.Offset = part.CFrame:pointToObjectSpace(frame.p)
		mesh.Scale = Vector3.new(mesh.Scale.x, mesh.Scale.y, (pos0 - pos1).magnitude * 5)
	end
	function createBlockMesh(part, scale)
		local mesh = Instance.new("BlockMesh")
		mesh.Scale = scale
		mesh.Parent = part
		return mesh
	end
	function lerp(a, b, t)
	return a + (b - a)*t
end

function GetSurfaceNormal(part,point) 
	local p = part.CFrame:toObjectSpace(CFrame.new(point)).p
	if part.ClassName == "Part" and (part.Shape == Enum.PartType.Ball or part.Shape == Enum.PartType.Cylinder) then
		return (point - part.CFrame.p)
	elseif (math.abs(p.X)>=part.Size.X/2-.1) then
		return (part.CFrame*Vector3.new(p.X/math.abs(p.X),0,0)-part.CFrame.p)
	elseif (math.abs(p.Y)>=part.Size.Y/2-.1) then
		return (part.CFrame*Vector3.new(0,p.Y/math.abs(p.Y),0)-part.CFrame.p)
	elseif (math.abs(p.Z)>=part.Size.Z/2-.1) then
		return (part.CFrame*Vector3.new(0,0,p.Z/math.abs(p.Z))-part.CFrame.p)
	elseif part.ClassName == "WedgePart" then
		return part.Position - (part.CFrame * CFrame.new(0,-part.Size.Z,part.Size.Y)).p
	end
end

function concreteHit(part, point, isAnchored)
	local direction = GetSurfaceNormal(part,point).unit
	local hole = game.Lighting.BulletHoleConcrete:clone()
	--[[local sound = game.Lighting:FindFirstChild("BulletHit"..math.random(1,4)):clone()
	sound.PlayOnRemove = false
	sound.Parent = hole
	sound.Volume = 1
	sound.Pitch = math.random(60,80) *0.01]]
	hole.Parent = game.Workspace
	--sound:Play()
	--hole.Base.Fire.Color = part.BrickColor.Color
	--hole.Base.Fire.SecondaryColor = part.BrickColor.Color
	hole.Base.CFrame = CFrame.new(point, point + direction) * CFrame.Angles(math.rad(90),0,0)
	hole.Base.Transparency = 1
	game.Debris:AddItem(hole,.05)
	Spawn(function()
		--wait(1/15)
		--hole.Base.Fire.Enabled = false
	end)
end



function metalHit(part, point, isAnchored)
	local direction = GetSurfaceNormal(part,point).unit
	local hole = game.Lighting.BulletHoleMetal:clone()
	--[[local sound = game.Lighting:FindFirstChild("BulletHit"..math.random(1,4)):clone()
	sound.PlayOnRemove = false
	sound.Parent = hole
	sound.Volume = 1
	sound.Pitch = math.random(60,80) *0.01]]
	hole.Parent = game.Workspace
	--sound:Play()
	
	--hole.Base.Fire.Color = part.BrickColor.Color
	--hole.Base.Fire.SecondaryColor = part.BrickColor.Color
	hole.Base.BrickColor = part.BrickColor
	hole.Base.CFrame = CFrame.new(point, point + direction) * CFrame.Angles(math.rad(90),0,0)
	hole.Base.Transparency =  1
	game.Debris:AddItem(hole,.05)
	--print("Fire")
	Spawn(function()
		--wait(1/15)
		--hole.Base.Fire.Enabled = false
	end)
end



function fleshHit(part, point, direction)
	local hole = game.Lighting.BulletHoleFlesh:clone()
	--[[local sound = game.Lighting:FindFirstChild("BulletHit"..math.random(1,4)):clone()
	sound.PlayOnRemove = false
	sound.Parent = hole
	sound.Volume = 1
	sound.Pitch = math.random(60,80) *0.01]]
	hole.Parent = game.Workspace
	--sound:Play()
	
	hole.Base.CFrame = CFrame.new(point, point + direction) * CFrame.Angles(math.rad(90),0,0)
	--hole.Base.Sound:Play()
	game.Debris:AddItem(hole,.05)
	Spawn(function()
		--wait(1/15)
		--hole.Base.Fire.Enabled = false
	end)
end



function reload(mouse)
if plane.Turret.Ammo.Value<plane.Turret.ClipSize.Value then
	reloading=true
	head.Reload:Play()
	--ReloadSequence()
		if reloading then
				am2 = plane.Turret.ClipSize.Value - plane.Turret.Ammo.Value
				plane.Turret.Ammo.Value = plane.Turret.ClipSize.Value
			--check()
		end
	--check()
	--mouse.Icon=Cursors[1]
	reloading=false
end
end




function getYawFromVector(lvec)
	local yaw = 0
	local a = lvec.X
	local o = lvec.Z
	yaw = math.atan2(a,o) + math.pi
	return yaw
end


suppresionrange = 15
function suppress(pos)
	local Players = game.Players:GetChildren()
	for i = 1, #Players do 
		local char = Players[i].Character 
		if char:FindFirstChild("Torso") then
			local torso = char:FindFirstChild("Torso")
			local torsodist = (torso.Position - pos).magnitude
			if torsodist <= suppresionrange then
				local bullethit = game.Lighting.BulletHit:clone()
				bullethit.Parent = Players[i]
				wait()
				bullethit:remove()
			end		
		end
	end
end

function whizsound(lvec,start)
delay(0,function()
	Players = game.Players:GetChildren()
	for i = 1, #Players do 
		if Players[i] ~= game.Players:GetPlayerFromCharacter(bin.Parent) and Players[i].TeamColor ~= game.Players:GetPlayerFromCharacter(bin.Parent).TeamColor then
		if Players[i].Character then
			if Players[i].Character.Torso then
				local lvec2 = (startpoint - Players[i].Character.Torso.Position).unit
				angle1 = math.deg(getYawFromVector(lvec))
				angle2 =  math.deg(getYawFromVector(lvec2))
				print(((lvec*10) - Players[i].Character.Torso.Position).magnitude , ((lvec*10) - start).magnitude)
				if ((lvec*10) - Players[i].Character.Torso.Position ).magnitude  < ((lvec*10) - start).magnitude then
					--print(angle2,(angle1-10))
					local difangle = (angle1-angle2)-180
					local distance = math.abs(math.sin(math.rad(difangle)) * (start - Players[i].Character.Torso.Position).magnitude)
					--part.CFrame:pointToObjectSpace(frame.p)
					--distance = hey
					if distance < 10 then
						local whiz = game.Lighting.whiz.Value:clone()
						whiz.Parent = Players[i]
						wait()
						whiz:remove()
					end
				end
			end
		end
		end
	end
end)
end

function recoilCam(angle, sway, timeUp, timeDown)
	recoilId = (recoilId or 0)+ 1 % 20
	local framesUp = math.ceil(timeUp*50)
	local framesDown = math.ceil(timeDown*50)
	local c = coroutine.create(function()
		--Game.Players.LocalPlayer.Character:FindFirstChild("Recoil").Value = true
		local myId = recoilId
		for i = 1, framesUp do
			if myId ~= recoilId then break end
			cam = game.Workspace.CurrentCamera 
			local cam_rot = cam.CoordinateFrame - cam.CoordinateFrame.p
			local cam_scroll = (cam.CoordinateFrame.p - cam.Focus.p).magnitude
			local ncf = CFrame.new(cam.Focus.p)*cam_rot*CFrame.Angles(math.rad(angle/framesUp),math.rad(sway/framesUp),0)
			cam.CoordinateFrame = ncf*CFrame.new(0, 0, cam_scroll)			
			wait(1/50)
		end
		for i = 1, framesDown do
			if myId ~= recoilId then break end
			local i = (recoil * math.random() * 2 -recoil)/2
			cam = game.Workspace.CurrentCamera 
			local cam_rot = cam.CoordinateFrame - cam.CoordinateFrame.p
			local cam_scroll = (cam.CoordinateFrame.p - cam.Focus.p).magnitude
			local ncf = CFrame.new(cam.Focus.p)*cam_rot*CFrame.Angles(math.rad(-angle/framesDown),math.rad(-sway/framesDown),0)
			cam.CoordinateFrame = ncf*CFrame.new(0, 0, cam_scroll)	
			wait(1/50)
		end
		--Game.Players.LocalPlayer.Character:FindFirstChild("Recoil").Value = false
		coroutine.yield()
	end)
	coroutine.resume(c)
end

function firemachinegun()
ammo = seat.Parent.Ammo.Value
ClipSize = seat.Parent.ClipSize.Value
h = bin.Parent.Humanoid
	if seat.Parent.Ammo.Value > 0 and reloading == false then
	BaseDamage = seat.Parent:FindFirstChild("Damage").Value
	seat.Parent.Ammo.Value = seat.Parent.Ammo.Value - 1
	head = seat.Parent.Top.Gun
	head.Fire:Play()
	startpoint=head.CFrame.p
--	local dir=((aim)-startpoint)
	local dir = seat.Parent.Top.Gun.CFrame.lookVector + Vector3.new(
	(math.random() * 2 - 1) / 10 * (1 - gunSpecs.accuracy / 100) /1,
	(math.random() * 2 - 1) / 10 * (1 - gunSpecs.accuracy / 100) /1,
	(math.random() * 2 - 1) / 10 * (1 - gunSpecs.accuracy / 100) /1)

	local position = head.Position
	local velocity = dir.unit * gunSpecs.bulletSpeed
	local pos0, hit
	local pos1 = position
	--local bullet = createPart("Bullet", workspace.Ignore, true)
	--bullet.BrickColor = BrickColor.new(1008)
	--bullet.Anchored = true
	--bullet.CFrame = CFrame.new(0, 0, 0)
	--local bulletMesh = createBlockMesh(bullet, Vector3.new(1, 1, 1))
whizsound(dir.unit,startpoint)

spawn(function()
					local time = 0.6
					for i = 1, 5 do
						pos0 = pos1
						pos1 = (velocity * time) + Vector3.new(0, -(10 * time), 0)

						-- Ray cast
						hit, pos1 = rayCast(pos0, pos1, {seat.Parent,seat.Parent.Top,seat.Parent.Bottom,seat.Parent.Parent,workspace.Ignore,bin.Parent,game.Workspace.CurrentCamera})


						-- Place path
						if i == 1 then
				
						else
						--	placePartWithMesh(bullet, bulletMesh, pos0, pos1)
						end

						-- Stop or continue
						if hit then 

						break 
						end
						time = time + wait(0.6)
					end



					-- Hit
							if hit then
								delay(0, function()
								--print(hit.Name)
								suppress(pos1)
								end)
								if hit.Parent.className == "Hat" then
									hit = hit.Parent
								elseif hit.Parent.className == "Tool" then
									hit = hit.Parent
								end
								
								local humanoid=hit.Parent:FindFirstChild("Humanoid")
								if humanoid~=nil then
									local damage=math.random(BaseDamage-(BaseDamage*0.01),BaseDamage+(BaseDamage*0.01))
									if hit.Name=="Head" then
										damage=damage*2
									elseif hit.Name=="Torso" then
									damage=damage*1.25
									else
										damage=damage
									end
									fleshHit(hit, pos1, dir.unit * -1)

									if humanoid.Health>0 and h.Health>0 then
										
										local eplr=game.Players:playerFromCharacter(humanoid.Parent)
										local plr=game.Players:GetPlayerFromCharacter(bin.Parent)
										--[[if eplr~=nil and plr~=nil then
											if eplr.Neutral or plr.Neutral then
												Mouse.Icon = "http://www.roblox.com/asset/?id=49170312"
												tagHumanoid(humanoid)
												humanoid:TakeDamage(damage)
											end
										else
											Mouse.Icon = "http://www.roblox.com/asset/?id=49170312"	
											tagHumanoid(humanoid)
											humanoid:TakeDamage(damage)
										end]]
										if eplr~=nil and plr~=nil then
										if eplr.TeamColor~=plr.TeamColor or eplr.Neutral or plr.Neutral then
												tagHumanoid(humanoid)
												humanoid:TakeDamage(damage)
										end
										else

											tagHumanoid(humanoid)
											humanoid:TakeDamage(damage)
										end
									end
								else
									if hit.Material == Enum.Material.Concrete or hit.Material == Enum.Material.Slate then
										concreteHit(hit, pos1, hit.Anchored)
									else
										metalHit(hit,pos1, hit.Anchored)
									end
								end
									
								if (hit.Parent:findFirstChild("Hit")) then
									hit.Parent.Health.Value = hit.Parent.Health.Value - BaseDamage/3
								end
								if hit.Parent:FindFirstChild("Health") then
									if hit.Parent:FindFirstChild("Owner") then
									if hit.Parent:FindFirstChild("Owner").Value.TeamColor ~= game.Players:GetPlayerFromCharacter(bin.Parent).TeamColor then
									hit.Parent.Health.Value = hit.Parent.Health.Value - BaseDamage
									end
									end
								end
								if hit.Parent.Parent:FindFirstChild("Health") then
									if hit.Parent.Parent:FindFirstChild("Owner") then
									if hit.Parent.Parent:FindFirstChild("Owner").Value.TeamColor ~= game.Players:GetPlayerFromCharacter(bin.Parent).TeamColor then
									hit.Parent.Parent.Health.Value = hit.Parent.Parent.Health.Value - BaseDamage
									end
									end
								end
								--bullet:remove()

						else
							--bullet:remove()
						end
					
	end)

	local deb=game:FindFirstChild("Debris")
	if deb==nil then
		local debris=Instance.new("Debris")
		debris.Parent=game
	end
	--check()
	head.FlashFX1.Enabled = true
	head.FlashFX2.Enabled = true
	head.FLASH.Enabled = true 
	cam = game.Workspace.CurrentCamera
	firing = true
	recoil = seat.Parent:FindFirstChild("Recoil").Value
	recoilCam(recoil*50, ((recoil*50) * math.random() * 2 - recoil)/2, .05,.2)
	--[[if not Tool.ZoomedIn.Value then
		recoil = Tool.Stats.Control.Value
		local i = (recoil * math.random() * 2 -recoil)/2
		local cam_rot = cam.CoordinateFrame - cam.CoordinateFrame.p
		local cam_scroll = (cam.CoordinateFrame.p - cam.Focus.p).magnitude
		local ncf = CFrame.new(cam.Focus.p)*cam_rot*CFrame.fromEulerAnglesXYZ(recoil, 0, 0)
		cam.CoordinateFrame = ncf*CFrame.new(i, 0, cam_scroll)
		bounceWeld(weld33, nil,CFrame.new((up3 + .1), 0, -1) * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(0), math.rad(-90)), 0, ROF)
		bounceWeld(weld55, nil, (CFrame.new(up3, 0.6, 0.8)- Vector3.new(-0.075, -0.2, -0.25)) * CFrame.fromEulerAnglesXYZ(math.rad(320), 0, math.rad(-90)),0, ROF)
	elseif Tool.ZoomedIn.Value then
		recoil = Tool.Stats.Control.Value
		local i = (recoil * math.random() * 2 -recoil)/2
		local cam_rot = cam.CoordinateFrame - cam.CoordinateFrame.p
		local cam_scroll = (cam.CoordinateFrame.p - cam.Focus.p).magnitude
		local ncf = CFrame.new(cam.Focus.p)*cam_rot*CFrame.fromEulerAnglesXYZ(recoil, 0, 0)
		cam.CoordinateFrame = ncf*CFrame.new(i, 0, cam_scroll)
		bounceWeld(weld33, nil,CFrame.new(up3, 0, -.875) * CFrame.fromEulerAnglesXYZ(math.rad(-129), math.rad(0), math.rad(-90)), 0, ROF)
		bounceWeld(weld55, nil,  CFrame.new((up3 - .08), 0.5, 0.5) * CFrame.fromEulerAnglesXYZ(math.rad(281), 0, math.rad(-90)), 0, ROF)
	end]]
	--[[if not Tool.ZoomedIn.Value then
	--	recoilCam(recoil, recoil * math.random() * 2 -recoil, .05,.2)
		bounceWeld(weld33, nil,CFrame.new((up3 + .1), 0, -1) * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(2), math.rad(-90)), .03, .15,nil,CFrame.new(up2, 0.2, -1)  * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(-0), math.rad(-90)))
		bounceWeld2(weld55, nil, (CFrame.new(up3, 0.6, 0.8)- Vector3.new(-0.075, -0.2, -0.25)) * CFrame.fromEulerAnglesXYZ(math.rad(320), 0, math.rad(-90)), .03, .15,nil,(CFrame.new(up2, 0.8, 0.8) - Vector3.new(-0.075, -0.2, -0.25)) * CFrame.fromEulerAnglesXYZ(math.rad(320), 0, math.rad(-90)))
	elseif Tool.ZoomedIn.Value then
		bounceWeld(weld33, nil,CFrame.new(up3, 0, -.875) * CFrame.fromEulerAnglesXYZ(math.rad(-129), math.rad(4), math.rad(-90)), .03, .15,nil,CFrame.new(up2-0.08, 0.2, -1) * CFrame.fromEulerAnglesXYZ(math.rad(-129), math.rad(-0), math.rad(-90)))
		bounceWeld2(weld55, nil,  CFrame.new((up3 - .08), 0.6, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(281), 0, math.rad(-90)), .03, .15,nil,CFrame.new(up2-0.08, 0.8, 0.8) * CFrame.fromEulerAnglesXYZ(math.rad(281), 0, math.rad(-90)))
	end]]
	--zooming = false
	--aimoff()
	recoiloffset = recoiloffset - recoil * 50
		if recoiling == false then
			recoiling = true
			delay(0,function()
				while recoiloffset ~= 0 and recoiling == true do
					wait()
					if recoiloffset < 0 then
					recoiloffset = recoiloffset + (recoil*20)
					else
					recoiloffset = 0
					recoiling = false
					end	
				end
				recoiling = false
			end)
		end
		
	wait(1/10)
	head.FlashFX1.Enabled = false
	head.FlashFX2.Enabled = false
	head.FLASH.Enabled = false 
	wait(seat.Parent:FindFirstChild("ReloadSpeed").Value)
	firing = false
end
end

recoiloffset = 0
recoiling = false

function firetank()
ammo = seat.Parent.Ammo.Value
ClipSize = seat.Parent.ClipSize.Value
h = bin.Parent.Humanoid
	if seat.Parent.Ammo.Value > 0 and reloading == false then
	BaseDamage = seat.Parent:FindFirstChild("Damage").Value
	killradius = seat.Parent:FindFirstChild("KillBlastRadius").Value
	maxdist = seat.Parent:FindFirstChild("BlastRadius").Value
	seat.Parent.Ammo.Value = seat.Parent.Ammo.Value - 1
	head = seat.Parent.Top.Gun
			if 	head.Fire.IsPlaying == true then
				head.Fire2:Play()
			else
				head.Fire:Play()
			end
			if 	head.FireDistant.IsPlaying == true then
				head.FireDistant2:Play()
			else
				head.FireDistant:Play()
			end
	startpoint=head.CFrame.p
--	local dir=((aim)-startpoint)
	local dir = seat.Parent.Top.Gun.CFrame.lookVector + Vector3.new(
	(math.random() * 2 - 1) / 10 * (1 - gunSpecs.accuracy / 100) /1,
	(math.random() * 2 - 1) / 10 * (1 - gunSpecs.accuracy / 100) /1,
	(math.random() * 2 - 1) / 10 * (1 - gunSpecs.accuracy / 100) /1)

	local position = head.Position
	local velocity = dir.unit * gunSpecs.bulletSpeed
	local pos0, hit
	local pos1 = position
	--local bullet = createPart("Bullet", workspace.Ignore, true)
	--bullet.BrickColor = BrickColor.new(1008)
	--bullet.Anchored = true
	--bullet.CFrame = CFrame.new(0, 0, 0)
	--local bulletMesh = createBlockMesh(bullet, Vector3.new(1, 1, 1))
whizsound(dir.unit,startpoint)

Spawn(function()
					local time = 0.6
					for i = 1, 5 do
						pos0 = pos1
						pos1 = (velocity * time) + Vector3.new(0, -(10 * time), 0)

						-- Ray cast
						hit, pos1 = rayCast(pos0, pos1, {seat.Parent,seat.Parent.Top,seat.Parent.Bottom,seat.Parent.Parent,workspace.Ignore,bin.Parent,game.Workspace.CurrentCamera})


						-- Place path
						if i == 1 then
				
						else
							--placePartWithMesh(bullet, bulletMesh, pos0, pos1)
						end

						-- Stop or continue
						if hit then 

						break 
						end
						time = time + wait(0.6)
					end



					-- Hit
							if hit then
								delay(0, function()
								--print(hit.Name)
								suppress(pos1)
								end)
								local ExplosionObject = Instance.new("Explosion",game.Workspace)
								ExplosionObject.Position = pos1
								ExplosionObject.BlastRadius = seat.Parent:FindFirstChild("KillBlastRadius").Value
								local explosion = game.Lighting.Explosion:clone()								
								explosion.Base.Explosion.Size = UDim2.new(seat.Parent:FindFirstChild("KillBlastRadius").Value*5, 0, seat.Parent:FindFirstChild("KillBlastRadius").Value*5, 0) 
								explosion.Base.Light.Range = seat.Parent:FindFirstChild("KillBlastRadius").Value * 5
								explosion.Parent = game.Workspace
								explosion.Base.CFrame = CFrame.new(pos1)
								game:GetService("Debris"):AddItem(explosion, .1)
								delay(0,function()
									Players = game.Players:GetChildren()
									for i = 1, #Players do 
										if Players[i] ~= game.Players:GetPlayerFromCharacter(bin.Parent) and Players[i].TeamColor ~= game.Players:GetPlayerFromCharacter(bin.Parent).TeamColor then
										if Players[i].Character then
											if Players[i].Character.Torso and Players[i].Character.Humanoid.Health > 0 then
												local dist = (Players[i].Character.Torso.Position - pos1).magnitude
												local damage = math.max(((100*(killradius/maxdist))+105)-(100*(dist/maxdist)), 0)
													print(damage)
													if damage > 0 then
														if Players[i].Character.Humanoid~=nil then
														if Players[i].Character.Humanoid.Health>0 and h.Health>0 then
																--[[hit2, pos2 = rayCast(pos1, (Players[i].Character.Torso.Position - pos1), {workspace.Ignore})
																if hit2.Parent.className == "Hat" then
																	hit2 = hit2.Parent
																elseif hit.Parent.className == "Tool" then
																	hit2 = hit2.Parent
																end
																local humanoid=hit2.Parent:FindFirstChild("Humanoid")]]
																--if humanoid ~= nil then
																if Players[i].Character:FindFirstChild("VehicleEnter").Value == false then
																	local eplr=Players[i]
																	local plr=game.Players:GetPlayerFromCharacter(bin.Parent)
																	if eplr ~= nil and plr ~= nil then
																		if eplr.TeamColor~=plr.TeamColor or eplr.Neutral or plr.Neutral then
																			--Mouse.Icon = "http://www.roblox.com/asset/?id=33450396"
																			tagHumanoid(Players[i].Character.Humanoid)
																			Players[i].Character.Humanoid:TakeDamage(damage)
																		end
																	end
																end
																--end															
															end
														end
													end
												end
											end
										end
									end
								end)

								if hit.Parent.className == "Hat" then
									hit = hit.Parent
								elseif hit.Parent.className == "Tool" then
									hit = hit.Parent
								end
								
								local humanoid=hit.Parent:FindFirstChild("Humanoid")
								if humanoid~=nil then
									local damage=math.random(BaseDamage-(BaseDamage*0.01),BaseDamage+(BaseDamage*0.01))
									if hit.Name=="Head" then
										damage=damage*2
									elseif hit.Name=="Torso" then
									damage=damage*1.25
									else
										damage=damage
									end
									fleshHit(hit, pos1, dir.unit * -1)

									if humanoid.Health>0 and h.Health>0 then
										
										local eplr=game.Players:playerFromCharacter(humanoid.Parent)
										local plr=game.Players:playerFromCharacter(myChar)
										--[[if eplr~=nil and plr~=nil then
											if eplr.Neutral or plr.Neutral then
												Mouse.Icon = "http://www.roblox.com/asset/?id=49170312"
												tagHumanoid(humanoid)
												humanoid:TakeDamage(damage)
											end
										else
											Mouse.Icon = "http://www.roblox.com/asset/?id=49170312"	
											tagHumanoid(humanoid)
											humanoid:TakeDamage(damage)
										end]]
										if eplr~=nil and plr~=nil then
										if eplr.TeamColor~=plr.TeamColor or eplr.Neutral or plr.Neutral then
												if Tool.ZoomedIn.Value == true and (camera.CoordinateFrame.p - camera.Focus.p).magnitude < 1 then
												--Mouse.Icon = "http://www.roblox.com/asset/?id=33450396"
												else 
												--Mouse.Icon = "http://www.roblox.com/asset/?id=49170312"
												end 
												tagHumanoid(humanoid)
												humanoid:TakeDamage(damage)
										end
										else
											if Tool.ZoomedIn.Value == true and (camera.CoordinateFrame.p - camera.Focus.p).magnitude < 1 then
											--Mouse.Icon = "http://www.roblox.com/asset/?id=33450396"
											else 
											--Mouse.Icon = "http://www.roblox.com/asset/?id=49170312"
											end 
											tagHumanoid(humanoid)
											humanoid:TakeDamage(damage)
										end
									end
								else
									if hit.Material == Enum.Material.Concrete or hit.Material == Enum.Material.Slate then
										concreteHit(hit, pos1, hit.Anchored)
									else
										metalHit(hit,pos1, hit.Anchored)
									end
								end
									
								if (hit.Parent:findFirstChild("Hit")) then
									hit.Parent.Health.Value = hit.Parent.Health.Value - BaseDamage/3
								end
								if hit.Parent:FindFirstChild("Health") then
									if hit.Parent:FindFirstChild("Owner") then
									if hit.Parent:FindFirstChild("Owner").Value.TeamColor ~= game.Players:GetPlayerFromCharacter(bin.Parent).TeamColor then
									hit.Parent.Health.Value = hit.Parent.Health.Value - BaseDamage
									end
									end
								end
								if hit.Parent.Parent:FindFirstChild("Health") then
									if hit.Parent.Parent:FindFirstChild("Owner") then
									if hit.Parent.Parent:FindFirstChild("Owner").Value.TeamColor ~= game.Players:GetPlayerFromCharacter(bin.Parent).TeamColor then
									hit.Parent.Parent.Health.Value = hit.Parent.Parent.Health.Value - BaseDamage
									end
									end
								end
								--bullet:remove()

						else
							--bullet:remove()
						end
					
	end)

	local deb=game:FindFirstChild("Debris")
	if deb==nil then
		local debris=Instance.new("Debris")
		debris.Parent=game
	end
	--check()
	head.FlashFX1.Enabled = true
	head.FlashFX2.Enabled = true
	head.FLASH.Enabled = true 
	cam = game.Workspace.CurrentCamera
	firing = true
	recoil = seat.Parent:FindFirstChild("Recoil").Value
	recoilCam(recoil*50, ((recoil*50) * math.random() * 2 - recoil)/2, .05,.2)
	--[[if not Tool.ZoomedIn.Value then
		recoil = Tool.Stats.Control.Value
		local i = (recoil * math.random() * 2 -recoil)/2
		local cam_rot = cam.CoordinateFrame - cam.CoordinateFrame.p
		local cam_scroll = (cam.CoordinateFrame.p - cam.Focus.p).magnitude
		local ncf = CFrame.new(cam.Focus.p)*cam_rot*CFrame.fromEulerAnglesXYZ(recoil, 0, 0)
		cam.CoordinateFrame = ncf*CFrame.new(i, 0, cam_scroll)
		bounceWeld(weld33, nil,CFrame.new((up3 + .1), 0, -1) * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(0), math.rad(-90)), 0, ROF)
		bounceWeld(weld55, nil, (CFrame.new(up3, 0.6, 0.8)- Vector3.new(-0.075, -0.2, -0.25)) * CFrame.fromEulerAnglesXYZ(math.rad(320), 0, math.rad(-90)),0, ROF)
	elseif Tool.ZoomedIn.Value then
		recoil = Tool.Stats.Control.Value
		local i = (recoil * math.random() * 2 -recoil)/2
		local cam_rot = cam.CoordinateFrame - cam.CoordinateFrame.p
		local cam_scroll = (cam.CoordinateFrame.p - cam.Focus.p).magnitude
		local ncf = CFrame.new(cam.Focus.p)*cam_rot*CFrame.fromEulerAnglesXYZ(recoil, 0, 0)
		cam.CoordinateFrame = ncf*CFrame.new(i, 0, cam_scroll)
		bounceWeld(weld33, nil,CFrame.new(up3, 0, -.875) * CFrame.fromEulerAnglesXYZ(math.rad(-129), math.rad(0), math.rad(-90)), 0, ROF)
		bounceWeld(weld55, nil,  CFrame.new((up3 - .08), 0.5, 0.5) * CFrame.fromEulerAnglesXYZ(math.rad(281), 0, math.rad(-90)), 0, ROF)
	end]]
	--[[if not Tool.ZoomedIn.Value then
	--	recoilCam(recoil, recoil * math.random() * 2 -recoil, .05,.2)
		bounceWeld(weld33, nil,CFrame.new((up3 + .1), 0, -1) * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(2), math.rad(-90)), .03, .15,nil,CFrame.new(up2, 0.2, -1)  * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(-0), math.rad(-90)))
		bounceWeld2(weld55, nil, (CFrame.new(up3, 0.6, 0.8)- Vector3.new(-0.075, -0.2, -0.25)) * CFrame.fromEulerAnglesXYZ(math.rad(320), 0, math.rad(-90)), .03, .15,nil,(CFrame.new(up2, 0.8, 0.8) - Vector3.new(-0.075, -0.2, -0.25)) * CFrame.fromEulerAnglesXYZ(math.rad(320), 0, math.rad(-90)))
	elseif Tool.ZoomedIn.Value then
		bounceWeld(weld33, nil,CFrame.new(up3, 0, -.875) * CFrame.fromEulerAnglesXYZ(math.rad(-129), math.rad(4), math.rad(-90)), .03, .15,nil,CFrame.new(up2-0.08, 0.2, -1) * CFrame.fromEulerAnglesXYZ(math.rad(-129), math.rad(-0), math.rad(-90)))
		bounceWeld2(weld55, nil,  CFrame.new((up3 - .08), 0.6, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(281), 0, math.rad(-90)), .03, .15,nil,CFrame.new(up2-0.08, 0.8, 0.8) * CFrame.fromEulerAnglesXYZ(math.rad(281), 0, math.rad(-90)))
	end]]
	--zooming = false
	--aimoff()
	recoiloffset = recoiloffset - recoil * 50
		if recoiling == false then
			recoiling = true
			delay(0,function()
				while recoiloffset ~= 0 and recoiling == true do
					wait()
					if recoiloffset < 0 then
					recoiloffset = recoiloffset + (recoil*20)
					else
					recoiloffset = 0
					recoiling = false
					end	
				end
				recoiling = false
			end)
		end
		
	
	wait(1/10)
	head.FlashFX1.Enabled = false
	head.FlashFX2.Enabled = false
	wait(seat.Parent:FindFirstChild("ReloadSpeed").Value)
	firing = false

end
end

function fireartillery()
ammo = seat.Parent.Ammo.Value
ClipSize = seat.Parent.ClipSize.Value
h = bin.Parent.Humanoid
	if seat.Parent.Ammo.Value > 0 and reloading == false then
	BaseDamage = seat.Parent:FindFirstChild("Damage").Value
	killradius = seat.Parent:FindFirstChild("KillBlastRadius").Value
	maxdist = seat.Parent:FindFirstChild("BlastRadius").Value
	seat.Parent.Ammo.Value = seat.Parent.Ammo.Value - 1
	head = seat.Parent.Top.Gun
			if 	head.Fire.IsPlaying == true then
				head.Fire2:Play()
			else
				head.Fire:Play()
			end
			if 	head.FireDistant.IsPlaying == true then
				head.FireDistant2:Play()
			else
				head.FireDistant:Play()
			end
	startpoint=head.CFrame.p
--	local dir=((aim)-startpoint)
	
	local dir =  (mouse.Hit.p-seat.Parent.Top.ArmL.Position).unit --[[seat.Parent.Top.ArmL.CFrame.lookVector]] + Vector3.new(
	(math.random() * 2 - 1) / 10 * (1 - 100 / 100) /1,
	(math.random() * 2 - 1) / 10 * (1 - 100 / 100) /1,
	(math.random() * 2 - 1) / 10 * (1 - 100 / 100) /1)

	local position = seat.Parent.Top.ArmL.CFrame.p
	local velocity = dir.unit * seat.Parent:FindFirstChild("BulletVelocity").Value
	local pos0, hit
	local pos1 = position
	local bullet = createPart("Bullet", workspace.Ignore, true)
	bullet.BrickColor = BrickColor.new(1008)
	bullet.Anchored = true
	bullet.CFrame = CFrame.new(0, 0, 0)
	local bulletMesh = createBlockMesh(bullet, Vector3.new(5, 5, 5))
whizsound(dir.unit,startpoint)

Spawn(function()
					local time = 0.05
					Range = game.Lighting.FogEnd
					
						local ivel	= seat.Parent:FindFirstChild("BulletVelocity").Value
						local distx2 = distx
						local initialy = mouse.Hit.y
						local dify = -(seat.Parent.Top.ArmL.Position.y-mouse.Hit.y) -- seat.Parent.Top.ArmL.Position.y --seat.Parent.Top.ArmL.Position.y - 
						local square = (ivel*ivel*ivel*ivel) - (g*(g*(distx2*distx2) + 2*dify*(ivel*ivel)))
						local square2 = math.sqrt(square)
						topside = false
						if topside then
						firedegree = math.atan(((ivel*ivel) + square2)/(g*distx2))
						else
						firedegree = math.atan(((ivel*ivel) - square2)/(g*distx2))
						end
						initialP = seat.Parent.Top.ArmL.Position
						--print((firedegree))		
						print("Distance: "..distx2, " TargetY: "..initialy)	
						local bottom = ivel*math.cos(firedegree)
						local bottom2 = ivel*math.sin(firedegree)
						local x = 0
						local eta = (bottom2 + math.sqrt((bottom2*bottom2) + 2*g*dify))/g
						local waiteta = (eta/(distx2/10))
					if distx2 < 9000 then
					for x = 0, (distx2+100), 10 do
						--local x = seat.Parent:FindFirstChild("BulletVelocity").Value * time	
						local y =  (initialP.y) + x*math.tan(firedegree) - ((g*x*x)/(2*(bottom * bottom)))
						--local t = (x/ivel*math.cos(firedegree))
						--local y = vy*time - .5*g*time*time
						--( - seat.Parent.Top.ArmL.Position.y).magnitude
						
						if x == 10 then
						pos0 = seat.Parent.Top.ArmL.Position
						else
						pos0 = pos1
						end
						
						pos1 = CFrame.new(((dir.unit * x)*Vector3.new(1,0,1)) + Vector3.new(initialP.x, y, initialP.z)).p
						print("X: "..x," Y: "..y)
						-- Ray cast	
						local ignorelist = {seat.Parent,seat.Parent.Top,seat.Parent.Bottom,seat.Parent.Parent,workspace.Ignore,bin.Parent,game.Workspace.CurrentCamera}
						hit, pos1 = workspace:FindPartOnRayWithIgnoreList(Ray.new(pos0, (pos1 - pos0).unit*((pos1 - pos0).magnitude)),ignorelist)
						
						-- Place path
						if i == 1 then
							
						else
							bullet.Position = CFrame.new(((dir.unit * x)*Vector3.new(1,0,1)) + Vector3.new(initialP.x, y, initialP.z)).p
						end

						-- Stop or continue
						if x >= (distx2+50) or hit then 
						print("STOP",hit)
						break 
						end
						wait(waiteta)
					end
					end
							if hit then
								delay(0, function()
								--print(hit.Name)
								suppress(pos1)
								end)
								local explosion = game.Lighting.Explosion:clone()								
								explosion.Base.Explosion.Size = UDim2.new(seat.Parent:FindFirstChild("KillBlastRadius").Value*5, 0, seat.Parent:FindFirstChild("KillBlastRadius").Value*5, 0) 
							--	explosion.Base.Light.Range = seat.Parent:FindFirstChild("KillBlastRadius").Value * 5
								explosion.Parent = game.Workspace
								explosion.Base.CFrame = CFrame.new(pos1)
								game:GetService("Debris"):AddItem(explosion, .1)
								delay(0,function()
									Players = game.Players:GetChildren()
									for i = 1, #Players do 
										if Players[i] ~= game.Players:GetPlayerFromCharacter(bin.Parent) and Players[i].TeamColor ~= game.Players:GetPlayerFromCharacter(bin.Parent).TeamColor then
										if Players[i].Character then
											if Players[i].Character.Torso and Players[i].Character.Humanoid.Health > 0 then
												local dist = (Players[i].Character.Torso.Position - pos1).magnitude
												local damage = math.max(((100*(killradius/maxdist))+105)-(100*(dist/maxdist)), 0)
													print(damage)
													if damage > 0 then
														if Players[i].Character.Humanoid~=nil then
														if Players[i].Character.Humanoid.Health>0 and h.Health>0 then
																--[[hit2, pos2 = rayCast(pos1, (Players[i].Character.Torso.Position - pos1), {workspace.Ignore})
																if hit2.Parent.className == "Hat" then
																	hit2 = hit2.Parent
																elseif hit.Parent.className == "Tool" then
																	hit2 = hit2.Parent
																end
																local humanoid=hit2.Parent:FindFirstChild("Humanoid")]]
																--if humanoid ~= nil then
																if Players[i].Character:FindFirstChild("VehicleEnter").Value == false then
																	local eplr=Players[i]
																	local plr=game.Players:GetPlayerFromCharacter(bin.Parent)
																	if eplr ~= nil and plr ~= nil then
																		if eplr.TeamColor~=plr.TeamColor or eplr.Neutral or plr.Neutral then
																			--Mouse.Icon = "http://www.roblox.com/asset/?id=33450396"
																			tagHumanoid(Players[i].Character.Humanoid)
																			Players[i].Character.Humanoid:TakeDamage(damage)
																		end
																	end
																end
																--end															
															end
														end
													end
												end
											end
										end
									end
								end)

								if hit.Parent.className == "Hat" then
									hit = hit.Parent
								elseif hit.Parent.className == "Tool" then
									hit = hit.Parent
								end
								
								local humanoid=hit.Parent:FindFirstChild("Humanoid")
								if humanoid~=nil then
									local damage=math.random(BaseDamage-(BaseDamage*0.01),BaseDamage+(BaseDamage*0.01))
									if hit.Name=="Head" then
										damage=damage*2
									elseif hit.Name=="Torso" then
									damage=damage*1.25
									else
										damage=damage
									end
									--fleshHit(hit, pos1, dir.unit * -1)

									if humanoid.Health>0 and h.Health>0 then
										
										local eplr=game.Players:playerFromCharacter(humanoid.Parent)
										local plr=game.Players:playerFromCharacter(myChar)
										--[[if eplr~=nil and plr~=nil then
											if eplr.Neutral or plr.Neutral then
												Mouse.Icon = "http://www.roblox.com/asset/?id=49170312"
												tagHumanoid(humanoid)
												humanoid:TakeDamage(damage)
											end
										else
											Mouse.Icon = "http://www.roblox.com/asset/?id=49170312"	
											tagHumanoid(humanoid)
											humanoid:TakeDamage(damage)
										end]]
										if eplr~=nil and plr~=nil then
										if eplr.TeamColor~=plr.TeamColor or eplr.Neutral or plr.Neutral then
												if Tool.ZoomedIn.Value == true and (camera.CoordinateFrame.p - camera.Focus.p).magnitude < 1 then
												--Mouse.Icon = "http://www.roblox.com/asset/?id=33450396"
												else 
												--Mouse.Icon = "http://www.roblox.com/asset/?id=49170312"
												end 
												tagHumanoid(humanoid)
												humanoid:TakeDamage(damage)
										end
										else
											if Tool.ZoomedIn.Value == true and (camera.CoordinateFrame.p - camera.Focus.p).magnitude < 1 then
											--Mouse.Icon = "http://www.roblox.com/asset/?id=33450396"
											else 
											--Mouse.Icon = "http://www.roblox.com/asset/?id=49170312"
											end 
											tagHumanoid(humanoid)
											humanoid:TakeDamage(damage)
										end
									end
								else
									if hit.Material == Enum.Material.Concrete or hit.Material == Enum.Material.Slate then
										--concreteHit(hit, pos1, hit.Anchored)
									else
										--metalHit(hit,pos1, hit.Anchored)
									end
								end
									
								if (hit.Parent:findFirstChild("Hit")) then
									hit.Parent.Health.Value = hit.Parent.Health.Value - BaseDamage/3
								end
								if hit.Parent:FindFirstChild("Health") then
									if hit.Parent:FindFirstChild("Owner") then
									if hit.Parent:FindFirstChild("Owner").Value.TeamColor ~= game.Players:GetPlayerFromCharacter(bin.Parent).TeamColor then
									hit.Parent.Health.Value = hit.Parent.Health.Value - BaseDamage
									end
									end
								end
								if hit.Parent.Parent:FindFirstChild("Health") then
									if hit.Parent.Parent:FindFirstChild("Owner") then
									if hit.Parent.Parent:FindFirstChild("Owner").Value.TeamColor ~= game.Players:GetPlayerFromCharacter(bin.Parent).TeamColor then
									hit.Parent.Parent.Health.Value = hit.Parent.Parent.Health.Value - BaseDamage
									end
									end
								end
								bullet:remove()

						else
							bullet:remove()
						end
					
	end)

	local deb=game:GetService("Debris")
	--check()
	head.FlashFX1.Enabled = true
	head.FlashFX2.Enabled = true
	head.FLASH.Enabled = true 
	cam = game.Workspace.CurrentCamera
	firing = true
	recoil = seat.Parent:FindFirstChild("Recoil").Value
	recoilCam(recoil*50, ((recoil*50) * math.random() * 2 - recoil)/2, .05,.2)
	--[[if not Tool.ZoomedIn.Value then
		recoil = Tool.Stats.Control.Value
		local i = (recoil * math.random() * 2 -recoil)/2
		local cam_rot = cam.CoordinateFrame - cam.CoordinateFrame.p
		local cam_scroll = (cam.CoordinateFrame.p - cam.Focus.p).magnitude
		local ncf = CFrame.new(cam.Focus.p)*cam_rot*CFrame.fromEulerAnglesXYZ(recoil, 0, 0)
		cam.CoordinateFrame = ncf*CFrame.new(i, 0, cam_scroll)
		bounceWeld(weld33, nil,CFrame.new((up3 + .1), 0, -1) * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(0), math.rad(-90)), 0, ROF)
		bounceWeld(weld55, nil, (CFrame.new(up3, 0.6, 0.8)- Vector3.new(-0.075, -0.2, -0.25)) * CFrame.fromEulerAnglesXYZ(math.rad(320), 0, math.rad(-90)),0, ROF)
	elseif Tool.ZoomedIn.Value then
		recoil = Tool.Stats.Control.Value
		local i = (recoil * math.random() * 2 -recoil)/2
		local cam_rot = cam.CoordinateFrame - cam.CoordinateFrame.p
		local cam_scroll = (cam.CoordinateFrame.p - cam.Focus.p).magnitude
		local ncf = CFrame.new(cam.Focus.p)*cam_rot*CFrame.fromEulerAnglesXYZ(recoil, 0, 0)
		cam.CoordinateFrame = ncf*CFrame.new(i, 0, cam_scroll)
		bounceWeld(weld33, nil,CFrame.new(up3, 0, -.875) * CFrame.fromEulerAnglesXYZ(math.rad(-129), math.rad(0), math.rad(-90)), 0, ROF)
		bounceWeld(weld55, nil,  CFrame.new((up3 - .08), 0.5, 0.5) * CFrame.fromEulerAnglesXYZ(math.rad(281), 0, math.rad(-90)), 0, ROF)
	end]]
	--[[if not Tool.ZoomedIn.Value then
	--	recoilCam(recoil, recoil * math.random() * 2 -recoil, .05,.2)
		bounceWeld(weld33, nil,CFrame.new((up3 + .1), 0, -1) * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(2), math.rad(-90)), .03, .15,nil,CFrame.new(up2, 0.2, -1)  * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(-0), math.rad(-90)))
		bounceWeld2(weld55, nil, (CFrame.new(up3, 0.6, 0.8)- Vector3.new(-0.075, -0.2, -0.25)) * CFrame.fromEulerAnglesXYZ(math.rad(320), 0, math.rad(-90)), .03, .15,nil,(CFrame.new(up2, 0.8, 0.8) - Vector3.new(-0.075, -0.2, -0.25)) * CFrame.fromEulerAnglesXYZ(math.rad(320), 0, math.rad(-90)))
	elseif Tool.ZoomedIn.Value then
		bounceWeld(weld33, nil,CFrame.new(up3, 0, -.875) * CFrame.fromEulerAnglesXYZ(math.rad(-129), math.rad(4), math.rad(-90)), .03, .15,nil,CFrame.new(up2-0.08, 0.2, -1) * CFrame.fromEulerAnglesXYZ(math.rad(-129), math.rad(-0), math.rad(-90)))
		bounceWeld2(weld55, nil,  CFrame.new((up3 - .08), 0.6, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(281), 0, math.rad(-90)), .03, .15,nil,CFrame.new(up2-0.08, 0.8, 0.8) * CFrame.fromEulerAnglesXYZ(math.rad(281), 0, math.rad(-90)))
	end]]
	--zooming = false
	--aimoff()
	recoiloffset = recoiloffset - recoil * 50
		if recoiling == false then
			recoiling = true
			delay(0,function()
				while recoiloffset ~= 0 and recoiling == true do
					wait()
					if recoiloffset < 0 then
					recoiloffset = recoiloffset + (recoil*20)
					else
					recoiloffset = 0
					recoiling = false
					end	
				end
				recoiling = false
			end)
		end
		
	
	wait(1/10)
	head.FlashFX1.Enabled = false
	head.FlashFX2.Enabled = false
	head.FLASH.Enabled = false 
	wait(seat.Parent:FindFirstChild("ReloadSpeed").Value)
	firing = false

end
end

fire = false
bin.Equipped:connect(function()
	


	
Aim = true
PlaneCheck()

	delay(0,function()
		bin.Parent.Humanoid.Jumping:connect(function()		
			seat.BF.maxForce = Vector3.new(0, 0, 0)
			seat.TR.maxTorque = Vector3.new(0, 0, 0)
			seat.BG.maxTorque = Vector3.new(0, 0, 0)
			script.Parent:remove()
		end)
	end)	

function Click(mouse)
fire = true
	if seat.Parent:FindFirstChild("Type").Value == "MachineGun" then
		while fire == true and seat.Parent.Ammo.Value > 0 and reloading == false and firing == false do
			firemachinegun()
		end
	elseif seat.Parent:FindFirstChild("Type").Value == "Tank" and seat.Parent.Ammo.Value > 0 and reloading == false and firing == false then
		firetank()
	elseif seat.Parent:FindFirstChild("Type").Value == "Artillery" and seat.Parent.Ammo.Value > 0 and reloading == false and firing == false and math.deg(up) > 0 and math.deg(up) < 90 then
		fireartillery(mouse)
	elseif seat.Parent:FindFirstChild("Type").Value == "APC" and seat.Parent.Ammo.Value > 0 and reloading == false and firing == false then
		while fire == true and seat.Parent.Ammo.Value > 0 and reloading == false and firing == false do
			firetank()
		end		
	end
end

function UnClick()
fire = false
end


--bin.Parent.Parent.Character.Humanoid.TargetPoint = mouse.Hit.p
bin.Moved.OnServerEvent:Connect(function(plr, mouseHit)
delay(0,function()
	if Aim and PlaneCheck() then
		
wait(1/28)
		turnspeed = seat.Parent:FindFirstChild("TurnSpeed").Value
		if seat:findFirstChild("Spine") then
		local vec = mouseHit.p - seat.Spine.Part1.Position 
		local vru = seat.Spine.Part0.CFrame:vectorToObjectSpace(vec).unit 
		--local h = math.sqrt(vru.x^2 + vru.z^2)
		local da = math.atan2(vru.x,-vru.z)
		seat.Spine.C0 = CFrame.fromAxisAngle(Vector3.new(0, -1, 0), da)
		mem_da = rot
		--[[
		if da > -180 and da < 0 then
		seat.Spine.C0 = CFrame.fromAxisAngle(Vector3.new(0, -1, 0), -rot)
		mem_da = -rot
		print(math.deg(mem_da))
		elseif da < 180 and da > 0 then
		seat.Spine.C0 = CFrame.fromAxisAngle(Vector3.new(0, -1, 0), rot)
		mem_da = rot
		print(math.deg(mem_da))
		end	
		]]
		
		--print(math.deg(mem_da))
	--[[	if math.abs(da - mem_da) > .05 then
		if (da - mem_da) > 0  then
			rot = rot + turnspeed
			seat.Spine.C0 = CFrame.fromAxisAngle(Vector3.new(0, -1, 0), rot)
		elseif (da - mem_da) < 0  then
			rot = rot + turnspeed
			seat.Spine.C0 = CFrame.fromAxisAngle(Vector3.new(0, -1, 0), rot)
		end	
		else]]

		end
		if seat:findFirstChild("ShoulderR") then
		local vec = mouseHit.p - seat.ShoulderR.Part1.Position
		local vru = seat.ShoulderR.Part0.CFrame:vectorToObjectSpace(vec).unit 
		local ea = math.asin(vru.y)
		seat.ShoulderR.C0 = CFrame.fromAxisAngle(Vector3.new(1, 0, 0), ea)	
		end
		if seat:findFirstChild("ShoulderL") then
		local vec = mouseHit.p - seat.ShoulderL.Part1.Position
		local vru = seat.ShoulderL.Part0.CFrame:vectorToObjectSpace(vec).unit 
		distx = ((mouseHit.p - seat.ShoulderL.Part1.Position) * Vector3.new(1,0,1)).magnitude 
		local y = seat.ShoulderL.Part0.CFrame.y - mouseHit.y
		ea = math.asin(vru.y)
		seat.ShoulderL.C0 = CFrame.fromAxisAngle(Vector3.new(1, 0, 0), ea)	* CFrame.new(0,0,-recoiloffset)
		mem_ea = up
		end
		if seat:findFirstChild("SpecialL") then
		local vec = mouseHit.p - seat.SpecialL.Part1.Position
		local vru = seat.SpecialL.Part0.CFrame:vectorToObjectSpace(vec).unit 
		local ea = math.asin(vru.y)
		seat.SpecialL.C0 = CFrame.fromAxisAngle(Vector3.new(1, 0, 0), ea)	
		end
		if seat:findFirstChild("SpecialR") then
		local vec = mouseHit.p - seat.SpecialR.Part1.Position
		local vru = seat.SpecialR.Part0.CFrame:vectorToObjectSpace(vec).unit 
		local ea = math.asin(vru.y)
		seat.SpecialR.C0 = CFrame.fromAxisAngle(Vector3.new(1, 0, 0), ea)	
		end
	end
end)
end)
end)

bin.keyDown.OnServerEvent:Connect(function(plr, mouse)
	Click(mouse)
end)

bin.keyUp.OnServerEvent:Connect(function()
	UnClick()
end)

bin.Key.OnServerEvent:Connect(function(player, key, mouse)
	if PlaneCheck() then
		if key == "f"  then

		end

		if key == "c" and seat.Parent:findFirstChild("Crouch") then
			if seat.Parent.Crouch.Value == false then
			seat.Parent.Crouch.Value = true
			else
			seat.Parent.Crouch.Value = false
			end
		end
		if key == "z" and seat.Parent:findFirstChild("SMS") then
			if seat.Parent.SMS.Value == false then
			seat.Parent.SMS.Value = true
			else
			seat.Parent.SMS.Value = false
			end
		end
		if key == "f" and seat.Parent:findFirstChild("Special") then
			if not seat.Parent.Special.Value then
			seat.Parent.Special.Value = true
			end
		end
		if key == "f" and seat.Parent:findFirstChild("Target") then
		seat.Parent.Target.Value = mouse.Target
		end
	end
	wait()
end)