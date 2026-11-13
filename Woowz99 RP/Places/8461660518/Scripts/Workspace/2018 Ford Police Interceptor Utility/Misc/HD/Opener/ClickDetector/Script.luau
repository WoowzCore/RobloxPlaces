wait(0.1)
local m = script.Parent.Parent.Parent.SS.Motor

script.Parent.MouseClick:Connect(function()
	if script.Parent.Parent.Up.Value == false then
	 m.DesiredAngle = 1.1
		script.Parent.Parent.DoorOpen:Play()
		script.Parent.Parent.Up.Value = true
	elseif  script.Parent.Parent.Up.Value == true then
		m.DesiredAngle = 0
		script.Parent.Parent.DoorClose:Play()
		script.Parent.Parent.Up.Value = false
	end
	end)
