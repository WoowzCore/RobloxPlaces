local isOn = false

veh = game.Workspace:FindFirstChild(script.Parent.Parent.CarName.Value, true)



function on() 
 isOn = true
     veh.lightbar1.ta1.Modes.right.Value = false
        
end

function off() 
 isOn = false
   veh.lightbar1.ta1.Modes.right.Value = true
end

function onButtonClicked()
 
 if isOn == true then off() else on() end

end

script.Parent.MouseButton1Click:connect(onButtonClicked)

on()