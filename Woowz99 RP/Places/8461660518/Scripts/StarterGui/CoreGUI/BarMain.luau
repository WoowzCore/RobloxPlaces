local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
local Human = character:WaitForChild("Humanoid")
local Stamina = character:WaitForChild("Stamina")
local HealthFrame=script.Parent.StatsFrame.HealthFrame:WaitForChild("Bar")
local HealthFrame2=script.Parent.StatsFrame.HealthFrame:WaitForChild("Bar2")
local StaminaFrame=script.Parent.StatsFrame.StaminaFrame:WaitForChild("Bar")
local StaminaFrame2=script.Parent.StatsFrame.StaminaFrame:WaitForChild("Bar2")
Human:GetPropertyChangedSignal("Health"):connect(function()
	HealthFrame:TweenSize(UDim2.new(1 / Human.MaxHealth * Human.Health, 0,0.8, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.1)
	HealthFrame2:TweenSize(UDim2.new(1 / Human.MaxHealth * Human.Health, 0,0.8, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.4)
end)


Stamina.Changed:connect(function()
	StaminaFrame:TweenSize(UDim2.new(0.010 * Stamina.Value, 0, 0.8, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.1)
	StaminaFrame2:TweenSize(UDim2.new(0.010 * Stamina.Value, 0, 0.8, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.4)
end)

