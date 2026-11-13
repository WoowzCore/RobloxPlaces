local gun = game.ServerStorage.AWP
local parent = script.Parent
respawnTimer = 5
pickedUp = false

parent.Touched:Connect(function(hit)
	if pickedUp then return end
	if hit.Parent then
        local player = game.Players:GetPlayerFromCharacter(hit.Parent);
		print(player)
	    if player then
	    	gun:Clone().Parent = player.Backpack
		
			pickedUp = true
	
			wait(respawnTimer)
			pickedUp = false
		end
	end
end)

function SetTransparency(value)
		
	
end