local atmosphere = game:GetService("Lighting").Atmosphere

local FogMultiply = 250
local FogMaxY = 150

local function UpdateAtmosphere(y)
	local result = 0

	if y < FogMaxY then
		result = (FogMaxY - y)/FogMultiply
	end
	
	atmosphere.Density = result
end

atmosphere.Density = 0
while wait() do
	UpdateAtmosphere(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position.Y)
end