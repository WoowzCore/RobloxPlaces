local toolActivated = false
local ACCELERATION_SPEED = 30
local TIME_TO_MAX_SPEED = 3
local TIME_TO_STOP = 1
local timeToolUsed = 0
local currentTime
local previousTime
local currentAcceleration = 0
local checkTouchpadEvent
local usingTouchpad = false
local particleEmitter = script.Parent.Handle.ParticleEmitter
local light = script.Parent.Handle.PointLight
local MAX_LIGHT = 5
local MAX_RANGE = 15
local MIN_LIGHT = 2
local MIN_RANGE = 8

local function smoothStep(t)
	return t*t*t*(t*(t*6 - 15) + 10);
end

local function accelerateTime(dt)
	local animationStep
	if toolActivated then
		timeToolUsed = timeToolUsed + dt
		if timeToolUsed > TIME_TO_MAX_SPEED then
			timeToolUsed = TIME_TO_MAX_SPEED
		end
		animationStep = timeToolUsed / TIME_TO_MAX_SPEED
	else
		timeToolUsed = timeToolUsed - dt
		if timeToolUsed < 0 then
			timeToolUsed = 0
		end
		animationStep = timeToolUsed / TIME_TO_STOP
	end
	
	local sstep = smoothStep(animationStep)
	if sstep > .01 then
		particleEmitter.Rate = 50 + sstep * 150
	else
		particleEmitter.Rate = 0
	end
	currentAcceleration = ACCELERATION_SPEED * sstep
	if currentAcceleration <= 0 then
		currentAcceleration = 0
		light.Brightness = 0
		light.Range = 0
	end
	
	if currentAcceleration ~= 0 then
		local currentTime = game.Lighting:GetMinutesAfterMidnight()
		currentTime = currentTime + currentAcceleration
		script.Parent.ChangeTime:FireServer(currentTime)
		light.Brightness = animationStep * MAX_LIGHT + MIN_LIGHT
		light.Range = animationStep * MAX_RANGE + MIN_RANGE
	end
end

function activateTool()
	if not usingTouchpad then
		toolActivated = true
	else
		toolActivated = not toolActivated
		if not toolActivated then
			timeToolUsed = timeToolUsed / TIME_TO_MAX_SPEED * TIME_TO_STOP
		end
	end
	particleEmitter.Rate = 200
end

function deactivateTool()
	if not usingTouchpad then
		toolActivated = false
		timeToolUsed = timeToolUsed / TIME_TO_MAX_SPEED * TIME_TO_STOP
	end
end

function setUsingTouchpad()
	usingTouchpad = true
end

local checkTouchpadEvent = game:GetService("UserInputService").TouchStarted:connect(setUsingTouchpad)
script.Parent.Activated:connect(activateTool)
script.Parent.Deactivated:connect(deactivateTool)
script.Parent.Unequipped:connect(deactivateTool)
currentTime = tick()

while wait() do
	previousTime = currentTime
	currentTime = tick()
	accelerateTime(currentTime-previousTime)
end