while true do
	if script.Parent.Parent.Parent.AMECOTouch.Light.Value == 0 then
		script.Parent.PointLight.Brightness = 0
		script.Parent.PointLight.Enabled = false
		script.Parent.Material = "SmoothPlastic"
	elseif script.Parent.Parent.Parent.AMECOTouch.Light.Value == 1 then
		script.Parent.PointLight.Brightness = 0
		script.Parent.PointLight.Enabled = false
		script.Parent.Material = "SmoothPlastic"
	elseif script.Parent.Parent.Parent.AMECOTouch.Light.Value == 2 then
		script.Parent.PointLight.Brightness = 1
		script.Parent.PointLight.Enabled = true
		script.Parent.Material = "Neon"
	elseif script.Parent.Parent.Parent.AMECOTouch.Light.Value == 3 then
		script.Parent.PointLight.Brightness = 2
		script.Parent.PointLight.Enabled = true
		script.Parent.Material = "Neon"
	elseif script.Parent.Parent.Parent.AMECOTouch.Light.Value == 4 then
		script.Parent.PointLight.Brightness = 3
		script.Parent.PointLight.Enabled = true
		script.Parent.Material = "Neon"
	end
	wait()
end