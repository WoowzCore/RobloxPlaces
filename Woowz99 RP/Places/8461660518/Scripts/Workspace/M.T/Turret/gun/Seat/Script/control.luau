wait(0.2)
local TARGET_RADIUS = 5
local MAX_SPEED = 1750
local MAX_TORQUE = Vector3.new(4e6, 4e6, 0)
local MAX_THRUST = 1750
local THRUST_P = 500
local THRUST_D = 500
md = false
local mouse = game.Players.LocalPlayer:GetMouse()
mouse.TargetFilter = script.Value.Value
local running = false
local gun=script.Value.Value
local SPAWN = gun.body:GetPrimaryPartCFrame()
local aimpos = Vector3.new(0,0,0)
rs=game:GetService("RunService").RenderStepped
local canfire = true
local round = 1

function fire()
	if canfire == true and md == true then
		canfire=false
		local a = Instance.new("Part")
		local spawnPosition
		if round ==1 then
		spawnPosition = gun.gun.gunpart.Position + (gun.gun.gunpart.CFrame.lookVector * 5)
		else
		spawnPosition = gun.gun.gunpart2.Position + (gun.gun.gunpart2.CFrame.lookVector * 5)

			end
		a.Size = Vector3.new(0.2,0.2,5)
		a.CFrame = CFrame.new(spawnPosition, mouse.Hit.p)
		a.BrickColor=BrickColor.new("Bright yellow")
		a.Material = "Neon"
		local rocketPropulsion = Instance.new('RocketPropulsion', a)
	    rocketPropulsion.CartoonFactor = 1
	    rocketPropulsion.TargetRadius = TARGET_RADIUS
	    rocketPropulsion.MaxSpeed = MAX_SPEED
	    rocketPropulsion.MaxTorque = MAX_TORQUE
     	rocketPropulsion.MaxThrust = MAX_THRUST
    	rocketPropulsion.ThrustP = THRUST_P
	    rocketPropulsion.ThrustD = THRUST_D
	    local direction = (mouse.Hit.p - a.Position).unit
	    rocketPropulsion.TargetOffset = a.Position + (direction * 100000000)
		rocketPropulsion:Fire()
	    a.CanCollide = false
		a.Parent=game.Workspace
		if round == 1 then
		gun.gun.effect.bam:Play()
		spawn(function()
		for i = 1, 10 do
		gun.gun.effect.ParticleEmitter:Emit(5)
		rs:Wait()
		end
		end)
		spawn(function()
		for i = 1, 20 do
		gun.gun.effect.smoke:Emit(1)
		wait(0.1)
		end
		end)
		spawn(function()
		gun.gun.barrel.Mesh.Offset = Vector3.new(0,-4,0)
		for i = 1, 10 do
		gun.gun.barrel.Mesh.Offset = Vector3.new(0,(-4+(i/2.5)),0)
		rs:Wait()
		end
		end)
		end
		if round == 2 then
		gun.gun.effect2.bam:Play()
		spawn(function()
		for i = 1, 10 do
		gun.gun.effect2.ParticleEmitter:Emit(5)
		rs:Wait()
		end
		end)
		spawn(function()
		for i = 1, 20 do
		gun.gun.effect2.smoke:Emit(1)
		wait(0.1)
		end
		end)
		spawn(function()
		gun.gun.barrel2.Mesh.Offset = Vector3.new(0,-4,0)
		for i = 1, 10 do
		gun.gun.barrel2.Mesh.Offset = Vector3.new(0,(-4+(i/2.5)),0)
		rs:Wait()
		end
		end)
		end
		if round == 1 then
		local b=script.bullet:Clone()
		b.Parent=a
		b.Value.Value = gun.gun.gunpart
		b.Disabled =false
		game:GetService("Debris"):AddItem(a,7)
		else
		local b=script.bullet:Clone()
		b.Parent=a
		b.Value.Value = gun.gun.gunpart2
		b.Disabled =false
		game:GetService("Debris"):AddItem(a,7)	
		end
		if round ==1 then
			round = 2
		else
			round = 1
		end
		wait(0.1)
		canfire=true
		if md == true then
			fire()
		end
	end
end
function poo()
		gun.gun.barrel.Mesh.Offset = Vector3.new(0,0,0)
	mouse.TargetFilter = nil
	mouse.Icon=oldIcon
	script:remove()
end
function no()
	md = false
end
function mousedown()
	md = true
	fire()
end
oldIcon = mouse.Icon
mouse.Icon="http://www.roblox.com/asset/?id=138865017"
person = game.Players.LocalPlayer.Character
person.Humanoid.Jumping:connect(poo)
mouse.Button1Down:connect(mousedown) -- Run function
mouse.Button1Up:connect(no)	
while rs:Wait() do
	aimpos = mouse.Hit.p
	if (aimpos-gun.base.Position).magnitude>3 then
	
	
	local c = aimpos
	local x = (gun.gun:GetPrimaryPartCFrame()*CFrame.new(0, 0, -100000)).x
	local y = (SPAWN*CFrame.new(0, 0, -100000)).y
	local z = (gun.gun:GetPrimaryPartCFrame()*CFrame.new(0, 0, -100000)).z
	A = Vector3.new(x,
					y,
					z
					)
	if c then
		gun.gun:SetPrimaryPartCFrame(
			CFrame.new(gun.body:GetPrimaryPartCFrame().p,
			c)
		)
		gun.body:SetPrimaryPartCFrame(
			CFrame.new(
				SPAWN.p,
				A
			)
		)
	else
		gun:SetPrimaryPartCFrame(gun.body:GetPrimaryPartCFrame())
		gun.body:SetPrimaryPartCFrame(
			CFrame.new(
				SPAWN.p,
				A
			)
		)
		end
	end
end

