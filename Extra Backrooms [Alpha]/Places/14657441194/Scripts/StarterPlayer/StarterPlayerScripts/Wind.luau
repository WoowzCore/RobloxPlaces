local w = game.Workspace

local timer = 0
local timer2 = 0
game:GetService("RunService").RenderStepped:Connect(function(dt)
	timer += 1
	timer2 += 0.3
	local wind = ( math.sin(timer/1000) * (30 * ((1+math.sin(timer2/200))*5)) )/3
	w.GlobalWind = Vector3.new(0.1 * wind,0,0.07 * wind)
end)