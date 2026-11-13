local basa = require(game.ServerScriptService.EBLibbary)
local tool = script.Parent
local EBL = require(game.ServerScriptService.EBLibbary)

local function Eat()
	local player = game:GetService("Players"):GetPlayerFromCharacter(tool.Parent)
	EBL.ChangeStat(player,"Water",false,-70)
	EBL.ChangeStat(player,"Food",false,125)
	EBL.ChangeStat(player,"Intoxicationb",false,2)
	EBL.ChangeStat(player,"Stamina",false,300)
	EBL.ChangeStat(player,"Mental",false,20)
	EBL.ChangeStat(player,"Health",false,20)
	tool:Destroy()
	EBL.PlaySound(player,"4604390759",0.5,nil,{6,0})
end

script.Parent.Activated:Connect(function()
	Eat()
end)