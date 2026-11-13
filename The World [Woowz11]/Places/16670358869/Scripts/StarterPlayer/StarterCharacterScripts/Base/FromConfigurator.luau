local base = require(script.Parent.Base)
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
base.Player = plr
local chr = plr.Character or plr.CharacterAdded:Wait()
base.Character = chr
base.Humanoid = chr:WaitForChild("Humanoid",60)
local config = script.Parent.Parent:FindFirstChild("Configuration")
if config then
	base.Config = config

	local function s(name,def)
		local setting = config:FindFirstChild(name)
		if setting then
			return setting.Value
		else
			return def
		end
	end

	local mouse = plr:GetMouse()
	local u = game:GetService("UserInputService")
	u.MouseDeltaSensitivity = s("Sensitivity",1)
	base.SetRobloxCore(false,"ResetButtonCallback",not s("DisableReset",false))
	base.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,s("CanClimbing",true))
	print(s("CanClimbing",true))

end