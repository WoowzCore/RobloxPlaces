function newSound(id)
	local sound = Instance.new("Sound", script.Parent.Torso)
	sound.SoundId = id
	return sound
end

Debounce = true

script.Parent.Torso.ClickDetector.MouseClick:Connect(function()
	if Debounce == true then
		Debounce = false
		local meow = newSound("rbxassetid://8772968188")
		local money = script.Parent.money:Clone()
		money.Parent = workspace
		money.Script.Disabled = false
		money.Money:Destroy()
		money.CFrame = script.Parent.Torso.CFrame * CFrame.new(0, 0, 2)
		meow:Play()
		wait(meow.TimeLength * 2)
		meow:Destroy()
		Debounce = true
	end
end)

local Humanoid = script.Parent.Humanoid

while wait(math.random(3, 5)) do
	Humanoid:MoveTo(script.Parent.Torso.Position + Vector3.new(math.random(-11, 11), 0, math.random(-11, 11)))
end