local pistol = script.Parent
local base = require(game:GetService("ServerScriptService").Base)
local plrs = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")
local sss = game:GetService("ServerScriptService")

local l1,l2,l3,l4,l5 = pistol.lamp1,pistol.lamp2,pistol.lamp3,pistol.lamp4,pistol.lamp5

local ammo = 5

local shootsounds = {"6569844325","800000246"}

local active = nil

local function ChangeLight(bulb,bool,disable)
	if disable == nil then disable = false end
	if bool then
		if disable then
			bulb.Color = Color3.fromRGB(255, 62, 62)
		else
			bulb.Color = Color3.fromRGB(255, 255, 0)
		end
		bulb.Material = Enum.Material.Neon
	else
		bulb.Color = Color3.fromRGB(153, 120, 64)
		bulb.Material = Enum.Material.Glass
	end
end

local hole = CFrame.new()
pistol.RayFromTool.RayFromToolRE.OnServerEvent:Connect(function(plr,pos,hit,cframe,rot)
	hole = cframe
end)

local function updlight()
	ChangeLight(l1,ammo == 5,not active)
	ChangeLight(l2,ammo >= 4,not active)
	ChangeLight(l3,ammo >= 3,not active)
	ChangeLight(l4,ammo >= 2,not active)
	ChangeLight(l5,ammo >= 1,not active)
end

local function Shoot(plr)
	pistol.MeshPart.Sound.SoundId = "rbxassetid://"..shootsounds[math.random(1,#shootsounds)]
	pistol.MeshPart.Sound.PlaybackSpeed = math.random(80,120)/100
	pistol.MeshPart.Sound:Play()
	
	updlight()
	
	base.Shoot(hole,plr)
end
local waiting = false
pistol.Use.Event:Connect(function()
	if waiting then return end
	if ammo <= 0 or not active then waiting = true pistol.MeshPart.Sound.SoundId = "rbxassetid://9117396156" pistol.MeshPart.Sound.Volume = 1 pistol.MeshPart.Sound.RollOffMaxDistance = 30 pistol.MeshPart.Sound:Play() 	wait(0.5) waiting = false return end
	waiting = true
	
	ammo -= 1
	Shoot(plrs:GetPlayerFromCharacter(pistol.Parent))
	
	wait(0.1)
	waiting = false
end)

local function UpdateActive(bool)
	if bool == active then return end
	active = bool
	updlight()
end
UpdateActive(false)

while wait(0.5) do
	if pistol.Parent:FindFirstChildOfClass("Humanoid") then
		UpdateActive(sss.ServerInfo.Data.Emergency.Value)
	else
		UpdateActive(false)
	end
end