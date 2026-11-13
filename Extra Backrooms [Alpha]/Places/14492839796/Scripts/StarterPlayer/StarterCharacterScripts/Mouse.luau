local uis = game:GetService("UserInputService")
local ugs = UserSettings():GetService("UserGameSettings")
local plrdata = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerData)
local s = require(plrdata.Script)

uis.MouseIconEnabled = false

wait(1)

local function UpdateSensivity()
	local result = plrdata.SensivityValues.Default

	plrdata.Sensivity = result
	uis.MouseDeltaSensitivity = plrdata.Sensivity / ugs.MouseSensitivity
end

game:GetService("RunService").RenderStepped:Connect(function(dt)
	UpdateSensivity()
end)