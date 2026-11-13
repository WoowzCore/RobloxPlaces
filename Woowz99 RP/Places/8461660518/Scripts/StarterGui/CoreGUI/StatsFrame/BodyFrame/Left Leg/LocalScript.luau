local char = game.Players.LocalPlayer.Character
local ts = game:GetService("TweenService")


while wait() do
	if char:FindFirstChild("Left Leg") == nil then
		script.Parent.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end