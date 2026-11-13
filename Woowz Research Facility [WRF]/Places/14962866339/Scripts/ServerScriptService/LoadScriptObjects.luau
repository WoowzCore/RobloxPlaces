local physicalobjects = {}

for _, part in pairs(game.Workspace:GetDescendants()) do
	if part:IsA("BasePart") then
		if part.Anchored == false then
			part.Anchored = true
			table.insert(physicalobjects,part)
		end
	end
	
	if part:IsA("PackageLink") then
		local obj = part.Parent
		for _, scr in pairs(obj:GetChildren()) do
			if scr:IsA("Script") then
				scr.Enabled = true
			end
		end
	end
end

local function LoadScriptObjects()

local base = require(script.Parent.Base)
local ss = game:GetService("ServerStorage")
local sss = game:GetService("ServerScriptService")
local lab = require(script.Parent.Lab)
base.Start()
local l = game:GetService("Lighting")
l.DepthOfField.Enabled = true

local GuiIds = {}

local objects = {}
local packages = {}

local function Start()
	base.Switch("CODE_RED",false)
end
Start()

for _, obj in pairs(game:GetService("ServerStorage").SCRIPTOBJECTS:GetChildren()) do
	objects[obj.Name] = obj
end
	
for _, obj in pairs(game:GetService("ServerStorage").PACKAGES:GetChildren()) do
	packages[obj.Name] = obj
end

local function SpawnObject(transform,objname,createdobjects)
	local thatpackage = (packages[objname]~=nil)
	
	if not thatpackage then
		if objects[objname]==nil then print("Не найден префаб (или пакет) ["..objname.."]!") return end
		local obj = objects[objname]:Clone()
	
		if typeof(transform) == "Vector3" or typeof(transform) == "CFrame" then
			local transformpart = Instance.new("Part")
			local model = Instance.new("Model")
			if typeof(transform) == "Vector3" then
				transformpart.CFrame = CFrame.new(transform)
			else
				transformpart.CFrame = transform
			end
			transformpart.Anchored = true
			transformpart.Transparency = 1
			transformpart.CanCollide = false
			transformpart.Parent = model
			model.PrimaryPart = transformpart
			model.Parent = game.Workspace
			transform = model
		end
	
		local objparent = transform.Parent
		if createdobjects then
			objparent = game.Workspace.CreatedObjects
		
			if obj.Name == "GasStove" then
				obj:FindFirstChild("explosiondecal"):Destroy()
			end
		
		end
	
		if obj.Name == "HolidayDecorations" then
			local hollidayobjects = {
				["Halloween"] = {},
				["Christmas"] = {"Present1","Present2","Present3","Present4","Present5","Present6","Present7","Present8","christmas tree"},
				["Easter"] = {},
				["Cosmonautics"] = {},
				["WRFDay"] = {}
			}
		
			local hollidaylist = hollidayobjects[sss.ServerInfo.Data.Holiday.Value]
		
			local dont = false
			if hollidaylist == nil then
				dont = true
			else
				if #hollidaylist == 0 then
					dont = true
				end
			end
			if dont then
				for _, p in pairs(obj:GetChildren()) do
					if p.Name ~= "center" then
						p:Destroy()
					end
				end
			else
				local savethisobject = hollidaylist[math.random(1,#hollidaylist)]
				for _, p in pairs(obj:GetChildren()) do
					if p.Name ~= savethisobject and p.Name ~= "center" then
						p:Destroy()
					end
				end
			end
	
		end
	
		obj.Parent = objparent
		if obj:IsA("Model") then
			obj:SetPrimaryPartCFrame(transform:GetPrimaryPartCFrame())
		end
		if obj:IsA("Part") or obj:IsA("UnionOperation") or obj:IsA("MeshPart") then
			obj.CFrame = transform:GetPrimaryPartCFrame()
		end
	
		for _, values in pairs(obj:GetChildren()) do
			if values:IsA("ValueBase") then
				for _2, values2 in pairs(transform:GetChildren()) do
					if values.Name == values2.Name then values.Value = values2.Value end
				end		
				if values.Name == "GuiID" then
					if GuiIds[objname] == nil then
						GuiIds[objname] = 0
					end
					values.Value = GuiIds[objname]
					GuiIds[objname] = GuiIds[objname] + 1
				end
			end
		end
		transform:Destroy()
	
		for _, s in pairs(obj:GetDescendants()) do
			if s:IsA("Script") or s:IsA("LocalScript") or s:IsA("ModuleScript") then
				s.Enabled = true
			end
		end
	else
		local obj = packages[objname]:Clone()
		if createdobjects then
				obj.Parent = game.Workspace.CreatedObjects
		else
				obj.Parent = game.Workspace
		end
		if typeof(transform) == "Vector3" or typeof(transform) == "CFrame" then
			if typeof(transform) == "Vector3" then
				transform = CFrame.new(transform)
			end
			
			if obj:IsA("Model") then
				obj:SetPrimaryPartCFrame(transform)
			else
				obj.CFrame = transform
			end
		end
		for _, scr in pairs(obj:GetChildren()) do
			if scr:IsA("Script") then
				scr.Enabled = true
			end
		end
	end
	
end

game:GetService("ReplicatedStorage").SpawnPrefab.Event:Connect(SpawnObject)

for _, transforms in pairs(game.Workspace:GetDescendants()) do
	if transforms.Name == "SCRIPTOBJECT" then
		SpawnObject(transforms,transforms.OBJ.Value)
	end
end

local function MapRandomisations()
	for _, obj in pairs(game.Workspace:GetDescendants()) do
		if obj:IsA("Part") then
			if obj.Name == "CEILING_TILE" then
				if math.random(0,100) >= 90 and obj.MaterialVariant == "Ceiling" then
					obj:Destroy()
				end
			end
		end
	end
end
MapRandomisations()

for _, part in pairs(physicalobjects) do
	part.Anchored = false
end

end

script.Parent.CompileScriptableObjects.Event:Connect(LoadScriptObjects)