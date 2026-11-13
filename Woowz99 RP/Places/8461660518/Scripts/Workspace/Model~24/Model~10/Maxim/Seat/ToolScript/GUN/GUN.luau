thetool=nil
local wc = game.Workspace:GetChildren()
for i = 1, #wc do
	if wc[i].Name == "Maxim" then
		if wc[i].Seat:findFirstChild("SeatWeld") then
			if wc[i].Seat["SeatWeld"].Part1.Parent == game.Players.LocalPlayer.Character then
				thetool = wc[i].GunIgnore.Barrel
			end
		end
	end
end
-------------------------------------DEFULT STUFF, NEEDED TO BE LIKE THIS, IF YOU CHANGE THIS LITTLE PART, YOU BREACK IT
equiped=false
reloading=false
stopper=false
down=false
-------------------------------------GAMEINFO
Team=BrickColor.new("Bright red")
TeamsAliies=BrickColor.new("Bright green")
-------------------------------------GUNINFO
OriginalToolName=script.Parent.Name
RayLength=3000
MAXclips=thetool.MAXclips.Value
Firerate=0.07
BaseDamage=10
VehicleDamage=35
MAXammo=200
reloadinterval=8/MAXammo
Spread=0.08
threebb=false
auto=true
shot=false
ShotFrom=Vector3.new(-1.5,0.6,0)
clips=thetool.Clips
ammo=thetool.Ammo
Cursor="rbxasset://textures\\GunCursor.png"
ReloadCursor="rbxasset://textures\\GunWaitCursor.png"
-------------------------------------RAYINFO
Bullet=Instance.new("Part")
Bullet.Name="Bullet"
Bullet.BrickColor=BrickColor.new("White")
Bullet.Anchored=true
Bullet.CanCollide=false
Bullet.Locked=true
Bullet.Size=Vector3.new(1,1,1)
Bullet.Transparency=.65
Bullet.formFactor=0
Bullet.TopSurface=0
Bullet.BottomSurface=0
mesh=Instance.new("SpecialMesh")
mesh.Parent=Bullet
mesh.MeshType="Brick"
mesh.Name="Mesh"
mesh.Scale=Vector3.new(.15,.15,1)
-------------------------------------REFERENCES
player=game.Players.LocalPlayer
-------------------------------------SCRIPT

function flash()
	if equiped==true then
		if clips.Value==0 then
			for i=1, 5 do
				player.PlayerGui.GunGui.Clips.TextLabel.TextColor3=Color3.new(1, 1, 1)
				wait(0.05)
				if reloading==true then
					player.PlayerGui.GunGui.Clips.TextLabel.TextColor3=Color3.new(128/255, 128/255, 128/255)
					break
				end
				player.PlayerGui.GunGui.Clips.TextLabel.TextColor3=Color3.new(128/255, 0, 0)
				wait(0.05)
				if reloading==true then
					player.PlayerGui.GunGui.Clips.TextLabel.TextColor3=Color3.new(128/255, 128/255, 128/255)
					break
				end
			end
		elseif ammo.Value==0 then
			for i=1, 5 do
				player.PlayerGui.GunGui.Ammo.TextLabel.TextColor3=Color3.new(1, 1, 1)
				wait(0.05)
				if reloading==true then
					player.PlayerGui.GunGui.Ammo.TextLabel.TextColor3=Color3.new(128/255, 128/255, 128/255)
					break
				end
				player.PlayerGui.GunGui.Ammo.TextLabel.TextColor3=Color3.new(128/255, 0, 0)
				wait(0.05)
				if reloading==true then
					player.PlayerGui.GunGui.Ammo.TextLabel.TextColor3=Color3.new(128/255, 128/255, 128/255)
					break
				end
			end
		end
	end
end

