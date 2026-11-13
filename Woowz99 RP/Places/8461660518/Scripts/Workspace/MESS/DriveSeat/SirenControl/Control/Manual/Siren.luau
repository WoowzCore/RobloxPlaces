veh = game.Workspace:FindFirstChild(script.Parent.Parent.CarName.Value, true)
airhorn = veh.Body.lightbar1.middle.Manual
function Click(mouse)
airhorn:Play()
if veh.Body.lightbar1.middle.Wail.IsPlaying == true then
veh.Body.lightbar1.middle.Wail:Stop()
veh.Body.lightbar1.middle.Wail.Volume = 0
end
if veh.Body.lightbar1.middle.Yelp.IsPlaying == true then
veh.Body.lightbar1.middle.Yelp:Stop()
veh.Body.lightbar1.middle.Yelp.Volume = 0
end
if veh.Body.lightbar1.middle.Priority.IsPlaying == true then
veh.Body.lightbar1.middle.Priority:Stop()
veh.Body.lightbar1.middle.Priority.Volume = 0
end
veh.Body.lightbar1.middle.Beep:Play(0.1)
end
function Unclick(mouse)
airhorn:Stop()
if veh.Body.lightbar1.middle.Wail.Volume == 0 then
veh.Body.lightbar1.middle.Wail:Play()
end
if veh.Body.lightbar1.middle.Yelp.Volume == 0 then
veh.Body.lightbar1.middle.Yelp:Play()
end
if veh.Body.lightbar1.middle.Priority.Volume == 0 then
veh.Body.lightbar1.middle.Priority:Play()
end
veh.Body.lightbar1.middle.Wail.Volume = 1
veh.Body.lightbar1.middle.Yelp.Volume = 1
veh.Body.lightbar1.middle.Priority.Volume = 1
end
script.Parent.MouseButton1Down:connect(Click)
script.Parent.MouseButton1Up:connect(Unclick)