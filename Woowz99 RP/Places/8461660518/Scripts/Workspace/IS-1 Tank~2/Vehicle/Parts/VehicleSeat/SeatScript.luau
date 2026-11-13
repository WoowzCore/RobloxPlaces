seat=script.Parent

function ChildAdded(child)
	if child == seat.SeatWeld then
		char = child.Part1.Parent
		player = game.Players:getPlayerFromCharacter(char)
		if player then
			
			local obj = player:findFirstChild("Turret")
			if obj then
				obj:remove()
			end
			
			script.Parent.TankGUI:clone().Parent = player.PlayerGui;
			
			local tur = Instance.new("ObjectValue")
			tur.Name = "Turret"
			tur.Value = seat.Parent
			tur.Parent = player
			
			seat.Tank:clone().Parent = player.Backpack
		end
	end
end

function ChildRemoved(child)
	char = child.Part1.Parent
	player = game.Players:getPlayerFromCharacter(char)
	if player then
		local gui = player.PlayerGui:findFirstChild("TankGUI")
		if gui then
			gui:remove()
		end
		
		local tool = player.Backpack:findFirstChild("Tank")
		if tool then
			tool:remove()
		end
		
		local obj = player:findFirstChild("Turret")
		if obj then
			obj:remove()
		end
	end
end

seat.ChildAdded:connect(ChildAdded)
seat.ChildRemoved:connect(ChildRemoved)