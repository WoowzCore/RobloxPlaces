local Zombie = script.Parent
local Humanoid = Zombie.Humanoid

--[[======================================================================]]
	local SkinColorRandom = {Min = -40; Max = 10;}
--[[======================================================================]]

local Parts = {
	Head = Zombie.Head;
	Base = Zombie.HumanoidRootPart;
	ArmLeft = Zombie["Left Arm"];
	ArmRight = Zombie["Right Arm"];
	LegLeft = Zombie["Left Leg"];
	LegRight = Zombie["Right Leg"];
	Torso = Zombie.Torso;
	Full = Zombie.Parent;
	TwoHead = Zombie.Parent.TwoHead;
}

local FaceObjects = {
	Face = Parts.Head.Face;
	Eyes = Parts.TwoHead.Eyes;
	HeadForm = Parts.Head.Form;
	TwoHeadForm = Parts.TwoHead.Form;
}

local ZombieType = "Basical"

local NilTexture = 8774752075

local DecorInfo = {
	SkinColor = {
		{Color3.fromRGB(186, 169, 135)},{Color3.fromRGB(109, 107, 80)}
	};
	BloodColor = {{Color3.fromRGB(125,30,16)},{Color3.fromRGB(89, 55, 38)}};
	HeadForm = {
		{"rbxasset://fonts/head.mesh"},{"rbxassetid://8635368147"},{"https://www.roblox.com/asset/?id=5560742556"},{"rbxassetid://8635368421"}
	};
	Face = {
		Face = {8784972163,8785020620,8840403351,8842367374};
		Eyes = {8842470791,8842472757,NilTexture,8842475566};
		
	};
}

local function GetRandomInTablet(tablet)
	local result = tablet[math.random(1,#tablet)]
	return result[1]
end

local function SetPartColor(part,Color,blood)
	local R,G,B
	R = Color.R
	G = Color.G
	B = Color.B
	
	local RandColorSetting = math.random(SkinColorRandom.Min,SkinColorRandom.Max)/10

	local randcolor = Vector3.new(RandColorSetting/255,RandColorSetting/255,RandColorSetting/255)
	local colorvec = Vector3.new(R,G,B)+randcolor
	local NewColor = BrickColor.new(colorvec.X,colorvec.Y,colorvec.Z)
	if math.random(0,10) > 9 then
		part.BrickColor = BrickColor.new(blood.R,blood.G,blood.B)
	else
		part.BrickColor = NewColor
	end
end

local function SetBodyColor()
	local colors = DecorInfo.SkinColor
	local Color = GetRandomInTablet(colors)
	local blood = GetRandomInTablet(DecorInfo.BloodColor)
	
	for _,part in pairs(Zombie:GetChildren()) do
		if part:IsA("Part") then
			SetPartColor(part,Color,blood)	
		end
	end
end
SetBodyColor()

local function SetTexture(decal,tex)
	decal.Texture = "rbxassetid://"..tex
end

local function SetMesh(mesh,form)
		mesh.MeshId = form
end
local function GenerateFace()
	local TabletFaces = DecorInfo.Face.Face
	local RandomFace = math.random(1,#TabletFaces)
	SetTexture(FaceObjects.Face,DecorInfo.Face.Face[RandomFace])
	SetTexture(FaceObjects.Eyes,DecorInfo.Face.Eyes[RandomFace])
	local RandomMesh = GetRandomInTablet(DecorInfo.HeadForm)
	SetMesh(FaceObjects.TwoHeadForm,RandomMesh)
	SetMesh(FaceObjects.HeadForm,RandomMesh)
end
GenerateFace()