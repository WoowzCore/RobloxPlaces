local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local rootPart = char:WaitForChild("HumanoidRootPart")
local EBL = require(script.Parent:WaitForChild("EBLibbary"))
local Data = require(script.Parent.Data)
local Sounds = game:GetService("SoundService").Basa

local Light = game.Lighting

local CC = Light.ColorCorrection
local PlayerPosition = rootPart.Position

local eyes = char:WaitForChild("Head"):WaitForChild("Eyes",60)

local health = 0
local stamina = 0
local mental = 0
local water = 0
local food = 0
local function Survival()
	health = hum.Health / hum.MaxHealth
	stamina = EBL.GetStats("Stamina")/1000
	mental = EBL.GetStats("Mental")/1000
	water = EBL.GetStats("Water")/1000
	food = EBL.GetStats("Food")/1000
end

local function UpdateGraphic()
	CC.Saturation = math.max(-1,Data.Graphic["Saturation"] - (1-health) - ((1-water)/2) - ((1-food)/2) + (1-mental))
	CC.Brightness = (-(1-stamina))/4
	eyes.Brightness = 0.07 + ((1-stamina)/4)
	Sounds.LowMental.Enabled = (mental <= 0.1)
end

game:GetService("RunService").RenderStepped:Connect(function(dt)
	PlayerPosition = rootPart.Position
	Survival()
	
	UpdateGraphic()
end)

game:GetService("ReplicatedStorage").GetGraphic.OnClientInvoke  = function()
	return #plr.PlayerScripts:GetDescendants()
end