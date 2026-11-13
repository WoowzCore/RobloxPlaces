local data = game:GetService("ServerScriptService").Data

local AllObjects = game.Workspace:GetDescendants()

local function LoadPhysicSoundToTool(tool)
	local handle = tool.Handle
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://8260212770"
	sound.Volume = 0.5
	sound.RollOffMode = Enum.RollOffMode.Linear
	sound.RollOffMaxDistance = 6
	sound.RollOffMinDistance = 0
	sound.Name = "PhysicSound"
	local clonescript = data.ToolPhysic:Clone()
	clonescript.Parent = handle
	sound.Parent = clonescript
	clonescript.Enabled = true
end

for i, child in pairs(AllObjects) do
	if child.Name == "Looting" then
		local clonescript = data.Looting:Clone()
		clonescript.Parent = child.Interact
		clonescript.Enabled = true
	end
end

for i, toolparts in pairs(AllObjects) do
	if toolparts:IsA("ProximityPrompt") and toolparts.Parent.Parent:IsA("Tool") then
		if toolparts.Parent.Parent:IsA("Tool") then
			LoadPhysicSoundToTool(toolparts.Parent.Parent)
			local clonescript = data.Interact:Clone()
			clonescript.Parent = toolparts
			clonescript.Enabled = true
		end
	end
end

for i, child in pairs(AllObjects) do
	if child.Name == "EntitySpawn" then
		local clonescript = data.EntitySpawn:Clone()
		clonescript.Parent = child
		clonescript.Enabled = true
	end
end

for i, child in pairs(AllObjects) do
	if child.Name == "ChanceDelete" then
		local clonescript = data.DeletePartChance:Clone()
		clonescript.Parent = child
		clonescript.Enabled = true
	end
end

local TCG = "Tools"
game:GetService("PhysicsService"):RegisterCollisionGroup(TCG)

for i, toolparts in pairs(game:GetService("ReplicatedStorage").Items:GetDescendants()) do
	if toolparts:IsA("ProximityPrompt") then
		LoadPhysicSoundToTool(toolparts.Parent.Parent)
		local clonescript = data.Interact:Clone()
		clonescript.Parent = toolparts
		clonescript.Enabled = true
	end

	if toolparts:IsA("MeshPart") or toolparts:IsA("Part") then
		toolparts.CollisionGroup = TCG
	end
end