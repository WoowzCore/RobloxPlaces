local car = script.Parent.Parent.Car.Value
local GBrake = script.Parent.Parent.Values.Brake
local light=0

function Light(on)
	for i,v in pairs(car.Body.Lights:GetChildren()) do
		if v:FindFirstChild("Light")~=nil then
			v.Light.Enabled=on
		end
		if on then
			v.Material=Enum.Material.Neon
		else
			v.Material=Enum.Material.Metal
		end
		if v.Name=="FF" then
			if on then
				v.Transparency=0
				v.BrickColor = BrickColor.new("Institutional white")
			else
				v.Transparency=0
				v.BrickColor = BrickColor.new("Medium stone grey")
			end
		end
		if v.Name=="R_TL" or v.Name=="R_RL" or v.Name=="L_TL" or v.Name=="L_RL"then 
			v.Material=Enum.Material.Metal
			v.Light.Enabled=false
		end
	end
end

script.Parent.MouseButton1Click:connect(function()
	if light==1 then
		light=0
	else
		light=light+1
	end
	if light==1 then
		script.Parent.Text="Lights: On"
		Light(true)
	else
		script.Parent.Text="Lights: Off"
		Light(false)
	end
end)

script.Parent.Parent.Values.Brake.Changed:connect(function()
	for i,v in pairs(car.Body.Lights:GetChildren()) do
		if v.Name=="R" then
			if v.Light.Enabled then
				if GBrake.Value>0 then
					v.Light.Brightness=12
					v.Light.Range=15
				else
					v.Light.Brightness=8
					v.Light.Range=10
				end
			else
				v.Transparency=0
				if GBrake.Value>0 then
					v.Material=Enum.Material.Neon
				else
					v.Material=Enum.Material.Metal
				end
			end
		elseif v.Name=="RR" then
			if GBrake.Value>0 then
				v.Material=Enum.Material.Neon
			else
				v.Material=Enum.Material.SmoothPlastic
			end
		end
	end
end)
