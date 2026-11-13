local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local rootPart = char:WaitForChild("HumanoidRootPart")
local Sounds = game:GetService("SoundService")
local Data = require(script.Parent:WaitForChild("Data"))

local Light = game.Lighting

local PlayerPosition = rootPart.Position

local function upd()
	local y = -73.49	
	if PlayerPosition.Y < y then
		Sounds.AmbientReverb = Enum.ReverbType.ConcertHall
	else
		Sounds.AmbientReverb = Enum.ReverbType.NoReverb
	end
	local t = math.min(1,( 1-math.min(y,PlayerPosition.Y)/y )*(-3.472))
	Light.Atmosphere.Density = 0.299 - t * 0.299
	Light.ClockTime = 13.4 - t * 13.4
end

game:GetService("RunService").RenderStepped:Connect(function(dt)
	PlayerPosition = rootPart.Position
	upd()
end)