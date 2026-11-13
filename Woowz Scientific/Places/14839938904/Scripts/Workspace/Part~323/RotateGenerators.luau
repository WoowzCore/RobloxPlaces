local ts = game:GetService("TweenService")

local basa = require(game.ServerScriptService.ServerBasa)

local PP = script.Parent.ProximityPrompt

local lampochka = script.Parent.lampochka

local key = script.Parent.key

local socket_animation = false
local socket_animation_out = true

local enablemonitor = script.Parent.enablemonitor.ClickDetector

local keyloaded = false

local rotateengine = workspace.rotationengine
local rotationgengine = false

local FULLLOADED = false
local select_moved = false

local savedenginerotation = 180

local buttonpressed = false

local s1,s2,s3,s4 = script.Parent.select_1,script.Parent.select_2,script.Parent.select_3,script.Parent.select_4

local rotatethise = script.Parent.rotatepanel.rotatethise
local select_ = script.Parent.rotatepanel.select

local selectedCore = 1
local instaletcore = 1

local savemonitor = 1
local monitorenabled = true

local colors = {[1] = Color3.fromRGB(255, 58, 58), [2] = Color3.fromRGB(39, 255, 24), [3] = Color3.fromRGB(70, 82, 255), [4] = Color3.fromRGB(246, 255, 75)}

local function ChangeScreen(numer)
	local screen = script.Parent.screen
	local screensign = screen.Sign
	local screenlight = script.Parent.screenlight.PointLight
	if numer == 0 then
		ts:Create(screen,TweenInfo.new(0.5),{Size = Vector3.new(0.005, 0.172, 0.172)}):Play()
		--ts:Create(screensign,TweenInfo.new(0.5),{Size = Vector3.new(1.424, 1.114, 0.222)}):Play()
		screensign.SurfaceGui.SIGN.TextTransparency = 1
		ts:Create(screenlight,TweenInfo.new(0.5),{Brightness = 0}):Play()
	else
		if not rotationgengine then
		ts:Create(screen,TweenInfo.new(0.5),{Size = Vector3.new(0.048, 1.616, 1.616)}):Play()
		screensign.SurfaceGui.SIGN.TextTransparency = 0
		--ts:Create(screensign,TweenInfo.new(0.5),{Size = Vector3.new(2.506, 1.96, 0.39)}):Play()
		ts:Create(screenlight,TweenInfo.new(0.5),{Brightness = 4.32}):Play()
		end
		savemonitor = numer
		screensign.Parent.Value.Value = colors[numer]
		screensign.SurfaceGui.SIGN.Text = numer
	end
end

local waitenablemonitor = false
enablemonitor.MouseClick:Connect(function()
	if waitenablemonitor then return end
	enablemonitor.Parent.Sound:Play()
	waitenablemonitor = true
	ts:Create(enablemonitor.Parent,TweenInfo.new(0.1),{CFrame = CFrame.new(155.922, -2237.357, -341.526) * CFrame.Angles(0,math.rad(-75),math.rad(-9.092))}):Play()
	wait(0.1)
	ts:Create(enablemonitor.Parent,TweenInfo.new(0.1),{CFrame = CFrame.new(155.944, -2237.371, -341.442) * CFrame.Angles(0,math.rad(-75),math.rad(-9.092))}):Play()
	monitorenabled = not monitorenabled
	if monitorenabled then
		ChangeScreen(savemonitor)
	else
		ChangeScreen(0)
	end
	waitenablemonitor = false
end)

local function ClickButton()
	if instaletcore == selectedCore then return end
	if not FULLLOADED then return end
	if select_moved then return end
	if buttonpressed then return end
	local x,y,z = rotateengine:GetPivot():ToOrientation()
	buttonpressed = true
	savedenginerotation = math.deg(y)
	ts:Create(script.Parent.rotatepanel.button,TweenInfo.new(0.25),{C1 = CFrame.new(0.1,0,0) * CFrame.Angles(0,0,math.rad(90))}):Play()
	script.Parent.button.Sound:Play()
	wait(0.25)
	ChangeScreen(0)
	script.Parent.bottom.light.Color = Color3.fromRGB(182, 165, 137)
	script.Parent.bottom.light.PointLight.Color = Color3.fromRGB(255, 245, 187)
	script.Parent.bottom.light.SpotLight.Color = Color3.fromRGB(255, 255, 255)
	script.Parent.front.light.Color = Color3.fromRGB(182, 165, 137)
	script.Parent.front.light.PointLight.Color = Color3.fromRGB(255, 245, 187)
	script.Parent.front.light.SpotLight.Color = Color3.fromRGB(255, 255, 255)
	script.Parent.left.light.Color = Color3.fromRGB(182, 165, 137)
	script.Parent.left.light.PointLight.Color = Color3.fromRGB(255, 245, 187)
	script.Parent.left.light.SpotLight.Color = Color3.fromRGB(255, 255, 255)
	script.Parent.right.light.Color = Color3.fromRGB(182, 165, 137)
	script.Parent.right.light.PointLight.Color = Color3.fromRGB(255, 245, 187)
	script.Parent.right.light.SpotLight.Color = Color3.fromRGB(255, 255, 255)
	ts:Create(script.Parent.rotatepanel.button,TweenInfo.new(0.25),{C1 = CFrame.new(0.25,0,0) * CFrame.Angles(0,0,math.rad(90))}):Play()
	wait(1)
	script.Parent.socketlight.Material = Enum.Material.Neon
	script.Parent.socketlight.SurfaceLight.Enabled = true
	script.Parent.socket.light.Material = Enum.Material.Glass
	script.Parent.socket.light.PointLight.Enabled = false
	ts:Create(script.Parent.socket.basa,TweenInfo.new(4),{CFrame = CFrame.new(164.035, -2295.184, -322.102)}):Play()
	wait(4)
	script.Parent.socketlight.Material = Enum.Material.Glass
	script.Parent.socketlight.SurfaceLight.Enabled = false
	rotationgengine = true
	
