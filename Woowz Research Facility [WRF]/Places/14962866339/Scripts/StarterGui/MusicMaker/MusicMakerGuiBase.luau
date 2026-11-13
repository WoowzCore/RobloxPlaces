local gui = script.Parent
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))
local scr = require(chr:WaitForChild("PlayerScript"))
local rs = game:GetService("ReplicatedStorage")

local musictool = nil
local data = {}

local ws = gui.background

local connections = {}
local connections2 = {}
local acceptschars = "_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ*/+-0123456789!>#$<^&:,\\"
local numbers = "0123456789"

local function esc(x)
	return (x:gsub('%%', '%%%%')
		:gsub('^%^', '%%^')
		:gsub('%$$', '%%$')
		:gsub('%(', '%%(')
		:gsub('%)', '%%)')
		:gsub('%.', '%%.')
		:gsub('%[', '%%[')
		:gsub('%]', '%%]')
		:gsub('%*', '%%*')
		:gsub('%+', '%%+')
		:gsub('%-', '%%-')
		:gsub('%?', '%%?'))
end

function lerp(a,b,t) return a * (1-t) + b * t end

local function PlayNote(id)
	if gui.help.Visible then return end
	local sounds = {
		[0] = {"584691395",Vector2.new(0.7,1.3)},
		[1] = {"4582790360",Vector2.new(0.7,1.3)},
		[2] = {"7714439701",Vector2.new(0.7,1.3)},
		[3] = {"3727724569",Vector2.new(0.7,1.3)},
		[4] = {"9120472743",Vector2.new(0.7,1.3)},
		[5] = {"3466988045",Vector2.new(0.7,1.3)},
		[6] = {"6568398699",Vector2.new(0.4,1)},
		[7] = {"9113891284",Vector2.new(1,1.5)},
		[8] = {"8864905994",Vector2.new(0.7,1.3)},
		[9] = {"1836360908",Vector2.new(0.9,1.2)}
	}
	local sound = sounds[data["note"] or 0]
	rs.PlaySound:FireServer(sound[1],musictool.Handle.Position,1,25,lerp(sound[2].X,sound[2].Y,id/10))
	if id == 10 then
		id = "90"
	end
	scr.ts(ws.Piano:FindFirstChild("Piano"..id),TweenInfo.new(0.05,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0),{ImageTransparency = 0.4})
	wait(0.05)
	scr.ts(ws.Piano:FindFirstChild("Piano"..id),TweenInfo.new(0.05,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0),{ImageTransparency = 1})
end

game:GetService("UserInputService").InputBegan:Connect(function(key,chat)
	if not chat and musictool then
		local keys = {
			[Enum.KeyCode.One] = 1,
			[Enum.KeyCode.Two] = 2,
			[Enum.KeyCode.Three] = 3,
			[Enum.KeyCode.Four] = 4,
			[Enum.KeyCode.Five] = 5,
			[Enum.KeyCode.Six] = 6,
			[Enum.KeyCode.Seven] = 7,
			[Enum.KeyCode.Eight] = 8,
			[Enum.KeyCode.Nine] = 9,
			[Enum.KeyCode.Zero] = 10
		}
		if keys[key.KeyCode] then
			PlayNote(keys[key.KeyCode])
		end
	end
end)

local function GeneratePiano()
	local function GenerateP(id)
		local nota = ws.Source.PianoN:Clone()
		nota.ZIndex = 11-id
		nota.Parent = ws.Piano
		nota.Visible = true
		nota.MouseButton1Click:Connect(function()
			PlayNote(id)
		end)
		if id == 10 then
			id = "90"
		end
		nota.Name = "Piano"..id
	end
	GenerateP(1)
	GenerateP(2)
	GenerateP(3)
	GenerateP(4)
	GenerateP(5)
	GenerateP(6)
	GenerateP(7)
	GenerateP(8)
	GenerateP(9)
	GenerateP(10)
end
GeneratePiano()

local function DestroyLine(line,id_)
	if data["play"] then return end
	table.remove(data["lines"],id_)
	table.remove(data["linesdata"],id_)
	connections[id_]:Disconnect()
	table.remove(connections,id_)
	connections2[id_]:Disconnect()
	table.remove(connections2,id_)
	line:Destroy()
	for i, line_ in pairs(data["lines"]) do
		line_.Name = "Line"..i
		line_.ID.Text = i
		connections[i]:Disconnect()
		connections[i] = line_.RemoveButton.MouseButton1Click:Connect(function()
			if gui.help.Visible then return end
			DestroyLine(line_,i)
		end)
		connections2[i]:Disconnect()
		connections2[i] = line_.InputText:GetPropertyChangedSignal("Text"):Connect(function()
			local s = ""
			for _, c in pairs(string.split(line_.InputText.Text,"")) do
				if string.find(acceptschars,esc(c)) then
					s = s..c
				end
			end
			line_.InputText.Text = s
			if utf8.len(line_.InputText.Text) > 147 then
				line_.InputText.Text = string.sub(line_.InputText.Text,1,147)
			end
			data["linesdata"][i] = line_.InputText.Text
			line_.position.symbol_position.Text = "0/"..utf8.len(line_.InputText.Text)
		end)
	end
