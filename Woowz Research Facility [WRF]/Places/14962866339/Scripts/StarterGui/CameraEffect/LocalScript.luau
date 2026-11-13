wait(5)
local grain = script.Parent.grain
local light = game:GetService("Lighting")

local changedbool = false
local oldambientlight = light.Ambient

while wait() do
	if script.Parent.Enabled ~= changedbool then
		if script.Parent.Enabled then
			light.Ambient = Color3.fromRGB(23, 40, 29)
		else
			light.Ambient = oldambientlight
		end
		changedbool = script.Parent.Enabled
	end
	
	light.CameraBlur.Enabled = script.Parent.Enabled
	light.CameraColorCorrection.Enabled = script.Parent.Enabled
	light.CameraBloom.Enabled = script.Parent.Enabled
	
	if script.Parent.Enabled then
		grain.TileSize = UDim2.new(math.random(70,130)/100,0,math.random(70,130)/100,0)
	end
end