local MultiplyPlacer = game:GetService("ServerStorage").MultiplyPlacer

local ReplicatedStorage = MultiplyPlacer.ReplicatedStorage
local ServerScriptService = MultiplyPlacer.ServerScriptService
local ServerStorage = MultiplyPlacer.ServerStorage
local Teams = MultiplyPlacer.Teams
local SoundService = MultiplyPlacer.SoundService

local function Install(what,here)
	for _, i in pairs(what:GetChildren()) do
		i.Parent = here
	end
	print(what.Name .. " Installed!")
end

local s = game:GetService("StarterPlayer")
s.HealthDisplayDistance = 100
s.NameDisplayDistance = 0
s.CameraMaxZoomDistance = 0.5
s.CameraMinZoomDistance = 0.5
s.CameraMode = Enum.CameraMode.LockFirstPerson
s.CharacterMaxSlopeAngle = 50
s.CharacterWalkSpeed = 13
s.LoadCharacterAppearance = true
s.UserEmotesEnabled = false
s.CharacterUseJumpPower = false
s.CharacterJumpHeight = 1.5
s.EnableMouseLockOption = false
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

local w = game:GetService("Workspace")

w.Gravity = 45

Install(Teams,game:GetService("Teams"))
Install(SoundService,game:GetService("SoundService"))
Install(ServerStorage,game:GetService("ServerStorage"))
Install(ReplicatedStorage,game:GetService("ReplicatedStorage"))
Install(ServerScriptService,game:GetService("ServerScriptService"))