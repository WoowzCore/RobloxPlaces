local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Humanoid = script.Parent.Parent:FindFirstChild("Humanoid")
local Remotes = script.Parent:WaitForChild("Remotes")
local BanWave = Remotes.BanWave
Mouse.KeyDown:connect(function(Key)
	Key = Key:lower()
	if Key == 'z' then
		BanWave:FireServer()
	elseif Key == 'x' then
		Humanoid.WalkSpeed = 200
		Humanoid.JumpPower = 100
	end
end)