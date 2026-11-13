local players = game:GetService("Players")
local StarterPlayerValues = game.Scene.Main.StarterPlayerValues

players.PlayerAdded:Connect(function(player)

	local PlayerValues = StarterPlayerValues:Clone()
	PlayerValues.Name = "PlayerValues"
	PlayerValues.Parent = player
	
	local InventoryItems = Instance.new("Folder",game.Scene.Main.Inventorys)
	InventoryItems.Name = player.UserId.."_Inventory"
	
	player.CharacterAdded:Connect(function(ch)
		
		local RS = game.RStorage

		RS.MakeThisHumanoidHuman:Fire(player)
		
	end)
	
end)

players.PlayerRemoving:Connect(function(player)

	local PlayerValues = script.Parent:WaitForChild(player.UserId)
	if PlayerValues then
		PlayerValues:Destroy()
	else
		warn(player.Name.." Not Have Player Values")
	end
	
	local InventoryItems = game.Scene.Main.Inventorys:WaitForChild(player.UserId.."_Inventory")
	if InventoryItems then
		InventoryItems:Destroy()
	else
		warn("Player not have inventorys!")
	end

end)

game.RStorage.SetPlayerValue.OnServerEvent:Connect(function(player,name,val)
	--if name:IsA(string) then
	local value = player:WaitForChild("PlayerValues"):WaitForChild(name)
	value.Value = val
	--else
	--	warn("Value name it is not string! this [".. tostring(typeof(name)).."], player this ["..tostring(player) .. "] and value [".. tostring(val).."]")
	--end
end)

