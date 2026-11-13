local Tool = script.Parent
local AllParts = {}

local ForScripts = workspace.ForScripts
local ScriptNew = ForScripts.GetTool
local TouchDet = ForScripts.GetToolDetect

local Created = Tool:FindFirstChild("Created")

function CreateValues()
	local Getted_Value = Instance.new("BoolValue")
	Getted_Value.Name = "Getted"
	Getted_Value.Parent = Tool
	local Created_Value = Instance.new("BoolValue")
	Created_Value.Name = "Created"
	Created_Value.Parent = Tool
	local Inv_ID_Value = Instance.new("StringValue")
	Inv_ID_Value.Name = "Inventory_ID"
	Inv_ID_Value.Parent = Tool
end
if Created == nil then
	CreateValues()
	Created = Tool.Created
end
	
local Getted = Tool.Getted.Value
	
function DetectPart(part)
	if part:IsA("Part") and part.Name ~= "Handle" then
		table.insert(AllParts,part)
		if Getted == false then
			TouchDet:Clone().Parent = part
			local ScriptNew_new = ScriptNew:Clone()
			ScriptNew_new.Parent = part
			ScriptNew_new.Disabled = false
		end
	end
end

if Created.Value == false then
	for _, part in pairs(Tool:GetChildren()) do
		DetectPart(part)
	end
end

Created.Value = true