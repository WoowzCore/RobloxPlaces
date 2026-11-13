local base = require(game:GetService("ServerScriptService").Base)
local gui = script.Parent.Screen.PCscreen
local data = game:GetService("ServerScriptService").ServerInfo.Data
local broken_joskidisk = (math.random(0,100)>=98)

local needpassword = (math.random(0,100)>=20)
local user_icons = {"16644078400","16644083272","16644085479","16644087740","16644089788"}
local user_names = {"root","User","ALEX","Copp","Рекапча","Arduino","kENTYKi","Карп","Калуга","kiril","rekalcha","Самара","LUKAFAN","Алхимик","Моргенпикчес","Вилли","password57128","Снауер","Снайпер","KYS","Dak","blip","Badgerlovk","deffy","Fari","Aurey","Darthzz","32141","skibididopdopyesyes","nekit","pavel","atrem","dima","red","Сновидение","WSRS","EBR","V1RUS","WVIRUS","BloodEye","BloodRaw","sandbox","alo","Isaac","find_replace_select","erthyief","veryhrkud","ynhs5yw4"}
local user_backg = {{"16643394061",Color3.fromRGB(39,106,164)},{"16643410395",Color3.fromRGB(80,135,88)},{"16643490669",Color3.fromRGB(121,59,137)},{"16643494786",Color3.fromRGB(145,205,193)},{"16643500783",Color3.fromRGB(37,51,87)}}

local user = {}

local background = nil

local function GetUser()
	local name = "Админ"
	local icon = "16643995717"
	if math.random(0,100)>20 then
		if math.random(0,100)>50 then
			local n = base.Names[math.random(1,#base.Names)]
			name = n
			if math.random(0,100)>40 then
					local n1 = base.Surnames[math.random(1,#base.Surnames)]
					local sym = " "
					if math.random(0,100)>50 then
						sym = "_"
					end
					name = n1..sym..name
			end
		else
			name = user_names[math.random(1,#user_names)]
			local randend = {"0","1","2","3","4","5","6","7","8","9","10","20","2005","1999","1445","1448","1007","_","ツ"}
			if math.random(0,100)>40 then
				name = name..randend[math.random(1,#randend)]
			end
		end
		if math.random(0,100)>20 then
			icon = user_icons[math.random(1,#user_icons)]
		end
	end
	return {name,icon}
end

if needpassword then
	local userdata = GetUser()
	user = {userdata[1],userdata[2],user_backg[math.random(1,#user_backg)]}
else
	local backgrounds = {"16644373034","16644386439","16644389067","16644391229"}
	background = backgrounds[math.random(1,#backgrounds)]
end

local settextconsole_ = 0
local consoletextpositions = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T"}
local function SetTextConsole(text)
	settextconsole_ += 1
	local c = gui.Console
	if settextconsole_ > 20 then
		settextconsole_ = 20
		for i,char in pairs(consoletextpositions) do
			if i ~= 20 then
				c["Line"..char].Text = c["Line"..consoletextpositions[i+1]].Text
			end
		end
	end
	c["Line"..consoletextpositions[settextconsole_]].Text = text
end
local function ClearConsole()
	settextconsole_ = 0
	for _, part in pairs(gui.Console:GetChildren()) do
		if part:IsA("TextLabel") then
			part.Text = ""
		end
	end
end
local function s(text)
	SetTextConsole(text)
end
local function w(t)
	t = t + (math.random()*(t/2))
	wait(t)
end

local function disable()
	gui.Background.BackgroundTransparency = 1
	ClearConsole()
	gui.Loading.Visible = false
	gui.LoadingScreen.Visible = false
	gui.Password.Visible = false
	gui.BackgroundPassword.Visible = false
	script.Parent.Screen.SurfaceLight.Enabled = false
	gui.UserName.Visible = false
	gui.Icon.Visible = false
	gui.WorkTable.Visible = false
end


local function enable()
	script.Parent.Screen.brokemonitor:Play()
	base.ts(gui.Background,TweenInfo.new(1),{BackgroundTransparency = 0})
	w(1)
	s("\"Copprum\"(C)2025 Сделано Luka")
	w(0.1)
	s("Данные считаны Дата: "..data.Day.Value.."/"..data.Month.Value.."/"..string.sub(tostring(data.Year.Value),3,4).." Ver PROplus-784-18G")
	s("CPU : LCPU 1024bit Ksenon Processor 5670")
	w(0.5)
	s("   Скорость : 6.00 GHz")
	w(1)
	local i = 0
	local popitok = math.random(5,35)
	while i < popitok do
		i+=1
		w(0.1)
		s("Проверка ПО... ("..(math.floor((i+math.random())*10)/10).."T)")
	end
	if math.random(0,100)>50 then
		w(2)
	end
	if broken_joskidisk then
		local disk = "C"
		if math.random(0,100)>50 then
			disk = "D"
		end
		script.Parent.Screen.brokemonitor:Play()
		s("Замечено повреждение жёского диска: "..disk)
		wait(0.5)
		s("Просим вас обратиться за ремонтом техники")
		w(0.1)
		s("Пожалуйста выключите компьютер")
		s("Не тратьте энергию!")
	else
		s("Проверка закончена, Добро пожаловать!")
		wait(1)
		ClearConsole()
		gui.LoadingScreen.Visible = true
		w(2)
		gui.Loading.Visible = true
		local rand = math.random(1,10)
		wait(rand)
		script.Parent.Screen.open:Play()
		gui.Loading.Visible = false
		gui.LoadingScreen.Visible = false
		if needpassword then
			gui.BackgroundPassword.Image = "rbxassetid://"..user[3][1]
			gui.Icon.Image = "rbxassetid://"..user[2]
			script.Parent.Screen.SurfaceLight.Color = user[3][2]
			gui.UserName.Text = user[1]
			gui.UserName.Visible = true
			gui.BackgroundPassword.Visible = true
			script.Parent.Screen.SurfaceLight.Enabled = true
			gui.Password.Visible = true
			gui.Icon.Visible = true
		else
			gui.WorkTable.Image = "rbxassetid://"..background
			gui.WorkTable.Visible = true
		end
	end
end

local t_e,t_d = nil,nil

script.Parent.EnableFromPC.Event:Connect(function(enabled)
	script.Parent.Active.Value = enabled
	if enabled then
		t_e = task.spawn(enable)
		if t_d then task.cancel(t_d) end
	else
		t_d = task.spawn(disable)
		if t_e then task.cancel(t_e) end
	end
	gui.Enabled = enabled
end)

disable()

local rot = 0
while wait() do
	if gui.Loading.Visible then
		rot+=10
		if rot > 180 then
			rot = 0
		end
		gui.Loading.Rotation = rot
		gui.Loading.UIGradient.Rotation = 45 - rot
	end
end