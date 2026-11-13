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

local UI = script.Parent

local UIs = {
	Arm = UI.Arm;
}

game:GetService("RunService").RenderStepped:Connect(function()
	if GetPlayerValue("NowMoveLeftArm") then
		UIs.Arm.Text = "L"
		UIs.Arm.TextColor3 = Color3.new(0,1,0)
	else
		UIs.Arm.Text = "R"
		UIs.Arm.TextColor3 = Color3.new(1,0,0)
	end
end)