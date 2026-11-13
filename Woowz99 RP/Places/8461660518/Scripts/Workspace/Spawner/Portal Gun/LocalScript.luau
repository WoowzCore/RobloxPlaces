local tool = script.Parent
local debris = game:GetService("Debris")
local timestart = false
local timer = 0
local model = Instance.new("Model",game.Workspace)
local colora = BrickColor.new(Color3.new(math.random(255)/255,math.random(255)/255,math.random(255)/255))
local colorb = BrickColor.new(Color3.new(math.random(255)/255,math.random(255)/255,math.random(255)/255))
print(colora)
print(colorb)
tool:WaitForChild("Settings")
local pp = script.Parent.Settings.PortalPower
local cw = script.Parent.Settings.CameraWait
local cg --[[;^)]] = script.Parent.Settings.CanGrab
local gp = script.Parent.Settings.GrabPower
local gr = script.Parent.Settings.GrabRange
script.Parent:WaitForChild("surface")
funcs = require(script.Parent.surface)

function gpos(part,pos,ignore)
	local r = Ray.new(part.Position,(pos-part.Position).unit*999)
	return workspace:FindPartOnRayWithIgnoreList(r,ignore)
end

tool.Equipped:connect(function (mouse)
	script.Parent.Handle.Anchored = false
	local player = game.Players.LocalPlayer
	local grabbed_object = nil
	model.Name = player.Name.."'s Portals"
	local canTeleport = true
	
	function getModelMass(model)
		if model == nil then return 0 end
		local mass = 0
		local function getModelMass(m)
			for i,v in pairs(m:GetChildren()) do
				if v:IsA("BasePart") then
					mass = mass + v:GetMass()
				elseif v:IsA("Model") then
					getModelMass(v)
				end
			end
		end
		getModelMass(model)
		return mass
	end
	
	function telePortal(hit, blue)
		if hit == grabbed_object then
			grabbed_object.Grab:Destroy()
			grabbed_object = nil
		end
		if model:findFirstChild("BluePortal") and model:findFirstChild("RedPortal") then
			if hit.Parent and hit.Parent ~= workspace and hit.Anchored == false then
				if getModelMass(hit.Parent) > 60 then return else
					if hit.Parent:findFirstChild("Torso") then
						hit = hit.Parent.Torso
					end
				end
			else
				if hit:getMass() > 60  or hit.Anchored then return end
			end
			
			local this
			local other
			
			if blue then
				this = model.BluePortal
				other = model.RedPortal
			else
				this = model.RedPortal
				other = model.BluePortal
			end
			
			local x = math.abs(hit.Velocity.x)
			local y = math.abs(hit.Velocity.y)
			local z = math.abs(hit.Velocity.z)
			
			local main = 0
			if x > y and x > z then
				main = x
			elseif y > x and y > z then
				main = y
			elseif z > x and z > y then
				main = z
			end
			main = math.ceil(main)
			local dir = other.CFrame.lookVector
			local spawn = other.CFrame.p + (dir*3)
			hit.CFrame = CFrame.new(spawn, spawn+dir*2)
			hit.Velocity = dir*main*pp.Value
		end
	end
	
	function makePortal(pos, hit, blue)
		local p = Instance.new("Part", model)
		if blue then p.Name = "BluePortal" else p.Name = "RedPortal" end
		if blue then p.BrickColor = colora else p.BrickColor = colorb end
		p.Material = Enum.Material.Neon
		p.FormFactor = Enum.FormFactor.Custom
		p.Size = Vector3.new(4,6,3)
		p.TopSurface = 0
		p.BottomSurface = 0
		p.Anchored = true
		local p2 = Instance.new("Part", model)
		p2.Size = Vector3.new(0.2,0.2,0.2)
		p2.CanCollide = false
		p2.TopSurface = 0
		p2.BottomSurface = 0
		p2.BrickColor = p.BrickColor
		if blue then
			p2.Name = "BP"
		else
			p2.Name = "RP"
		end
		local sm2 = Instance.new("SpecialMesh", p2)
		sm2.Scale = Vector3.new(0.45, 0.3, 0.0018)
		sm2.MeshId = "rbxassetid://431119824"
		local sm = Instance.new("SpecialMesh",p)
		sm.MeshType = "Sphere"
		sm.Scale = Vector3.new(1,1,0.01)
		p.CanCollide = false
		local dir = funcs.getSide(hit,funcs.surface(hit,pos))
		p.CFrame = CFrame.new(pos, pos + dir)
		p2.CFrame = p.CFrame * CFrame.Angles(0,0,math.pi/2)
		funcs.weld(p2,p)
		if hit.Anchored == false then
			local pos = p.CFrame:inverse() * hit.CFrame
			funcs.weld(p,hit)
			p.Anchored = false
			p.ChildRemoved:connect(function (c)
				if c.Name == "Weld" then
					p:Destroy()
					p2:Destroy()
				end
			end)
		end
		p.Touched:connect(funcs.debounce(function (h) if canTeleport then canTeleport = false telePortal(h,blue) wait(.1) canTeleport = true end end))
	end
	
	function firePortal(origin,dir,blue,chit,target)
		local p = Instance.new("Part", game.Workspace)
		p.FormFactor = Enum.FormFactor.Custom
		p.Size = Vector3.new(.1,.1,.1)
		p.TopSurface = 0
		p.BottomSurface = 0
		if blue then
			p.BrickColor = colora
		else
			p.BrickColor = colorb
		end
		p.Material = Enum.Material.Neon
		local sm = Instance.new("SpecialMesh",p)
		sm.MeshType = "Sphere"
		sm.Scale = Vector3.new(10,10,10)
		p.Reflectance = 1
		local bf = Instance.new("BodyForce",p)
		bf.force = Vector3.new(0,196.2,0)*p:GetMass()
		p.Velocity = dir*200
		p.CFrame = CFrame.new(origin,origin+dir)
		p:BreakJoints()
		tool.Fire:Play()
		funcs.debounce(p.Touched:connect(function (h)
			if blue and target then
				if model:FindFirstChild("BluePortal") then model.BluePortal:Destroy() end
				if model:FindFirstChild("BP") then model.BP:Destroy() end
				makePortal(chit,target,true)
				
			elseif not blue and target then
				if model:FindFirstChild("RedPortal") then model.RedPortal:Destroy() end
				if model:FindFirstChild("RP") then model.RP:Destroy() end
				makePortal(chit,target,false)
			end
			p:Destroy()
		end))
		debris:AddItem(p,120)
	end
				
		funcs.debounce(mouse.Button2Down:connect(function ()
			timestart = false
			wait(cw.Value)
			timestart = true
		end))
				
		funcs.debounce(mouse.Button1Down:connect(function ()
			local dir = (mouse.Hit.p - player.Character.Head.Position).unit
			local origin = player.Character.Head.Position + dir*5
			local block, pos = gpos(tool.Handle,mouse.Hit.p,{tool.Parent,model,grabbed_object})
			firePortal(origin,dir,true,pos,block)
		end))
		
		funcs.debounce(mouse.Button2Up:connect(function ()
			if timestart then return end
			local dir = (mouse.Hit.p - player.Character.Head.Position).unit
			local origin = player.Character.Head.Position + dir*5
			local block, pos = gpos(tool.Handle,mouse.Hit.p,{tool.Parent,model,grabbed_object})
			firePortal(origin,dir,false,pos,block)
		end))
		
		funcs.debounce(mouse.KeyDown:connect(function (k)
			local mt = mouse.Target
			if mt then
				if k == "e" and cg.Value then
					if grabbed_object == nil and (mt.Position - tool.Handle.Position).magnitude < gr.Value then
						if mt:getMass() > gp.Value then return end
						mt.CFrame = tool.Handle.CFrame * CFrame.new(0,6,0)
						local w = funcs.weld(mt, tool.Handle)
						w.Name = "Grab"
						grabbed_object = mt
					elseif grabbed_object then
						grabbed_object.Grab:Destroy()
						grabbed_object.Velocity = tool.Parent.Torso.CFrame.lookVector*100
						grabbed_object = nil
					end
				end
			end
			
			if k == "r" then
				model:ClearAllChildren()
			end
		end))	
	
	local event = workspace.ChildRemoved:connect(function (c)
		if c == model then
			model = Instance.new("Model", workspace)
			model.Name = player.Name.."'s Portals"
		end
	end)
	
	player.Character.Humanoid.Died:connect(function ()
		event:disconnect()
		model:Destroy()
	end)
end)

tool.Unequipped:connect(function ()
	if tool.Parent == game.Workspace then
		model:Destroy()
		model = Instance.new("Model", workspace)
	end
end)