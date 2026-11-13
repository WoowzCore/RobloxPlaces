local carSeat = script.Parent.Parent
local F = {}

--F.updateSound = function(Sound, Pitch, Volume)
--	if Sound then
--		if Pitch then
--			Sound.Pitch = Pitch
--		end
--		if Volume then
--			Sound.Volume = Volume
--		end
--	end
--end

F.updateWindows = function(Window, Toggle)
	if script.Parent.Parent.Windows:findFirstChild(Window) then
		script.Parent.Parent.Windows:findFirstChild(Window).Value = Toggle
	end	
end

F.BreakON = function(JB)
	carSeat.Parent.Body.JB.A.Disabled = false
	carSeat.Parent.Body.JB.B.Disabled = false
	carSeat.Parent.Body.JB2.A.Disabled = false
	carSeat.Parent.Body.JB2.B.Disabled = false
				carSeat.Parent.Body.Dash.DashSc.G.Modes.SpeedStats.Unit.Text = "Damage: ON"
			carSeat.Parent.Body.Dash.DashSc.G.Modes.Info.Unit.Text = "Damage: ON"
						wait(4)
			carSeat.Parent.Body.Dash.DashSc.G.Modes.SpeedStats.Unit.Text = "MPH"
			carSeat.Parent.Body.Dash.DashSc.G.Modes.Info.Unit.Text = "No Information"
end

F.BreakOFF = function(JB)
	carSeat.Parent.Body.JB2.A.Disabled = true
	carSeat.Parent.Body.JB.A.Disabled = true
	carSeat.Parent.Body.JB2.B.Disabled = true
	carSeat.Parent.Body.JB.B.Disabled = true
				carSeat.Parent.Body.Dash.DashSc.G.Modes.SpeedStats.Unit.Text = "Damage: OFF"
			carSeat.Parent.Body.Dash.DashSc.G.Modes.Info.Unit.Text = "Damage: OFF"
						wait(4)
						carSeat.Parent.Body.Dash.DashSc.G.Modes.SpeedStats.Unit.Text = "MPH"
						carSeat.Parent.Body.Dash.DashSc.G.Modes.Info.Unit.Text = "No Information"
end
F.DashSwitch = function(Dash)
 if carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.Speed.Value == true then 
			carSeat.Parent.Body.Dash.DashSc.G.Select:TweenPosition(UDim2.new(0, 0, 0, 20), "Out", "Quint", 1, true)
			carSeat.Parent.Body.Dash.DashSc.G.Modes.Info.Visible = false
			carSeat.Parent.Body.Dash.DashSc.G.Modes.MPG:TweenPosition(UDim2.new(0, -100, 0, 0), "Out", "Quint", 1, true)
			carSeat.Parent.Body.Dash.DashSc.G.Modes.SpeedStats.Visible = true
			carSeat.Parent.Body.Dash.DashSc.G.Modes.SpeedStats:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quint", 1, true)
			carSeat.Parent.Body.Dash.DashSc.G.Modes.Stats.Visible = false
			carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.Speed.Value = false
			carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.Info.Value = true
			carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.Version.Value = false
			carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.MPG.Value = false
elseif  carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.Info.Value == true then
	carSeat.Parent.Body.Dash.DashSc.G.Select:TweenPosition(UDim2.new(0, 25, 0, 20), "Out", "Quint", 1, true)
	carSeat.Parent.Body.Dash.DashSc.G.Modes.Info.Position = UDim2.new(0, 100, 0, 0)
		carSeat.Parent.Body.Dash.DashSc.G.Modes.Info.Visible = true
		carSeat.Parent.Body.Dash.DashSc.G.Modes.SpeedStats:TweenPosition(UDim2.new(0, -100, 0, 0), "Out", "Quint", 1, true)
			carSeat.Parent.Body.Dash.DashSc.G.Modes.Info:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quint", 1, true)
		carSeat.Parent.Body.Dash.DashSc.G.Modes.Stats.Visible = false
		carSeat.Parent.Body.Dash.DashSc.G.Modes.MPG.Visible = false
			carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.Speed.Value = false
			carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.Info.Value = false
			carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.Version.Value = true
			carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.MPG.Value = false
