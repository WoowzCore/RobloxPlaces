GUI = script.Parent.SS3

script.Parent.ChildAdded:connect(function(child)
	if child:IsA("Weld") then
--		child.C0 = CFrame.new(0,-0.6,0)*CFrame.fromEulerAnglesXYZ(-(math.pi/2),0,0) --// Reposition player
		if child.Part1.Name == "HumanoidRootPart" then
			player = game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			if player and (not player.PlayerGui:FindFirstChild("Screen")) then --// The part after the "and" prevents multiple GUI's to be copied over.
				GUI.CarSeat.Value = script.Parent --// Puts a reference of the seat in this ObjectValue, now you can use this ObjectValue's value to find the car directly.
				GUI:Clone().Parent = player.PlayerGui --// Compact version
				if script.Parent.L.Value == true then --because you can't get in a locked car
					wait()
					script.Parent.Disabled = true
					wait()
					script.Parent.Disabled = false
				end
				script.Parent.Occupied.Value = true
				script.Parent.Parent.Body.Dash.Spd.Interface.Enabled = true
				script.Parent.Parent.Body.Dash.Tac.Interface.Enabled = true
				script.Parent.Parent.Body.Lights.Runner.Material = "Neon"
				script.Parent.Parent.Body.Dash.Screen.G.Enabled = true
				script.Parent.Parent.Body.Dash.Screen.G.Startup.Visible = true
				script.Parent.Parent.Body.Dash.Screen.G.Caution.Visible = false
				script.Parent.Parent.Body.Dash.DashSc.G.Unit.Visible = true
				script.Parent.Parent.Body.Dash.DashSc.G.Enabled = true
				script.Parent.Parent.DriveSeat.SS3.DashInfoSpeed.Info.Value = true
				script.Parent.Parent.DriveSeat.SS3.DashInfoSpeed.Speed.Value = false
				script.Parent.Parent.DriveSeat.SS3.DashInfoSpeed.Version.Value = false
				script.Parent.Parent.DriveSeat.SS3.DashInfoSpeed.MPG.Value = false
				script.Parent.Parent.DriveSeat.SS3.Radios.FMOne.Value = true
				script.Parent.Parent.DriveSeat.SS3.Radios.FMTwo.Value = false
				script.Parent.Parent.DriveSeat.SS3.Radios.FMThree.Value = false
				script.Parent.Parent.DriveSeat.SS3.Radios.FMFour.Value = false
				script.Parent.Parent.Body.Dash.DashSc.G.Modes.SpeedStats.Visible = false
						script.Parent.Parent.Body.Dash.DashSc.G.Modes.Info.Visible = false
						script.Parent.Parent.Body.Dash.DashSc.G.Modes.Stats.Visible = false
						script.Parent.Parent.Body.Dash.DashSc.G.Frame.Position = UDim2.new(0, 0, 0, -5)
						script.Parent.Parent.Body.Dash.DashSc.G.Select.Position = UDim2.new(0, 0, 0, -5)
						script.Parent.Parent.Body.Dash.DashSc.G.Unit.Text = "Welcome"
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0.9
						wait(0.2)
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0.8
						wait(0.2)
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0.7
						wait(0.2)
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0.6
						wait(0.2)
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0.5
						wait(0.2)
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0.4
						wait(0.2)
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0.3
						script.Parent.Parent.Body.Dash.Spd.Interface.LightInfluence = 1.5
						script.Parent.Parent.Body.Dash.Tac.Interface.LightInfluence = 1.5
						wait(0.2)
						script.Parent.Parent.Body.Dash.DashSc.G.Car.ImageTransparency = 0.7
						script.Parent.Parent.Body.Dash.DashSc.G.Speed.ImageTransparency = 0.7
						script.Parent.Parent.Body.Dash.DashSc.G.Info1.ImageTransparency = 0.7
						script.Parent.Parent.Body.Dash.DashSc.G.Gas.ImageTransparency = 0.7
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0.2
						script.Parent.Parent.Body.Dash.Spd.Interface.LightInfluence = 1
						script.Parent.Parent.Body.Dash.Tac.Interface.LightInfluence = 1
						script.Parent.Parent.Body.Dash.DashSc.G.Select:TweenPosition(UDim2.new(0, 0, 0, 20), "InOut", "Quint", 1, true)
					script.Parent.Parent.Body.Dash.DashSc.G.Frame:TweenPosition(UDim2.new(0, 0, 0, 20), "InOut", "Quint", 1, true)
						wait(0.2)
						script.Parent.Parent.Body.Dash.DashSc.G.Car.ImageTransparency = 0.4
						script.Parent.Parent.Body.Dash.DashSc.G.Speed.ImageTransparency = 0.4
						script.Parent.Parent.Body.Dash.DashSc.G.Info1.ImageTransparency = 0.4
						script.Parent.Parent.Body.Dash.DashSc.G.Gas.ImageTransparency = 0.4
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0.1
						script.Parent.Parent.Body.Dash.Spd.Interface.LightInfluence = .5
						script.Parent.Parent.Body.Dash.Tac.Interface.LightInfluence = .5
						wait(0.2)
						script.Parent.Parent.Body.Dash.DashSc.G.Car.ImageTransparency = 0
						script.Parent.Parent.Body.Dash.DashSc.G.Speed.ImageTransparency = 0
						script.Parent.Parent.Body.Dash.DashSc.G.Info1.ImageTransparency = 0
						script.Parent.Parent.Body.Dash.DashSc.G.Gas.ImageTransparency = 0
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0
						script.Parent.Parent.Body.Dash.Spd.Interface.LightInfluence = 0
						script.Parent.Parent.Body.Dash.Tac.Interface.LightInfluence = 0
						wait(2.2)
						script.Parent.Parent.Body.Dash.DashSc.G.Modes.SpeedStats.Position = UDim2.new(0, 0, 0, 0)
						script.Parent.Parent.Body.Dash.DashSc.G.Modes.SpeedStats.Visible = true
						script.Parent.Parent.Body.Dash.DashSc.G.Unit.Visible = false
						script.Parent.Parent.Body.Dash.Screen.G.Startup.Visible = false
						script.Parent.Parent.Body.Dash.Screen.G.Caution.Visible = true
						wait(6)
						script.Parent.Parent.Body.Dash.Screen.G.Caution.Visible = false
--						script.Parent.Parent.Body.Dash.Screen.G.Radio.Select.Position = UDim2.new(0, 0, 0, 60)
					end
			end
	end
end)

