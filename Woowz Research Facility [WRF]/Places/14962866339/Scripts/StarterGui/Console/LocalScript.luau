local console = script.Parent
local rs = game:GetService("ReplicatedStorage")
local log = game:GetService("LogService")

local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

local textframe = console.TextFrame

local list = console.Frame.ScrollingFrame

list.CanvasPosition = Vector2.new(0,100000)

local function PrintCreate(text,typ)
	console.Frame.prints.Text = base.t.g("otherui.messages")..((#list:GetChildren()-1) or 0)
	if text == nil then return end
	if typ == nil then return end
	local newtext = textframe:Clone()
	newtext.Parent = list
	local colors = {
		[Enum.MessageType.MessageOutput] = Color3.fromRGB(0,0,0),
		[Enum.MessageType.MessageInfo] = Color3.fromRGB(0, 68, 255),
		[Enum.MessageType.MessageWarning] = Color3.fromRGB(175, 117, 1),
		[Enum.MessageType.MessageError] = Color3.fromRGB(255,0,0)
	}
	newtext.TextLabel.TextColor3 = colors[typ]
	newtext.client.ImageColor3 = colors[typ]

	if string.split(text," ")[1] == "S-Admin:" or string.split(text," ")[1] == "C-Admin:" then
		if string.split(text," ")[1] == "C-Admin:" then
			newtext.client.Image = "rbxassetid://15422547543"
		end
		newtext.client.Visible = true
		newtext.TextLabel.Position = UDim2.new(0.04,0,0,0)
		
		local textsplit = string.split(text," ")
		text = ""
		for _, p in pairs(textsplit) do
			if _ ~= 1 then
				local space = " "
				if _ == 2 then
					space = ""
				end
				text = text .. space .. p
			end
		end
	end
	
	newtext.TextLabel.Text = text
	newtext.Visible = true
end

for _, l in pairs(rs.GiveLog:InvokeServer()) do
	if l == nil then return end
	PrintCreate(l["message"],l["messageType"])
end

local i = 0
rs.PrintResult.OnClientEvent:Connect(function(text,typ)
	i+=1
	if i > 2 then
		PrintCreate(text,typ)
	end
end)