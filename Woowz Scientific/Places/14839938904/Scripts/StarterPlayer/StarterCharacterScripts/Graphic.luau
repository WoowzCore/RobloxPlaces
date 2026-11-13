local plr = game.Players.LocalPlayer
local basa = require(plr:WaitForChild("PlayerScripts"):WaitForChild("PlayerBasa"))

local light = game.Lighting
local soundser = game.SoundService

local function SetYGraphic(y)
	light.OutdoorAmbient = Color3.fromRGB(89*y,97*y,103*y)
	light.Atmosphere.Density = 0.3*y
end

game:GetService("RunService").RenderStepped:Connect(function(dt)
	if basa.Character then
		local y = basa.RootPart.Position.Y
		local y_ = math.min(-5.5,y)
		y_ = math.max(y_,-300)
		y_ = math.abs(y_)
		y_ = y_ - 5.5
		SetYGraphic(1-y_/(300-5.5))
		
		if y <= -100 then
			light.ClockTime = 0
		else
			light.ClockTime = 11.1
		end
		
		if y <= -1769 then
			soundser.AmbientReverb = Enum.ReverbType.ConcertHall
		else
			soundser.AmbientReverb = Enum.ReverbType.NoReverb
		end
	end
end)