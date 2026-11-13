local obj = script.Parent

local speed = 1
while true do
	for i = 0,1,0.001*speed do
		obj.Color = Color3.fromHSV(i,1,1)
		wait()
	end
end