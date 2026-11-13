--[[========================================================]]
local function GetValue(name)
	local value = game.Scene.Main.GlobalValues:WaitForChild(name)
	return value.Value
end
local function SetValue(name,val)
	local value = game.Scene.Main.GlobalValues:WaitForChild(name)
	value.Value = val
end
local function GetPlayerValue(name)
	local value = game:GetService("Players").LocalPlayer:WaitForChild("PlayerValues"):WaitForChild(name)
	return value.Value
end
local function SetPlayerValue(name,val)
	game.RStorage.SetPlayerValue:FireServer(name,val)
	wait()
end
--[[========================================================]]

local player = game:GetService("Players").LocalPlayer
local GUI = script.Parent.Parent:WaitForChild("PlayerGui")
local DEBUG = GUI:WaitForChild("Screen").Debug
local function SetDebugString(name,text)
	local string_ = DEBUG.Background:FindFirstChild(name)
	if string_ then
		string_.Text = text
	end
end

local function CreateDebugString(name)
	local text = DEBUG.Saved.String:Clone()
	text.Parent = DEBUG.Background
	text.Name = name
	text.Visible = true
end
--[[========================================================]]
local Start_Stamina = 2000

--[[========================================================]]
local Cleanliness = {Sweat = 0;--[[Пот (Заостряет запах зомби)]] Blood = 0;--[[Кровь (добавляет безумие, Заостряет запах зомби)]] Rotten = 0;--[[Гниль (Затупляет запах зомби)]] Perfume = 0;--[[Духи (Резкий запах)]] }--[[Грязь на теле]]
local Stamina = Start_Stamina --[[Стамина]]
local Rabies = false --[[Бешенство, даёт так сказать силу духа, быстро восполняет стамину]]
local Without_Consciousness = false --[[Без сознания, рагдолл]]
local Adrenaline = 0
local Player_Temperature = 36.6
local PlayerGoing_Temperature = 36.6
local World_Temperature = 36.6
--[[========================================================]]
local function CreateDEBUG()
	CreateDebugString("Cleanliness")
	CreateDebugString("Stamina")
	CreateDebugString("Item_In_Hand")
	CreateDebugString("Temperature")
end
CreateDEBUG()

local function GetObjectName(obj)
	local result = "Not Have"
	if obj then
		local title = obj:FindFirstChild("Title")
		if title then
			result = title.Value
		else
			result = "ERROR, Not have TITLE"
		end
	end
	return result
end

local function GetArmName()
	local result = "Right"
	if GetPlayerValue("NowMoveLeftArm") then
		result = "Left"
	end
	
	return result
end

local function DEBUG()
	SetDebugString("Cleanliness","Cleanliness = {".. "Sweat = ("..Cleanliness.Sweat.."),".. "Blood = ("..Cleanliness.Blood.."),".. "Rotten = ("..Cleanliness.Rotten.."),".. "Perfume = ("..Cleanliness.Perfume..")" .."}")
	SetDebugString("Stamina","Stamina = {"..Stamina.. ", Rabies = (" .. tostring(Rabies) ..")"..", Adrinaline = (" .. Adrenaline ..")".."}")
	SetDebugString("Item_In_Hand","Hand Used Now = {".. GetArmName() .."} Arm Item = { Right = {".. GetObjectName(GetPlayerValue("ObjectInHand")) .."}, Left = {".. GetObjectName(GetPlayerValue("ObjectInHand2")) .."} }")
	SetDebugString("Temperature","WIP")
end

local function Nutrition()--Питание (белки, углеводы, жиры и тд)
	
end

local function Stat_Hungry()--Насколько у игрока сильный голод
	Nutrition()
end

local function Stat_Thirst()--Насколько у игрока сильная жажда

end

local function Stat_Stamina()--Насколько игрок устал

end

local function Stat_Sleep()--Насколько игрока в сон клонит

end

local function Stat_Cleanliness()--Насколько игрок грязный

end

local function Stat_Temperature()--Какая темпиратура у игрока

end

local function Stat_Disease()--Болезни в игроке

end

local function Stat_Wet()--Влажность

end

local function Stat_Pain()--Боль

end

local function Stat_Stress()--Стресс

end

local function Stat_Laziness()--Лень

end

local function Stat_Pumped()--Накаченность мышц

end

local function Stat_Oxygen()--Кислород

end

local function Stat_Waste()--Отходы жизни дейтельности

end

local function Stat_Circulation()--Кровообращение
	
end

local function Stat_Madness()--Безумие
	
end

local function Digestion()--Пищеворение
	Stat_Waste()
	Stat_Thirst()
	Stat_Hungry()
end

local function Intelligence()--Рассудок
	Stat_Laziness()
	Stat_Stress()
	Stat_Pain()
	Stat_Madness()
end

local function Stat_Body()--Тело
	Intelligence()
	Digestion()
	Stat_Pumped()
	Stat_Circulation()
end

local function SetStats()
	Stat_Stamina()
	Stat_Sleep()
	Stat_Cleanliness()
	Stat_Temperature()
	Stat_Disease()
	Stat_Oxygen()
	Stat_Wet()
	Stat_Body()
end

while wait() do
	
	SetStats()
	if GetPlayerValue("ShowDebug") then
		DEBUG()
	end
	
end
