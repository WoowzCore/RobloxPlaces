local isOn = false
veh = game.Workspace:FindFirstChild(script.Parent.Parent.CarName.Value, true).Body
local mouse=game.Players.LocalPlayer:GetMouse()
On=false
On2=false
On3=false
Allway=false
Left=false
Right=false
Stady=false
TakeD=false

mouse.KeyDown:connect(function(key)
	if key=="r" then 
		if veh.Lightbar.middle.Wail.IsPlaying == true then
			script.Parent.Parent.Wail.TextTransparency = 0.8
			script.Parent.Parent.MBOV.Visible = true
			script.Parent.Parent.MBOV.Text = "Made by OfficerVargas"
		veh.Lightbar.middle.Wail:Stop()
		veh.Lightbar.middle.Yelp:Stop()
		veh.Lightbar.middle.Priority:Stop()
		else
		veh.Lightbar.middle.Wail:Play()
		veh.Lightbar.middle.Yelp:Stop()
		veh.Lightbar.middle.Priority:Stop()
		script.Parent.Parent.Wail.TextTransparency = 0
		script.Parent.Parent.Yelp.TextTransparency = 0.8
		script.Parent.Parent.Priority.TextTransparency = 0.8
		script.Parent.Parent.MBOV.Visible = true
			script.Parent.Parent.MBOV.Text = "Made by OfficerVargas"
		end
	end
end)

mouse.KeyDown:connect(function(key)
	if key=="t" then 
		if veh.Lightbar.middle.Yelp.IsPlaying == true then
			script.Parent.Parent.Yelp.TextTransparency = 0.8
			script.Parent.Parent.MBOV.Visible = true
			script.Parent.Parent.MBOV.Text = "Made by OfficerVargas"
		veh.Lightbar.middle.Wail:Stop()
		veh.Lightbar.middle.Yelp:Stop()
		veh.Lightbar.middle.Priority:Stop()
		else
		veh.Lightbar.middle.Wail:Stop()
		veh.Lightbar.middle.Yelp:Play()
		veh.Lightbar.middle.Priority:Stop()
		script.Parent.Parent.Yelp.TextTransparency = 0
		script.Parent.Parent.Priority.TextTransparency = 0.8
		script.Parent.Parent.Wail.TextTransparency = 0.8
		script.Parent.Parent.MBOV.Visible = true
			script.Parent.Parent.MBOV.Text = "Made by OfficerVargas"
		end
	end
end)

mouse.KeyDown:connect(function(key)
	if key=="g" then 
		if veh.Lightbar.middle.Priority.IsPlaying == true then
		script.Parent.Parent.Priority.TextTransparency = 0.8
		script.Parent.Parent.MBOV.Visible = true
			script.Parent.Parent.MBOV.Text = "Made by OfficerVargas"
		veh.Lightbar.middle.Wail:Stop()
		veh.Lightbar.middle.Yelp:Stop()
		veh.Lightbar.middle.Priority:Stop()
		else
		veh.Lightbar.middle.Wail:Stop()
		veh.Lightbar.middle.Yelp:Stop()
		veh.Lightbar.middle.Priority:Play()
		script.Parent.Parent.Priority.TextTransparency = 0
		script.Parent.Parent.Yelp.TextTransparency = 0.8
		script.Parent.Parent.Wail.TextTransparency = 0.8
		script.Parent.Parent.MBOV.Visible = true
			script.Parent.Parent.MBOV.Text = "Made by OfficerVargas"
		end
	end
end)

--// F key, Horn
mouse.KeyDown:connect(function(key)
	if key=="f" then 
		script.Parent.Parent.Horn.TextTransparency = 0
		veh.Lightbar.middle.Airhorn:Play()
		veh.Lightbar.middle.Wail.Volume = 0
		veh.Lightbar.middle.Yelp.Volume = 0
		veh.Lightbar.middle.Priority.Volume = 0
script.Parent.Parent.MBOV.Visible = true
			script.Parent.Parent.MBOV.Text = "Made by OfficerVargas"
	end
end)

--// F key, Horn
mouse.KeyUp:connect(function(key)
	if key=="f" then 
		script.Parent.Parent.Horn.TextTransparency = 0.8
		veh.Lightbar.middle.Airhorn:Stop()
		veh.Lightbar.middle.Wail.Volume = 1
		veh.Lightbar.middle.Yelp.Volume = 1
		veh.Lightbar.middle.Priority.Volume = 1
		script.Parent.Parent.MBOV.Visible = true
			script.Parent.Parent.MBOV.Text = "Made by OfficerVargas"
	end
end)

mouse.KeyDown:connect(function(key)
	if key=="j" then 
		veh.Lightbar.middle.Beep:Play()
veh.Lightbar.RemoteEvent:FireServer(true)
	end
	end)
