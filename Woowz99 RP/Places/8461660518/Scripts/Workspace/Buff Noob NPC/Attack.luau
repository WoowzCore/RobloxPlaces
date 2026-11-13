local rarm = script.Parent:FindFirstChild("Right Arm")
local larm = script.Parent:FindFirstChild("Left Arm")
local Trso = script.Parent:FindFirstChild("Torso") 
function dmg(hit)
	if hit.Parent ~= nil then
		local hum = hit.Parent:findFirstChild("Humanoid")
		if hum ~= nil then
			hum.Health = hum.Health -10
		end
	end
end
 
rarm.Touched:connect(dmg)
larm.Touched:connect(dmg)
