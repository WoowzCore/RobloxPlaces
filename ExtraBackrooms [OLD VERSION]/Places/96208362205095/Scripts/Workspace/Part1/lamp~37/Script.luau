local lamp = script.Parent

local speed = 1
while true do
	for i = 0,1,0.001*speed do
		local col = Color3.fromHSV(i,1,1)
		lamp.SurfaceLight.Color = col
		lamp.Part.PointLight.Color = col
		wait()
	end
end