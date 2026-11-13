seat = script.Parent

function onSitUp(child, hopper)
	if child.Parent == nil then
		hopper.Parent = script
		hopper.Active = false
	end
end

function onChildAdded(part)
	if part.className == "Weld" then
		local torso = part.Part1
		if torso ~= nil then
			local char = torso.Parent
			local player = game.Players:GetPlayerFromCharacter(char)
			if player ~= nil then
				local hopper = script["GUN"]
				hopper.Parent = player.Backpack
				part.AncestryChanged:connect(function(child) onSitUp(child, hopper) end) 
			end
		end
	end
end

seat.ChildAdded:connect(onChildAdded)
-- Mark901