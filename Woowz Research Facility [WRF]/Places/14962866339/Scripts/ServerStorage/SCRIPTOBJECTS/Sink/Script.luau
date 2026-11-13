local sink = script.Parent
local base = require(game:GetService("ServerScriptService").Base)

local work = false
local waiting = false

local function onoff(bool)
	if waiting then return end
	waiting = true
	work = bool
	if work then
		base.ts(sink.sink_handle_base.Weld,TweenInfo.new(0.4),{C1 = CFrame.Angles(0,0,math.rad(-10))})
		sink.sink_handle.water:Play()
	else
		base.ts(sink.sink_handle_base.Weld,TweenInfo.new(0.4),{C1 = CFrame.new()})
		sink.sink_handle.water:Stop()
	end
	wait(0.4)
	sink.TopHole.Beam.Enabled = work
	sink.Particle.ParticleEmitter.Enabled = work
	sink.LightBase.PointLight.Enabled = work
	if work then
		sink.LightBase.Material = Enum.Material.Neon
		sink.LightBase.Color = Color3.fromRGB(170, 170, 170)
	else
		sink.LightBase.Material = Enum.Material.Glass
		sink.LightBase.Color = Color3.fromRGB(72, 72, 72)
	end
	
	waiting = false
end

sink.sink_handle.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
	onoff(not work)
end)
