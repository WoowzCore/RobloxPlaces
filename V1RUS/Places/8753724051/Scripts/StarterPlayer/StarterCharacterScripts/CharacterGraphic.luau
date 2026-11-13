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
local humanoid = character.Humanoid

while true do
	wait()
	for _,part in pairs(character:GetChildren()) do
		if part:IsA("BasePart") and part.Name ~= "Head" then
			part.LocalTransparencyModifier = part.Transparency
		end
	end

end