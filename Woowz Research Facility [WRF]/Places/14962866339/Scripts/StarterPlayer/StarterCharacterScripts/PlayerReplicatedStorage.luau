local rs = game:GetService("ReplicatedStorage")
local base = require(script.Parent.PlayerBase)

rs.Player.Tinnitus.OnClientEvent:Connect(function(t:number)
	if base.Parts then
		if base.Parts.Head then
			base.Parts.Head:FindFirstChild("Tinnitus").Volume = t/10
		end
	end
end)