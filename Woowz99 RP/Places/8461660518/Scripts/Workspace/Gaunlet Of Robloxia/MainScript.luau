local tool = script.Parent
--<<Variables>>--
local Buffev = tool.BuffEvent
local Nobuffev = tool.BuffOffEvent
local Powerr = tool.RemoteEvent
local Space = tool.TP
local Time = tool.Time
local Reality = tool.Real
local SS = tool.SingleSnapEvent
local S = tool.SnapEvent
local M = tool.Meteor
--<<ABILITIES>>--
function SSnap(target,hum)
	local terget = target:GetChildren()
	for i,torget in pairs(terget) do
		if torget:IsA("Part") then
			local eff = Instance.new("SelectionBox")
			local boom = Instance.new("Explosion")
			eff.Parent = torget.Parent
			eff.Adornee = torget.Parent
			eff.Color3 = Color3.new(0, 0, 0)
			eff.SurfaceColor3 = Color3.new(0, 0, 0)
			wait(1)
			eff:Destroy()
			boom.Parent = torget
			boom.Name = "The Snap"
			boom.Position = torget.Position
			boom.BlastPressure = 5
			wait(.01)
			boom:Destroy()
			for i,Part in pairs(torget.Parent) do
				if Part:IsA("Part") then
					Part:Destroy()
				end
			end
		end
	end
end
local function Power(player, mouseTarget)
	local gunlight = Instance.new("PointLight")
	gunlight.Brightness = 10
	gunlight.Color = Color3.new(255, 0, 150)
	gunlight.Parent = tool.Handle

	wait(0.1)
	gunlight:Destroy()
	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = {player.Character} --ignore the character when raycasting
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

	--raycast towards whatever the player's mouse is aiming at 
	local startPos = player.Character.PrimaryPart.Position
	local range = 300 -- how far the raycast can travel 
	local aimDirection = (mouseTarget - startPos).Position * range
	local rayResult = workspace:Raycast(startPos, aimDirection, raycastParams) -- raycast! 

	if rayResult then
		local hitPart = rayResult.Instance -- the part the raycast hit 
		local hitPos = rayResult.Position -- the position where the raycast hit 
		local distance = (hitPos - startPos).magnitude -- distance of our shot 

		if hitPart then
			local Hum = hitPart.Parent:FindFirstChildOfClass("Humanoid")
			if Hum then
				Hum:TakeDamage(Hum.MaxHealth)
			end
		end

		-- set up the laser part which just acts as a visual effect 
		local laserPart = Instance.new("Part")
		laserPart.Anchored = true 
		laserPart.Name = "Laser"
		laserPart.BrickColor = BrickColor.new("Royal purple")
		laserPart.CanCollide = false
		laserPart.Size = Vector3.new(1, 1, distance)
		laserPart.Material = Enum.Material.Neon
		laserPart.CFrame = CFrame.new(tool.Handle.Position, hitPos) * CFrame.new(0, 0, -distance / 2)
		laserPart.Parent = workspace

		wait(0.2)
		laserPart:Destroy()
	end
end
function RealityDestroyEffects(target)
	local eff = Instance.new("SelectionBox")
	eff.Parent = target
	eff.Adornee =target
	eff.Color3 = Color3.new(1, 0, 0)
	eff.SurfaceColor3 = Color3.new(1, 0, 0)
	wait(1)
	eff:Destroy()
	target:Destroy()
end
local function RealityDestroy(player, target)
	local gunlight2 = Instance.new("PointLight")
	gunlight2.Brightness = 10
	gunlight2.Color = Color3.new(255, 0, 0)
	gunlight2.Parent = tool.Handle

	wait(0.1)

	gunlight2:Destroy()
	RealityDestroyEffects(target)
end

local function SpaceTeleport(player, target)
	local gunlight = Instance.new("PointLight")
	gunlight.Brightness = 10
	gunlight.Color = Color3.new(0, 0, 255)
	gunlight.Parent = tool.Handle

	wait(0.1)

	gunlight:Destroy()
end

local function TimeFreeze(player,target)
	local gunlight = Instance.new("PointLight")
	gunlight.Brightness = 10
	gunlight.Color = Color3.new(0, 1, 0)
	gunlight.Parent = tool.Handle
	
	wait(0.1)
	gunlight:Destroy()
	local Froze = target.Parent
	local Hum = Froze:FindFirstChildOfClass("Humanoid")
	if Hum.WalkSpeed > 0 then
		--no
	else
		Hum.WalkSpeed = 0
		Hum.JumpPower = 0
	end
end

local function Snap()
	local Player = game:GetService("Players")
	local LOL = Player:GetPlayers()
	for i,plr in pairs(LOL) do
		SSnap(plr.Character,plr.Character:FindFirstChild("Humanoid"))
	end
end


local function Single_Snap(player, target)
	local gunlight = Instance.new("PointLight")
	gunlight.Brightness = 10
	gunlight.Color = Color3.new(0, 0, 0)
	gunlight.Parent = tool.Handle

	wait(0.1)

	gunlight:Destroy()
	if target:FindFirstChild("Humanoid") then
		SSnap(target,target:FindFirstChild("Humanoid"))
	end
end
--<<Values>>--
local function Buff(player, target)
	local protect = Instance.new("ForceField")
	protect.Name = "Field Of Time[TIME STONE]"
	protect.Visible = false
	protect.Parent = script.Parent.Parent
end

local function UnBuff(player, target)
	local force = script.Parent.Parent.Parent.Character["Field Of Time[TIME STONE]"]
	if force then
		force:Destroy()
	end
end

local function explode(player,target)
	local e = Instance.new("Explosion")
	e.DestroyJointRadiusPercent = 1 -- Make the explosion non-deadly 
	e.BlastRadius = 100
	e.Parent = target
	e.Position = target.Position
	wait(1)
	e:Destroy()
end

--<<Run Functions>>--
Buffev.OnServerEvent:Connect(Buff)
Nobuffev.OnServerEvent:Connect(UnBuff)
Powerr.OnServerEvent:Connect(Power)
Space.OnServerEvent:Connect(SpaceTeleport)
Time.OnServerEvent:Connect(TimeFreeze)
Reality.OnServerEvent:Connect(RealityDestroy)
SS.OnServerEvent:Connect(Single_Snap)
S.OnServerEvent:Connect(Snap)
M.OnServerEvent:Connect(explode)