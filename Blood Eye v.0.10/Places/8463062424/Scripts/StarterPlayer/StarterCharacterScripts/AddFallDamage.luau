function fallDamage(entrant)
	if game.Players:findFirstChild(entrant.Name) then --Finds whether or not the added child is a player
		wait(1) --Makes sure the player doesn't take damage just from spawning in
		fallDmg = script.FallDamage:clone()
		fallDmg.Disabled = false
		fallDmg.Parent = entrant
	end
end

game.Workspace.ChildAdded:connect(fallDamage)