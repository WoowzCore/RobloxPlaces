local t = script.Parent
local rs = game:GetService("ReplicatedStorage")

local name = t.Parent.Name

local obj = nil

for _, part in pairs(game.Workspace:GetDescendants()) do
	if part.Name == name then
		if part:FindFirstChild("GuiID") then
			if part:FindFirstChild("GuiID").Value == script.Parent.Parent:FindFirstChild("gID").Value then
				obj = part
			end
		end
	end
end

t.FocusLost:Connect(function()
	local filter = true
	if script.Parent:FindFirstChild("NoFilter") then
		filter = false
	end
	rs.ChangeTextGuiUpdate:FireServer(t.Text,script.Parent.Parent:FindFirstChild("gID").Value,t.Name,obj,t.Name,filter)
end)

rs.ChangeTextGui.OnClientEvent:Connect(function(text,id,textid,obj2)
	if script.Parent.Parent:FindFirstChild("gID").Value ~= id then return end
	if t.Name ~= textid then return end
	if obj2.Name ~= obj.Name then return end
	t.Text = text
end)