--[[========================================================]]
local function GetValue(name)
	local value = game.Scene.Main.GlobalValues:WaitForChild(name)
	return value.Value
end
local function SetValue(name,val)
	local value = game.Scene.Main.GlobalValues:WaitForChild(name)
	value.Value = val
end
local function GetPlayerValue(player,name)
	local value = player:WaitForChild("PlayerValues"):WaitForChild(name)
	return value.Value
end
local function SetPlayerValue(player,name,val)
	local value = player:WaitForChild("PlayerValues"):WaitForChild(name)
	value.Value = val
	wait()
end
--[[========================================================]]

local RS = game.RStorage
local SSS = game.SSS

local Scripts = SSS.Scripts

while true do
	wait()
	for _,players in pairs(game:GetService("Players"):GetPlayers()) do
		Scripts.BodyScript:Fire(players)
	end
end