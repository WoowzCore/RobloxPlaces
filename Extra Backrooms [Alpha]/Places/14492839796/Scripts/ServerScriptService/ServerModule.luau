local ss = game:GetService("ServerStorage")
local rs = game:GetService("ReplicatedStorage")

local m = {}

m.CreatePlayerCharacter = function(plr)
	local char = ss.PlayerModel:Clone()
	char.Parent = workspace.Other.Players
	char.Name = plr.Name
	
	plr.Character = char.PlayerModel
	
	rs.InstallPlayerData:FireClient(plr)
	
	for _, part in pairs(plr.Character:GetDescendants()) do
		if part:IsA("BasePart") then
			part:SetNetworkOwner(plr)
		end
	end
end

return m
