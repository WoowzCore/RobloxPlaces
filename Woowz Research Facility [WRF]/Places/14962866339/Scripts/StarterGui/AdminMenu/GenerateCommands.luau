local commandstemplate = script.Parent.Commands
local rs = game:GetService("ReplicatedStorage")
local serplrs = game:GetService("Players")
local plr = serplrs.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

local selectplayer = nil

local commandwait = false

local valuestypes = {
	["checkbox"] = commandstemplate.Details.checkbox,
	["list"] = commandstemplate.Details.list,
	["listplayer"] = commandstemplate.Details.listplayer,
	["input"] = commandstemplate.Details.input,
	["vector3"] = commandstemplate.Details.vector3,
	["color"] = commandstemplate.Details.color
}

local list = script.Parent.Panel.Values.UIList

local commands = {}
local function CreateCommand(id,sortid)
	if sortid == nil then sortid = 10000000 end
	local data = rs.GetCommand:InvokeServer(id)
	local title = base.t.g(data["Title"])

	local command = commandstemplate.BlankCommand:Clone()
	command.Name = title
	local commandid = Instance.new("StringValue",command)
	commandid.Value = id
	commandid.Name = "CommandID"
	command.Parent = list
	command.LayoutOrder = sortid
	
	command.Title.TextLabel.Text = title
	local hasplayer_icon = data["Settings"]["hasplayer"]
	local mainadmin_icon = data["Settings"]["mainadmin"]

	if hasplayer_icon then
		command.Title.img3.Image = "rbxassetid://15315832291"
		command.Title.img3.Visible = true
	end
	if mainadmin_icon then
		command.Title.img3.Image = "rbxassetid://15287387872"
		command.Title.img3.Visible = true
	end
	if hasplayer_icon and mainadmin_icon then
		command.Title.img3.Visible = false
		command.Title.img1.Visible = true
		command.Title.img2.Visible = true
	end
	
	local valueid = 1
	local addy = 0
	local uilistlayoutoffset = command.UIListLayout.Padding.Offset * (1+(#data["Values"]/10))
	for _, valuedata in pairs(data["Values"]) do
		local value = valuestypes[valuedata[2]]:Clone()
		local valueid_ = valuedata[1]
		local valueidobj = Instance.new("StringValue")
		valueidobj.Value = valueid_
		valueidobj.Name = "ValueID"
		valueidobj.Parent = value
		value.Name = "value"..valueid
		value.ZIndex = valueid
		valueid += 1
		value.Parent = command
		
		value.Title.Text = base.t.g(valuedata[3])
		if valuedata[4] ~= nil then
			value.Value.Value = valuedata[4]
		end
		
		value.LocalScript.Enabled = true
		value.Visible = true
		addy += value.Size.Height.Offset + uilistlayoutoffset
	end
	
	local confirm = commandstemplate.Details.finish:Clone()
	confirm.Parent = command
	confirm.Visible = true
	confirm.TextButton.Text = base.t.g("admin.confirm")
	if mainadmin_icon then
		confirm.EnabledButton.Value = base.MainAdmin
	end
	confirm.TextButton.MouseButton1Click:Connect(function()
		
		if commandwait == false then
			commandwait = true
			print("C-Admin: Команда ["..command.CommandID.Value.."] Активирована!")
			local commanddata = rs.GetCommand:InvokeServer(command.CommandID.Value)
			local result = {}
			for _, values in pairs(command:GetDescendants()) do
				if values:IsA("ValueBase") and values.Name == "Value" then
					result[values.Parent.ValueID.Value] = values.Value
				end
			end
			
			local error_ = false
			local commandresult = ""
			local selectedplr = {}
			if commanddata["Settings"]["noeveryone"] then
				if selectplayer.Value.Value == "EVERYONE" or selectplayer.Value.Value == "EVERYONENOTME" then
					commandresult = "Эта команда не принимает EVERYONE!"
					error_ = true
				else
					selectedplr = {serplrs:FindFirstChild(selectplayer.Value.Value)}
				end
			else
				if selectplayer.Value.Value == "EVERYONE" then
					selectedplr = serplrs:GetPlayers()
				elseif selectplayer.Value.Value == "EVERYONENOTME" then
					for _, p in pairs(serplrs:GetPlayers()) do
						if p.UserId ~= serplrs.LocalPlayer.UserId then
							table.insert(selectedplr,p)
						end
					end
				else
					selectedplr = {serplrs:FindFirstChild(selectplayer.Value.Value)}
				end
			end
			
			if not error_ then
			--[[==================[Локальные команды]======================]]
				local idc = command.CommandID.Value
				if idc == "freecamera" then
					base.Data.Camera.FreeCamera = not base.Data.Camera.FreeCamera 
					commandresult = "Свободная камера включена!"
					if base.Data.Camera.FreeCamera  == false then
						commandresult = "Свободная камера выключена!"
					end
				else
					commandresult = rs.PlayCommand:InvokeServer(selectedplr,idc,result)
				end
			--[[===========================================================]]
			end
			
			if commandresult ~= nil then
				list.Parent.Parent.Console.Text = commandresult
			else
				list.Parent.Parent.Console.Text = "..."
			end
			
			wait(0.01)
			commandwait = false
		else
			list.Parent.Parent.Console.Text = "Не так быстро!"
		end
			
		end)
	addy += confirm.Size.Height.Offset + uilistlayoutoffset
	
	command.Size = command.Size + UDim2.new(0,0,0,addy + uilistlayoutoffset) 
	command.Visible = true
	
	table.insert(commands,{command,sortid})
end

local function Update()
	if list.Parent.Parent:FindFirstChild("PlayersList") then
		list.Parent.Parent:FindFirstChild("PlayersList"):Destroy()
	end
	local randomphrases = {
		"","Привет!","Start loading...","$$$",">/...","...","Hello world!","2+2=4","2+2=5","Попробуйте так-же Blood Eye","Woowz был тут!","Его сотворило кое что большее","Как ты открыл это?!","Панель 3000","Не общайтесь с Dexon","27%","Павел","В процессе...","Бесконечен!","Проблема с навыком","Ура больше возможностей!","Абсолютно полезно","[ДАННЫЕ_УДАЛЕНЫ]","Наконец-то обновление!","Тебе звонят, ответь",":skeleton_skull:","WRF Day!","NightTheChosen?"
	}
	list.Parent.Parent.Console.Text = randomphrases[math.random(1,#randomphrases)]
	local plrselect = valuestypes["listplayer"]:Clone()
	plrselect.Name = "PlayersList"
	plrselect.Everyones.Value = true
	selectplayer = plrselect
	plrselect.Parent = list.Parent.Parent
	plrselect.Size = UDim2.new(0.95,0,0,60)
	plrselect.Position = UDim2.new(0.025,0,0.16,0)
	plrselect.Title.Text = base.t.g("admin.selectplayer")
	plrselect.LocalScript.Enabled = true
	plrselect.Visible = true
	
	for _, command in pairs(list:GetChildren()) do
		if command:IsA("Frame") then
			command:Destroy()
		end
	end
	
	for _, lists in pairs(list.Parent:GetChildren()) do
		if lists:IsA("Frame") then
			lists:Destroy()
		end
	end
	
	commands = {}
	
	CreateCommand("kill",-1000)
	CreateCommand("teleport",-999)
	CreateCommand("giveitem",-900)
	CreateCommand("hurt",-850)
	CreateCommand("setplayerdata",-849)
	CreateCommand("dummy",-848)
	CreateCommand("destroycorpses",-847)
	CreateCommand("getposition",-800)
	CreateCommand("prefab",-799)
	CreateCommand("createobject",-798)
	CreateCommand("destroyprefabs",-797)
	CreateCommand("destroydecals",-796)
	CreateCommand("playsound",-600)
	CreateCommand("stopsounds",-599)
	CreateCommand("explode",-399)
	CreateCommand("createparticle",-100)
	CreateCommand("setliquid",-50)
	CreateCommand("turnlight",-2)
	CreateCommand("shakelab",-1)
	CreateCommand("siren",0)
	CreateCommand("emergency",1)
	CreateCommand("shakecamera",20)
	CreateCommand("stopshake",21)
	CreateCommand("freecamera",800)
	CreateCommand("randsceneskin",900)
	CreateCommand("op",1000)
	CreateCommand("kick",1001)
	CreateCommand("restart")
end

local active = false
local died = false
while wait() do
	if script.Parent.Enabled ~= active then
		active = script.Parent.Enabled
		if active then
			Update()
		end
	end
	if base.Died ~= died then
		died = base.Died
		if died then
			base.GuiActives.Admin = false
		end
	end
end