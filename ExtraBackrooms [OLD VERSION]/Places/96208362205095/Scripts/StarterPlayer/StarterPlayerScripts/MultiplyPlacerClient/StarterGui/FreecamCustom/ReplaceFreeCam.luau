local GUI = script.Parent.Parent

local oldfreecam = GUI:FindFirstChild("Freecam")
if oldfreecam then
	oldfreecam:Destroy()
end

GUI.ChildAdded:Connect(function(child)
	if child.Name == "Freecam" then
		child:Destroy()
	end
end)