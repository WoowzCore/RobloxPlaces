local mouse=game.Players.LocalPlayer:GetMouse()
script.Parent:WaitForChild("src3")
src=script.Parent.src3.Value
mouse.KeyDown:connect(function(key)
	if key=="s" then 
		src:Play()
		src.Parent.Parent.Body.Brakes.on.Value = true
	end
end)
mouse.KeyUp:connect(function(key)
	if key=="s" then 
		src:Play()
		src.Parent.Parent.Body.Brakes.on.Value = false
		end
end)
src.Parent.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then 
		script.Parent:Destroy()
	end
end)