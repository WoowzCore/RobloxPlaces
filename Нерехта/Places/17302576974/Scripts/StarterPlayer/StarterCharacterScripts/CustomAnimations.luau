local PlayerData = require(script.Parent:WaitForChild("PlayerData"))

local Animations = {
--[[(Название) (Айди) (Слой 1-7) (Скорость) (Повторяемая) (Смешивание)]]
	["idle"]       = {"17322494818",1,1,true,0},
	["walk"]       = {"17322192773",2,1,true,0},
	["run"]        = {"17322501330",2,1,true,0},
	["crawl"]      = {"17349635482",2,1,true,0},
	["crawl_idle"] = {"17352104991",2,1,true,0},
	["lay"]        = {"17352053683",2,1,true,0},
	["lay_walk"]   = {"17349989851",2,1,true,0},
	["died"]       = {"17322504898",1,1,true,0},
}

local AnimationsTraks = {}

function LoadAnimations()
	local animpriority = {
		Enum.AnimationPriority.Core, Enum.AnimationPriority.Idle, Enum.AnimationPriority.Movement, Enum.AnimationPriority.Action, Enum.AnimationPriority.Action2, Enum.AnimationPriority.Action3, Enum.AnimationPriority.Action4
	}
	
	for id, animinfo in pairs(Animations) do
		if animinfo[1] ~= "" then
			local anim = Instance.new("Animation")
			anim.Name = id
			anim.Parent = PlayerData.Character:WaitForChild("Animations")
			anim.AnimationId = "rbxassetid://"..animinfo[1]
			local track = PlayerData.Humanoid:LoadAnimation(anim)
			track.Priority = animpriority[animinfo[2]]
			track.Looped = animinfo[4]
			AnimationsTraks[id] = track
		end
	end
end
script.Parent:WaitForChild("PlayerData").LoadAnimations.Event:Connect(LoadAnimations)

local WorkedAnimations = {}
local AS = {}
function ChangeAnimationState(id,speed)
	local state = AS[id]
	if state == nil then state = false end
	
	local animinfo = Animations[id]
	if animinfo == nil then
		warn("Animation ["..id.."] not found!")
	else
		if speed == nil then speed = animinfo[3] end
		if state then
			if AnimationsTraks[id] ~= nil then
				AnimationsTraks[id]:AdjustSpeed(speed)
			end
			if (not WorkedAnimations[id]) then
				WorkedAnimations[id] = true
				if AnimationsTraks[id] ~= nil then
					AnimationsTraks[id]:Play()
				end
			end
		else
			if (WorkedAnimations[id]) then
				WorkedAnimations[id] = false
				if AnimationsTraks[id] ~= nil then
					AnimationsTraks[id]:Stop()
				end
			end
		end
	end
end

game:GetService("RunService").RenderStepped:Connect(function(dt)
	if (PlayerData.PlayerLoaded) then
		AS["idle"] = true
		local PlayerMovement = PlayerData.Humanoid.MoveDirection.Magnitude*PlayerData.Humanoid.WalkSpeed
		
		AS["lay"] = PlayerData.Laying
		AS["crawl_idle"] = PlayerData.Crawl and not AS["lay"]
		
		if PlayerMovement > 0 then
			if PlayerMovement > 18 then
				AS["run"] = not AS["lay"] and not AS["crawl_idle"]
			else
				AS["walk"] = not AS["lay"] and not AS["crawl_idle"]
			end
			if AS["crawl_idle"] then AS["crawl_idle"] = false AS["crawl"] = true end
			if AS["lay"] then AS["lay"] = false AS["lay_walk"] = true end
		end
		
		
		if AS["died"] then
			AS = {}
			AS["died"] = true
		end
		ChangeAnimationState("walk",PlayerData.Humanoid.WalkSpeed/12)
		ChangeAnimationState("idle")
		ChangeAnimationState("run")
		ChangeAnimationState("crawl")
		ChangeAnimationState("crawl_idle")
		ChangeAnimationState("lay")
		ChangeAnimationState("lay_walk")
		ChangeAnimationState("died")
		AS = {}
	end
end)