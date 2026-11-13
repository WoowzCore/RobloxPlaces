local crate = nil
if math.random(0,100)>50 then
	crate = script.Parent.Crate1
	script.Parent.Crate2:Destroy()
else
	crate = script.Parent.Crate2
	script.Parent.Crate1:Destroy()	
end

local rand = math.random(1,3)
if rand == 1 then
	for _, part in pairs(crate:GetChildren()) do
		if part.Name == "PartTopBottom" or part.Name == "PartSide" then
			part:Destroy()
		end
	end
elseif rand == 2 then
	for _, part in pairs(crate:GetChildren()) do
		if part.Name == "PartTopBottom" then
			part:Destroy()
		end
	end
end

local colors = {{Color3.fromRGB(131, 113, 76),Color3.fromRGB(153, 140, 110)},{Color3.fromRGB(131, 100, 73),Color3.fromRGB(124, 100, 86)},{Color3.fromRGB(124, 117, 98),Color3.fromRGB(145, 136, 115)}}
local color = colors[math.random(1,#colors)]

for _, part in pairs(crate:GetChildren()) do
	if part.Name == "PartBase" then
		part.Color = color[1]
	else
		part.Color = color[2]
	end
end

script:Destroy()