end

local function selectcore(core)
	if not FULLLOADED then return end
	if selectedCore == core then return end
	if select_moved then return end
	if rotationgengine then return end
	
	select_moved = true
	selectedCore = core
	local select_pos = {0.8,0.2,-0.35,-0.85}
	ts:Create(select_,TweenInfo.new(0.5,Enum.EasingStyle.Linear),{C1 = CFrame.new(0,0,select_pos[core])}):Play()
	wait(0.5)
	select_moved = false
end

script.Parent.button.ClickDetector.MouseClick:Connect(function()
	ClickButton()
end)

s1.ClickDetector.MouseClick:Connect(function()
	selectcore(1)
end)
s2.ClickDetector.MouseClick:Connect(function()
	selectcore(2)
end)
s3.ClickDetector.MouseClick:Connect(function()
	selectcore(3)
end)
s4.ClickDetector.MouseClick:Connect(function()
	selectcore(4)
end)

local function LoadKey()
	key.Transparency = 0
	key.CastShadow = true
	ts:Create(key,TweenInfo.new(0.5),{CFrame = CFrame.new(151.611, -2237.718, -338.215) * CFrame.Angles(math.rad(9.092),math.rad(15),0)}):Play()
	wait(0.5)
	key.Sound:Play()
	ts:Create(key,TweenInfo.new(0.5),{CFrame = CFrame.new(151.611, -2237.718, -338.215) * CFrame.Angles(0,math.rad(105),math.rad(9.092))}):Play()
	wait(0.5)
	PP.ActionText = "Get Key"
	PP.Enabled = false
	lampochka.Material = Enum.Material.Neon
	lampochka.Color = Color3.fromRGB(0, 255, 51)
	lampochka.PointLight.Enabled = true
	FULLLOADED = true
	ts:Create(script.Parent.rotatepanel,TweenInfo.new(5,Enum.EasingStyle.Quint),{CFrame = script.Parent.rotatepanel.CFrame * CFrame.Angles(math.rad(179.99),0,0)}):Play()
	wait(2)
	script.Parent.r.Transparency = 0
	script.Parent.r.text.SurfaceGui.sign.TextTransparency = 0.04
	script.Parent.g.Transparency = 0
	script.Parent.g.text.SurfaceGui.sign.TextTransparency = 0.04
	script.Parent.b.Transparency = 0
	script.Parent.b.text.SurfaceGui.sign.TextTransparency = 0.04
	script.Parent.y.Transparency = 0
	script.Parent.y.text.SurfaceGui.sign.TextTransparency = 0.04
	wait(1)
	script.Parent.g.text.SurfaceGui.sign.Text = "error"
	script.Parent.b.text.SurfaceGui.sign.Text = "nuclear8"
	script.Parent.y.text.SurfaceGui.sign.Text = "error"
	ts:Create(rotatethise,TweenInfo.new(3),{C1 = rotatethise.C1 * CFrame.Angles(math.rad(120),0,0)}):Play()
	wait(3)
	PP.Enabled = true
end

local function UnLoadKey()
	FULLLOADED = false
	key.Sound:Play()
	ts:Create(key,TweenInfo.new(0.5),{CFrame = CFrame.new(151.611, -2237.718, -338.215) * CFrame.Angles(math.rad(9.092),math.rad(15),0)}):Play()
	wait(0.5)
	ts:Create(key,TweenInfo.new(0.5),{CFrame = CFrame.new(151.623, -2237.418, -338.169) * CFrame.Angles(math.rad(9.092),math.rad(15),0)}):Play()
	wait(0.5)
	key.Transparency = 1
	key.CastShadow = false
	PP.ActionText = "Insert Key"
	PP.Enabled = false
	lampochka.Material = Enum.Material.Glass
	lampochka.Color = Color3.fromRGB(0, 84, 17)
	lampochka.PointLight.Enabled = false
	script.Parent.r.Transparency = 1
	script.Parent.r.text.SurfaceGui.sign.TextTransparency = 1
	script.Parent.g.Transparency = 1
	script.Parent.g.text.SurfaceGui.sign.TextTransparency = 1
	script.Parent.b.Transparency = 1
	script.Parent.b.text.SurfaceGui.sign.TextTransparency = 1
	script.Parent.y.Transparency = 1
	script.Parent.y.text.SurfaceGui.sign.TextTransparency = 1
	script.Parent.g.text.SurfaceGui.sign.Text = "waiting"
	script.Parent.b.text.SurfaceGui.sign.Text = "waiting"
	script.Parent.y.text.SurfaceGui.sign.Text = "waiting"
	ts:Create(rotatethise,TweenInfo.new(3),{C1 = rotatethise.C1 * CFrame.Angles(math.rad(-120),0,0)}):Play()
	wait(2)
	ts:Create(script.Parent.rotatepanel,TweenInfo.new(5,Enum.EasingStyle.Quint),{CFrame = script.Parent.rotatepanel.CFrame * CFrame.Angles(math.rad(-179.99),0,0)}):Play()
	wait(5)
	PP.Enabled = true
