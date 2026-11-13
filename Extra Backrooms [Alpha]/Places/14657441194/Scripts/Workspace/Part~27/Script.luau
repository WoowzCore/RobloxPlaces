local EBL = require(game:GetService("ServerScriptService"):WaitForChild("EBLibbary"))
script.Parent.Touched:Connect(function(hit)
	if hit.Parent ~= nil then
		if hit.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
			local char = hit.Parent
			local plr = game:GetService("Players"):GetPlayerFromCharacter(char)
			EBL.TeleportPlayer(plr,"Level 0","hi")
		end
	end
end)