local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
local Human = character:WaitForChild("Humanoid")
local HealthFrame=script.Parent.StatsFrame.HealthFrame
local HealthText=HealthFrame.HealthNum
local StaminaFrame=script.Parent.StatsFrame.StaminaFrame
local StaminaText=StaminaFrame.StaminaNum
local TweenManage = game:GetService("TweenService")
	
while true do
	wait(0.01)
	HealthText.Text = math.floor(Human.Health).."%"
	if character:FindFirstChild("Stamina") then
		StaminaText.Text = math.floor(character.Stamina.Value).."%"
	end
end
