local scoped = false
local cam

script.Parent.Equipped:connect(function(mouse)
	cam = game.Workspace.CurrentCamera
	mouse.KeyDown:connect(function(key)
		key = key:lower()
		if key == "q" then
			cam.FieldOfView = scoped and 70 or 20
			scoped = not scoped
		end
	end)
end)

script.Parent.Unequipped:connect(function()
	cam.FieldOfView = 70
end)