script.Parent.ChildRemoved:connect(function(child)
	if child:IsA("Weld") then
		if child.Part1.Name == "HumanoidRootPart" then
			game.Workspace.CurrentCamera.FieldOfView = 70
			player = game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			if player and player.PlayerGui:FindFirstChild("SS3") then
				player.PlayerGui:FindFirstChild("SS3"):Destroy()
				script.Parent.Parent.Body.Lights.Runner.Material = "SmoothPlastic"
				script.Parent.Parent.Body.Dash.Screen.G.Enabled = false
				script.Parent.Parent.Body.Dash.DashSc.G.Unit.Visible = true
				script.Parent.Parent.Body.Dash.DashSc.G.Select:TweenPosition(UDim2.new(0, 0, 0, -5), "InOut", "Quint", 1, true)
					script.Parent.Parent.Body.Dash.DashSc.G.Frame:TweenPosition(UDim2.new(0, 0, 0, -5), "InOut", "Quint", 1, true)
						script.Parent.Parent.Body.Dash.DashSc.G.Modes.SpeedStats.Visible = false
						script.Parent.Parent.Body.Dash.DashSc.G.Modes.Info.Visible = false
						script.Parent.Parent.Body.Dash.DashSc.G.Modes.MPG.Visible = false
						script.Parent.Parent.Body.Dash.DashSc.G.Modes.Stats.Visible = false
						script.Parent.Parent.Body.Dash.DashSc.G.Unit.Text = "Goodbye"
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0.1
						wait(0.2)
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0.2
						wait(0.2)
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0.3
						wait(0.2)
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0.4
						wait(0.2)
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0.5
						wait(0.2)
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0.6
						wait(0.2)
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0.7
						wait(0.2)
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0.8
						script.Parent.Parent.Body.Dash.Spd.Interface.LightInfluence = .5
						script.Parent.Parent.Body.Dash.Tac.Interface.LightInfluence = .5
						script.Parent.Parent.Body.Dash.DashSc.G.Car.ImageTransparency = 0.3
						script.Parent.Parent.Body.Dash.DashSc.G.Speed.ImageTransparency = 0.3
						script.Parent.Parent.Body.Dash.DashSc.G.Info1.ImageTransparency = 0.3
						script.Parent.Parent.Body.Dash.DashSc.G.Gas.ImageTransparency = 0.3
						wait(0.2)
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 0.9
						script.Parent.Parent.Body.Dash.Spd.Interface.LightInfluence = 1
						script.Parent.Parent.Body.Dash.Tac.Interface.LightInfluence = 1
						script.Parent.Parent.Body.Dash.DashSc.G.Car.ImageTransparency = 0.7
						script.Parent.Parent.Body.Dash.DashSc.G.Speed.ImageTransparency = 0.7
						script.Parent.Parent.Body.Dash.DashSc.G.Info1.ImageTransparency = 0.7
						script.Parent.Parent.Body.Dash.DashSc.G.Gas.ImageTransparency = 0.7
						wait(0.2)
						script.Parent.Parent.Body.Dash.DashSc.G.ImageLabel.ImageTransparency = 1
						script.Parent.Parent.Body.Dash.Spd.Interface.LightInfluence = 1.8
						script.Parent.Parent.Body.Dash.Tac.Interface.LightInfluence = 1.8
						script.Parent.Parent.Body.Dash.DashSc.G.Car.ImageTransparency = 1
						script.Parent.Parent.Body.Dash.DashSc.G.Speed.ImageTransparency = 1
						script.Parent.Parent.Body.Dash.DashSc.G.Gas.ImageTransparency = 1
						script.Parent.Parent.Body.Dash.DashSc.G.Info1.ImageTransparency = 1
						wait(.4)
						script.Parent.Parent.Body.Dash.DashSc.G.Unit.Visible = false
						script.Parent.Parent.Body.Dash.DashSc.G.Enabled = false
						script.Parent.Occupied.Value = false
						script.Parent.Parent.Body.Dash.Spd.Interface.Enabled = false
						script.Parent.Parent.Body.Dash.Tac.Interface.Enabled = false
			end
		end
	end	
end)

