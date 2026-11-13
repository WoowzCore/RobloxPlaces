local sp = script.Parent
local db = true
local Animations = script.Parent.Animations

sp.Touched:connect(function(hit)
	if hit and hit.Parent:findFirstChild("Humanoid") and db then 
		db = false
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if not player.PlayerGui:findFirstChild("Animations") then 
			Animations:Clone().Parent = player.PlayerGui
		
		end
		wait()
		db = true
	end
end)

		
		