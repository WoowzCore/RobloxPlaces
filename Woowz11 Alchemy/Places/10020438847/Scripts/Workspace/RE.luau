local AddElement_RE = game:GetService("ReplicatedStorage"):WaitForChild("AddElement")
local ResetAllElements_RE = game:GetService("ReplicatedStorage"):WaitForChild("ResetElements")

local function CreatePlayerId(player,id)
	local ids = player:WaitForChild("Saved_Elements")

	local new_id = Instance.new("StringValue",ids)
	new_id.Name = id
	new_id.Value = id
end

local function ResetAllElements(player)
	local ids = player:WaitForChild("Saved_Elements")
	
	local new_ids = Instance.new("Folder",player)
	ids:Remove()
	new_ids.Name = "Saved_Elements"
end

AddElement_RE.OnServerEvent:Connect(CreatePlayerId)

ResetAllElements_RE.OnServerEvent:Connect(ResetAllElements)