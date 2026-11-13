local FF = script.Parent

local function steppedOn(part)
	local parent = part.Parent
	if game.Players:GetPlayerFromCharacter(parent) then
		parent.Humanoid.Sit = true
	end
end 

FF.Touched:connect(steppedOn)