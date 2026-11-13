local uis = game:GetService("UserInputService")
local plrdata = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerData)
local s = require(plrdata.Script)

wait(1)

local Priorities = {
	["1"] = Enum.AnimationPriority.Core,
	["2"] = Enum.AnimationPriority.Idle,
	["3"] = Enum.AnimationPriority.Movement,
	["4"] = Enum.AnimationPriority.Action,
	["5"] = Enum.AnimationPriority.Action2,
	["6"] = Enum.AnimationPriority.Action3,
	["7"] = Enum.AnimationPriority.Action4
}

--[[ Айди, Приоритет (1-7), Скорость, Размытие ]]
local AnimationsList = {
	Idle = {"18348357996",1,0.05,0.5},
	Walk = {"18348664077",2,0.5,0.5}
}

local AnimationTracks = {}

local AnimationsSpeed = {}

for name, animdata in pairs(AnimationsList) do
	local id = "rbxassetid://"..animdata[1]
	local anim = Instance.new("Animation")
	anim.Name = name
	anim.AnimationId = id
	anim.Parent = plrdata.Humanoid.Animator
	track = plrdata.Humanoid.Animator:LoadAnimation(anim)
	track.Priority = Priorities[tostring(animdata[2])]
	AnimationsSpeed[name] = animdata[3] 
	AnimationTracks[name] = track
end

function PlayAnimation(id,bool)
	local track = AnimationTracks[id]
	if bool == nil then
		bool = false
	end
	if track.IsPlaying ~= bool then
		if bool  then
			track:Play(AnimationsList[id][4])
		else
			track:Stop(AnimationsList[id][4])
		end
	end
	if bool then
		track:AdjustSpeed(AnimationsSpeed[id])
	end
end

function SetAnimationSpeed(id,speed)
	AnimationsSpeed[id] = speed
end

game:GetService("RunService").RenderStepped:Connect(function(dt)
	local NowAnimations = {}
	
	for id in pairs(AnimationsList) do
		NowAnimations[id] = false
	end
	
	if plrdata.Walk then
		NowAnimations["Walk"] = true
	else
		NowAnimations["Idle"] = true
	end
	
	local backwardwalk = 1
	if plrdata.WalkBackward then
		backwardwalk = -1
	end
	SetAnimationSpeed("Walk",plrdata.WalkSpeed/plrdata.WalkSpeedValues.Default/2*backwardwalk)
	for id, b in pairs(NowAnimations) do
		PlayAnimation(id,b)
	end
end)