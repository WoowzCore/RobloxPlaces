local part = script.Parent
local decal = part.Decal

local decals = {"rbxassetid://14544752254","rbxassetid://14544755062","rbxassetid://14544763667","rbxassetid://14544763667","rbxassetid://14544772437"}

while wait() do
	part.Color = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
	decal.Texture = decals[math.random(1,#decals)]
end