elseif  carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.Version.Value == true then
	carSeat.Parent.Body.Dash.DashSc.G.Select:TweenPosition(UDim2.new(0, 50, 0, 20), "Out", "Quint", 1, true)
		carSeat.Parent.Body.Dash.DashSc.G.Modes.Info:TweenPosition(UDim2.new(0, -100, 0, 0), "Out", "Quint", 1, true)
		carSeat.Parent.Body.Dash.DashSc.G.Modes.Stats.Position = UDim2.new(0, 100, 0, 0)
		carSeat.Parent.Body.Dash.DashSc.G.Modes.Stats.Visible = true
		carSeat.Parent.Body.Dash.DashSc.G.Modes.Stats:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quint", 1, true)
		carSeat.Parent.Body.Dash.DashSc.G.Modes.SpeedStats.Visible = false
		carSeat.Parent.Body.Dash.DashSc.G.Modes.MPG.Visible = false
		carSeat.Parent.Body.Dash.DashSc.G.Modes.Stats.Visible = true
		carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.Speed.Value = false
			carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.Info.Value = false
			carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.Version.Value = false
			carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.MPG.Value = true
elseif  carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.MPG.Value == true then
		carSeat.Parent.Body.Dash.DashSc.G.Modes.Info.Visible = false
		carSeat.Parent.Body.Dash.DashSc.G.Modes.SpeedStats.Visible = false
			carSeat.Parent.Body.Dash.DashSc.G.Modes.Stats:TweenPosition(UDim2.new(0, -100, 0, 0), "Out", "Quint", 1, true)
		carSeat.Parent.Body.Dash.DashSc.G.Modes.MPG.Position = UDim2.new(0, 100, 0, 0)
		carSeat.Parent.Body.Dash.DashSc.G.Modes.MPG.Visible = true
		carSeat.Parent.Body.Dash.DashSc.G.Modes.MPG:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quint", 1, true)
			carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.Speed.Value = true
			carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.Info.Value = false
			carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.Version.Value = false
			carSeat.Parent.DriveSeat.SS3.DashInfoSpeed.MPG.Value = false
			carSeat.Parent.Body.Dash.DashSc.G.Select:TweenPosition(UDim2.new(0, 75, 0, 20), "Out", "Quint", 1, true)
 end
end

F.volumedown = function(VolDown)
	carSeat.Parent.Body.MP.Sound.Volume = carSeat.Parent.Body.MP.Sound.Volume - 1
				print("Music volume:"..carSeat.Parent.Body.MP.Sound.Volume)
				carSeat.Parent.Body.Dash.DashSc.G.Modes.SpeedStats.Unit.Text = "VOL: "..carSeat.Parent.Body.MP.Sound.Volume
				carSeat.Parent.Body.Dash.DashSc.G.Modes.Info.Unit.Text = "VOLUME: "..carSeat.Parent.Body.MP.Sound.Volume
				carSeat.Parent.Body.Dash.Screen.G.Radio.VOLMENU.Visible = true
				carSeat.Parent.Body.Dash.Screen.G.Radio.VOLMENU.VolumeText.Text = "VOLUME: "..carSeat.Parent.Body.MP.Sound.Volume
						wait(1)
						carSeat.Parent.Body.Dash.DashSc.G.Modes.SpeedStats.Unit.Text = "MPH"
						carSeat.Parent.Body.Dash.DashSc.G.Modes.Info.Unit.Text = "No Information"
						wait(4)
						carSeat.Parent.Body.Dash.Screen.G.Radio.VOLMENU.Visible = false
end

