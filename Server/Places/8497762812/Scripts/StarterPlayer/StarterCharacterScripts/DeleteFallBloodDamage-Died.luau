local character = script.Parent
character.Humanoid.Died:connect(function()
	wait(1)
	character.FallDamageWithBlood:Destroy()
	
end)
