-------------------------------------------------
-- Customizable Dinosaur AI by Cat67383 --
-------------- Written 1/15/2022 --------------
-------------------------------------------------

local Character = script.Parent
local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
local pose = "Standing"

local currentAnim = ""
local currentAnimInstance = nil
local currentAnimTrack = nil
local currentAnimKeyframeHandler = nil
local currentAnimSpeed = 2.9

local runAnimTrack = nil
local runAnimKeyframeHandler = nil

local animTable = {}
local animNames = { 
	idle = 	{	
				{ id = "http://www.roblox.com/asset/?id=507766666", weight = 1 }
			},
	walk = 	{ 	
				{ id = "http://www.roblox.com/asset/?id=507777826", weight = 10 } 
			}, 
	run = 	{
				{ id = "http://www.roblox.com/asset/?id=507767714", weight = 30 } 
			}, 
}

math.randomseed(tick())

function configureAnimationSet(name, fileList)
	if (animTable[name] ~= nil) then
		for _, connection in pairs(animTable[name].connections) do
			connection:disconnect()
		end
	end
	animTable[name] = {}
	animTable[name].count = 0
	animTable[name].totalWeight = 0	
	animTable[name].connections = {}

	local allowCustomAnimations = true
	local AllowDisableCustomAnimsUserFlag = false

	local success, msg = pcall(function()
		AllowDisableCustomAnimsUserFlag = UserSettings():IsUserFeatureEnabled("UserAllowDisableCustomAnims2")
	end)

	if (AllowDisableCustomAnimsUserFlag) then
		local success, msg = pcall(function() allowCustomAnimations = game:GetService("StarterPlayer").AllowCustomAnimations end)
		if not success then
			allowCustomAnimations = true
		end
	end

	-- check for config values
	local config = script:FindFirstChild(name)
	if (allowCustomAnimations and config ~= nil) then
		table.insert(animTable[name].connections, config.ChildAdded:connect(function(child) configureAnimationSet(name, fileList) end))
		table.insert(animTable[name].connections, config.ChildRemoved:connect(function(child) configureAnimationSet(name, fileList) end))
		local idx = 1
		for _, childPart in pairs(config:GetChildren()) do
			if (childPart:IsA("Animation")) then
				table.insert(animTable[name].connections, childPart.Changed:connect(function(property) configureAnimationSet(name, fileList) end))
				animTable[name][idx] = {}
				animTable[name][idx].anim = childPart
				local weightObject = childPart:FindFirstChild("Weight")
				if (weightObject == nil) then
					animTable[name][idx].weight = 1
				else
					animTable[name][idx].weight = weightObject.Value
				end
				animTable[name].count = animTable[name].count + 1
				animTable[name].totalWeight = animTable[name].totalWeight + animTable[name][idx].weight
				idx = idx + 1
			end
		end
	end

	-- fallback to defaults
	if (animTable[name].count <= 0) then
		for idx, anim in pairs(fileList) do
			animTable[name][idx] = {}
			animTable[name][idx].anim = Instance.new("Animation")
			animTable[name][idx].anim.Name = name
			animTable[name][idx].anim.AnimationId = anim.id
			animTable[name][idx].weight = anim.weight
			animTable[name].count = animTable[name].count + 1
			animTable[name].totalWeight = animTable[name].totalWeight + anim.weight
--			print(name .. " [" .. idx .. "] " .. anim.id .. " (" .. anim.weight .. ")")
		end
	end
end

-- Setup animation objects
function scriptChildModified(child)
	local fileList = animNames[child.Name]
	if (fileList ~= nil) then
		configureAnimationSet(child.Name, fileList)
	end	
end

script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)


for name, fileList in pairs(animNames) do 
	configureAnimationSet(name, fileList)
end	

-- ANIMATION

