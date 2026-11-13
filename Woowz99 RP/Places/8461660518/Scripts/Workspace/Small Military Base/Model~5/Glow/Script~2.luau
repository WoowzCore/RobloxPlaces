
local enabled = false
script.Parent.Parent.hitbox.ClickDetector.MouseClick:connect(function()
	print("clickd")
	if enabled == false then enabled = true
		script.Parent.On.Value = true
		wait()
	else if enabled == true then enabled = false script.Parent.On.Value = false wait() end
	end
end)
