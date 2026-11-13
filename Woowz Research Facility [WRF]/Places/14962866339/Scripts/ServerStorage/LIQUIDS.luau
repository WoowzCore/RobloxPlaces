local l = {}

l.list = { --[[Функции: питьё жидкости, вылевание жидкости на какой-то объект, функция while для инструмента в котором жидкость]] --[[Текста: при выпивании, описание]]
	["вода"]                 = {["Style"] = {Enum.Material.Glass,        0.8, Color3.fromRGB(82, 186,255), ""},["Func"] = {"fullstamina",nil,nil},     ["Texts"] = {"","water"}},
	["кофе"]                 = {["Style"] = {Enum.Material.Sand,         0.1, Color3.fromRGB(53, 44, 36) , "steam"},["Func"] = {"power",nil,nil},     ["Texts"] = {"power","coffe"}},
	["газировка"]            = {["Style"] = {Enum.Material.Asphalt,      0.9, Color3.fromRGB(165,181,174), ""},["Func"] = {"fullstamina",nil,nil},     ["Texts"] = {"sugar","gas"}},
	["кола"]                 = {["Style"] = {Enum.Material.Glass,        0.6, Color3.fromRGB(74, 33, 19) , ""},["Func"] = {"fullstamina",nil,nil},     ["Texts"] = {"sugar","gas"}},
	["энергетик"]            = {["Style"] = {Enum.Material.Glass,        0.5, Color3.fromRGB(255,224,130), ""},["Func"] = {"energy",nil,nil},     ["Texts"] = {"power","gas"}},
	["сок"]                  = {["Style"] = {Enum.Material.Glass,        0,   Color3.fromRGB(255,194,89) , ""},["Func"] = {"fullstamina",nil,nil},     ["Texts"] = {"good","juice"}},
	["кровь"]                = {["Style"] = {Enum.Material.Glass,        0,   Color3.fromRGB(68, 9,  9)  , ""},["Func"] = {"toxic1",nil,nil},     ["Texts"] = {"blood","blood"}},
	["спирт"]                = {["Style"] = {Enum.Material.Glass,        0.8, Color3.fromRGB(255,255,255), ""},["Func"] = {"alchocol",nil,nil},     ["Texts"] = {"alcohol","alcohol"}},
	["грязь"]                = {["Style"] = {Enum.Material.CorrodedMetal,0,   Color3.fromRGB(47, 32, 21) , ""},["Func"] = {"toxic1",nil,nil},     ["Texts"] = {"mud","mud"}},
	["жидкий азот"]          = {["Style"] = {Enum.Material.Asphalt,      0.7, Color3.fromRGB(255,255,255), "nitrogen"},["Func"] = {nil,nil,nil},     ["Texts"] = {"ice","ice"}},
	["лава"]                 = {["Style"] = {Enum.Material.Neon,         0,   Color3.fromRGB(182,61, 0)  , "melted"},["Func"] = {"melted",nil,nil},["Texts"] = {"die","melted"}},
	["жидкое железо"]        = {["Style"] = {Enum.Material.Neon,         0,   Color3.fromRGB(199,165,64) , "melted"},["Func"] = {"melted",nil,nil},["Texts"] = {"die","melted"}},
	["ртуть"]                = {["Style"] = {Enum.Material.Metal,        0,   Color3.fromRGB(125,125,125), ""},["Func"] = {"poison",nil,nil},     ["Texts"] = {"blood","mercury"}},
	["тархун"]               = {["Style"] = {Enum.Material.Glass,        0.7, Color3.fromRGB(87, 200,0)  , ""},["Func"] = {"fullstamina",nil,nil},     ["Texts"] = {"good","gas"}},
	["молоко"]               = {["Style"] = {Enum.Material.Plastic,      0,   Color3.fromRGB(212,212,212), ""},["Func"] = {"recoverbones",nil,nil},     ["Texts"] = {"good","milk"}},
	["бульён"]               = {["Style"] = {Enum.Material.Sandstone,    0.4, Color3.fromRGB(161,119,72) , ""},["Func"] = {nil,nil,nil},     ["Texts"] = {"good","soup"}},
	["моча"]                 = {["Style"] = {Enum.Material.Glass,        0.7, Color3.fromRGB(226,181,0)  , ""},["Func"] = {"toxic1",nil,nil},     ["Texts"] = {"bad","stink"}},
	["слизь"]                = {["Style"] = {Enum.Material.Foil,         0.5, Color3.fromRGB(189,226,184), ""},["Func"] = {"toxic1",nil,nil},     ["Texts"] = {"bad","viscous"}},
	["гной"]                 = {["Style"] = {Enum.Material.Foil,         0.1, Color3.fromRGB(125,112,105), ""},["Func"] = {"toxic1",nil,nil},     ["Texts"] = {"bad","stink"}},
	["масло"]                = {["Style"] = {Enum.Material.Glass,        0.4, Color3.fromRGB(255,195,15) , ""},["Func"] = {nil,nil,nil},     ["Texts"] = {"bad",""}},
	["мыло"]                 = {["Style"] = {Enum.Material.Plastic,      0.3, Color3.fromRGB(255,171,247), ""},["Func"] = {"toxic1",nil,nil},     ["Texts"] = {"bad","juice"}},
	["отбеливатель"]         = {["Style"] = {Enum.Material.Plastic,      0.1, Color3.fromRGB(241,255,171), ""},["Func"] = {"vinegar",nil,nil},     ["Texts"] = {"die","chlorine"}},
	["мёд"]                  = {["Style"] = {Enum.Material.Glass,        0.2, Color3.fromRGB(255,106,0)  , ""},["Func"] = {"speedup",nil,nil},     ["Texts"] = {"sugar","honey"}},
	["чай"]                  = {["Style"] = {Enum.Material.Glass,        0.4, Color3.fromRGB(255,63, 24) , "steam"},["Func"] = {"fullstamina",nil,nil},     ["Texts"] = {"good","tea"}},
	["тяжёлая вода"]         = {["Style"] = {Enum.Material.Glass,        0.8, Color3.fromRGB(82, 186,255), ""},["Func"] = {"toxic2",nil,nil},     ["Texts"] = {"heavywater","water"}},
	["бензин"]               = {["Style"] = {Enum.Material.Glass,        0.35,Color3.fromRGB(246,255,165), ""},["Func"] = {"toxic2",nil,nil},     ["Texts"] = {"bad","gasoline"}},
	["керосин"]              = {["Style"] = {Enum.Material.Glass,        0.6, Color3.fromRGB(255,254,228), ""},["Func"] = {"toxic1",nil,nil},     ["Texts"] = {"bad","gasoline"}},
	["нефть"]                = {["Style"] = {Enum.Material.Glass,        0,   Color3.fromRGB(0,  0,  0)  , ""},["Func"] = {"toxic3",nil,nil},     ["Texts"] = {"bad","stink"}},
	["шоколад"]              = {["Style"] = {Enum.Material.Glass,        0,   Color3.fromRGB(76, 56, 40) , "steam"},["Func"] = {nil,nil,nil},     ["Texts"] = {"sugar","chocolade"}},
	["мороженое"]            = {["Style"] = {Enum.Material.Snow,         0,   Color3.fromRGB(148,129,145), ""},["Func"] = {nil,nil,nil},     ["Texts"] = {"icecream","ice"}},
	["коктейль"]             = {["Style"] = {Enum.Material.Glass,        0.25,Color3.fromRGB(88, 39, 148), ""},["Func"] = {"alchocol",nil,nil},     ["Texts"] = {"good","alcohol"}},
	["компот"]               = {["Style"] = {Enum.Material.Glass,        0.35,Color3.fromRGB(148,20, 22) , "steam"},["Func"] = {"fullstamina",nil,nil},     ["Texts"] = {"good","juice"}},
	["лимонад"]              = {["Style"] = {Enum.Material.Glass,        0.3, Color3.fromRGB(223,201,115), ""},["Func"] = {"fullstamina",nil,nil},     ["Texts"] = {"lemon","gas"}},
	["сироп"]                = {["Style"] = {Enum.Material.Glass,        0,   Color3.fromRGB(62, 19, 5)  , ""},["Func"] = {nil,nil,nil},     ["Texts"] = {"sugar","blood"}},
	["ацетон"]               = {["Style"] = {Enum.Material.Glass,        0.8, Color3.fromRGB(166,166,166), ""},["Func"] = {"toxic2",nil,nil},     ["Texts"] = {"bad","juice"}},
	["реактивное топливо"]   = {["Style"] = {Enum.Material.Plastic,      0,   Color3.fromRGB(26, 11, 4)  , ""},["Func"] = {"toxic3",nil,nil},     ["Texts"] = {"bad","stink"}},
	["жидкое стекло"]        = {["Style"] = {Enum.Material.Neon,         0.75,Color3.fromRGB(184,175,126), "melted"},["Func"] = {"melted",nil,nil},["Texts"] = {"die","melted"}},
	["яд"]                   = {["Style"] = {Enum.Material.Glass,        0.6, Color3.fromRGB(123,184,123), ""},["Func"] = {"poison",nil,nil},     ["Texts"] = {"bad",""}},
	["парализатор"]          = {["Style"] = {Enum.Material.Glass,        0.6, Color3.fromRGB(225,225,225), ""},["Func"] = {"paralize",nil,nil},     ["Texts"] = {"paralysis",""}},
	["клей"]                 = {["Style"] = {Enum.Material.Marble,       0,   Color3.fromRGB(195,194,198), ""},["Func"] = {"toxic2",nil,nil},     ["Texts"] = {"bad","glue"}},
	["краска"]               = {["Style"] = {Enum.Material.Slate,        0,   Color3.fromRGB(26, 152,61) , ""},["Func"] = {"toxic2",nil,nil},     ["Texts"] = {"bad","paint"}},
	["перекись водорода"]    = {["Style"] = {Enum.Material.Plastic,      0.9, Color3.fromRGB(255,255,255), ""},["Func"] = {"toxic1",nil,nil},     ["Texts"] = {"bad",""}},
	["йод"]                  = {["Style"] = {Enum.Material.Glass,        0,   Color3.fromRGB(40, 15, 10) , ""},["Func"] = {"toxic2",nil,nil},     ["Texts"] = {"bad","iodine"}},
	["хлоргексидин"]         = {["Style"] = {Enum.Material.Glass,        0.75,Color3.fromRGB(161,169,173), ""},["Func"] = {nil,nil,nil},     ["Texts"] = {"bad","alcohol"}},
	["жидкая боль"]          = {["Style"] = {Enum.Material.Glass,        0.3, Color3.fromRGB(213,0,  50) , ""},["Func"] = {nil,nil,nil},     ["Texts"] = {"die",""}},
	["антиматерия"]          = {["Style"] = {Enum.Material.Neon,         0,   Color3.fromRGB(0,  0,  0)  , "black"},["Func"] = {nil,nil,nil},     ["Texts"] = {"die","antimater"}},
	["полироль"]             = {["Style"] = {Enum.Material.Glass,        0.05,Color3.fromRGB(179,105,62) , ""},["Func"] = {"toxic2",nil,nil},     ["Texts"] = {"bad","alcohol"}},
	["антифриз"]             = {["Style"] = {Enum.Material.Plastic,      0,   Color3.fromRGB(68, 122,55) , ""},["Func"] = {"toxic3",nil,nil},     ["Texts"] = {"bad",""}},
	["адреналин"]            = {["Style"] = {Enum.Material.Glass,        0.85,Color3.fromRGB(118,79, 35) , ""},["Func"] = {"energy",nil,nil},     ["Texts"] = {"power",""}},
	["квас"]                 = {["Style"] = {Enum.Material.Ice,          0,   Color3.fromRGB(27, 17, 8)  , ""},["Func"] = {"fullstamina",nil,nil},     ["Texts"] = {"","bread"}},
	["кислота"]              = {["Style"] = {Enum.Material.Asphalt,      0.8, Color3.fromRGB(110,165,51) , "steam"},["Func"] = {"acid",nil,nil},  ["Texts"] = {"die","gas"}},
	["уксус"]                = {["Style"] = {Enum.Material.Glass,        0.8, Color3.fromRGB(163,162,165), ""},["Func"] = {"vinegar",nil,nil},     ["Texts"] = {"die","stink"}},
	["фурацилин"]            = {["Style"] = {Enum.Material.Glass,        0.7, Color3.fromRGB(200,202,93) , ""},["Func"] = {nil,nil,nil},     ["Texts"] = {"",""}},
	["жидкий натрий"]        = {["Style"] = {Enum.Material.Metal,        0,   Color3.fromRGB(202,202,202), ""},["Func"] = {"explode",nil,nil},     ["Texts"] = {"die","mercury"}},
}

l.gases = {
	--[[ Цвет, Летит вниз? ]]
	["steam"]    = {Color3.fromRGB(238, 254, 255), false},
	["nitrogen"] = {Color3.fromRGB(255, 255, 255), true},
	["melted"]   = {Color3.fromRGB(26 , 6  , 3  ), false},
	["black"]    = {Color3.fromRGB(0  , 0  , 0  ), true},
}

function l.Drink(plr,liquid)
	local data = l.list[liquid]
	if data == nil then
		error("Жидкость ["..liquid.."] не найдена!")
		return
	end
	local event = data["Func"][1]
	game:GetService("ReplicatedStorage").Player.Drink:FireClient(plr,event,data,liquid)
end

return l
