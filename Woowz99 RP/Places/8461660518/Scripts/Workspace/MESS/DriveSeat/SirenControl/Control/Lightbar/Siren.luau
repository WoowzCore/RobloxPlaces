local isOn = false

veh = game.Workspace:FindFirstChild(script.Parent.Parent.CarName.Value, true)

function on() 
	isOn = true
    veh.Body.lightbar1.on.Value = false
    veh.Body.lightbar2.on.Value = false
	
    veh.Body.lightbar1.middle.Beep:Play(0.1)
        
end

function off() 
	isOn = false
    veh.Body.lightbar1.on.Value = true
	veh.Body.lightbar2.on.Value = true
	
    veh.Body.lightbar1.middle.Beep:Play(0.1)
end

function onButtonClicked()
	
	if isOn == true then off() else on() end

end

script.Parent.MouseButton1Click:connect(onButtonClicked)