function check()
	if equiped==true then
		if clips.Value>0 then
			player.PlayerGui.GunGui.Clips.TextLabel.Text="Clips: "..clips.Value..""
			if clips.Value>MAXclips/2 then
				player.PlayerGui.GunGui.Clips.TextLabel.TextColor3=Color3.new(1, 1, 1)
			elseif clips.Value>MAXclips/4 and clips.Value<=MAXclips/2 then
				player.PlayerGui.GunGui.Clips.TextLabel.TextColor3=Color3.new(1, 1, 0)
			elseif clips.Value<=MAXclips/4 then
				player.PlayerGui.GunGui.Clips.TextLabel.TextColor3=Color3.new(1, 0, 0)
			end
		elseif clips.Value<=0 then
			clips.Value=0
			player.PlayerGui.GunGui.Clips.TextLabel.Text="Clips: "..clips.Value..""
			player.PlayerGui.GunGui.Clips.TextLabel.TextColor3=Color3.new(128/255, 0, 0)
		end
		if ammo.Value>0 then
			player.PlayerGui.GunGui.Ammo.TextLabel.Text="Ammo: "..ammo.Value..""
			if ammo.Value>MAXammo/2 then
				player.PlayerGui.GunGui.Ammo.TextLabel.TextColor3=Color3.new(1, 1, 1)
			elseif ammo.Value<=MAXammo/2 and ammo.Value>MAXammo/4 then
				player.PlayerGui.GunGui.Ammo.TextLabel.TextColor3=Color3.new(1, 1, 0)
			elseif ammo.Value<=MAXammo/4 then
				player.PlayerGui.GunGui.Ammo.TextLabel.TextColor3=Color3.new(1, 0, 0)
			end
		elseif ammo.Value<=0 then
			ammo.Value=0
			player.PlayerGui.GunGui.Ammo.TextLabel.Text="Ammo: "..ammo.Value..""
			player.PlayerGui.GunGui.Ammo.TextLabel.TextColor3=Color3.new(128/255, 0, 0)
		end
	end
end

function onClipsChanged()
	if clips.Value>0 and equiped==true and reloading==true then
		player.PlayerGui.GunGui.Clips.TextLabel.Text="Clips: "..clips.Value..""
		player.PlayerGui.GunGui.Clips.TextLabel.TextColor3=Color3.new(128/255, 128/255, 128/255)
	elseif clips.Value>0 and equiped==true then
		player.PlayerGui.GunGui.Clips.TextLabel.Text="Clips: "..clips.Value..""
		if clips.Value>MAXclips/2 then
			player.PlayerGui.GunGui.Clips.TextLabel.TextColor3=Color3.new(1, 1, 1)
		elseif clips.Value>MAXclips/4 and clips.Value<=MAXclips/2 then
			player.PlayerGui.GunGui.Clips.TextLabel.TextColor3=Color3.new(1, 1, 0)
		elseif clips.Value<MAXclips/4 then
			player.PlayerGui.GunGui.Clips.TextLabel.TextColor3=Color3.new(1, 0, 0)
		end
	elseif clips.Value<=0 and equiped==true then
		clips.Value=0
		player.PlayerGui.GunGui.Clips.TextLabel.Text="Clips: "..clips.Value..""
		player.PlayerGui.GunGui.Clips.TextLabel.TextColor3=Color3.new(128/255, 0, 0)
	end
end
thetool.Clips.Changed:connect(onClipsChanged)

function reload(mouse)
	if ammo.Value<MAXammo and clips.Value>0 then
		mouse.Icon=ReloadCursor
		reloading=true
		player.PlayerGui.GunGui.Clips.TextLabel.TextColor3=Color3.new(128/255, 128/255, 128/255)
		player.PlayerGui.GunGui.Ammo.TextLabel.TextColor3=Color3.new(128/255, 128/255, 128/255)
		player.PlayerGui.GunGui.Ammo.TextLabel.Text="Reloading"
		for i=1,100 do
			wait(0.07)
			if equiped==false then
				break
			end
		end
		if equiped~=false then
			clips.Value=clips.Value-1
			ammo.Value=MAXammo
			check()
		end
		reloading=false
		if clips.Value<=0 then
			clips.Value=0
		end
		mouse.Icon=Cursor
	elseif clips.Value==0 then
		flash()
	end
