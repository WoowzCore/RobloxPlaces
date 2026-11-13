local player = game.Players.LocalPlayer

repeat wait() until player.Character and player.Character:FindFirstChild("Humanoid")

local hum = player.Character["Humanoid"]

hum.HealthChanged:connect(function(health)
	if health <= 0 then
		hum.Health = hum.MaxHealth
		player.Character:MakeJoints()
	end
end)