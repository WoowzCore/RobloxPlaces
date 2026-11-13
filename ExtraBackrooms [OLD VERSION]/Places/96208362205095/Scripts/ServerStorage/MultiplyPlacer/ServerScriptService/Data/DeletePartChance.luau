local chance = script.Parent
local part = script.Parent.Parent
local savetransparency = script.Parent.Parent:FindFirstChild("TransparencySave")

if math.random(0,100) <= chance.Value then
	part:Destroy()
else
	if savetransparency then
		if savetransparency.Value == false then
			part.Transparency = 0	
		end
	else
		part.Transparency = 0
	end
	part.CastShadow = true
end