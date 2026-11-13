local tool = script.Parent
local configs = require(tool.Configurations)
local flame = tool.Flame.ParticleEmitter
local light = tool.Glass.PointLight
local lit = false
local equipped = false

local lightMinRange = configs.lightRange - configs.lightRangeVariation
local lightMaxRange = configs.lightRange + configs.lightRangeVariation

light.Brightness = 0
light.Range = configs.lightRange
flame.Enabled = false

function lightFlicker()
	repeat
		light.Range = math.max(lightMinRange, math.min(lightMaxRange, light.Range + math.random(-2, 2)))
		wait()
	until not lit or not equipped
	print("done")
end

function increaseLight()
	repeat
		light.Brightness = math.min((light.Brightness + 0.05), configs.lightBrightness)
		wait()
	until not lit or light.Brightness >= configs.lightBrightness
	if lit and configs.lightFlickerEnabled == true then
		spawn(lightFlicker)
	end
end

tool.Equipped:Connect(function()
	equipped = true
	if lit then
		wait(0.1)
		flame.Enabled = true
		increaseLight()
	end
end)

tool.Activated:Connect(function()
	if lit then
		lit = false
		flame.Enabled = false
		light.Brightness = 0
	else
		lit = true
		flame.Enabled = true
		increaseLight()
	end
end)

tool.Unequipped:Connect(function()
	equipped = false
	light.Brightness = 0
	flame.Enabled = false
end)