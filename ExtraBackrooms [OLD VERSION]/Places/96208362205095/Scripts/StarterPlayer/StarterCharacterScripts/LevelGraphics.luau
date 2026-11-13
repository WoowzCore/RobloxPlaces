local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local rootPart = char:WaitForChild("HumanoidRootPart")
local Sounds = game:GetService("SoundService").Basa
local Data = require(script.Parent:WaitForChild("Data"))

local Light = game.Lighting

local CC = Light.ColorCorrection
local PlayerPosition = rootPart.Position

local eyes = char:WaitForChild("Head"):WaitForChild("Eyes",60)

local function LevelMinusOne()
	local grayscale = 0
	local graycenter = Vector3.new(-481.333, -1.046, -691.095)

	local grayradius = 421

	local grayx = math.abs(PlayerPosition.X - graycenter.X)
	local grayy = math.abs(PlayerPosition.Y - graycenter.Y)
	local grayz = math.abs(PlayerPosition.Z - graycenter.Z)

	if grayx < grayradius and grayy < grayradius and grayz < grayradius then
		grayscale = (math.max(grayx,grayy,grayz)/grayradius)-1
	end

	Data.Graphic["Saturation"] = grayscale
end

game:GetService("RunService").RenderStepped:Connect(function(dt)
	PlayerPosition = rootPart.Position
	LevelMinusOne()
end)