local hum = script.Parent.Humanoid

local enabled = true
local oldHP = hum.Health
function OnHP(hp)
	if enabled == false then return end
	local dmg = oldHP - hp
	if dmg >=3 and hum.Health > 0 then
		enabled = false
		for i = 1, 2 do
			local copy = game.Lighting.headblood:Clone()
			copy.Position = script.Parent.Torso.Position + Vector3.new(0,1.5,0)
			copy.Parent = workspace.ignore
			wait(0.1)
		end

	end
	wait(0.5)
	oldHP = hum.Health
	enabled = true
end
hum.HealthChanged:connect(OnHP)