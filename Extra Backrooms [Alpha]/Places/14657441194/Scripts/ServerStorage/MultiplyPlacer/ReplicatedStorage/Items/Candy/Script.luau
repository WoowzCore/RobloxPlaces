local basa = require(game.ServerScriptService.EBLibbary)
local tool = script.Parent
local EBL = require(game.ServerScriptService.EBLibbary)

local function Eat()
	local player = game:GetService("Players"):GetPlayerFromCharacter(tool.Parent)
	EBL.ChangeStat(player,"Water",false,-20)
	EBL.ChangeStat(player,"Food",false,50)
	EBL.ChangeStat(player,"IntoxicationA",false,10)
	EBL.ChangeStat(player,"Stamina",false,100)
	EBL.ChangeStat(player,"Mental",false,100)
	EBL.ChangeStat(player,"Health",false,50)
	tool:Destroy()
	EBL.PlaySound(player,"4604390759",0.5,nil,{6,0})
end

script.Parent.Activated:Connect(function()
	Eat()
end)