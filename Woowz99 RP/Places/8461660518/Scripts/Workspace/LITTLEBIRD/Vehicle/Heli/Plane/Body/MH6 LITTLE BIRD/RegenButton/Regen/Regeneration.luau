local kit = script.Parent.Parent.Parent
local save = kit:clone()
local detector = script.Parent:WaitForChild('ClickDetector')
local canRegen = script.Parent:WaitForChild('CanRegen')
kit:WaitForChild('Required'):WaitForChild('DriverSeat'):WaitForChild('Heli_SControl').Disabled = false

detector.MouseClick:connect(function(player)
	if canRegen.Value == true then
		save.Parent = workspace
		kit:Destroy()
		kit = save
		kit:WaitForChild('Required'):WaitForChild('DriverSeat'):WaitForChild('Heli_SControl').Disabled = false
	end
end)
