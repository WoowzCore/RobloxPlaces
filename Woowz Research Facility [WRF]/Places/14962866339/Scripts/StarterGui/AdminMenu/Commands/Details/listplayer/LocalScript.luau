local selectbutton = script.Parent.TextButton
local plr = game:GetService("Players").LocalPlayer

local listobj = script.Parent.list
local scriptlist = nil

local list = {}
local first = false

local function GenerateList()
	for _, p in pairs(listobj:GetChildren()) do
		if p:IsA("TextButton") then
			p:Destroy()
		end
	end
	list = {}
	for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
		table.insert(list,plr.Name)
	end
	
	if script.Parent.Everyones.Value then
		table.insert(list,"EVERYONE")
		table.insert(list,"EVERYONENOTME")
	end
	
	for _, obj in pairs(list) do
		local button = Instance.new("TextButton",listobj)
		button.Text = obj
		button.Name = obj
		button.Size = UDim2.new(1,0,0,40)
		button.FontFace = Font.new("rbxasset://fonts/families/Jura.json",Enum.FontWeight.Bold)
		button.TextScaled = true
		button.TextColor3 = Color3.fromRGB(255,255,255)
		button.BackgroundColor3 = Color3.fromRGB(47,47,47)
		button.BorderSizePixel = 0
		button.MouseButton1Click:Connect(function()
			script.Parent.Value.Value = button.Text
			selectbutton.Text = script.Parent.Value.Value
			listobj.Visible = false
		end)
	end
	
	if not first then
		script.Parent.Value.Value = list[1]
		script.Parent.TextButton.Text = list[1]
	end
end
GenerateList()

selectbutton.MouseButton1Click:Connect(function()
	if script.Parent.Name ~= "PlayersList" then
		listobj.Parent = script.Parent.Parent.Parent.Parent
		listobj.Name = script.Parent.ValueID.Value.."_List"
		listobj.Position = UDim2.new(0,0,0,0)
		local t = selectbutton.AbsolutePosition-listobj.AbsolutePosition
		listobj.Position = UDim2.new(0,t.X,0,t.Y)
	end

	if scriptlist ~= nil then
		scriptlist:Destroy()
	end
	GenerateList()
	scriptlist = listobj.list:Clone()
	scriptlist.Parent = listobj
	scriptlist.Enabled = true
	listobj.Visible = true
end)