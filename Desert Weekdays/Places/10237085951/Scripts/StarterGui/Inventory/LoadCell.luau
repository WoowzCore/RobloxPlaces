local Inventory = script.Parent
local Values = Inventory.Parent.Values
local Cells = {}

for _, cell in pairs(Inventory:GetChildren()) do
	if cell:IsA("ImageButton") then
		table.insert(Cells,cell)
	end
end

function LoadCell(cell)
	local Object = Instance.new("ObjectValue")
	Object.Parent = cell
	Object.Name = "Object"
	local Script = Values.Data.Cell_script:Clone()
	Script.Parent = cell
	Script.Disabled = false
end

for _, cell in pairs(Cells) do
	LoadCell(cell)
end
