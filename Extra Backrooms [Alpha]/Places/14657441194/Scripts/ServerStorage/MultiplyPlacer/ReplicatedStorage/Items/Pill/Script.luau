local basa = require(game.ServerScriptService:WaitForChild("EBLibbary"))
local tool = script.Parent
local EBL = require(game.ServerScriptService:WaitForChild("EBLibbary"))

local top = tool.PillTopPart
local bottom = tool.PillBottomPart

local effecttop = tool.EffectTop
local effectbottom = tool.EffectBottom

--[[
	water = Востанавливает воду
	food = Востанавливает еду
	unwater = Забирает воду
	unfood = Забирает еду
	mental = Востанавливает псих. с.
	unmental = Забирает психю с.
	stamina = Востанавливает стамину
	hurt = Наносит урон
	heal = Лечит
	poison = Даёт ралзичное отравление
	unpoison  = Убирает всё отравление
	kill = Убивает
	nil = Ничего
	all = Востанавливает всё но чучуть
	unall = Забирает всё но чучуть 
]]

local effectcolors = {
	["nil"] = Color3.fromRGB(230,230,230),
	["kill"] = Color3.fromRGB(25,25,25),
	["water"] = Color3.fromRGB(10,74,204),
	["unwater"] = Color3.fromRGB(0,173,204),
	["food"] = Color3.fromRGB(204,81,0),
	["unfood"] = Color3.fromRGB(204,150,112),
	["mental"] = Color3.fromRGB(204,0,159),
	["unmental"] = Color3.fromRGB(95,0,204),
	["poison"] = Color3.fromRGB(30,204,0),
	["unpoison"] = Color3.fromRGB(12,81,0),
	["all"] = Color3.fromRGB(223,178,234),
	["unall"] = Color3.fromRGB(213,255,181),
	["heal"] = Color3.fromRGB(255,8,0),
	["hurt"] = Color3.fromRGB(91,3,0),
	["stamina"] = Color3.fromRGB(255,238,0)
}

local function PlayEffect(effect,plr)
	local char = plr.Character or plr.CharacterAdded:Wait()
	local hum = char:WaitForChild("Humanoid")
	local rand = math.random(1,100)
	if effect == "kill" then
		EBL.DetectHurt(plr,"kill","nil")
	elseif effect == "water" then
		EBL.ChangeStat(plr,"water",false,rand*5)
	elseif effect == "unwater" then
		EBL.ChangeStat(plr,"water",false,-rand*5)
	elseif effect == "food" then
		EBL.ChangeStat(plr,"food",false,rand*5)
	elseif effect == "unfood" then
		EBL.ChangeStat(plr,"food",false,-rand*5)
	elseif effect == "mental" then
		EBL.ChangeStat(plr,"mental",false,rand*5)
	elseif effect == "unmental" then
		EBL.ChangeStat(plr,"mental",false,-rand*5)
	elseif effect == "stamina" then
		EBL.ChangeStat(plr,"stamina",false,rand*9)
	elseif effect == "all" then
		EBL.ChangeStat(plr,"water",false,rand*2)
		EBL.ChangeStat(plr,"food",false,rand*2)
		EBL.ChangeStat(plr,"mental",false,rand*2)
		EBL.ChangeStat(plr,"stamina",false,rand*2)
	elseif effect == "unall" then	
		EBL.ChangeStat(plr,"water",false,-rand*2)
		EBL.ChangeStat(plr,"food",false,-rand*2)
		EBL.ChangeStat(plr,"mental",false,-rand*2)
		EBL.ChangeStat(plr,"stamina",false,-rand*2)
	elseif effect == "heal" then
		EBL.ChangeStat(plr,"health",false,rand/2)
	elseif effect == "hurt" then
		EBL.ChangeStat(plr,"health",false,-rand/2)
	elseif effect == "poison" then
		EBL.ChangeStat(plr,"Intoxicationa",false,rand*2)
		EBL.ChangeStat(plr,"Intoxicationb",false,rand*2)
		EBL.ChangeStat(plr,"Intoxicationc",false,rand*2)
		EBL.ChangeStat(plr,"Intoxicationd",false,rand*2)
	elseif effect == "unposion" then
		EBL.ChangeStat(plr,"Intoxicationa",false,-rand*2)
		EBL.ChangeStat(plr,"Intoxicationb",false,-rand*2)
		EBL.ChangeStat(plr,"Intoxicationc",false,-rand*2)
		EBL.ChangeStat(plr,"Intoxicationd",false,-rand*2)
	end	
end

local function SetColors(istop)
	local pill = bottom
	local effect = effectbottom.Value
	if istop == true then pill = top effect = effecttop.Value end
	pill.Color = effectcolors[effect]
end

SetColors(true)
SetColors()

tool.EffectTop:GetPropertyChangedSignal("Value"):Connect(function() SetColors(true) end)
tool.EffectBottom:GetPropertyChangedSignal("Value"):Connect(function() SetColors(false) end)

local function Eat()
	local player = game:GetService("Players"):GetPlayerFromCharacter(tool.Parent)
	
	if effecttop.Value == effectbottom.Value then
		PlayEffect(effecttop.Value,player)
	else
		PlayEffect(effecttop.Value,player)
		PlayEffect(effectbottom.Value,player)
	end
	
	tool:Destroy()
end

script.Parent.Activated:Connect(function()
	Eat()
end)