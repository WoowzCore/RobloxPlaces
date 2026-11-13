local basa = require(script.Parent:WaitForChild("PlayerBase"))
local u = game:GetService("UserInputService")
local c = basa.Camera
local rs = game:GetService("ReplicatedStorage")

local Lerp = function(a, b, t)
	return a + (b - a) * t
end

local Turn,Turn2 = 0,0

local function GunRecoil(guninfo)
	for i = 0, 10, 5 do
		local goal = c.CFrame * CFrame.Angles(math.rad(0.5), 0, 0)
		local newCF = c.CFrame:Lerp(goal, i)
		c.CFrame = newCF
		game:GetService("RunService").RenderStepped:Wait()
	end
end
rs.Player.GunRecoil.OnClientEvent:Connect(GunRecoil)

game:GetService("RunService").RenderStepped:Connect(function(dt)
	local result = basa.Camera.CFrame
	local ResultInAttachedToHead = false
	
	if basa.Data.Camera.FirstPerson then
		if basa.Ragdoll or basa.Died then
			ResultInAttachedToHead = true
			result = basa.Parts.Head.CFrame:ToWorldSpace(CFrame.new(0,0.3,0.1)) + basa.CameraInfo.CameraShake
		end
	end
	
	if basa.Settings.Gameplay.CustomCamera then
		if not ResultInAttachedToHead then
			local CT = tick()
			if basa.Humanoid.MoveDirection.Magnitude > 0 then
				local modifi = (basa.Humanoid.MoveDirection.Magnitude * basa.Humanoid.WalkSpeed)/basa.MovingData.WalkSpeed
				if basa.Died or basa.Ragdoll or basa.MovingData.Sit then
					modifi = 0 
				end
				local BobbleX = math.cos(CT*5)*(0.25*modifi)
				local BobbleY = math.abs(math.sin(CT*5))*(0.25*modifi)
				local Bobble = Vector3.new(BobbleX,BobbleY,0)
				basa.CameraInfo.OffsetMoving = basa.CameraInfo.OffsetMoving:lerp(Bobble, 0.25)
			else
				basa.CameraInfo.OffsetMoving = basa.CameraInfo.OffsetMoving * 0.75
			end
			
			local MouseDelta = u:GetMouseDelta()
			
			local x,y,z = basa.Camera.CFrame:ToOrientation()
			x = math.deg(x)
			
			local turnval = 6 * (((basa.Drunk/100)*3)+1)
			
			Turn = Lerp(Turn, math.clamp(MouseDelta.X, -turnval, turnval), (6 * dt))
			Turn2 = Lerp(Turn2, math.clamp(MouseDelta.Y, -turnval,turnval), (6 * dt))
			
			if Turn2+x > 80 or Turn2+x < 80 then
				Turn2 = 0
			end
			
			result = result * CFrame.Angles(math.rad(-Turn2), 0, math.rad(Turn))
		end
	end
	
	basa.Camera.CFrame = result
end)