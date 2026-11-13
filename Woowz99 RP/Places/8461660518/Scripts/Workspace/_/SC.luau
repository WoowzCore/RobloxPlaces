--// Made By Aetehel.

local NameYes="Humanoid"
local button = script.RespawnPart

robo=script.Parent:clone()

local de = false
script.RespawnPart.Touched:Connect(function(hit)
	if hit.Parent.Humanoid then
		if not de then
			de = true
			robo=robo:clone()
			robo.Parent=script.Parent.Parent
			robo:makeJoints()
			script.Parent:remove()
			wait(2)
			de = false
		end
	end
end)