F.volumeup = function(VolUp)
	carSeat.Parent.Body.MP.Sound.Volume = carSeat.Parent.Body.MP.Sound.Volume + 1
				print("Music volume:"..carSeat.Parent.Body.MP.Sound.Volume)
					carSeat.Parent.Body.Dash.DashSc.G.Modes.SpeedStats.Unit.Text = "VOL: "..carSeat.Parent.Body.MP.Sound.Volume
					carSeat.Parent.Body.Dash.DashSc.G.Modes.Info.Unit.Text = "VOLUME: "..carSeat.Parent.Body.MP.Sound.Volume
					carSeat.Parent.Body.Dash.Screen.G.Radio.VOLMENU.Visible = true
				carSeat.Parent.Body.Dash.Screen.G.Radio.VOLMENU.VolumeText.Text = "VOLUME: "..carSeat.Parent.Body.MP.Sound.Volume
						wait(1)
						carSeat.Parent.Body.Dash.DashSc.G.Modes.SpeedStats.Unit.Text = "MPH"
						carSeat.Parent.Body.Dash.DashSc.G.Modes.Info.Unit.Text = "No Information"
						wait(4)
						carSeat.Parent.Body.Dash.Screen.G.Radio.VOLMENU.Visible = false
end
F.TimeUpdate = function(Time)
	carSeat.Parent.Body.Dash.DashSc.G.Modes.SpeedStats.Time.Text = game.Lighting.TimeOfDay
	carSeat.Parent.Body.Dash.DashSc.G.Modes.Info.Time.Text = game.Lighting.TimeOfDay
	carSeat.Parent.Body.Dash.Screen.G.Radio.Time.Text = game.Lighting.TimeOfDay
	carSeat.Parent.Body.Dash.DashSc.G.Modes.SpeedStats.Speed.Text = math.floor(carSeat.Velocity.magnitude*((10/12) * (60/88)))
	carSeat.Parent.Body.Dash.DashSc.G.Modes.MPG.MPGCounter.Text = math.floor(carSeat.Velocity.magnitude*((10/12) * (25/88)))
	end

F.feON = function(FEon)
carSeat.Parent.Body.Dash.DashSc.G.Modes.Info.FE.Text = "FE: ON"
carSeat.Parent.Body.Dash.DashSc.G.Modes.Stats.FE.Text = "FE: ON"
end

F.feOFF = function(FEoff)
carSeat.Parent.Body.Dash.DashSc.G.Modes.Info.FE.Text = "FE: OFF"
carSeat.Parent.Body.Dash.DashSc.G.Modes.Stats.FE.Text = "FE: OFF"
end

F.FMSwitch = function(FM)
	if carSeat.Stations.mood.Value == 5 then
		carSeat.Parent.Body.Dash.Screen.G.Radio.Select.Visible = true
		carSeat.Parent.Body.MP.Sound:Stop()
		carSeat.Stations.mood.Value = 2
		carSeat.Parent.Body.Dash.Screen.G.Radio.Song.Text = "FM 93.3"
		carSeat.Parent.Body.Dash.Screen.G.Radio.Title.Text = "HipHop Hits!"
		carSeat.Parent.Body.Dash.Screen.G.Radio.Select:TweenPosition(UDim2.new(0, 0, 0, 105), "Out", "Quint", 1, true)
	elseif carSeat.Stations.mood.Value == 2 then
		carSeat.Parent.Body.MP.Sound:Stop()
		carSeat.Parent.Body.Dash.Screen.G.Radio.Select.Visible = true
		carSeat.Stations.mood.Value = 3
		carSeat.Parent.Body.Dash.Screen.G.Radio.Song.Text = "FM 95.5"
		carSeat.Parent.Body.Dash.Screen.G.Radio.Title.Text = "Pre-2000s"
		carSeat.Parent.Body.Dash.Screen.G.Radio.Select:TweenPosition(UDim2.new(0, 0, 0, 145), "Out", "Quint", 1, true)
	elseif carSeat.Stations.mood.Value == 3 then
		carSeat.Parent.Body.MP.Sound:Stop()
		carSeat.Parent.Body.Dash.Screen.G.Radio.Select.Visible = true
		carSeat.Stations.mood.Value = 4
		carSeat.Parent.Body.Dash.Screen.G.Radio.Song.Text = "FM 94.1"
		carSeat.Parent.Body.Dash.Screen.G.Radio.Title.Text = "Indie"
		carSeat.Parent.Body.Dash.Screen.G.Radio.Select:TweenPosition(UDim2.new(0, 0, 0, 190), "Out", "Quint", 1, true)
	elseif carSeat.Stations.mood.Value == 4 then
		carSeat.Parent.Body.MP.Sound:Stop()
		carSeat.Parent.Body.Dash.Screen.G.Radio.Select.Visible = true
		carSeat.Stations.mood.Value = 1
		carSeat.Parent.Body.Dash.Screen.G.Radio.Song.Text = "FM 103.7"
		carSeat.Parent.Body.Dash.Screen.G.Radio.Title.Text = "ENERGY TOP 40"
		carSeat.Parent.Body.Dash.Screen.G.Radio.Select:TweenPosition(UDim2.new(0, 0, 0, 60), "Out", "Quint", 1, true)
	elseif carSeat.Stations.mood.Value == 1 then
		carSeat.Parent.Body.MP.Sound:Stop()
		carSeat.Parent.Body.Dash.Screen.G.Radio.Select.Visible = false
		carSeat.Stations.mood.Value = 5
		carSeat.Parent.Body.Dash.Screen.G.Radio.Song.Text = ""
		carSeat.Parent.Body.Dash.Screen.G.Radio.Title.Text = ""
	end
