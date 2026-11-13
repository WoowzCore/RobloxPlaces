local base = require(game:GetService("ServerScriptService").Base)
local faststart = script.Parent:GetAttribute("FastStart")
local fastend = script.Parent:GetAttribute("FastEnd")

if script.Parent.Value == math.huge then return end

if faststart then
	if fastend then
		wait(script.Parent.Value)
	else
		base.ts(script.Parent,TweenInfo.new(script.Parent.Value),{Value = 0})
		wait(script.Parent.Value)
	end
else
	if fastend then
		local t = script.Parent.Value
		script.Parent.Value = 0
		base.ts(script.Parent,TweenInfo.new(script.Parent.Value),{Value = t})
		wait(t)
	else
		local t = script.Parent.Value
		script.Parent.Value = 0
		base.ts(script.Parent,TweenInfo.new(t/2),{Value = t})
		wait(t/2)
		base.ts(script.Parent,TweenInfo.new(t/2),{Value = 0})
		wait(t/2)
	end
end
script.Parent:Destroy()