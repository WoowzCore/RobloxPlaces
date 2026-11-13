local RS = game:GetService("ReplicatedStorage")
local lighting = true

RS.ADMINchangeLighting.OnClientEvent:Connect(function(bool)
	if bool == nil then
		bool = not lighting
	end
	lighting = bool
	if bool then
		game:GetService("Lighting").Ambient = Color3.fromRGB(0,0,0)
	else
		game:GetService("Lighting").Ambient = Color3.fromRGB(255,255,255)
	end
end)