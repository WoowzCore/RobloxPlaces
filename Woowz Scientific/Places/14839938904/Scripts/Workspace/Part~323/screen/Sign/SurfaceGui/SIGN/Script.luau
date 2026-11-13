while wait() do
	if script.Parent.Parent.Parent.Parent.Parent.screenlight.PointLight.Brightness ~= 0 then
		local i2 = math.random(-5,5)
		script.Parent.TextColor3 = Color3.fromRGB(190+i2*2,190+i2*2,190+i2*2)
		local c = script.Parent.Parent.Parent.Parent.Value.Value
		script.Parent.Parent.Parent.Parent.Color = Color3.fromRGB(math.min(c.R*255 + i2,255), math.min(c.G*255 + i2,255), math.min(c.B*255 + i2,255))
		script.Parent.Parent.Parent.Parent.Parent.screenlight.PointLight.Color = Color3.fromRGB(c.R*255 + i2, c.G*255 + i2, c.B*255 + i2)
	end
end