script.Parent.ClickDetector.MouseClick:connect(function()
	if script.Parent.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.AngularVelocity == Vector3.new(0,-100,0) then
		script.Parent.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.AngularVelocity = Vector3.new(0,100,0)
		script.Parent.Parent.FanClick.beep:Play()
	else
		script.Parent.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.AngularVelocity = Vector3.new(0,-100,0)
		script.Parent.Parent.FanClick.beep:Play()
	end
end)