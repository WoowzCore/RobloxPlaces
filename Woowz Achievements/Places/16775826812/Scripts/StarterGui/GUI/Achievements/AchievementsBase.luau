local gui = script.Parent
local vd = game:GetService("ReplicatedStorage").RS.GetVisualData:InvokeServer()

local function ButtonClick()
	gui.Background.Visible = not gui.Background.Visible
end
gui.Button.MouseButton1Click:Connect(ButtonClick)
gui.Background.Visible = false

local id = 0
for id_string, data in pairs(vd.Achievements) do
	id += 1
	local frame = gui.Data.Achievement:Clone()
	local newid = "Ach_"
	local nextnumber = math.floor(id/30)
	local numbercount = id-(nextnumber*30)
	local num = 0
	repeat
		newid = newid..tostring(nextnumber)
	until num < numbercount
	frame.Name = newid
	frame.Parent = gui.Background.List.ScrollingFrame
	frame.Background.ImageLabel.Image = data["Icon"]
	frame.Background.Text.LabelName.Text = data["Name"]
	frame.Background.Text.LabelDesc.Text = data["Desc"]
	frame.Visible = true
end