end

PP.Triggered:Connect(function(plr)
	keyloaded = not keyloaded
	if keyloaded then
		LoadKey()
	else
		UnLoadKey()
	end
end)

function lerp(a,b,t) return a * (1-t) + b * t end

local i = 0
local imax = 100
while wait() do
	local lr = Enum.Material.Glass
	local lr2 = Color3.fromRGB(42, 12, 12)
	local ly = Enum.Material.Glass
	local ly2 = Color3.fromRGB(45, 48, 7)
	local lg = Enum.Material.Glass
	local lg2 = Color3.fromRGB(11, 47, 10)
	if math.sin(i)>= 0.5 then lr = Enum.Material.Neon lr2 = Color3.fromRGB(153, 44, 44) end
	if FULLLOADED then ly = Enum.Material.Neon ly2 = Color3.fromRGB(140, 153, 22) end
	if selectedCore == instaletcore then lg = Enum.Material.Neon lg2 = Color3.fromRGB(37, 153, 31) end
	if script.Parent.lightred.Material ~= lr or script.Parent.lightyellow.Material ~= ly or script.Parent.lightgreen.Material ~= lg then
		script.Parent.lightred.Sound:Play()
	end
	script.Parent.lightred.Material = lr
	script.Parent.lightred.Color = lr2
	script.Parent.lightyellow.Material = ly
	script.Parent.lightyellow.Color = ly2
	script.Parent.lightgreen.Material = lg
	script.Parent.lightgreen.Color = lg2
	
	if rotationgengine then
		i += 0.01 + (-(2*(i/imax)-1)^2+1)/4
		local rotations = {180,-90,0,90}
		local r = math.rad(lerp(savedenginerotation,rotations[selectedCore],i/imax))
		script.Parent.rot.CFrame = CFrame.new(178.698, -2398.045, -432.062) * CFrame.Angles(0, math.rad(360*(i/imax)*20), math.rad(-90))
		basa.AddShakeData("rotateengines",Vector3.new(163.441, -2397.627, -452.763),100*(-(2*(i/imax)-1)^2+1),150)
		rotateengine:PivotTo(CFrame.new(rotateengine:GetPivot().Position.X,rotateengine:GetPivot().Position.Y,rotateengine:GetPivot().Position.Z) * CFrame.Angles(0,r,math.rad(90)))
		if i > imax then
			i = 0
			basa.RemoveShakeData("rotateengines")
			rotationgengine = false
			instaletcore = selectedCore
			buttonpressed = false
			ChangeScreen(instaletcore)
			local function fun(lamp)
				local typ = lamp.Name
				local instcor = instaletcore
				
				if typ == "right" then
					if instaletcore == 1 then
						instcor = 4
					elseif instaletcore == 2 then
						instcor = 1
					elseif instaletcore == 3 then
						instcor = 2
					else
						instcor = 3
					end
				elseif typ == "bottom" then
					if instaletcore == 1 then
						instcor = 3
					elseif instaletcore == 2 then
						instcor = 4
					elseif instaletcore == 3 then
						instcor = 1
					else
						instcor = 2
					end
				elseif typ == "left" then
					if instaletcore == 1 then
						instcor = 2
					elseif instaletcore == 2 then
						instcor = 3
					elseif instaletcore == 3 then
						instcor = 4
					else
						instcor = 1
					end
				end
				lamp.light.Color = colors[instcor]
				lamp.light.PointLight.Color = colors[instcor]
				lamp.light.SpotLight.Color = colors[instcor]
			end
			fun(script.Parent.front)
			fun(script.Parent.right)
			fun(script.Parent.bottom)
			fun(script.Parent.left)
			script.Parent.socketlight.Material = Enum.Material.Neon
			script.Parent.socketlight.SurfaceLight.Enabled = true
			ts:Create(script.Parent.socket.basa,TweenInfo.new(4),{CFrame = CFrame.new(164.035, -2295.184, -347.177)}):Play()
			wait(4)
			script.Parent.socketlight.Material = Enum.Material.Glass
			script.Parent.socketlight.SurfaceLight.Enabled = false
			script.Parent.socket.light.Material = Enum.Material.Neon
			script.Parent.socket.light.PointLight.Enabled = true
		end
	end
end