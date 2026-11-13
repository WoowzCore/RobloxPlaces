local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

game:GetService("RunService").RenderStepped:Connect(function(dt)
	if hum.Health <= 0 then
		script.Parent.ImageTransparency = 0
	else
		script.Parent.ImageTransparency = 1
	end
end)