end

function onAmmoChanged()
	if ammo.Value>0 and equiped==true then
		player.PlayerGui.GunGui.Ammo.TextLabel.Text="Ammo: "..ammo.Value..""
		if ammo.Value>MAXammo/2 then
			player.PlayerGui.GunGui.Ammo.TextLabel.TextColor3=Color3.new(1, 1, 1)
		elseif ammo.Value<=MAXammo/2 and ammo.Value>MAXammo/4 then
			player.PlayerGui.GunGui.Ammo.TextLabel.TextColor3=Color3.new(1, 1, 0)
		elseif ammo.Value<=MAXammo/4 then
			player.PlayerGui.GunGui.Ammo.TextLabel.TextColor3=Color3.new(1, 0, 0)
		end
	elseif ammo.Value<=0 then
		ammo.Value=0
		player.PlayerGui.GunGui.Ammo.TextLabel.Text="Ammo: "..ammo.Value..""
		player.PlayerGui.GunGui.Ammo.TextLabel.TextColor3=Color3.new(128/255, 0, 0)
	end
end
thetool.Ammo.Changed:connect(onAmmoChanged)

 function raycast(startp, endp, ign)
	local vec=(endp-startp)
	if vec.magnitude<1000 then
		local hit,pos=game.Workspace:FindPartOnRay(Ray.new(startp,vec),ign)
		if hit and pos then
			if hit.Parent.className=="Tool" or hit.Parent.className=="Hat" then
				if hit.Parent.Parent ~= nil then
					if hit.Parent.Parent:findFirstChild("Humanoid")~=nil then
						return hit.Parent, pos
					end
				end
			elseif string.lower(hit.Name)=="glass" then
				local vec=(endp-pos)
				hit,pos=raycast(pos,vec,ign)
			elseif string.lower(hit.Name)=="water" then
				local vec=(endp-pos)
				hit,pos=raycast(pos,vec,ign)
			elseif hit.Transparency==1 or hit.Name=="Bullet" or hit.Name=="BulletTexture" then
				local vec=(endp-pos)
				hit,pos=raycast(pos,vec,hit)
			end
		end
		return hit,pos
	end
	return nil
end

function tagHumanoid(humanoid)
	local plr=game.Players:playerFromCharacter(thetool.Parent)
	local enplr = game.Players:GetPlayerFromCharacter(humanoid.Parent)
	if enplr == nil then
		humanoid.Health = humanoid.Health - BaseDamage
	end
	if plr~=nil then
		local tag=Instance.new("ObjectValue")
		tag.Value=plr
		tag.Name="creator"
		tag.Parent=humanoid
		delay(0.2,function()
			if tag~=nil then
				tag.Parent=nil
			end
		end)
	end
end

function onKeyDown(key,mouse)
	key=key:lower()
	if key=="r" and not reloading then
		reload(mouse)
	elseif key=="t" then
		stopper=false
		reloading=false
		thetool=FindPlane()
	end
end

function movecframe(p,pos)
	p.Parent=game.Lighting
	p.Position=pos
	p.Parent=game.Workspace
end

function SameTeam(killer, victim)
	if game:findFirstChild("Teams")~=nil then
		if killer ~= victim then
			if killer.Neutral==true or victim.Neutral then
				return false
			elseif killer.TeamColor==Team and victim.TeamColor==TeamsAliies then 
				return true
			elseif killer.TeamColor==TeamsAliies and victim.TeamColor==Team then
				return true
			elseif killer.TeamColor == victim.TeamColor then
				return true
			else
				return false
			end
			return false
		else
			return true
		end
		return false
	else
		return false
	end
end

