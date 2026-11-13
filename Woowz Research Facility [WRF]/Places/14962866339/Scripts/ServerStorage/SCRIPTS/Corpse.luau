local hum = script.Parent:WaitForChild("Humanoid")
hum.Health = 1
wait(1)
hum.Health = 0
while wait(1) do
	if hum then
		hum:ChangeState(Enum.HumanoidStateType.Physics)
	end
end