local hum = script.Parent.Humanoid
local blood = game.Lighting.headblood

local function Dead()
	blood.Position = script.Parent.Torso.Position
	blood:Clone().Parent = script.Parent.Torso
	wait(.5)
	blood.Position = script.Parent.Torso.Position
	blood:Clone().Parent = script.Parent.Torso
	wait(.5)
	blood.Position = script.Parent.Torso.Position
	blood:Clone().Parent = script.Parent.Torso
	wait(.5)
	blood.Position = script.Parent.Torso.Position
	blood:Clone().Parent = script.Parent.Torso
	wait(.5)
	blood.Position = script.Parent.Torso.Position
	blood:Clone().Parent = script.Parent.Torso
	wait(.5)
	blood.Position = script.Parent.Torso.Position
	blood:Clone().Parent = script.Parent.Torso
	wait(.5)
end

hum.Died:Connect(Dead)