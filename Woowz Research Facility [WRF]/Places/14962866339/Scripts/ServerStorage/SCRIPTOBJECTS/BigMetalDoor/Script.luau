local door = script.Parent.BigMetalDoorPetla.Weld

local base = require(game:GetService("ServerScriptService").Base)

local active = false

local otheractive = {}

local waitingdooropen = false
local dooropen = false

wait(0.1)
for _, part in pairs(script.Parent.Parent:GetDescendants()) do
	if part.Name == "ActivateOther" then
		table.insert(otheractive,part)
	end
end

local function ChangeDoorState(bool)
	if waitingdooropen then return end
	if dooropen == active then return end
	waitingdooropen = true
	
	local rot = 0
	if bool then
		rot = 100
	end
	
	base.ShakeCamera(script.Parent.BigMetalDoorBASE,10,30,10,true)
	base.ts(door,TweenInfo.new(10),{C0 = CFrame.new(0,0,0) * CFrame.Angles(math.rad(rot),0,0)})
	wait(10)
	
	dooropen = bool
	wait(5)
	waitingdooropen = false
end

while wait() do
	
	local a = false
	for _, act in pairs(otheractive) do
		if act.Value == true then
			a = true
		end
	end
	
	if active ~= a then
		active = a
	end
	
	ChangeDoorState(active)
end