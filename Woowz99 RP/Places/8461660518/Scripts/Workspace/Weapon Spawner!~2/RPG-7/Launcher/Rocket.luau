-----------------
--| Constants |--
-----------------

local BLAST_RADIUS = 6
local BLAST_PRESSURE = 750000

-- Rocket will fly through things named these
local ROCKET_IGNORE_LIST = {rocket = 1, handle = 1, effect = 1, water = 1} --NOTE: Keys must be lowercase, values must evaluate to true

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

local Rocket = script.Parent
local CreatorTag = WaitForChild(Rocket, 'creator')

local Connection = nil

-----------------
--| Functions |--
-----------------

-- Returns the ancestor that contains a Humanoid, if it exists
local function FindCharacterAncestor(subject)
	if subject and subject ~= Workspace then
		local humanoid = subject:FindFirstChild('Humanoid')
		if humanoid then
			return subject, humanoid
		else
			return FindCharacterAncestor(subject.Parent)
		end
	end
	return nil
end

local function OnExplosionHit(hitPart)
	if hitPart then
		local _, humanoid = FindCharacterAncestor(hitPart.Parent)
		if humanoid and humanoid.Health > 0 then
			local hitBindable = humanoid:FindFirstChild('Hit')
			if hitBindable then
				hitBindable:Invoke(0, CreatorTag)
			else
				print("Could not find BindableFunction 'Hit'")
			end
		end
	end
end

local function OnTouched(otherPart)
	if Rocket and otherPart then
		-- Fly through anything in the ignore list
		if ROCKET_IGNORE_LIST[string.lower(otherPart.Name)] then
			return
		end

		-- Fly through the creator
		local myPlayer = CreatorTag.Value
		if myPlayer and myPlayer.Character and myPlayer.Character:IsAncestorOf(otherPart) then
			return
		end

		-- Create the explosion
		local explosion = Instance.new('Explosion')
		explosion.BlastPressure = BLAST_PRESSURE
		explosion.BlastRadius = BLAST_RADIUS
		explosion.Position = Rocket.Position
		explosion.Hit:connect(OnExplosionHit)
		explosion.Parent = Workspace

		-- Start playing the boom sound
		local boomSound = Rocket:FindFirstChild('Boom')
		if boomSound then
			boomSound:Play()
		end

		-- NOTE:
		-- If we just destroyed the rocket at this point, the boom sound would be destroyed too,
		-- so instead we will hide the rocket, keep it in the same spot, and schedule it for deletion

		-- Stop playing the swoosh sound
		local swooshSound = Rocket:FindFirstChild('Swoosh')
		if swooshSound then
			swooshSound:Stop()
		end

		-- Put out the fire
		local fire = Rocket:FindFirstChild('Fire')
		if fire then
			fire:Destroy()
		end

		Rocket.Transparency = 1
		Rocket.CanCollide = false
		Rocket.Anchored = true
		DebrisService:AddItem(Rocket, 3)

		-- Destroy the connection so this method won't be called again
		Connection:disconnect()
	end
end

--------------------
--| Script Logic |--
--------------------

-- Arm the rocket and save the touch connection so we can disconnect it later
Connection = Rocket.Touched:connect(OnTouched)
