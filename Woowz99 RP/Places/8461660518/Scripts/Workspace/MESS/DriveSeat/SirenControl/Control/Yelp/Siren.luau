local isOn = false

veh = game.Workspace:FindFirstChild(script.Parent.Parent.CarName.Value, true)

function on() 
	isOn = true
veh.Body.lightbar1.middle.Yelp:Stop()
veh.Body.lightbar1.middle.Beep:Play(0.1)

end
function off() 
	isOn = false

veh.Body.lightbar1.middle.Beep:Play(0.1)
veh.Body.lightbar1.middle.Yelp:Play()
veh.Body.lightbar1.middle.Priority:Stop()
veh.Body.lightbar1.middle.Wail:Stop()
end

function onButtonClicked()
	
	if isOn == true then off() else on() end

end

script.Parent.MouseButton1Click:connect(onButtonClicked)

on()
