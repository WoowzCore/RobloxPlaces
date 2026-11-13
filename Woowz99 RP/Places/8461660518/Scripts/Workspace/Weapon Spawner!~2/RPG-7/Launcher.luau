-----------------
--| Constants |--
-----------------

local COOLDOWN = 4 -- Seconds until tool can be used again

-- RocketPropulsion Fields
local TARGET_RADIUS = 5
local MAX_SPEED = 95
local MAX_TORQUE = Vector3.new(4e6, 4e6, 0)
local MAX_THRUST = 50000
local THRUST_P = 500
local THRUST_D = 50000

local TARGET_OVERSHOOT_DISTANCE = 10000000

local ROCKET_MESH_ID = 'http://www.roblox.com/asset/?id=94690081'
local ROCKET_MESH_SCALE = Vector3.new(2.5, 2.5, 2)
local ROCKET_PART_SIZE = Vector3.new(1, 1, 4)

--------------------
--| WaitForChild |--
--------------------

-- Waits for parent.child to exist, then returns it
local function WaitForChild(parent, childName)
	assert(parent, "ERROR: WaitForChild: parent is nil")
	while not parent:FindFirstChild(childName) do parent.ChildAdded:wait() end
	return parent[childName]
end

-----------------
--| Variables |--
-----------------

local DebrisService = Game:GetService('Debris')
local PlayersService = Game:GetService('Players')

local Tool = script.Parent
local ToolHandle = Tool.Handle

local RocketScript = WaitForChild(script, 'Rocket')

local SwooshSound = WaitForChild(script, 'Swoosh')
local BoomSound = WaitForChild(script, 'Boom')
local ReloadSound = WaitForChild(ToolHandle, 'ReloadSound')
local FireSound = WaitForChild(ToolHandle, 'FireSound')

local MyModel = nil
local MyPlayer = nil

local BaseRocket = nil
local RocketClone = nil

-----------------
--| Functions |--
-----------------

local function MakeBaseRocket()
	-- Set up the rocket part
	local rocket = Instance.new('Part')
	rocket.Name = 'Rocket'
	rocket.FormFactor = Enum.FormFactor.Custom --NOTE: This must be done before changing Size
	rocket.Size = ROCKET_PART_SIZE
	rocket.CanCollide = false
	rocket.BottomSurface = Enum.SurfaceType.Smooth
	rocket.TopSurface = Enum.SurfaceType.Smooth

	-- Add the mesh
	local mesh = Instance.new('SpecialMesh', rocket)
	mesh.MeshId = ROCKET_MESH_ID
	mesh.Scale = ROCKET_MESH_SCALE
	mesh.TextureId = ToolHandle.Mesh.TextureId

	-- Add fire
	local fire = Instance.new('Fire', rocket)
	fire.Heat = 3
	fire.Size = 2

	-- Add the propulsion
	local rocketPropulsion = Instance.new('RocketPropulsion', rocket)
	rocketPropulsion.CartoonFactor = 1
	rocketPropulsion.TargetRadius = TARGET_RADIUS
	rocketPropulsion.MaxSpeed = MAX_SPEED
	rocketPropulsion.MaxTorque = MAX_TORQUE
	rocketPropulsion.MaxThrust = MAX_THRUST
	rocketPropulsion.ThrustP = THRUST_P
	rocketPropulsion.ThrustD = THRUST_D

	-- Clone the sounds
	local swooshSoundClone = SwooshSound:Clone()
	swooshSoundClone.Parent = rocket
	local boomSoundClone = BoomSound:Clone()
	boomSoundClone.Parent = rocket

	-- Attach creator tags
	local creatorTag = Instance.new('ObjectValue', rocket)
	creatorTag.Name = 'creator' --NOTE: Must be called 'creator' for website stats
	creatorTag.Value = MyPlayer
	local iconTag = Instance.new('StringValue', creatorTag)
	iconTag.Name = 'icon'
	iconTag.Value = Tool.TextureId

	-- Finally, clone the rocket script and enable it
	local rocketScriptClone = RocketScript:Clone()
	rocketScriptClone.Parent = rocket
	rocketScriptClone.Disabled = false

	return rocket
end

local function OnEquipped()
	MyModel = Tool.Parent
	MyPlayer = PlayersService:GetPlayerFromCharacter(MyModel)
	BaseRocket = MakeBaseRocket()
	RocketClone = BaseRocket:Clone()
end

local function OnActivated(byFireButton)
	if Tool.Enabled and MyModel and MyModel:FindFirstChild('Humanoid') and MyModel.Humanoid.Health > 0 then
		Tool.Enabled = false

		-- Get the target position
		local targetPosition = MyModel.Humanoid.TargetPoint
		if byFireButton then -- Using Fire Button, shoot forwards
			targetPosition = MyModel.Humanoid.Torso.CFrame.lookVector * 1000
		end

		-- Position the rocket clone
		local spawnPosition = ToolHandle.Position + (ToolHandle.CFrame.lookVector * (ToolHandle.Size.z / 2))
		RocketClone.CFrame = CFrame.new(spawnPosition, targetPosition) --NOTE: This must be done before assigning Parent
		DebrisService:AddItem(RocketClone, 30)
		RocketClone.Parent = Workspace

		-- Assign target and launch!
		FireSound:Play()
		local rocketPropulsion = RocketClone:FindFirstChild('RocketPropulsion')
		if rocketPropulsion then
			local direction = (targetPosition - RocketClone.Position).unit
			rocketPropulsion.TargetOffset = RocketClone.Position + (direction * TARGET_OVERSHOOT_DISTANCE)
			rocketPropulsion:Fire()
		end

		wait(0) --TODO: Remove when sounds realize they can be played as soon as they enter the Workspace

		-- Swoosh!
		local swooshSound = RocketClone:FindFirstChild('Swoosh')
		if swooshSound then
			swooshSound:Play()
		end

		-- Prepare the next rocket to be fired
		RocketClone = BaseRocket:Clone()

		ReloadSound:Play()

		wait(COOLDOWN)

		-- Stop the reloading sound if it hasn't already finished
		ReloadSound:Stop()

		Tool.Enabled = true
	end
end

local function OnUnequipped()
	ReloadSound:Stop() --TODO: This does not work online
end

-- Also activate when the Fire Button is down
local function OnChildAdded(child)
	if child.Name == 'FireButtonDown' then
		child.Changed:connect(function(newValue)
			if newValue == true then
				OnActivated(true)
			end
		end)
	end
end

--------------------
--| Script Logic |--
--------------------

Tool.Equipped:connect(OnEquipped)
Tool.Activated:connect(OnActivated)
Tool.Unequipped:connect(OnUnequipped)
Tool.ChildAdded:connect(OnChildAdded) --NOTE: Added for Fire Button
