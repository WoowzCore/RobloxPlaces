local u = game:GetService("UserInputService")
local plr = game:GetService("Players").LocalPlayer
local uis = game:GetService("UserInputService")
local ugs = UserSettings():GetService("UserGameSettings")
local cam = workspace.CurrentCamera
local tw = game:GetService("TweenService")
local pd = require(script.Parent.PlayerData)
local mouse = plr:GetMouse()
local keys = {}

local p = {}

p.loaded = false
p.showmouse = false
p.mouse = plr:GetMouse()
p.walkspeed = 0

local cameraMoveSpeed = 1
local mouseDelta = Vector2.zero

p.CameraLoading = function()
	repeat 
		cam.CameraType = Enum.CameraType.Scriptable
		task.wait(1)
	until cam.CameraType == Enum.CameraType.Scriptable
	
	uis.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement then
			local inputDelta = Input.Delta
			
			mouseDelta = Vector3.new(
				mouseDelta.X - (inputDelta.X / pd.Sensitivity),
				math.clamp(mouseDelta.Y - inputDelta.Y / pd.Sensitivity, pd.CameraMin, pd.CameraMax)
			)
		end
	end)
end
p.CameraLoading()

p.Jump = function()
	if not pd.Ragdoll then
		workspace.Player.Body:ApplyImpulse(Vector3.new(0,pd.JumpPower*10,0))
	end
end

local Attacked = false
mouse.Button1Down:Connect(function()
	if not pd.Ragdoll and not Attacked then
		Attacked = true
		wait(1)
		Attacked = false
	end
end)

u.InputBegan:Connect(function(key)
	keys[key.KeyCode] = true
	
	if(key.KeyCode==Enum.KeyCode.Space)then
		p.Jump()
		if pd.Ragdoll then
			pd.Ragdoll = false
		end
	end
	
	if(key.KeyCode==Enum.KeyCode.R)then
		pd.Ragdoll = not pd.Ragdoll
	end
end)

u.InputEnded:Connect(function(key)
	keys[key.KeyCode] = false
end)

p.UpdateCameraArms = function()
	--[[local pos = workspace.Player.Model.Torso.ArmPos.WorldPosition
	if Attacked then
		pos = workspace.Player.Model.Torso.ArmAttackPos.WorldPosition
	end
	
	workspace.Player.Model.ArmRight.AlignOrientation.CFrame = CFrame.new(pos)]]
end

local t = 0
local bob = 0
local movingdir = Vector3.new(0,0,0)
p.UpdateCamera = function(dt)
	local bx,by,bz = workspace.Player.Body.CFrame:ToOrientation()
	local rotation = CFrame.Angles(0, math.rad(mouseDelta.X), 0) * CFrame.Angles(math.rad(mouseDelta.Y), 0, 0) * CFrame.Angles(bx,0,bz)
	
	local velocity = (movingdir).Magnitude
	bob = bob + velocity
	
	local x,y,z = cam.CFrame:ToOrientation()
	local bobbingoffset = CFrame.Angles(0,y,0):VectorToWorldSpace(Vector3.new(math.sin(bob/300)/3,math.cos(bob/200)/4,0))
	
	local tw_ = tw:Create(cam,TweenInfo.new(dt),{CFrame = 
		CFrame.new(workspace.Player.Eyes.CFrame.Position + bobbingoffset) * rotation
	}):Play()
	workspace.Player.Legs.AlignOrientation.CFrame = CFrame.Angles(0,y,0)
end

p.UpdateWalk = function()
	if not pd.Ragdoll then
		local velocity = (workspace.Player.Body.AssemblyLinearVelocity*Vector3.new(1,0,1)).Magnitude
		local speed = math.max(p.walkspeed-velocity,0)
		local x = 0
		local z = 0
		if(keys[Enum.KeyCode.W])then
			z += 1
		end
		if(keys[Enum.KeyCode.S])then
			z -= 1
		end
		if(keys[Enum.KeyCode.D])then
			x -= 1
		end
		if(keys[Enum.KeyCode.A])then
			x += 1
		end
	
		if(x~=0 or z~=0)then
			local camrotcf = workspace.Camera.CFrame - workspace.Camera.CFrame.p
			local camrot = math.atan2(camrotcf.lookVector.x, camrotcf.lookVector.z)
			local v = CFrame.Angles(0,camrot,0):VectorToWorldSpace(Vector3.new(x,0,z)).Unit
			workspace.Player.Body:ApplyImpulse(v*speed)
		end
		movingdir = Vector3.new(x*speed,0,z*speed)
	else
		movingdir = Vector3.zero
	end
end

p.UpdateSpeed = function()
	local result = pd.WalkSpeed
	
	if(keys[Enum.KeyCode.LeftShift])then
		result = pd.RunSpeed
	elseif(keys[Enum.KeyCode.LeftControl])then
		result = pd.SlowWalkSpeed
	end
	
	p.walkspeed = result
end

p.RagdollUpdate = function()
	workspace.Player.Legs.AlignOrientation.Enabled = not pd.Ragdoll
	workspace.Player.Model.ArmLeft.AlignOrientation.Enabled = not pd.Ragdoll
	workspace.Player.Model.ArmRight.AlignOrientation.Enabled = not pd.Ragdoll
end

p.UpdateFunction = function(dt)
	t = t + dt
	u.MouseIconEnabled = p.showmouse
	if(p.showmouse)then
		u.MouseBehavior = Enum.MouseBehavior.Default
	else
		u.MouseBehavior = Enum.MouseBehavior.LockCenter
	end
	
	p.UpdateSpeed()
	p.UpdateWalk()
	p.UpdateCameraArms()
	p.UpdateCamera(dt)
	p.RagdollUpdate()
end

game:GetService("RunService").RenderStepped:Connect(function(dt)
	if(p.loaded)then
		p.UpdateFunction(dt)
	end
end)

return p
