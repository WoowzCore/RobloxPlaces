local hbase = require(script.Parent:WaitForChild("HotbarBase"))
local rs = game:GetService("ReplicatedStorage")
local plr = game:GetService("Players").LocalPlayer
local t = require(plr.PlayerScripts:WaitForChild("Translation"))

hbase.AddSlot(1)
hbase.AddSlot(2)
hbase.AddSlot(3)
hbase.AddSlot(4)
hbase.AddSlot(5)
hbase.AddSlot(6)
hbase.AddSlot(7)
hbase.AddSlot(8)
hbase.AddSlot(9)
hbase.AddSlot(10)

local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local rarm = chr:WaitForChild("Right Arm")

local hasiteminarm = false
local itemsinbackpack = 0
local savedtool = nil

while wait() do
	local tooldescription = ""
	if chr:FindFirstChildWhichIsA("Tool") then
		if not hasiteminarm then
			hasiteminarm = true
			hbase.Upd()
		end
		if chr:FindFirstChildWhichIsA("Tool") ~= savedtool then
			hbase.Upd2()
			savedtool = chr:FindFirstChildWhichIsA("Tool")
		end
		if chr:FindFirstChildWhichIsA("Tool"):FindFirstChild("Description") then
			tooldescription = chr:FindFirstChildWhichIsA("Tool"):FindFirstChild("Description").Value
		end
	else
		if hasiteminarm then
			hasiteminarm = false
			savedtool = nil
			hbase.Upd()
		end
		
		if rarm:FindFirstChild("RightGrip") then
			rs.DropItem:FireServer(rarm:FindFirstChild("RightGrip"))
		end
	end
	
	if itemsinbackpack ~= #plr.Backpack:GetChildren() then
		itemsinbackpack = #plr.Backpack:GetChildren()
		hbase.Upd()
	end
	if tooldescription ~= "" then
		tooldescription = t.g(tooldescription)
	end
	script.Parent.ItemDescription.Text = tooldescription
end