end

local function CreateLine(d)
	if data["lines"] == nil then data["lines"] = {} end
	if data["linesdata"] == nil then data["linesdata"] = {} end
	if #data["lines"] < 10 then
		local line = ws.Source.LineN:Clone()
		line.Parent = ws.ScrollingFrame
		table.insert(data["lines"],line)
		local id = #data["lines"]
		line.Name = "Line"..id
		line.ID.Text = id
		data["linesdata"][id] = ""
		connections[id] = line.RemoveButton.MouseButton1Click:Connect(function()
			if gui.help.Visible then return end
			DestroyLine(line,id)
		end)
		connections2[id] = line.InputText:GetPropertyChangedSignal("Text"):Connect(function()
			local s = ""
			for _, c in pairs(string.split(line.InputText.Text,"")) do
				if string.find(acceptschars,esc(c)) then
					s = s..c
				end
			end
			line.InputText.Text = s
			if utf8.len(line.InputText.Text) > 147 then
				line.InputText.Text = string.sub(line.InputText.Text,1,147)
			end
			data["linesdata"][id] = line.InputText.Text
			line.position.symbol_position.Text = "0/"..utf8.len(line.InputText.Text)
		end)
		line.Visible = true
		if d ~= nil then
			line.InputText.Text = d
		end
	end
end

ws.create.MouseButton1Click:Connect(function()
	if gui.help.Visible then return end
	if data["play"] then return end
	CreateLine()
end)

local function SetPlay(bool,inv)
	if bool == nil then bool = false end
	if data["play"] == nil then
		data["play"] = false
	else
		if inv then
			data["play"] = not data["play"]
			bool = data["play"]
		else
			data["play"] = bool
		end
	end
	if bool then
		ws.play.BackgroundColor3 = Color3.fromRGB(238, 21, 21)
		ws.play.Text = base.t.g("musicmaker.stop")
		if data["lines"] then
			for id, line in pairs(data["lines"]) do
				line.InputText.TextEditable = false
			end
		end
	else
		ws.play.BackgroundColor3 = Color3.fromRGB(68, 255, 0)
		ws.play.Text = base.t.g("musicmaker.start")
		if data["lines"] then
			for id, line in pairs(data["lines"]) do
				line.InputText.TextEditable = true
				line.position.symbol_position.Text = "0/"..utf8.len(line.InputText.Text)
				line.position.symbol.Text = "?"
			end
		end
	end
	ws.Speed.TextEditable = not bool
	ws.MusicID.TextEditable = not bool
	ws.MusicSpeed.TextEditable = not bool
	ws.MusicVolume.TextEditable = not bool
	ws.TimeEnd.TextEditable = not bool
	ws.SelectKey.TextEditable = not bool
end

ws.play.MouseButton1Click:Connect(function()
	if gui.help.Visible then return end
	SetPlay(nil,true)
end)

ws.Speed:GetPropertyChangedSignal("Text"):Connect(function()
	local t = ws.Speed.Text
	local s = ""
	for _, c in pairs(string.split(t,"")) do
		if string.find(numbers,esc(c)) then
			s = s..c
		end
	end
	t = s
	if utf8.len(t) > 3 then
		t = string.sub(t,1,3)
	end
	ws.Speed.Text = t
	if t == "" then
		t = "0"
	end
	data["speed"] = tonumber(t)
end)

ws.TimeEnd:GetPropertyChangedSignal("Text"):Connect(function()
	local t = ws.TimeEnd.Text
	local s = ""
	for _, c in pairs(string.split(t,"")) do
		if string.find(numbers,esc(c)) then
			s = s..c
		end
	end
	t = s
	if utf8.len(t) > 4 then
		t = string.sub(t,1,4)
	end
	ws.TimeEnd.Text = t
	if t == "" then
		t = "0"
	end
	data["timeend"] = tonumber(t)
end)

ws.MusicID:GetPropertyChangedSignal("Text"):Connect(function()
	local t = ws.MusicID.Text
	local s = ""
	for _, c in pairs(string.split(t,"")) do
		if string.find(numbers,esc(c)) then
			s = s..c
		end
	end
	t = s
	ws.MusicID.Text = t
	data["musicid"] = tonumber(t)
end)

