local basa = require(game:GetService("ServerScriptService").Base)

local ActivateOther = script.Parent.ActivateOther

local keypressed = {}

local waiting = false

local p = 0
local password = "WELCOME"

local timer = 0

local function UpdateTextLabel(str)
	if str == nil then str = password end
	script.Parent.screen.screen.TextLabel.Text = str
end

local function KeyAnimation(key,keypres,cframe)
	script.Parent.screen.Button.PlaybackSpeed = math.random(95,105)/100
	script.Parent.screen.Button:Play()
	basa.ts(key,TweenInfo.new(0.125),{CFrame = keypres.CFrame})
	wait(0.125)
	basa.ts(key,TweenInfo.new(0.125),{CFrame = cframe})
	wait(0.125)
end

local i = 1
while i < 10  do
	local key = script.Parent["passwordkey"..i]
	local keypressedpart = script.Parent["passwordkey"..i.."_pressed"]
	local keycframe = key.CFrame
	local i_number = i
	key.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
		if waiting then return end
		if keypressed[key.Name] then return end
		if password == "WELCOME" or p==0 then password = "" end
		keypressed[key.Name] = true
		KeyAnimation(key,keypressedpart,keycframe)
		keypressed[key.Name] = false
		if p >= 8 then return end
		password = password ..i_number 
		p += 1
		UpdateTextLabel()
		timer = 0
	end)
	
	i += 1	
end

local keyentercframe = script.Parent.passwordkeyenter.CFrame
script.Parent.passwordkeyenter.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
	if waiting then return end
	if keypressed[script.Parent.passwordkeyenter.Name] then return end
	keypressed[script.Parent.passwordkeyenter.Name] = true
	waiting = true
	KeyAnimation(script.Parent.passwordkeyenter,script.Parent.passwordkeyenter_pressed,keyentercframe)
	local t = 7
	local id = "1554378033"
	if tostring(script.Parent.PasswordCode.Value) == password then
		ActivateOther.Value = true
		UpdateTextLabel("ACCEPTED")
	else
		ActivateOther.Value = false
		t = 1
		id = "5855421995"
		if password == "WELCOME" then
			UpdateTextLabel("NOPASSWORD")
		else
			UpdateTextLabel("ABOVE")
		end
	end
	script.Parent.screen.Sound.SoundId = "rbxassetid://"..id
	script.Parent.screen.Sound:Play()
	wait(t)
	ActivateOther.Value = false
	password = "WELCOME"
	p = 0
	UpdateTextLabel()
	waiting = false
	keypressed[script.Parent.passwordkeyenter.Name] = false
end)
local keydeletecframe = script.Parent.passwordkeyclear.CFrame
local function clear()
	if waiting then return end
	password = "WELCOME"
	p = 0
	UpdateTextLabel()
	keypressed[script.Parent.passwordkeyclear.Name] = false
end
script.Parent.passwordkeyclear.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
	if waiting then return end
	if keypressed[script.Parent.passwordkeyclear.Name] then return end
	keypressed[script.Parent.passwordkeyclear.Name] = true
	KeyAnimation(script.Parent.passwordkeyclear,script.Parent.passwordkeyclear_pressed,keydeletecframe)
	clear()
end)

while wait() do
	timer += 1
	if p>0 and timer > 200 then
		timer = 0
		clear()
	end
end