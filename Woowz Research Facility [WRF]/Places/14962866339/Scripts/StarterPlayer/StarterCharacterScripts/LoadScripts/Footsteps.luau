local base = require(script.Parent:WaitForChild("PlayerBase"))
local rs = game:GetService("ReplicatedStorage")

local FootStepsSounds = {
	[""]         = {"EMPTY"},
	["concrete"] = {"753586499","753586564","753586632"},
	["rock"]     = {"753586893","753586941","753586985"},
	["metal"]    = {"753587018","753587056","753587105"},
	["wood"]     = {"753587439","753587491","753587550"},
	["glass"]    = {"EMPTY"},
	["dirt"]     = {"753586698","753586769","753586834"},
	["grass"]    = {"EMPTY"},
	["sand"]     = {"EMPTY"},
	["snow"]     = {"EMPTY"},
	["plastic"]  = {"753587248","753587336","753587388"},
	["carpet"]   = {"753587145","753587178","753587209"},
	["grid"]     = {"EMPTY"},
}

local FootStepsMaterials = {
	[Enum.Material.Plastic]       = "plastic",
	[Enum.Material.SmoothPlastic] = "plastic",
	[Enum.Material.Neon]          = "glass",
	[Enum.Material.Wood]          = "wood",
	[Enum.Material.WoodPlanks]    = "wood",
	[Enum.Material.Marble]        = "concrete",
	[Enum.Material.Basalt]        = "rock",
	[Enum.Material.Slate]         = "rock",
	[Enum.Material.CrackedLava]   = "rock",
	[Enum.Material.Concrete]      = "concrete",
	[Enum.Material.Limestone]     = "rock",
	[Enum.Material.Granite]       = "concrete",
	[Enum.Material.Pavement]      = "concrete",
	[Enum.Material.Brick]         = "concrete",
	[Enum.Material.Pebble]        = "concrete",
	[Enum.Material.Cobblestone]   = "rock",
	[Enum.Material.Rock]          = "rock",
	[Enum.Material.Sandstone]     = "rock",
	[Enum.Material.CorrodedMetal] = "metal",
	[Enum.Material.DiamondPlate]  = "metal",
	[Enum.Material.Foil]          = "metal",
	[Enum.Material.Metal]         = "metal",
	[Enum.Material.Grass]         = "grass",
	[Enum.Material.LeafyGrass]    = "grass",
	[Enum.Material.Sand]          = "sand",
	[Enum.Material.Fabric]        = "carpet",
	[Enum.Material.Snow]          = "snow",
	[Enum.Material.Mud]           = "dirt",
	[Enum.Material.Ground]        = "dirt",
	[Enum.Material.Asphalt]       = "concrete",
	[Enum.Material.Salt]          = "sand",
	[Enum.Material.Ice]           = "glass",
	[Enum.Material.Glacier]       = "glass",
	[Enum.Material.Glass]         = "glass",
	[Enum.Material.ForceField]    = "",
	[Enum.Material.Air]           = "",
	[Enum.Material.Water]         = "",
	[Enum.Material.Cardboard]     = "carpet",
	[Enum.Material.Carpet]        = "carpet",
	[Enum.Material.CeramicTiles]  = "concrete",
	[Enum.Material.ClayRoofTiles] = "concrete",
	[Enum.Material.RoofShingles]  = "concrete",
	[Enum.Material.Leather]       = "plastic",
	[Enum.Material.Plaster]       = "concrete",
	[Enum.Material.Rubber]        = "plastic",
}

local function Footstep(speed)
	local RayParameters = RaycastParams.new()
	RayParameters.FilterType = Enum.RaycastFilterType.Exclude
	RayParameters.FilterDescendantsInstances = base.Character:GetDescendants()
	RayParameters.IgnoreWater = true
	local RayOrigin = base.Parts.Root.Position
	local RayDestination = base.Parts.Root.CFrame + (base.Parts.Root.CFrame.UpVector * -3.5)
	local RayDirection = RayDestination - RayOrigin
	local RaycastResult = workspace:Raycast(RayOrigin, RayDirection.Position, RayParameters)
	if RaycastResult then
		if RaycastResult.Instance then
			local hit = RaycastResult.Instance
			base.Floor = hit
			local sounds = FootStepsSounds[FootStepsMaterials[hit.Material]]
			if sounds[1] ~= "EMPTY" then
				rs.PlaySound:FireServer(sounds[math.random(1,#sounds)],base.Parts.Root.Position,speed*1.5,speed*15,math.min(speed+math.random()/10,1.75))
			end
		else
			base.Floor = nil
		end
	else
		base.Floor = nil
	end
end

local timer = 0
while wait() do
	if base.Humanoid and not (base.Died or base.Ragdoll or base.MovingData.Crawl) then
		local speed = (base.Humanoid.MoveDirection.Magnitude * base.Humanoid.WalkSpeed)/base.MovingData.WalkSpeed
		if speed > 0 then
			timer += 1
			if timer > (10/speed) then
				timer = 0
				Footstep(speed)
			end
		end
	end
end