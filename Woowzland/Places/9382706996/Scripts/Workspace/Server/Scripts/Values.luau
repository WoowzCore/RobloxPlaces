local Server = script.Parent.Parent

function GetPlayerFromID(playerID)
	local player = game:GetService("Players"):GetPlayerByUserId(playerID)
	if player then
		return player
	else
		return nil
	end
end

function CheckPlayerStatus(playerID)
	local PlayersStatus = Server.Data.Players_Status
	local NeedStatus = "None"
	for _, status in ipairs(PlayersStatus:GetChildren()) do
		if status.Value == playerID then
			NeedStatus = status.Name
		end
	end
	return NeedStatus
end

function CheckPlayer (PlayerID)
	local player = GetPlayerFromID(PlayerID)
	if player then
		
		if CheckPlayerStatus(PlayerID) == "Admin" then
			return true
		else
			return false
		end
		
	else
		print("Incorrect player id")
		return false
	end
end