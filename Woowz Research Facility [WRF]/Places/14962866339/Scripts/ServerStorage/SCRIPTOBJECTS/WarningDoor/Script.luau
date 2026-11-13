local activated = true
local cframe = script.Parent.door_warning.CFrame
local base = require(game:GetService("ServerScriptService").Base)
local waiting = false

local dooropents = nil

local function DoorActive()
	if waiting then return end
	waiting = true
	activated = script.Parent.Active.Value
	if activated then
		dooropents = base.ts(script.Parent.door_warning,TweenInfo.new(20),{Position = Vector3.new(cframe.p.x,cframe.p.y,cframe.p.z)})
		
		local i = 0
		while i < 20 do
			if script.Parent.Active.Value then wait(1) end
			i += 1
		end
		waiting = false
	else
		if dooropents then dooropents:Remove() end
		base.ts(script.Parent.door_warning,TweenInfo.new(1,Enum.EasingStyle.Bounce),{Position = Vector3.new(cframe.p.x,cframe.p.y-6.9,cframe.p.z)})
		wait(1)
		waiting = false
	end
end

while wait() do
	if script.Parent.Active.Value ~= activated then
		DoorActive()
	end	
end
