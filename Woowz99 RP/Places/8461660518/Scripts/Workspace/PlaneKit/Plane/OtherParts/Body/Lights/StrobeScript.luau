local Light = script.Parent

while true do
	wait()
	if script.Parent.StrobeValue.Value == true then
		Light.Strobe1.PointLight.Enabled = true
		Light.Strobe1.White.Enabled = true
		Light.Strobe1.Material = Enum.Material.Neon
		Light.Strobe2.PointLight.Enabled = true
		Light.Strobe2.White.Enabled = true
		Light.Strobe2.Material = Enum.Material.Neon
		Light.Strobe3.PointLight.Enabled = true
		Light.Strobe3.White.Enabled = true
		Light.Strobe3.Material = Enum.Material.Neon
		wait(0.05)
		Light.Strobe1.PointLight.Enabled = false
		Light.Strobe1.White.Enabled = false
		Light.Strobe1.Material = Enum.Material.Glass
		Light.Strobe2.PointLight.Enabled = false
		Light.Strobe2.White.Enabled = false
		Light.Strobe2.Material = Enum.Material.Glass
		Light.Strobe3.PointLight.Enabled = false
		Light.Strobe3.White.Enabled = false
		Light.Strobe3.Material = Enum.Material.Glass
		wait(1)
	else
		Light.Strobe1.PointLight.Enabled = false
		Light.Strobe1.White.Enabled = false
		Light.Strobe1.Material = Enum.Material.Glass
		Light.Strobe2.PointLight.Enabled = false
		Light.Strobe2.White.Enabled = false
		Light.Strobe2.Material = Enum.Material.Glass
		Light.Strobe3.PointLight.Enabled = false
		Light.Strobe3.White.Enabled = false
		Light.Strobe3.Material = Enum.Material.Glass
	end
end