local lamp = script.Parent

local speed = 1
while true do
	for i = 0,1,0.001*speed do
		local col = Color3.fromHSV(i,1,1)
		lamp.SurfaceLight.Color = col
		lamp.G.PointLight.Color = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
		lamp.G3.PointLight.Color = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
		lamp.G2.PointLight.Color = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
		wait()
	end
end