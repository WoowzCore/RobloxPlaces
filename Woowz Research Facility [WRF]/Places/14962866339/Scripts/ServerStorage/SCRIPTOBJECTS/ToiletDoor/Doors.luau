local base = require(game:GetService("ServerScriptService").Base)
local door = script.Parent.doorcollision
local rychka = script.Parent.rychka

local dooropen = false
local lock = false

local waiting = false
local function ChangeDoorState(bool,rnd)
	if lock then return end
	if waiting then return end
	if dooropen == bool then return end
	waiting = true
	dooropen = bool
	
	if bool then
		door.Anchored = false
		if rnd then
			door.HingeConstraint.TargetAngle = math.random(0,90)
		else
			door.HingeConstraint.TargetAngle = 75
		end
		wait(0.5)
		door.HingeConstraint.ActuatorType = Enum.ActuatorType.None
	else
		local function setweld(weld)
			weld.ActuatorType = Enum.ActuatorType.Servo
			weld.TargetAngle = 0
		end
		setweld(door.HingeConstraint)
		local lrot = math.abs(door.HingeConstraint.CurrentAngle)/90

		wait(lrot+0.5)
		rychka.close:Play()
		door.Anchored = true
	end
	
	script.Parent.Open.Value = dooropen
	waiting = false
end

local lockwaiting = false
local function ChangeLockState(bool)
	if lockwaiting then return end
	if lock == bool then return end
	if dooropen then return end
	lockwaiting = true
	lock = bool
	
	if bool then
		base.ts(script.Parent.lockpart.Weld,TweenInfo.new(1),{C1 = CFrame.new(0, 0, 0.1)})
		base.ts(script.Parent.lockpart.WeldLOCK,TweenInfo.new(1),{C1 = CFrame.Angles(math.rad(90),0,0)})
	else
		base.ts(script.Parent.lockpart.Weld,TweenInfo.new(1),{C1 = CFrame.new()})
		base.ts(script.Parent.lockpart.WeldLOCK,TweenInfo.new(1),{C1 = CFrame.new()})
	end
	wait(1)
	
	lockwaiting = false
end

if script.Parent.Open.Value == true then
	ChangeDoorState(true)
end

script.Parent.trigger.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
	ChangeDoorState(not dooropen)
end)

script.Parent.trigger2.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
	ChangeLockState(not lock)
end)

if math.random(0,100) >= 50 then
	ChangeDoorState(true,true)
end