script.Parent.FanClick.ClickDetector.MouseClick:Connect(function()
	if script.Parent.Demo.Value == 0 then
		script.Parent.Demo.Value = 1
		wait(5)
		script.Parent.Demo.Value = 0
	end
end)

script.Parent.LightClick.ClickDetector.MouseClick:Connect(function()
	if script.Parent.Demo.Value == 1 then
		script.Parent.Demo.Value = 2
	end
end)

script.Parent.FanClick.ClickDetector.MouseClick:Connect(function()
	if script.Parent.Demo.Value == 2 then
		script.Parent.Demo.Value = 3
	end
end)

script.Parent.LightClick.ClickDetector.MouseClick:Connect(function()
	if script.Parent.Demo.Value == 3 then
		script.Parent.Demo.Value = 4
	end
end)

script.Parent.FanClick.ClickDetector.MouseClick:Connect(function()
	if script.Parent.Demo.Value == 4 then
		script.Parent.Demo.Value = 5
		script.Parent.Light.Value = 5
		script.Parent.Parent.Fan.Light.Material = "SmoothPlastic"
		script.Parent.Parent.Fan.Light.PointLight.Enabled = false
		script.Parent.Parent.Fan.Light.PointLight.Brightness = 0
		wait(1.6)
		script.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.AngularVelocity = Vector3.new(0,-100,0)
		script.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.MaxTorque = Vector3.new(0,0,0)
		script.Parent.Speed.Value = 7
		wait(8)
		script.Parent.Parent.Fan.Light.Material = "Neon"
		script.Parent.Parent.Fan.Light.PointLight.Enabled = true
		script.Parent.Parent.Fan.Light.PointLight.Brightness = 1
		wait(1)
		script.Parent.Parent.Fan.Light.PointLight.Brightness = 2
		wait(1)
		script.Parent.Parent.Fan.Light.PointLight.Brightness = 3
		wait(11)
		script.Parent.FanClick.beep:Play()
		script.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.MaxTorque = Vector3.new (0,2.5,0)
		wait(1.5)
		script.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.MaxTorque = Vector3.new (0,.5,0)
		wait(1)
		script.Parent.FanClick.beep:Play()
		script.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.MaxTorque = Vector3.new (0,2.5,0)
		wait(1.5)
		script.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.MaxTorque = Vector3.new (0,1,0)
		wait(1)
		script.Parent.FanClick.beep:Play()
		script.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.MaxTorque = Vector3.new (0,2.5,0)
		wait(1.5)
		script.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.MaxTorque = Vector3.new (0,1.25,0)
		wait(5)
		script.Parent.Parent.Fan.Light.PointLight.Brightness = 2
		wait(1)
		script.Parent.Parent.Fan.Light.PointLight.Brightness = 1
		wait(7)
		script.Parent.FanClick.beep:Play()
		script.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.MaxTorque = Vector3.new (0,2.5,0)
		wait(1.5)
		script.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.MaxTorque = Vector3.new (0,1.55,0)
		wait(1)
		script.Parent.FanClick.beep:Play()
		script.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.MaxTorque = Vector3.new (0,2.5,0)
		wait(1.5)
		script.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.MaxTorque = Vector3.new (0,2,0)
		wait(1)
		script.Parent.FanClick.beep:Play()
		script.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.MaxTorque = Vector3.new (0,2.5,0)
		wait(4.8)
		script.Parent.FanClick.beep:Play()
		script.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.AngularVelocity = Vector3.new(0,100,0)
		wait(15.6)
		script.Parent.FanClick.beep:Play()
		script.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.AngularVelocity = Vector3.new(0,-100,0)
		wait(4.7)
		script.Parent.FanClick.beep:Play()
		script.Parent.Parent.Fan.Motorset.Motor.BodyAngularVelocity.MaxTorque = Vector3.new(0,0,0)
		wait(4.5)
		script.Parent.Parent.Fan.Light.Material = "SmoothPlastic"
		script.Parent.Parent.Fan.Light.PointLight.Enabled = false
		script.Parent.Parent.Fan.Light.PointLight.Brightness = 0
		script.Parent.Demo.Value = 0
		script.Parent.Speed.Value = 0
		script.Parent.Light.Value = 1
	end
end)