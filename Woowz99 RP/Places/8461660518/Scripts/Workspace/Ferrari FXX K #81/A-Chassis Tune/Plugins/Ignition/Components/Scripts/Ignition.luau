wait(0.2) 
local button = script.Parent.Parent.Parent
local car = script.Parent.Parent.Parent.Parent.Car.Value
local sound = script.Parent.Parent.Start
sound.Parent = car.DriveSeat
button.MouseButton1Click:connect(function()
	if script.Parent.Parent.Parent.Text == "Engine: Off" then 
		sound:Play()
		wait(1.2)
		sound.Parent.Rev:Play()
		script.Parent.Parent.Parent.Parent.IsOn.Value = true
		button.Text = "Engine: On"
	else
		script.Parent.Parent.Parent.Parent.IsOn.Value = false 
		button.Text = "Engine: Off"
		sound.Parent.Rev:Stop()
	end 
	end)
