local EntitySpawner = script.Parent
local typ = EntitySpawner.Type.Value
local EBL = require(game:GetService("ServerScriptService"):WaitForChild("EBLibbary"))

local entities = EBL.Entites[typ]

EntitySpawner.Transparency = 1

local spawnchance = 50

if EntitySpawner:FindFirstChild("Randomization") then
	spawnchance = EntitySpawner.Randomization.Value
end

local entity = nil
if math.random(0,100) >= (100-spawnchance) then
	entity = EBL.FullSpawnEntity(entities[math.random(1,#entities)],EntitySpawner.Position)
end