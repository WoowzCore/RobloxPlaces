local Light = script.Parent

while true do
	wait()
	if script.Parent.BeaconValue.Value == true then
		Light.Beacon1.PointLight.Enabled = true
		Light.Beacon1.Red.Enabled = true
		Light.Beacon1.Material = Enum.Material.Neon
		Light.Beacon2.PointLight.Enabled = true
		Light.Beacon2.Red.Enabled = true
		Light.Beacon2.Material = Enum.Material.Neon
		wait(0.5)
		Light.Beacon1.PointLight.Enabled = false
		Light.Beacon1.Red.Enabled = false
		Light.Beacon1.Material = Enum.Material.Glass
		Light.Beacon2.PointLight.Enabled = false
		Light.Beacon2.Red.Enabled = false
		Light.Beacon2.Material = Enum.Material.Glass
		wait(1.5)
	else
		Light.Beacon1.PointLight.Enabled = false
		Light.Beacon1.Red.Enabled = false
		Light.Beacon1.Material = Enum.Material.Glass
		Light.Beacon2.PointLight.Enabled = false
		Light.Beacon2.Red.Enabled = false
		Light.Beacon2.Material = Enum.Material.Glass
	end
end