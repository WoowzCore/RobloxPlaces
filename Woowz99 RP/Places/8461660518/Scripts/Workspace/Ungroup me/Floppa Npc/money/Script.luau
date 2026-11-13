local Cash = workspace.Cash.Cash.Cash
script.Parent.Touched:Connect(function(player)
	if (player.Parent:FindFirstChild("Humanoid") ~= nil and player.Parent:FindFirstChild("Floppa") == nil) then
		local sound = Instance.new("Sound", script.Parent)
		sound.SoundId = "rbxassetid://4525871712"
		sound:Play()
		Cash.Value = Cash.Value + 1
		script.Parent.Transparency = 1
		script.Parent.CanCollide = false
		script.Parent.Anchored = true
		script.Disabled = true
		wait(sound.TimeLength)
		sound:remove()
		script.Parent:remove()
	end
end)