function stopAllAnimations()
	local oldAnim = currentAnim
	
	currentAnim = ""
	currentAnimInstance = nil
	if (currentAnimKeyframeHandler ~= nil) then
		currentAnimKeyframeHandler:disconnect()
	end

	if (currentAnimTrack ~= nil) then
		currentAnimTrack:Stop()
		currentAnimTrack:Destroy()
		currentAnimTrack = nil
	end

	-- clean up walk if there is one
	if (runAnimKeyframeHandler ~= nil) then
		runAnimKeyframeHandler:disconnect()
	end
	
	if (runAnimTrack ~= nil) then
		runAnimTrack:Stop()
		runAnimTrack:Destroy()
		runAnimTrack = nil
	end
	
	return oldAnim
end


function setAnimationSpeed(speed)
	if speed ~= currentAnimSpeed then
		currentAnimSpeed = speed
		currentAnimTrack:AdjustSpeed(currentAnimSpeed)
	end
end

function keyFrameReachedFunc(frameName)
	if (frameName == "End") then
		if currentAnim == "walk" then
			runAnimTrack.TimePosition = 0.0
			currentAnimTrack.TimePosition = 0.0
		else
			local repeatAnim = currentAnim
			local animSpeed = currentAnimSpeed
			playAnimation(repeatAnim, 0.15, Humanoid)
			setAnimationSpeed(animSpeed)
		end
	end
end

function rollAnimation(animName)
	local roll = math.random(1, animTable[animName].totalWeight) 
	local origRoll = roll
	local idx = 1
	while (roll > animTable[animName][idx].weight) do
		roll = roll - animTable[animName][idx].weight
		idx = idx + 1
	end
	return idx
end

function playAnimation(animName, transitionTime, humanoid) 	
	local idx = rollAnimation(animName)
	local anim = animTable[animName][idx].anim

	-- switch animation		
	if (anim ~= currentAnimInstance) then
		
		if (currentAnimTrack ~= nil) then
			currentAnimTrack:Stop(transitionTime)
			currentAnimTrack:Destroy()
		end

		if (runAnimTrack ~= nil) then
			runAnimTrack:Stop(transitionTime)
			runAnimTrack:Destroy()
		end

		currentAnimSpeed = 1.0
	
		-- load it to the humanoid; get AnimationTrack
		currentAnimTrack = humanoid:LoadAnimation(anim)
		 
		-- play the animation
		currentAnimTrack:Play(transitionTime)
		currentAnim = animName
		currentAnimInstance = anim

		-- set up keyframe name triggers
		if (currentAnimKeyframeHandler ~= nil) then
			currentAnimKeyframeHandler:disconnect()
		end
		currentAnimKeyframeHandler = currentAnimTrack.KeyframeReached:connect(keyFrameReachedFunc)
	end
end
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
function onRunning(speed)
	if speed>0.5 and speed<16 then
		playAnimation("walk", 0.2, Humanoid)
		pose = "Walking"
	elseif speed>16 then
		playAnimation("run", 0.2, Humanoid)
		pose = "Running"
	elseif speed<0.5 then
		playAnimation("idle", 0.2, Humanoid)
		pose = "Standing"
	end
end
function onDied()
	pose = "Dead"
end
function onGettingUp()
	pose = "GettingUp"
end
function onFallingDown()
	pose = "FallingDown"
end
function onPlatformStanding()
	pose = "PlatformStanding"
end
local lastTick = 0
function stepAnimate(currentTime)
	local amplitude = 1
	local frequency = 1
  	local deltaTime = currentTime - lastTick
  	lastTick = currentTime
	if (pose == "Dead" or pose == "GettingUp" or pose == "FallingDown" or pose == "Seated" or pose == "PlatformStanding") then
		stopAllAnimations()
		amplitude = 0.1
		frequency = 1
	end
end
-- connect events
Humanoid.Died:connect(onDied)
Humanoid.Running:connect(onRunning)
Humanoid.GettingUp:connect(onGettingUp)
Humanoid.FallingDown:connect(onFallingDown)
Humanoid.PlatformStanding:connect(onPlatformStanding)
-- initialize to idle
playAnimation("idle", 0.1, Humanoid)
pose = "Standing"
-- loop to handle timed state transitions
while Character.Parent ~= nil do
	local currentGameTime = wait(0.1)
	stepAnimate(currentGameTime)
end