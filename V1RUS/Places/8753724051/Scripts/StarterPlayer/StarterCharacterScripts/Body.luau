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
local character = script.Parent

local parts = {
	Torso = character:WaitForChild("Torso");
	Base = character:WaitForChild("HumanoidRootPart");
	arms = {
		left = character:WaitForChild("Left Arm");
		right = character:WaitForChild("Right Arm");
	};
}

local NeckPos = parts.Torso.Neck.C0
local cam = game.Scene.CurrentCamera

while wait() do
	local CamDir = parts.Base.CFrame:toObjectSpace(cam.CFrame).lookVector
	game.RStorage.RotateHead:FireServer(character,NeckPos)--CFrame.new(0,NeckPos.y,0))-- * CFrame.Angles(0,-math.asin(CamDir.x),0) * CFrame.Angles(math.asin(CamDir.y),0,0) )
end
