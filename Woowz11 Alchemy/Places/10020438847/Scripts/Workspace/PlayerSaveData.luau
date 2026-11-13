local Players = game:GetService("Players")
local datastor = game:GetService("DataStoreService")
local mydatastor = datastor:GetDataStore("mydatastor")

function PlayerJoin(player)
	local player_id = "Player_"..player.UserId
	local data = mydatastor:GetAsync(player_id)

	local Data_Elements = data["elements"]
	print(Data_Elements)
	
	local New_pl_data = Instance.new("Folder",player)
	New_pl_data.Name = "Saved_Elements"
	
	for _, id in pairs(Data_Elements) do
		local new_id = Instance.new("StringValue",New_pl_data)
		new_id.Name = id
		new_id.Value = id
	end
end

function PlayerExit(player)
	local player_id = "Player_"..player.UserId
	local data = mydatastor:GetAsync(player_id)

	local New_Data = {
		elements = {};
	}
	for _, id in pairs(player.Saved_Elements:GetChildren()) do
		print(id.Name)
		table.insert(New_Data.elements,id.Name)
	end

	local success, err = pcall(function()
		mydatastor:SetAsync(player_id,New_Data)
	end)

	if success then
		print(New_Data.elements)
	else
		print("DATA SAVED ERROR!")
	end

end

Players.PlayerAdded:Connect(PlayerJoin)


Players.PlayerRemoving:Connect(PlayerExit)