ws.MusicSpeed:GetPropertyChangedSignal("Text"):Connect(function()
	local t = ws.MusicSpeed.Text
	local s = ""
	for _, c in pairs(string.split(t,"")) do
		if string.find(numbers,esc(c)) then
			s = s..c
		end
	end
	t = s
	if utf8.len(t) > 3 then
		t = string.sub(t,1,3)
	end
	ws.MusicSpeed.Text = t
	if t == "" then
		t = "100"
	end
	data["mspeed"] = tonumber(t)
end)

ws.MusicVolume:GetPropertyChangedSignal("Text"):Connect(function()
	local t = ws.MusicVolume.Text
	local s = ""
	for _, c in pairs(string.split(t,"")) do
		if string.find(numbers,esc(c)) then
			s = s..c
		end
	end
	t = s
	if utf8.len(t) > 3 then
		t = string.sub(t,1,3)
	end
	ws.MusicVolume.Text = t
	if t == "" then
		t = "100"
	end
	data["volume"] = tonumber(t)
end)

ws.SelectKey:GetPropertyChangedSignal("Text"):Connect(function()
	local t = ws.SelectKey.Text
	local s = ""
	for _, c in pairs(string.split(t,"")) do
		if string.find(numbers,esc(c)) then
			s = s..c
		end
	end
	t = s
	if utf8.len(t) > 1 then
		t = string.sub(t,1,1)
	end
	ws.SelectKey.Text = t
	if t == "" then
		t = "0"
	end
	data["note"] = tonumber(t)
end)

gui.helpbutton.MouseButton1Click:Connect(function()
	if not (data["play"] or false) then
		gui.help.Visible = not gui.help.Visible
		for _, textbox in pairs(ws:GetDescendants()) do
			if textbox:IsA("TextBox") then
				textbox.TextEditable = not gui.help.Visible
			end
		end
	end
end)

local function upd()
	gui.background.BackgroundColor3 = data["toolcolor"]
	
	ws.ScrollingFrame.ThatEmpty.Visible = (#ws.ScrollingFrame:GetChildren()<=2)
	ws.count.Text = (#ws.ScrollingFrame:GetChildren()-2)
	
	if data["play"] then
		local sp = musictool.GetSoundsPositions:InvokeServer()
		if data["lines"] then
			if #data["lines"]>0 then
				for id,pos in pairs(sp[1]) do
					local line = data["lines"][id]
					local p = pos
					if p == 0 then
						p = utf8.len(data["linesdata"][id])
					end
					if data["play"] then
						if p == -1 or p == 0 then
							line.position.symbol_position.Text = "0/"..utf8.len(line.InputText.Text)
							line.position.symbol.Text = "?"
						else
							line.position.symbol_position.Text = p.."/"..utf8.len(line.InputText.Text)
							line.position.symbol.Text = string.sub(line.InputText.Text,p,p)
						end
					end
				end
			end
		end
		ws.timer.Text = sp[2]
	end
end

local function setawake()
	if data["lines"] ~= nil then
		local connections = {}
		local connections2 = {}
		for id, linedat in pairs(ws.ScrollingFrame:GetChildren()) do
			if linedat:IsA("Frame") and linedat.Name ~= "ThatEmpty" then
				linedat:Destroy()
			end
		end
	end
end

local stopmusicconnection = nil
local function set()
	ws.Speed.Text = data["speed"] or "50"
	if data["linesdata"] ~= nil then
		for id, linedat in pairs(data["linesdata"]) do
			CreateLine(linedat)
		end
	end
	SetPlay(data["play"])
	ws.TimeEnd.Text = data["timeend"] or "0"
	ws.MusicID.Text = data["musicid"] or ""
	ws.MusicVolume.Text = data["volume"] or "100"
	ws.MusicSpeed.Text = data["mspeed"] or "100"
	ws.SelectKey.Text = data["note"] or "0"
	if stopmusicconnection ~= nil then
		stopmusicconnection:Disconnect()
	end
	stopmusicconnection = musictool.StopMusic.OnClientEvent:Connect(function()
		SetPlay(false)
	end)
end

while wait() do
	if gui.Enabled and base.Tool then
		if base.Tool.Name == "MusicMaker" then
			if musictool ~= base.Tool then
				musictool = base.Tool
				setawake()
				data = musictool.GetData:InvokeServer()
				set()
				gui.help.Visible = false
			end
			upd()
			musictool.SetData:FireServer(data)
		else
			musictool = nil
		end
	else
		musictool = nil
	end
end