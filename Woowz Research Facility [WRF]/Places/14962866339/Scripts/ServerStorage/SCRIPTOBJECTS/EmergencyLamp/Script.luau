local lamp = script.Parent
local sss = game:GetService("ServerScriptService").ServerInfo.Data.Emergency

local i = 0
local function change(bool)
	if bool then
		lamp.glass.PointLight.Enabled = true
		lamp.lamp.Material = Enum.Material.Neon
		lamp.glass.Sound:Play()
	else
		i = 0
		lamp.glass.PointLight.Enabled = false
		lamp.lamp.Color = Color3.new(115, 94, 94)
		lamp.lamp.Material = Enum.Material.Glass
		lamp.glass.Sound:Stop()
	end
end

local emergency = false
while wait() do
	if emergency ~= sss.Value then
		emergency = sss.Value
		change(emergency)
	end
	
	if emergency then
		i += 0.5
		local sin = (math.sin(i-(math.pi/2))+1)/2
		lamp.lamp.Color = Color3.fromRGB(sin*225+30,0,0)
		lamp.glass.PointLight.Brightness = sin*3.5
	end
end