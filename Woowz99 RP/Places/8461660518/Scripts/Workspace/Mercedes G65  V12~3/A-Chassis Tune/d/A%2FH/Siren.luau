veh = game.Workspace:FindFirstChild(script.Parent.Parent.CarName.Value, true)
airhorn = veh.lightbar1.middle.Airhorn
function Click(mouse)
airhorn:Play()
veh.lightbar1.middle.Wail.Volume = 0
veh.lightbar1.middle.Yelp.Volume = 0
veh.lightbar1.middle.Priority.Volume = 0
veh.lightbar1.middle.Beep:Play(0.1)
end
function Unclick(mouse)
airhorn:Stop()
veh.lightbar1.middle.Wail.Volume = 1
veh.lightbar1.middle.Yelp.Volume = 1
veh.lightbar1.middle.Priority.Volume = 1
end
script.Parent.MouseButton1Down:connect(Click)
script.Parent.MouseButton1Up:connect(Unclick)