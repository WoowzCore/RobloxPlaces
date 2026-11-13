GUI = script.Parent.SS3

script.Parent.ChildAdded:connect(function(child)
	if child:IsA("Weld") then
--		child.C0 = CFrame.new(0,-0.6,0)*CFrame.fromEulerAnglesXYZ(-(math.pi/2),0,0) --// Reposition player
		if child.Part1.Name == "HumanoidRootPart" then
			player = game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			if player and (not player.PlayerGui:FindFirstChild("Screen")) then --// The part after the "and" prevents multiple GUI's to be copied over.
				GUI.CarSeat.Value = script.Parent --// Puts a reference of the seat in this ObjectValue, now you can use this ObjectValue's value to find the car directly.
				GUI:Clone().Parent = player.PlayerGui --// Compact version
				script.Parent.Parent.Body.Lights.RunL.Material = "Neon"
				script.Parent.Parent.Body.Lights.RunR.Material = "Neon"
				script.Parent.Parent.Body.Dash.DashSc.G.Enabled = true
				script.Parent.Parent.Body.Dash.S.G.Enabled = true
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
				script.Parent.Parent.Body.Lights.RunL.Material = "SmoothPlastic"
				script.Parent.Parent.Body.Lights.RunR.Material = "SmoothPlastic"
				script.Parent.Parent.Body.Dash.DashSc.G.Enabled = false
				script.Parent.Parent.Body.Dash.S.G.Enabled = false
			end
		end
	end	
end)

