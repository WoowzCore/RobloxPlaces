drop = script.Parent.DropPoint1
machine = script.Parent

function insertId(gearId)
	local root = game:GetService("InsertService"):LoadAsset(gearId)

	game:GetService("InsertService"):Insert(root)

	local r = script.ToolClean:Clone()
	r.Disabled = false
	r.Parent = root

	root.Parent = machine.InsertedObjects
	root:MoveTo(drop.Position)
 end

y = machine.Buttons:GetChildren()
for z = 1, #y do
	local c = y[z]:GetChildren()
	for i = 1, #c do
		if c[i]:IsA("Part") and c[i]:findFirstChild("ClickDetector") ~= nil then
			local gearId = c[i]:findFirstChild("ItemID")
			c[i].ClickDetector.MouseClick:connect(function()
				if c[i].ClickDetector.Debounce.Value == false then
					local oldColor = c[i].BrickColor
					local oldRef = c[i].Reflectance
					c[i].ClickDetector.Debounce.Value = true
					c[i].Reflectance = 0.6
					c[i].BrickColor = BrickColor.new("Really black")
					insertId(gearId.Value)
					machine.Parent.ClickCount.Value = machine.Parent.ClickCount.Value + 1
					wait(3)
					c[i].ClickDetector.Debounce.Value = false
					c[i].Reflectance = oldRef
					c[i].BrickColor = oldColor
				end
			end)
		end
	end
	print("Gear category: " .. y[z].Name .. " connected")
end 