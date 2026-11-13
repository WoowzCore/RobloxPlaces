local entity = script.Parent
local hum = entity.Humanoid
local EBL = require(game:GetService("ServerScriptService"):WaitForChild("EBLibbary"))
EBL.NPCCollisions(entity)

local plrskin = 0
local nownpcskin = true

local stage = math.random(0,2)
--[[
0 - Pasive
1 - Food
2 - Agresive
]]

local necksave = entity.Torso.Neck.C0

local function ChangeHead()
	local head = entity.Head
	local childrens = {}
	for _,i in pairs(head:GetChildren()) do
		table.insert(childrens,i)
	end
	local newhead = Instance.new("Part")
	local mesh = Instance.new("SpecialMesh")
	mesh.Name = "Mesh"
	newhead.BrickColor = head.BrickColor
	newhead.CastShadow = head.CastShadow
	newhead.Color = head.Color
	newhead.Material = head.Material
	newhead.MaterialVariant = head.MaterialVariant
	newhead.Reflectance = head.Reflectance
	newhead.Transparency = head.Transparency
	newhead.Size = head.Size
	newhead.Position = head.Position
	newhead.Rotation = head.Rotation
	newhead.CFrame = head.CFrame
	newhead.Name = head.Name
	newhead.CanCollide = head.CanCollide
	newhead.CanTouch = head.CanTouch
	newhead.CollisionGroup = head.CollisionGroup
	newhead.Anchored = head.Anchored
	newhead.Parent = head.Parent
	for _, part in pairs(childrens) do
		part.Parent = newhead
	end
	local neck = entity.Torso.Neck
	local necksave = neck.C0
	local necksave2 = neck.C1
	neck.Part1 = newhead
	neck.C0 = necksave
	neck.C1 = necksave2
	mesh.Parent = newhead
	mesh.Scale = Vector3.one * 1.25
	mesh.MeshType = Enum.MeshType.Head
	head:Destroy()
end

local function ChangeSkin()
	if nownpcskin then
		ChangeHead()
	end
	nownpcskin = false
	entity.Humanoid:ApplyDescription(game.Players:GetHumanoidDescriptionFromUserId(plrskin))
	for i,part in pairs(entity:GetDescendants()) do
		if part:IsA("Part") then
			part.Material = Enum.Material.Wood
			part.MaterialVariant = "Humanoid"
		elseif part:IsA("Accessory") then
			part.Handle.Material = Enum.Material.Wood
			part.Handle.MaterialVariant = "Humanoid"
		elseif part:IsA("ParticleEmitter") then
			part:Destroy()
		end
	end
end

local function Touch(obj)
	if obj == nil then return end
	if obj.Parent:FindFirstChildOfClass("Humanoid") then
		local kill = EBL.DetectHurt(obj,math.random(1,10),"sharp")
		if kill then
			if game.Players:GetPlayerFromCharacter(obj.Parent) == nil then return end
			local plrid = game.Players:GetPlayerFromCharacter(obj.Parent).UserId
			if plrid ~= plrskin then
				plrskin = plrid
				ChangeSkin()
			end
		end
	end
end

local getnearplayerradius = math.random(10,70)
local colors = {
	{197, 170, 117},{196,150,66},{196,174,133},
	{196,140,111},{239,193,170},{175,106,72},
	{196,176,96},{196,188,155},{206,190,128},
	{206,195,179},{206,167,39},{206,161,113}
}

local randcolor = math.random(1,#colors)
for i,part in pairs(entity:GetDescendants()) do
	if part:IsA("Part") or part:IsA("MeshPart") then
		part.Color = Color3.fromRGB(colors[randcolor][1],colors[randcolor][2],colors[randcolor][3])
	end 
end

entity.HumanoidRootPart.Touched:Connect(Touch)

local speed = {
	[0] = 4,
	[1] = 8,
	[2] = 14
}

local function Updt()
	hum.WalkSpeed = speed[stage]
	
	if math.random(0,1000)>=999 then
		stage = math.random(0,2)
	end
	
end


local function Move()
	if entity.PrimaryPart == nil then return end
	local plr = EBL.GetNearPlayer(entity.PrimaryPart.Position,getnearplayerradius)
	if plr == nil or stage == 0 then
		if math.random(0,100)>=80 then
			EBL.MoveTo(entity,entity.PrimaryPart.Position + Vector3.new(math.random(-50,50),0,math.random(-50,50)))
		end
		return
	end
	--EBL.RotateNPCHead(entity,plr:WaitForChild("Head"),necksave)
	EBL.MoveTo(entity,plr.PrimaryPart.Position)
end

while wait() do
	Updt()
	Move()
end