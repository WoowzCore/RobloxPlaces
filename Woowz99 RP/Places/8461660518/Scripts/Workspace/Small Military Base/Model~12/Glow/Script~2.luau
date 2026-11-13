

while wait(0.25) do
	--script.Parent.Transparency = 0
	if script.Parent.On.Value == true then
		script.Parent.PointLight.Enabled = true
	script.Parent.PointLight.Range = 10
	script.Parent.Transparency = 0.1
	wait(0.1)
		script.Parent.PointLight.Range = 9.5
	script.Parent.Transparency = 0.2
		script.Parent.PointLight.Range = 9.3
	wait(0.1)
	script.Parent.Transparency = 0.3
		script.Parent.PointLight.Range = 9.5
	wait(0.1)
		script.Parent.PointLight.Range = 9.3	
	script.Parent.Transparency = 0.2
	
	wait(0.1)
		script.Parent.PointLight.Range = 9.5
	script.Parent.Transparency = 0.1
	wait(0.1)
		script.Parent.PointLight.Range = 10
	--script.Parent.Transparency = 0
	else script.Parent.Transparency = 1
		 script.Parent.PointLight.Enabled = false
		end
	
end
