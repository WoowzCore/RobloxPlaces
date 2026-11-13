script.Parent.ClickDetector.MouseClick:Connect(function()
	if script.Parent.Parent.Speed.Value == 0 then
		script.Parent.Parent.Speed.Value = 7
		script.Parent.beep:Play()
		script.Parent.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.MaxTorque = Vector3.new(0,2.5,0)
		wait(1.5)
		script.Parent.Parent.Speed.Value = 1
		elseif script.Parent.Parent.Speed.Value == 1 then
		script.Parent.Parent.Speed.Value = 7
		script.Parent.beep:Play()
		script.Parent.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.MaxTorque = Vector3.new(0,2.5,0)
		wait(1.5)
		script.Parent.Parent.Speed.Value = 2
		elseif script.Parent.Parent.Speed.Value == 2 then
		script.Parent.Parent.Speed.Value = 7
		script.Parent.beep:Play()
		script.Parent.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.MaxTorque = Vector3.new(0,2.5,0)
		wait(1.5)
		script.Parent.Parent.Speed.Value = 3
		elseif script.Parent.Parent.Speed.Value == 3 then
		script.Parent.Parent.Speed.Value = 7
		script.Parent.beep:Play()
		script.Parent.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.MaxTorque = Vector3.new(0,2.5,0)
		wait(1.5)
		script.Parent.Parent.Speed.Value = 4
		elseif script.Parent.Parent.Speed.Value == 4 then
		script.Parent.Parent.Speed.Value = 7
		script.Parent.beep:Play()
		script.Parent.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.MaxTorque = Vector3.new(0,2.5,0)
		wait(1.5)
		script.Parent.Parent.Speed.Value = 5
		elseif script.Parent.Parent.Speed.Value == 5 then
		script.Parent.beep:Play()
		script.Parent.Parent.Speed.Value = 6
		elseif script.Parent.Parent.Speed.Value == 6 then
		script.Parent.beep:Play()
		script.Parent.Parent.Speed.Value = 0
	end
end)