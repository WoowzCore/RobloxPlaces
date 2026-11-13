GUI = script.Parent.Screen

script.Parent.ChildAdded:connect(function(child)
	if child:IsA("Weld") then
		--child.C0 = CFrame.new(0,-0.1,0)*CFrame.fromEulerAnglesXYZ(-(math.pi/2),0,0) --// Reposition player
		if child.Part1.Name == "HumanoidRootPart" then
			player = game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			script.Parent:SetNetworkOwner(player)
			if player and (not player.PlayerGui:FindFirstChild("Screen")) then --// The part after the "and" prevents multiple GUI's to be copied over.
				GUI.CarSeat.Value = script.Parent --// Puts a reference of the seat in this ObjectValue, now you can use this ObjectValue's value to find the car directly.
				GUI:Clone().Parent = player.PlayerGui --// Compact version
				script.Parent.Stop:Play()
				script.Parent.Sound:Play()
				script.Parent.Sound2:Play()
				script.Parent.Wind:Play()
			end
		end
	end
end)

script.Parent.ChildRemoved:connect(function(child)
	if child:IsA("Weld") then
		if child.Part1.Name == "HumanoidRootPart" then
			script.Parent.Parent.Parent.RWD.RWD.MaxSpeed = 0
			  script.Parent.Parent.Parent.RWD.RWD.Throttle = 0
  				script.Parent.Parent.Parent.RWD.RWD.Torque = 10
				 script.Parent.Parent.Parent.LW.VS.MaxSpeed = 0
 				  script.Parent.Parent.Parent.LW.VS.Throttle = 0
  					 script.Parent.Parent.Parent.LW.VS.Torque = 10
					   script.Parent.Parent.Parent.RW.VS.MaxSpeed = 0
  						script.Parent.Parent.Parent.RW.VS.Throttle = 0
  						 script.Parent.Parent.Parent.RW.VS.Torque = 10
						  script.Parent.Sound:Stop()
						  script.Parent.Sound2:Stop()
						  script.Parent.Wind:Stop()
						   script.Parent.Stop:Play()
						    script.Parent.InsaneMode.Value = false
							script.Parent.Parent.Runners.A.Material = "SmoothPlastic"
							script.Parent.Parent.Runners.B.Material = "SmoothPlastic"
							script.Parent.Parent.Runners.C.Material = "SmoothPlastic"
							script.Parent.Parent.Runners.D.Material = "SmoothPlastic"
							script.Parent.Parent.Runners.E.Material = "SmoothPlastic"
							script.Parent.Parent.Runners.F.Material = "SmoothPlastic"
							script.Parent.Parent.Runners.G.Material = "SmoothPlastic"
							script.Parent.Parent.Runners.H.Material = "SmoothPlastic"
							script.Parent.Parent.Runners.I.Material = "SmoothPlastic"
							script.Parent.Parent.Runners.J.Material = "SmoothPlastic"
							script.Parent.Parent.Runners.K.Material = "SmoothPlastic"
							script.Parent.Parent.Runners.L.Material = "SmoothPlastic"
							script.Parent.Parent.Runners.M.Material = "SmoothPlastic"
							script.Parent.Parent.Runners.N.Material = "SmoothPlastic"
							script.Parent.Parent.Runners.O.Disp.Enabled = false
							script.Parent.Parent.Runners.P.Disp.Enabled = false
							if script.Parent.Parent.Parent.DoorLD.Door.SS2.Motor.DesiredAngle == 0 then
								script.Parent.Parent.Parent.DoorLD.Door.SS2.Motor.DesiredAngle = -1
								script.Parent.Parent.Parent.DoorLD.Door.Handle.DoorOpen:Play()
							end
						player = game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			if player and player.PlayerGui:FindFirstChild("Screen") then
				player.PlayerGui:FindFirstChild("Screen"):Destroy()
				wait(4)
				if script.Parent.Parent.Parent.DoorLD.Door.SS2.Motor.DesiredAngle < 0 then
					script.Parent.Parent.Parent.DoorLD.Door.SS2.Motor.DesiredAngle = 0
					wait(0.58)
					script.Parent.Parent.Parent.DoorLD.Door.Handle.DoorClose:Play()
				end
			end
		end
	end	
end)

