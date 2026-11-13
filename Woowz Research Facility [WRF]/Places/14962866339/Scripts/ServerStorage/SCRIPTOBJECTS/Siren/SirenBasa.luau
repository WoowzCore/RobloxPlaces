local base = require(game:GetService("ServerScriptService").Base)
base.SendSirensToPlayers()

script.Parent.Enabled:GetPropertyChangedSignal("Value"):Connect(function()
	base.SendSirensToPlayers()
end)

script.Parent.Destroying:Connect(function()
	base.SendSirensToPlayers()
end)