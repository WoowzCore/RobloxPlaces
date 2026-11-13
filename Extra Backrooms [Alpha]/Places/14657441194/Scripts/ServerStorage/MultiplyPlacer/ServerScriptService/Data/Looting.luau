local interact = script.Parent
local looted = false
local timer = 0
local settimer = 3000
local EBL = require(game:GetService("ServerScriptService"):WaitForChild("EBLibbary"))

local part = interact.Parent
part.Transparency = 1
part.Size = Vector3.new(0.001,0.001,0.001)

interact.Sound.Volume = 0.5

interact.Triggered:Connect(function(plr)
	if not looted then
		looted = true
		settimer = 5000 + math.random(0,2000)
		timer = 0
		EBL.Looting(interact.Type.Value,interact.Parent)
		interact.Enabled = false
		interact.Parent.CanCollide = false
		interact.Sound:Play()
	end
end)

while wait() do
	if looted then
		timer += 1
		if timer >= settimer then
			looted = false
			interact.Enabled = true
			interact.Parent.CanCollide = true
		end
	end
end