function takeDamage(dm, pl)
	if pl:findFirstChild("Armor")~=nil then
		sh=pl:findFirstChild("Armor")
		if sh.Value==0 then
			pl.Humanoid:TakeDamage(dm)
		elseif sh.Value<dm then
			newdm=dm-sh.Value
			sh.Value=0
			pl.Humanoid:TakeDamage(newdm)
		elseif sh.Value>dm then
			sh.Value=sh.Value-dm
		elseif sh.Value==dm then
			sh.Value=0
		end
	else
		pl.Humanoid:TakeDamage(dm)
	end
end

function KillALLTheNoobs(aim)
	thetool.Fire:Play()
	thetool.Light.Light.Visible = true
	thetool.PointLight.Enabled = true
	local bullet=Bullet:clone()
	local startpoint=thetool.Position
	local direction=(aim-startpoint)
	local cfrm=CFrame.new(startpoint, direction+startpoint)
	local vector=startpoint+(direction.Unit*999)
	if (startpoint-vector).magnitude<1000 then
		local hit,pos=raycast(startpoint,vector,thetool.Parent)
		bullet.Parent=game.Workspace
		if hit~=nil then
			if hit.Parent==thetool.Parent.Parent or game.Players:GetPlayerFromCharacter(hit.Parent)==game.Players.LocalPlayer then
				return nil
			end
			if hit.Parent:FindFirstChild("VecHealth")~=nil then
				vech=hit.Parent:FindFirstChild("VecHealth")
				vech.Value=vech.Value-VehicleDamage
			end
			if hit.Parent:FindFirstChild("HealthStatus")~=nil then
				fo=hit.Parent:FindFirstChild("HealthStatus")
				fo.Value=fo.Value-BaseDamage
			end
			local humanoid=hit.Parent:FindFirstChild("Humanoid")
			if humanoid~=nil then
				local damage=math.random(BaseDamage-(BaseDamage*.25),BaseDamage+(BaseDamage*.25))
				if hit.Name=="Head" then
					damage=damage*1.25
				elseif hit.Name=="Torso" then
				else
					damage=damage*.75
				end
				if humanoid.Health>0 then
					local eplr=game.Players:GetPlayerFromCharacter(humanoid.Parent)
					local plr=game.Players.LocalPlayer
					if eplr~=nil and plr~=nil then
						if (SameTeam(plr, eplr)==false) then
							if hit.Parent:findFirstChild("ForceField")==nil then
								tagHumanoid(humanoid)
								takeDamage(damage, humanoid.Parent)
							end
						end
					else
						if hit.Parent:findFirstChild("ForceField")==nil then
							tagHumanoid(humanoid)
							takeDamage(damage, humanoid.Parent)
						end
					end
				end
			end
			distance=(startpoint-pos).magnitude
			bullet.CFrame=cfrm*CFrame.new(0,0,-distance/2)
			bullet.Mesh.Scale=Vector3.new(.15,.15,distance)
		else
			bullet.CFrame=cfrm*CFrame.new(0,0,-RayLength/2) 
			bullet.Mesh.Scale=Vector3.new(.15,.15,RayLength)
		end
		if pos~=nil then
			--bt2.CFrame=bullet.CFrame
			--movecframe(bt2,pos)
		end
		local deb=game:FindFirstChild("Debris")
		if deb==nil then
			local debris=Instance.new("Debris")
			debris.Parent=game
		end
		ammo.Value=ammo.Value-1
		check()
		game.Debris:AddItem(bullet,.05)
		game.Debris:AddItem(sX, .3)
		wait(0.03)
		thetool.Light.Light.Visible = false
		thetool.PointLight.Enabled = false
	end
end

function onButton1Up(mouse)
	down=false
end

