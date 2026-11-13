local iteminfo = script.Parent.Item

local PickItems = script.Parent.Pickable
local WorldItems = script.Parent.World

for _,items in pairs(PickItems:GetChildren()) do
	local newiteminfo = iteminfo:Clone()
	newiteminfo.Parent = items
	newiteminfo.Disabled = false
end