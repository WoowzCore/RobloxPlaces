local car = script.Parent.Parent.Car.Value
local light=0
local RGear = script.Parent.Parent.Values.Gear

script.Parent.Parent.Values.Gear.Changed:connect(function()
		for i,v in pairs(car.Body.ReverseLights:GetChildren()) do
		if v.Name=="V" then
			if RGear.Value<0 then
				v.Light.Brightness=1
				v.Light.Range=2
			else
				v.Light.Brightness=0
				v.Light.Range=0
			end
			if RGear.Value<0 then
				v.Material=Enum.Material.Neon
			else
				v.Material=Enum.Material.SmoothPlastic
			end
		end
	end
end)