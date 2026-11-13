local currentTween = nil 
local bar = script.Parent.Bar 
local plr = game.Players.LocalPlayer 
local p = script.Parent.HealthNum 
local char = plr.Character or plr.CharacterAdded:Wait() 
local ts = game:GetService("TweenService") 
local hum = char:WaitForChild("Humanoid") 

function TweenTo(alpha) 
	if currentTween then
		currentTween:Pause() 
	end 
	currentTween = ts:Create(
		bar,
		TweenInfo.new(
			.2
		),
		{Size = UDim2.fromScale(alpha,1)} 
	)
	currentTween:Play()
end

hum.HealthChanged:Connect(function() 
	TweenTo(hum.Health/hum.MaxHealth) 
	p.Text = math.round(hum.Health/hum.MaxHealth*100)  .. "%"; 
	bar.BackgroundColor3 = Color3.fromHSV((hum.Health/hum.MaxHealth)*.3, 1, 1) 
end)