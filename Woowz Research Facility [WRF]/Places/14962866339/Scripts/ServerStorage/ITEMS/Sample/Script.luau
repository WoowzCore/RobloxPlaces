local glass = script.Parent
local sample = nil
local gui = glass.eticetka.SurfaceGui

local AllSamples = string.split(glass.Samples.Value,",")
local Samples = {
	["Onion"] = {"Лук",2,Color3.fromRGB(194, 163, 92)},
	["Cucumber"] = {"Огурец",3,Color3.fromRGB(114, 180, 79)},
	["Potato"] = {"Картошка",4,Color3.fromRGB(95, 72, 51)},
	["Pork"] = {"Свинина",5,Color3.fromRGB(255, 197, 185)},
	["Beef"] = {"Говядина",4,Color3.fromRGB(179, 117, 111)},
	["Chicken"] = {"Курятина",1,Color3.fromRGB(231, 197, 162)},
	["Fish"] = {"Рыба",2,Color3.fromRGB(129, 193, 177)},
	["Mold"] = {"Плесень",1,Color3.fromRGB(144, 181, 130)},
	["Alien"] = {"Инопланетное"},
	["Bug"] = {"Жук",6,Color3.fromRGB(255, 151, 66)},
	["Cancer"] = {"Раковая клетка",1,Color3.fromRGB(193, 101, 93)},
	["Virus"] = {"Вирус",3,Color3.fromRGB(174, 70, 181)},
	["Bat"] = {"Летучая мышь",1,Color3.fromRGB(84, 86, 59)},
	["Rat"] = {"Крыса",5,Color3.fromRGB(100, 100, 100)},
	["Monkey"] = {"Обезьяна",3,Color3.fromRGB(255, 53, 53)},
	["Tiger"] = {"Тигр",2,Color3.fromRGB(207, 126, 12)},
	["Shark"] = {"Акула",2,Color3.fromRGB(40, 103, 197)},
	["Tick"] = {"Клещ",6,Color3.fromRGB(168, 0, 0)},
	["Jellyfish"] = {"Медуза",4,Color3.fromRGB(255, 174, 254)},
	["Crow"] = {"Ворона",1,Color3.fromRGB(22, 22, 22)},
	["Whale"] = {"Кит",4,Color3.fromRGB(54, 105, 120)},
	["Worm"] = {"Червь",5,Color3.fromRGB(255, 134, 209)}
}

local function SetSample(s)
	if sample == s then return end
	sample = s
	
	glass.m1.Transparency = 1
	glass.m1_2.Transparency = 1
	glass.m2.Transparency = 1
	glass.m3.Transparency = 1
	glass.m4.Transparency = 1
	glass.m5.Transparency = 1
	glass.m6.Transparency = 1
	
	if s == "" then
		gui.ImageLabel.sample.Text = '"Чистый"'
	else
		local data = Samples[s]
		local color = nil
		local meshid = nil
		if s == "Alien" then
			meshid = math.random(1,6)
			color = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
		else
			meshid = data[2]
			color = data[3]
		end
		local name = data[1]
		
		if meshid == 1 then
			glass.m1.Transparency = 0
			glass.m1_2.Transparency = 0
			glass.m1.Color = color
			glass.m1_2.Color = color
		else
			glass["m"..meshid].Transparency = 0
			glass["m"..meshid].Color = color
		end
		
		gui.ImageLabel.sample.Text = '"'..name..'"'
	end
end
SetSample(glass.Sample.Value)

local i = 0
while wait() do
	if sample ~= glass.Sample.Value then
		SetSample(glass.Sample.Value)
	end
	
	i+=1
	if i >= 30 then
		i = 0
		glass.Sample.Value = AllSamples[math.random(1,#AllSamples)]
	end
end