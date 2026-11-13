local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local base = require(script.Parent:WaitForChild("PlayerBase"))
local u = game:GetService("UserInputService")

local function restartcharacter()
	local chr = plr.Character or plr.CharacterAdded:Wait()
	base.Load(plr)
	plr.CameraMode = Enum.CameraMode.LockFirstPerson
	
	wait()
	for _, p in pairs(chr:GetDescendants()) do
		if p:IsA("MeshPart") then
			local transparency = 0
			if p.Name == "Head" then transparency = 1 end
			p:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
				p.LocalTransparencyModifier = transparency
			end)
			p.LocalTransparencyModifier = transparency
		end
	end
end

restartcharacter()

local sg = game:GetService("StarterGui")
sg:SetCoreGuiEnabled(Enum.CoreGuiType.All,false)