function onButton1Down(mouse)
	h=game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
	if reloading~=true and stopper~=true and h~=nil and equiped==true then
		thetool.Triger:Play()
		down=true
		stopper=true
		if ammo.Value<=0 then
			flash()
		end
		while ammo.Value>0 and h.Health>0 and down==true do
			if threebb then
				local startpoint=thetool.CFrame.p
				local mag=(mouse.Hit.p-startpoint).magnitude
				local rndm=Vector3.new(math.random(-(Spread/10)*mag,(Spread/10)*mag),math.random(-(Spread/10)*mag,(Spread/10)*mag),math.random(-(Spread/10)*mag,(Spread/10)*mag))
				KillALLTheNoobs(mouse.Hit.p+rndm)
				if ammo.Value<=0 then
					break
				end
				wait(0.05)
				local startpoint=thetool.CFrame.p
				local mag2=((mouse.Hit.p+rndm)-startpoint).magnitude
				local rndm2=Vector3.new(math.random(-(.1/10)*mag2,(.1/10)*mag2),math.random(-(.1/10)*mag2,(.1/10)*mag2),math.random(-(.1/10)*mag2,(.1/10)*mag2))
				KillALLTheNoobs(mouse.Hit.p+rndm+rndm2)
				if ammo.Value<=0 then
					break
				end
				wait(0.05)
				KillALLTheNoobs(mouse.Hit.p+rndm+rndm2+rndm2)
			elseif shot then
				local startpoint=thetool.CFrame.p
				local mag=(mouse.Hit.p-startpoint).magnitude
				local rndm=Vector3.new(math.random(-(Spread/10)*mag,(Spread/10)*mag),math.random(-(Spread/10)*mag,(Spread/10)*mag),math.random(-(Spread/10)*mag,(Spread/10)*mag))
				KillALLTheNoobs(mouse.Hit.p+rndm)
				local mag2=(mouse.Hit.p-startpoint).magnitude
				local rndm2=Vector3.new(math.random(-(.2/10)*mag2,(.2/10)*mag2),math.random(-(.2/10)*mag2,(.2/10)*mag2),math.random(-(.2/10)*mag2,(.2/10)*mag2))
				KillALLTheNoobs(mouse.Hit.p+rndm2)
				local rndm3=Vector3.new(math.random(-(.2/10)*mag2,(.2/10)*mag2),math.random(-(.2/10)*mag2,(.2/10)*mag2),math.random(-(.2/10)*mag2,(.2/10)*mag2))
				KillALLTheNoobs(mouse.Hit.p+rndm3)
				local rndm4=Vector3.new(math.random(-(.2/10)*mag2,(.2/10)*mag2),math.random(-(.2/10)*mag2,(.2/10)*mag2),math.random(-(.2/10)*mag2,(.2/10)*mag2))
				KillALLTheNoobs(mouse.Hit.p+rndm4)
			else
				local startpoint=thetool.CFrame.p
				local mag=(mouse.Hit.p-startpoint).magnitude
				local rndm=Vector3.new(math.random(-(Spread/10)*mag,(Spread/10)*mag),math.random(-(Spread/10)*mag,(Spread/10)*mag),math.random(-(Spread/10)*mag,(Spread/10)*mag))
				KillALLTheNoobs(mouse.Hit.p+rndm)
			end
			wait(Firerate)
			if auto==false or ammo.Value<=0 then
				break
			end
		end
		stopper=false
	end
end

function onEquippedLocal(mouse)
	if mouse==nil then
		print("Mouse not found")
		return 
	end
	if (not player.PlayerGui:FindFirstChild("GunGui")) then
		script.GunGui:Clone().Parent=player.PlayerGui
	end
	mouse.Icon=Cursor
	mouse.KeyDown:connect(function(key) onKeyDown(key,mouse) end)
	mouse.Button1Down:connect(function() onButton1Down(mouse) end)
	mouse.Button1Up:connect(function() onButton1Up(mouse) end)
	equiped=true
	down=false
	check()
end

function onUnequippedLocal(mouse)
		if player.PlayerGui:FindFirstChild("GunGui")~=nil then
			player.PlayerGui:FindFirstChild("GunGui").Parent=nil	
		end
	equiped=false
	reloading=false
	down=false
end

script.Parent.Selected:connect(onEquippedLocal)
script.Parent.Deselected:connect(onUnequippedLocal)
