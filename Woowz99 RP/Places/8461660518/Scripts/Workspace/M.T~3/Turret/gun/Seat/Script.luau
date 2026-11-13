
function powers()
	if script.Parent.Occupant~= nil then
		local a = script.Parent.Occupant
		local b = game.Players:GetPlayerFromCharacter(a.Parent)
		if b~= nil then
			if a.Parent:findFirstChild("control") == nil then
			g=script.control:Clone()
			g.Value.Value=script.Parent.Parent.Parent
			g.Parent=b.Character
			g.Disabled=false
			end
		end
	end
end
script.Parent.Changed:connect(powers)