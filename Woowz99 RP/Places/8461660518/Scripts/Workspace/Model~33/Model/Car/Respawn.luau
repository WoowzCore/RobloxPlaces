z = script.Parent
backup = z:clone()

while true do
	wait(5)
	if z:FindFirstChild("Zombie") then
		if z.Zombie.Health == 0 then
			z:Remove()
			wait(4)
			backup.Parent = game.Workspace
			backup.Head:MakeJoints()
			backup.HumanoidRootPart:MakeJoints()
		end
	end
	if z == nil then
		wait(4)
		backup.Parent = game.Workspace
		backup.Head:MakeJoints()
		backup.HumanoidRootPart:MakeJoints()
	end
end