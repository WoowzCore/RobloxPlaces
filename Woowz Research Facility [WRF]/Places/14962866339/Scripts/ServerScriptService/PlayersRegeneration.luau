local plrs = game:GetService("Players")

while wait(1) do
	for _, plr in pairs(plrs:GetPlayers()) do
		local chr = plr.Character or plr.CharacterAdded:Wait()
		local hum = chr:WaitForChild("Humanoid")
		local regenpower = 1
		if hum.Health > 0 then
			for _2, part in pairs(chr:GetChildren()) do
				if part.Name == "Head" or part.Name == "Right Arm" or part.Name == "Left Arm" or part.Name == "Torso" or part.Name == "Right Leg" or part.Name == "Left Leg" then
					if math.random(0,100)>=75 then
						local health = part:FindFirstChild("Health")
						if health ~= nil then
							if health.Value ~= 0 then
								local healthmax = part:FindFirstChild("HealthMax")
								local result = health.Value + regenpower
								if result >= healthmax.Value then health = healthmax end
								health.Value = result
							end
						end
					end
				end
			end
		end
	end
end