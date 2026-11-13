local hbase = {}

local rs = game:GetService("ReplicatedStorage")
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hotbar = script.Parent.HotbarBaseFrame
local base = require(chr:WaitForChild("PlayerBase"))

hbase.slots = {
	["1"] = nil,
	["2"] = nil,
	["3"] = nil,
	["4"] = nil,
	["5"] = nil,
	["6"] = nil,
	["7"] = nil,
	["8"] = nil,
	["9"] = nil,
	["10"] = nil
}

function hbase.AddSlot(i)
	local slot = script.Parent.Source.Slot:Clone()
	slot.Parent = hotbar
	slot.Base.ToolName.Text = ""
	hbase.slots[tostring(i)] = slot
	
	if i == 10 then i = 0 end
	slot.Base.I.Text = tostring(i)
	slot.Visible = true
end

hbase.items = {
	["1"] = nil,
	["2"] = nil,
	["3"] = nil,
	["4"] = nil,
	["5"] = nil,
	["6"] = nil,
	["7"] = nil,
	["8"] = nil,
	["9"] = nil,
	["10"] = nil
}

hbase.connections = {
	["1"] = nil,
	["2"] = nil,
	["3"] = nil,
	["4"] = nil,
	["5"] = nil,
	["6"] = nil,
	["7"] = nil,
	["8"] = nil,
	["9"] = nil,
	["10"] = nil
}

hbase.itemspos = {}

function hbase.GetItem(i)
	rs.ItemToArm:FireServer(hbase.items[tostring(i)])
end

function hbase.UpdateSlot(slot,i)
	local item = hbase.items[i]
	if item ~= nil then
		local inarm = false
		if item.Parent:FindFirstChildWhichIsA("Humanoid") then
			inarm = true
		end
		local name = item.Name
		if item:FindFirstChild("ToolName") then
			name = base.t.g(item:FindFirstChild("ToolName").Value)
		end
		slot.Base.ToolName.Text = name
		if hbase.connections[i] ~= nil then
			hbase.connections[i]:Disconnect()
		end
		local c = slot.Base.Button.MouseButton1Click:Connect(function()
			hbase.GetItem(i)
		end)
		hbase.connections[i] = c
		slot.Base.Button.Stroke.Enabled = inarm
		if item:FindFirstChild("Icon") then
			slot.Base.Button.Image = "rbxassetid://"..item:FindFirstChild("Icon").Value
		else
			slot.Base.Button.Image = "rbxassetid://16392607717"
		end
		slot.Base.Button.Visible = true
	else
		slot.Base.ToolName.Text = ""
		slot.Base.Button.Visible = false
	end
end

function hbase.Upd()
	hbase.items = {}
	for i, item in pairs(plr.Backpack:GetChildren()) do
		hbase.items[tostring(item:WaitForChild("InventoryIDPosition").Value)] = item
	end
	local itemarm = chr:FindFirstChildWhichIsA("Tool")
	if itemarm then
		hbase.items[tostring(itemarm:WaitForChild("InventoryIDPosition").Value)] = itemarm
	end
	hbase.Upd2()
end

function hbase.Upd2()
	for i, slot in pairs(hbase.slots) do
		hbase.UpdateSlot(slot,i)
	end
end

return hbase
