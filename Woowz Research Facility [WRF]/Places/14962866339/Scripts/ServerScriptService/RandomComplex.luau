local skins = {
	zone13 = {
		{["Bottom"] = Color3.fromRGB(195, 150, 127),["Middle"] = Color3.fromRGB(90, 90, 90),["Wall"] = Color3.fromRGB(204, 203, 207),["Top"] = Color3.fromRGB(200, 200, 200),["Ceiling"] = Color3.fromRGB(128, 131, 122),["Base"] = Color3.fromRGB(90, 93, 93),["Floor"] = Color3.fromRGB(112, 112, 115),["Bricks"] = Color3.fromRGB(138, 135, 120)},
		{["Bottom"] = Color3.fromRGB(204, 171, 143),["Middle"] = Color3.fromRGB(138, 138, 138),["Wall"] = Color3.fromRGB(188, 187, 179),["Top"] = Color3.fromRGB(147, 147, 147),["Ceiling"] = Color3.fromRGB(121, 121, 121),["Base"] = Color3.fromRGB(122, 126, 126),["Floor"] = Color3.fromRGB(154, 154, 158),["Bricks"] = Color3.fromRGB(94, 87, 69)},
		{["Bottom"] = Color3.fromRGB(128, 146, 147),["Middle"] = Color3.fromRGB(95, 95, 95),["Wall"] = Color3.fromRGB(100, 111, 108),["Top"] = Color3.fromRGB(87, 93, 95),["Ceiling"] = Color3.fromRGB(135, 143, 143),["Base"] = Color3.fromRGB(47, 49, 49),["Floor"] = Color3.fromRGB(93, 93, 95),["Bricks"] = Color3.fromRGB(95, 83, 75)},
		{["Bottom"] = Color3.fromRGB(175, 104, 99),["Middle"] = Color3.fromRGB(179, 140, 122),["Wall"] = Color3.fromRGB(180, 166, 159),["Top"] = Color3.fromRGB(149, 134, 122),["Ceiling"] = Color3.fromRGB(167, 156, 145),["Base"] = Color3.fromRGB(167, 168, 162),["Floor"] = Color3.fromRGB(197, 182, 173),["Bricks"] = Color3.fromRGB(136, 106, 88)},
		{["Bottom"] = Color3.fromRGB(178, 185, 113),["Middle"] = Color3.fromRGB(165, 179, 149),["Wall"] = Color3.fromRGB(152, 161, 148),["Top"] = Color3.fromRGB(134, 149, 131),["Ceiling"] = Color3.fromRGB(153, 167, 147),["Base"] = Color3.fromRGB(99, 108, 92),["Floor"] = Color3.fromRGB(134, 145, 115),["Bricks"] = Color3.fromRGB(122, 136, 113)}
	}
}

local exitsignsgreen = nil

local function deepCopy(original)
	local copy = {}
	for k, v in pairs(original) do
		if type(v) == "table" then
			v = deepCopy(v)
		end
		copy[k] = v
	end
	return copy
end

local function randScene(random)
	if random == nil then random = false end
	exitsignsgreen = (math.random(0,100)>=30)
	local exitsignskin = {
		[true] = {Color3.fromRGB(89, 250, 220),Color3.fromRGB(8, 255, 56)},
		[false] = {Color3.fromRGB(250, 143, 143),Color3.fromRGB(255, 0, 0)}
	}
	
	if random then
		local col1, col2 = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255)),Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
		exitsignskin = {
			[true] = {Color3.fromRGB(math.min(255,col1.R+128),math.min(255,col1.G+128),math.min(255,col1.B+128)),col1},
			[false] = {Color3.fromRGB(math.min(255,col2.R+128),math.min(255,col2.G+128),math.min(255,col2.B+128)),col2}
		}
	end
	
	local skins_ = deepCopy(skins)
	
	local function randexitsigns(sign)
		local colors = exitsignskin[exitsignsgreen]
		sign.neon.Color = colors[2]
		sign.neon2.Color = colors[1]
		sign.force.Color = colors[2]
		sign.force.PointLight.Color = colors[2]
	end
	
	local randomzakrep = 1
	if math.random(0,100)>=50 then
		randomzakrep = -1
	end
	
	local function randzone13()
		local zone13 = skins_.zone13[math.random(1,#skins_.zone13)]
		
		if random then
			zone13["Bricks"] = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
			zone13["Wall"] = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
			zone13["Top"] = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
			zone13["Ceiling"] = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
			zone13["Base"] = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
			zone13["Floor"] = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
			zone13["Bottom"] = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
			zone13["Middle"] = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
		end
		
		for _, p in pairs(workspace.Zone13_Part1:GetDescendants()) do
			local n = p.Name
			if n == "Part_walloffice_top" then p.Color = zone13["Bricks"] end
			if n == "Part_walloffice" then p.Color = zone13["Wall"] end
			local r = math.max(math.min(math.round(zone13["Wall"].r*255) + (20*randomzakrep),255),0)
			local g = math.max(math.min(math.round(zone13["Wall"].g*255) + (20*randomzakrep),255),0)
			local b = math.max(math.min(math.round(zone13["Wall"].b*255) + (20*randomzakrep),255),0)
			if n == "Part_walloffice_zaklepka" then p.Color = Color3.fromRGB(r,g,b) end
			if n == "Part_topofcice" then p.Color = zone13["Top"] end
			if n == "Part_officeceiling_koridor" or n == "Part_celing_office_zone13_RoomNoobs" then p.Color = zone13["Ceiling"] end
			if n == "Part_floorofice" then p.Color = zone13["Base"] end
			if n == "Part_floorofice2" then p.Color = zone13["Floor"] end
			if n == "Part_bottomofcice" or n == "Part_office_KAFITERIAFLOOR" then p.Color = zone13["Bottom"] end
			if n == "Part_bottomofcice_middle" then p.Color = zone13["Middle"] end
		end
	end
	
	randzone13()
	
	local datedisplay_colors = {"red","green","blue","yellow"}
	local datedisplay_color = datedisplay_colors[math.random(1,#datedisplay_colors)]
	
	for _, p in pairs(workspace:GetDescendants()) do
		if p.Name == "ExitSign" then
			randexitsigns(p)
		end
		
		if p.Name == "DateDisplay" then
			p.NumbersColor.Value = datedisplay_color
		end
	end
end

wait(1)
randScene()
game:GetService("ReplicatedStorage").RandScene.Event:Connect(randScene)