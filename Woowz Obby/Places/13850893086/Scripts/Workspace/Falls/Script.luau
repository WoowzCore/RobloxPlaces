local part = script.Parent

local function explodePart(Hit)
	if part.Anchored == false and Hit.name == "Checkpoint" then
		local explosion = Instance.new("Explosion")
		explosion.Position = part.Position
		explosion.Parent = part
		explosion.BlastPressure = 0
		explosion.DestroyJointRadiusPercent = 0
		explosion.BlastRadius = 500
		explosion.BlastPressure = 500
	end
end

part.Touched:Connect(explodePart)