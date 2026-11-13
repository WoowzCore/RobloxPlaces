local mouse=game.Players.LocalPlayer:GetMouse()
script.Parent:WaitForChild("src3")
src=script.Parent.src3.Value
mouse.KeyDown:connect(function(key)
	if key=="c" then 
		src:Play()
		if src.Parent.Parent.Body.Right.on.Value == true then
		src.Parent.Parent.Body.Right.on.Value = false
		else
			src.Parent.Parent.Body.Right.on.Value = true
		end
		end
end)
src.Parent.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then 
		script.Parent:Destroy()
	end
end)