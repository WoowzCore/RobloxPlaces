local RS = game:GetService("ReplicatedStorage")
local basa = require(script.Parent.ServerBasa)

local function PlayerAdded(plr)
	plr:LoadCharacter()
	plr.CharacterAdded:Connect(function(char)
		char.Humanoid:ApplyDescription(game.Players:GetHumanoidDescriptionFromUserId(plr.UserId))
		wait(3)
		RS.PlayerScriptStart:FireClient(plr)
	end)
end

game.Players.PlayerAdded:Connect(PlayerAdded)
for _, player in ipairs(game.Players:GetPlayers()) do
	PlayerAdded(player)
end

while wait() do
	for _, plr in pairs(game.Players:GetPlayers()) do
		if plr ~= nil then
			local suc,err = pcall(function()
				local data = RS.GetPlayerData:InvokeClient(plr)
				if data ~= nil then
					RS.SetPlayerData:FireAllClients(data,plr)
				end
			end)
			if err then end
		end
	end
end