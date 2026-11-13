local uis = game:GetService("UserInputService")
local plrdata = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerData)
local s = require(plrdata.Script)

wait(1)

function RotateCharacter()
	local camvec = plrdata.Camera.CFrame.lookVector
	local camrot = math.atan2(-camvec.x,-camvec.z)
	plrdata.Character.HumanoidRootPart.CFrame = CFrame.new(plrdata.Character.HumanoidRootPart.Position) * CFrame.Angles(0, camrot, 0)
end

game:GetService("RunService").RenderStepped:Connect(function(dt)
	RotateCharacter()
end)