local plate = script.Parent.PressurePlate
local hinge = script.Parent.BodyUnion.HingeConstraint

plate.Touched:connect(function(obj)
	local humanoid = obj.Parent:FindFirstChildWhichIsA("Humanoid")
	if humanoid and humanoid.RootPart == obj then
		hinge.TargetAngle = -90
	end
end)

plate.TouchEnded:connect(function(obj)
	local humanoid = obj.Parent:FindFirstChildWhichIsA("Humanoid")
	if humanoid and humanoid.RootPart == obj then
		hinge.TargetAngle = 0
	end
end)