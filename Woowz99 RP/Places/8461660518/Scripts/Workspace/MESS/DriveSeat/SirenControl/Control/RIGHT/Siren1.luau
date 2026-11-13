local isOn = false

veh = game.Workspace:FindFirstChild(script.Parent.Parent.CarName.Value, true)

function on() 
	isOn = true
    veh.Body.Spotlights.TrafficControl.Value = ""
        
end

function off() 
	isOn = false
    veh.Body.Spotlights.TrafficControl.Value = ">"
end

function onButtonClicked()
	
	if isOn == true then off() else on() end

end

script.Parent.MouseButton1Click:connect(onButtonClicked)

on()