end

F.updateSong = function(Song)
	carSeat.Stations.mood.Value = 5
	carSeat.Parent.Body.Dash.Screen.G.Radio.Select.Visible = false
	carSeat.Parent.Body.MP.Sound:Stop()
	wait()
	carSeat.Parent.Body.MP.Sound.SoundId = "rbxassetid://"..Song
	wait()
	carSeat.Parent.Body.MP.Sound:Play()
	carSeat.Parent.Body.Dash.Screen.G.Radio.Song.Text = "Custom song"
	carSeat.Parent.Body.Dash.Screen.G.Radio.Title.Text = ""
	carSeat.Parent.Body.Dash.Screen.G.Radio.Select.Visible = false
end

F.pauseSong = function()
	carSeat.Stations.mood.Value = 5
	carSeat.Parent.Body.Dash.Screen.G.Radio.Select.Visible = false
	carSeat.Parent.Body.MP.Sound:Stop()
		carSeat.Parent.Body.Dash.Screen.G.Radio.Song.Text = "Music off"
end

F.updateVolume = function(Vol)
	carSeat.Parent.Body.MP.Sound.Volume = carSeat.Parent.Body.MP.Sound.Volume + Vol/5
end

F.updateValue = function(Val, Value)
	if Val then
		Val.Value = Value
	end
end

--F.brakeLights = function(Tog)
--	for i,v in pairs(script.Parent.Parent.Parent:getChildren()) do
--		if v:FindFirstChild('Brake') then
--			v.Braking.Enabled = (carSeat.Ignition.Value == 1 and Tog or false)
--			v.Lights.Enabled = (carSeat.Ignition.Value == 1 and Tog or false)
--		end
--	end
--end

--F.reverseLights = function(Tog)
--	for i,v in pairs(script.Parent.Parent.Parent:getChildren()) do
--		if v:FindFirstChild('Reverse') then
--			v.Braking.Enabled = (carSeat.Ignition.Value == 1 and Tog or false)
--			v.Lights.Enabled = (carSeat.Ignition.Value == 1 and Tog or false)
--		end
--	end
--end

--F.headLights = function(Tog)
--	for i,v in pairs(script.Parent.Parent.Parent:getChildren()) do
--		if v:FindFirstChild('Head') or v:FindFirstChild('Tail') then
--			v.BGUI.Enabled = (carSeat.Ignition.Value == 1 and Tog or false)
--			v.SpotLight.Enabled = (carSeat.Ignition.Value == 1 and Tog or false)
--		end
--	end
--	carSeat.Headlights.Value = (carSeat.Ignition.Value == 1 and Tog or false)
--end

script.Parent.OnServerEvent:connect(function(Player, Func, ...)
	if F[Func] then
		F[Func](...)
	end
end)