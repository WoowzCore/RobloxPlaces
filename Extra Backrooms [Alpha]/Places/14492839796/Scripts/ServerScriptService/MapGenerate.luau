for _, part in pairs(game.Workspace:GetDescendants()) do
	if part:IsA("NumberValue") then
		if part.Name == "ChanceDelete" then
			if math.random(0,100)<part.Value then
				part.Parent:Destroy()
			else
				if part.Parent:IsA("BasePart") then
					part.Parent.Transparency = 0
					part.Parent.CastShadow = true
				end
				part:Destroy()
			end
		end
	end
end

local lig = game:GetService("Lighting")

lig.Ambient = Color3.new(0,0,0)
lig.DepthOfField.Enabled = true

print("Extrabackrooms map generated!")