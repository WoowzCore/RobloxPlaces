local dirtcolors = {Color3.fromRGB(175, 142, 121),Color3.fromRGB(140, 113, 97),Color3.fromRGB(111, 89, 77),Color3.fromRGB(185, 168, 130),Color3.fromRGB(129, 117, 91),Color3.fromRGB(129, 121, 112),Color3.fromRGB(129, 129, 129),Color3.fromRGB(171, 171, 171),Color3.fromRGB(117, 134, 113),Color3.fromRGB(134, 101, 75),Color3.fromRGB(166, 122, 79)}

script.Parent.dirt.Color = dirtcolors[math.random(1,#dirtcolors)]

local pot = script.Parent
local plants = {pot.Plant1,pot.Plant2,pot.Plant3,pot.Plant4,pot.Plant5,pot.Plant6}

local selectedplant = math.random(1,#plants)

for i, plant in pairs(plants) do
	if i ~= selectedplant then
		plant:Destroy()
	end
end