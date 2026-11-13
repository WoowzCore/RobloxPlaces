local ply = game:GetService("Players").LocalPlayer
local MultiplyPlacer = ply:WaitForChild("PlayerScripts"):WaitForChild("MultiplyPlacerClient")

local PlayerGui = MultiplyPlacer.StarterGui
local PlayerScripts = MultiplyPlacer.StarterPlayer.StarterPlayerScripts
local CharacterScripts = MultiplyPlacer.StarterPlayer.StarterCharacterScripts

local loaded = false
local function Install(what,here,clone)
	local function CloneThis(i)
		local obj = i
		if clone then obj = i:Clone() end
		obj.Parent = here
		if obj:IsA("LocalScript") then obj.Enabled = true end
	end
	
	for _, i in pairs(what:GetChildren()) do
		if i:IsA("ScreenGui") then
			if i.ResetOnSpawn == false then
				if not loaded then 	
					CloneThis(i)
				end
			else
				CloneThis(i)
			end
		else
			CloneThis(i)
		end
	end
end

ply.CameraMode = Enum.CameraMode.LockFirstPerson

local function LoadChar(char)
	print("Character ["..ply.Name.."] Start Loading...")
	Install(CharacterScripts,char,true)
	Install(PlayerGui,ply.PlayerGui,true)
	
	local s = char:WaitForChild("Humanoid")
	s.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	s.NameDisplayDistance = 0
	s.MaxSlopeAngle = 50
	s.WalkSpeed = 13
	s.UseJumpPower = false
	s.JumpHeight = 1.5
	s.JumpPower = 0
	s.BreakJointsOnDeath = false
	s.AutoJumpEnabled = false

	local l = game:GetService("Lighting")
	if l:FindFirstChildOfClass("DepthOfFieldEffect") then
		local ld = l:FindFirstChildOfClass("DepthOfFieldEffect")
		ld.FarIntensity = 0.244
		ld.FocusDistance = 53.44
		ld.InFocusRadius = 50
		ld.NearIntensity = 0.527
	end
	if l:FindFirstChildOfClass("BloomEffect") then
		local lb = l:FindFirstChildOfClass("BloomEffect")
		lb.Intensity = 1
		lb.Size = 32
		lb.Threshold = 3.51
	end
end
LoadChar(ply.Character or ply.CharacterAdded:Wait())
loaded = true
ply.CharacterAdded:Connect(LoadChar)
Install(PlayerScripts,ply.PlayerScripts)