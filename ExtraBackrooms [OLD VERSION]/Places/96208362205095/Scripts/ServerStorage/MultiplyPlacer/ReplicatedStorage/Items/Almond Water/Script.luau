local basa = require(game.ServerScriptService:WaitForChild("EBLibbary"))
local tool = script.Parent
local open = tool.Empty.Value
local drinked = tool.Empty.Value
local EBL = require(game.ServerScriptService:WaitForChild("EBLibbary"))

local function OpenCan()
	open = true
	tool.Lid.Transparency = 1
	tool.Open:Play()
end

local function Drink()
	drinked = true
	tool.Drink:Play()
	local player = game:GetService("Players"):GetPlayerFromCharacter(tool.Parent)
	EBL.ChangeStat(player,"Water",false,250)
	EBL.ChangeStat(player,"Food",false,25)
	EBL.ChangeStat(player,"IntoxicationA",false,-25)
	EBL.ChangeStat(player,"IntoxicationB",false,-20)
	EBL.ChangeStat(player,"IntoxicationC",false,-15)
	EBL.ChangeStat(player,"IntoxicationD",false,-5)
	EBL.ChangeStat(player,"Stamina",false,20)
	EBL.ChangeStat(player,"Mental",false,50)
	EBL.ChangeStat(player,"Health",false,10)
	tool.Empty.Value = true
end

script.Parent.Activated:Connect(function()
	if not open then
		OpenCan()
	else
		if not drinked then
			Drink()
		end
	end
end)