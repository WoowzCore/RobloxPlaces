function onTouch(part) 
local human = part.Parent:findFirstChild("Humanoid") 
if human ~= nil then 
	part.Parent:findFirstChild("LeftFoot").Transparency = 1
	part.Parent:findFirstChild("LeftHand").Transparency = 1
	part.Parent:findFirstChild("LeftLowerArm").Transparency = 1
	part.Parent:findFirstChild("LeftLowerLeg").Transparency = 1
	part.Parent:findFirstChild("LeftUpperArm").Transparency = 1
	part.Parent:findFirstChild("LeftUpperLeg").Transparency = 1
	part.Parent:findFirstChild("LowerTorso").Transparency = 1
	part.Parent:findFirstChild("RightFoot").Transparency = 1
	part.Parent:findFirstChild("RightHand").Transparency = 1
	part.Parent:findFirstChild("RightLowerArm").Transparency = 1
	part.Parent:findFirstChild("RightLowerLeg").Transparency = 1
	part.Parent:findFirstChild("RightUpperArm").Transparency = 1
	part.Parent:findFirstChild("RightUpperLeg").Transparency = 1
	part.Parent:findFirstChild("UpperTorso").Transparency = 1
	part.Parent:findFirstChild("Head").Transparency = 0.99
	part.Parent:findFirstChild("Head").face.Transparency = 1


	if part.Parent:findFirstChild("Shirt") ~= nil then
		part.Parent:findFirstChild("Shirt"):Destroy()
	end
	if part.Parent:findFirstChild("Pants") ~= nil then
		part.Parent:findFirstChild("Pants"):Destroy()
	end
	if part.Parent:findFirstChild("Shirt Graphic") ~= nil then
		part.Parent:findFirstChild("Shirt Graphic"):Destroy()
	end
	if part.Parent:findFirstChild("Body Colors") ~= nil then
		part.Parent:findFirstChild("Body Colors"):Destroy()
	end

	if part.Parent:findFirstChild("Head"):findFirstChild("LimbMesh") ~= nil then
		if part.Parent:findFirstChild("Head"):findFirstChild("face") ~= nil then
			part.Parent:findFirstChild("Head"):findFirstChild("face"):Destroy()
		end
		part.Parent:findFirstChild("Head"):findFirstChild("LimbMesh"):Destroy()
		local addmesh = Instance.new("SpecialMesh",part.Parent:findFirstChild("Head"))
		addmesh.MeshId = "http://www.roblox.com/asset/?id=134079402"
end
	if part.Parent:findFirstChild("Torso"):findFirstChild("roblox") ~= nil then
		part.Parent:findFirstChild("Torso"):findFirstChild("roblox"):Destroy()
	end
end 
	local d = part.Parent:GetChildren() 
	for i=1, #d do 
		if (d[i].className == "Accessory") then 
			d[i]:Destroy()
		end
	end
end 


script.Parent.Touched:connect(onTouch) 

--COLORS

--1 = white
--208 = Light stone grey
--194 = Medium stone grey
--199 = Dark stone grey
--26 = Black
--21 = Bright red
--24 = Bright yellow
--226 = Cool yellow
--23 = Bright blue
--107 = Bright bluish green
--102 = Medium blue
--11 = Pastel blue
--45 = Light blue
--135 = Sand blue
--106 = Bright orange
--105 = Br. yellowish orange
--141 = Earth green
--28 = Dark green
--37 = Bright green
--119 = Br. yellowish green
--29 = Medium green
--151 = Sand green
--38 = Dark orange
--192 = Reddish brown
--104 = Bright violet
--9 = Light reddish violet
--101 = Medium red
--5 = Brick Yellow
--153 = Sand red
--217 = Brown
--18 = Nougat
--125 = Light orange

