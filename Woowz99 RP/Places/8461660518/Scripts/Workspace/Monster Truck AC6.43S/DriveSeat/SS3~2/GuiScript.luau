--// SS3 controls for AC6 by Itzt, originally for 2014 Infiniti QX80. i don't know how to tune ac lol
 
wait(0.1)
local player = game.Players.LocalPlayer
local HUB = script.Parent.HUB
local TR = script.Parent.Tracker
local limitButton = HUB.Name
local FE = game.Workspace.FilteringEnabled
local lightOn = false
local Camera = game.Workspace.CurrentCamera
local cam = script.Parent.nxtcam.Value
local carSeat = script.Parent.CarSeat.Value
local mouse = game.Players.LocalPlayer:GetMouse()
local windows = false
local handler = carSeat:WaitForChild('Filter')
local winfob = HUB.Parent.Music
local pal = false
local palpal = HUB.Parent.Palette
local red = 0
local green = 0
local blue = 1
local debounce = false

-------------------------
 
mouse.KeyDown:connect(function (key)
    key = string.lower(key)
		if key == "k" then --Camera controls
	        if cam == ("car") then
				Camera.CameraSubject = player.Character.Humanoid
				Camera.CameraType = ("Custom")
				cam = ("freeplr")
				Camera.FieldOfView = 70
			elseif cam == ("freeplr") then
				Camera.CameraSubject = player.Character.Humanoid
				Camera.CameraType = ("Attach")
				cam = ("lockplr")
				Camera.FieldOfView = 45
	        elseif cam == ("lockplr") then
				Camera.CameraSubject = carSeat
				Camera.CameraType = ("Custom")
				cam = ("car")
				Camera.FieldOfView = 70
	        end
	elseif key == "u" then --Window controls
		 if windows == false then 
			winfob.Visible = true
			windows = true
		 else windows = false
			winfob.Visible = false
		 end
		elseif key == "n" then --Dash Screen Switch
			if carSeat.Parent.Body.Dash.DashSc.G.Unit.Visible == false then
				handler:FireServer('DashSwitch', true)
				else
			end
			elseif key == "f" then --FM Screen Switch
			if carSeat.Parent.Body.Dash.Screen.G.Startup.Visible == false and carSeat.Parent.Body.Dash.Screen.G.Caution.Visible == false then
				handler:FireServer('FMSwitch', true)
				else
			end
		elseif key == "[" then -- volume down
			if carSeat.Parent.Body.MP.Sound.Volume >= 0 then
				handler:FireServer('volumedown', true)
			end
		elseif key == "]" then -- volume up
			if carSeat.Parent.Body.MP.Sound.Volume <= 10 then
				handler:FireServer('volumeup', true)
			end	
	end
end)

HUB.Limiter.MouseButton1Click:connect(function() --Ignition
 if carSeat.IsOn.Value == false then
	carSeat.IsOn.Value = true
	carSeat.Startup:Play()
	wait(1)
	carSeat.Chime:Play()
else
	carSeat.IsOn.Value = false
end
end)

TR.SN.MouseButton1Click:connect(function() --Show tracker names
	script.Parent.Names.Value = true
end)

TR.HN.MouseButton1Click:connect(function() --Hide tracker names
	script.Parent.Names.Value = false
end)

winfob.mg.Play.MouseButton1Click:connect(function() --Play the next song
	handler:FireServer('updateSong', winfob.mg.Input.Text)
end)

winfob.mg.Stop.MouseButton1Click:connect(function() --Play the next song
	handler:FireServer('pauseSong')
end)

carSeat.Indicator.Changed:connect(function()
	if carSeat.Indicator.Value == true then
		script.Parent.Indicator:Play()
	else
		script.Parent.Indicator2:Play()
	end
end)

game.Lighting.Changed:connect(function(prop)
	if prop == "TimeOfDay" then
	handler:FireServer('TimeUpdate')
	end
end)

if game.Workspace.FilteringEnabled == true then
	handler:FireServer('feON')
elseif game.Workspace.FilteringEnabled == false then
	handler:FireServer('feOFF')
end

carSeat.LI.Changed:connect(function()
	if carSeat.LI.Value == true then
		carSeat.Parent.Body.Dash.Spd.G.Indicator.Visible = true
		script.Parent.HUB.Left.Visible = true
	else
		carSeat.Parent.Body.Dash.Spd.G.Indicator.Visible = false
		script.Parent.HUB.Left.Visible = false
	end
end)

carSeat.RI.Changed:connect(function()
	if carSeat.RI.Value == true then
		carSeat.Parent.Body.Dash.Tac.G.Indicator.Visible = true
		script.Parent.HUB.Right.Visible = true
	else
		carSeat.Parent.Body.Dash.Tac.G.Indicator.Visible = false
		script.Parent.HUB.Right.Visible = false
	end
end)

for i,v in pairs(script.Parent:getChildren()) do
	if v:IsA('TextButton') then
		v.MouseButton1Click:connect(function()
			if carSeat.Windows:FindFirstChild(v.Name) then
				local v = carSeat.Windows:FindFirstChild(v.Name)
				if v.Value == true then
					handler:FireServer('updateWindows', v.Name, false)
				else
					handler:FireServer('updateWindows', v.Name, true)
				end
			end
		end)
	end
end


while wait() do
	if carSeat.Parent:FindFirstChild("Body") then
			carSeat.Parent.Body.Dash.DashSc.G.Modes.SpeedStats.Speed.Text = math.floor(carSeat.Velocity.magnitude*((10/12) * (60/88)))
	end
end