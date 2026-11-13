local plr = game:GetService("Players").LocalPlayer
local m = require(plr.PlayerScripts.Scripts.GameManager)

script.Parent.PlayButton.MouseButton1Click:Connect(function()
	
	script.Parent.Enabled = false
	m.StartGame()
	
end)