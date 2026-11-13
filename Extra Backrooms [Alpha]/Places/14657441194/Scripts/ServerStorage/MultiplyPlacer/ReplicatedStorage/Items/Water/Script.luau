local basa = require(game.ServerScriptService:WaitForChild("EBLibbary"))
local tool = script.Parent
local drinked = tool.Empty.Value
local EBL = require(game.ServerScriptService:WaitForChild("EBLibbary"))

local function Drink()
	drinked = true
	tool.Drink:Play()
	local player = game:GetService("Players"):GetPlayerFromCharacter(tool.Parent)
	EBL.ChangeStat(player,"Water",false,250)
	tool.Empty.Value = true
end

script.Parent.Activated:Connect(function()
	if not drinked then
		Drink()
	end
end)