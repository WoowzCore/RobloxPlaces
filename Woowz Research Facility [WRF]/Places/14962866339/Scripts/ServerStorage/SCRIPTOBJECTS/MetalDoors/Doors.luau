local base = require(game:GetService("ServerScriptService").Base)
local doorl, doorr = script.Parent.Door, script.Parent.Door2
local rychka = doorl.Rychka

local dooropen = false

local locked = false

local weldl,weldr = doorl.HingeConstraint,doorr.HingeConstraint

local waiting = false
local function ChangeDoorState(bool)
	if waiting then return end
	if dooropen == bool then return end
	waiting = true
	
	local rand1 = math.random(1,3)/10
	base.ts(doorl.Weld,TweenInfo.new(rand1),{C0 = CFrame.new(-1.55, -1.2, 0) * CFrame.Angles(0, math.rad(-90), 0)})
	base.ts(doorl.Weld,TweenInfo.new(rand1),{C1 = CFrame.new() * CFrame.Angles(math.rad(45),0, 0)})
	wait(rand1)
	local function CloseRychka()
		rand1 = math.random(1,3)/10
		base.ts(doorl.Weld,TweenInfo.new(rand1),{C0 = CFrame.new(-1.45, -0.95, 0) * CFrame.Angles(math.rad(0), math.rad(-90), 0)})
		base.ts(doorl.Weld,TweenInfo.new(rand1),{C1 = CFrame.new()})
		wait(rand1)
	end
	
	if locked then rychka.lock:Play() CloseRychka() waiting = false return end
	
	if not bool then
		local function setweld(weld,r)
			weld.ActuatorType = Enum.ActuatorType.Servo
			if r then
				weld.TargetAngle = -180
			else
				weld.TargetAngle = 0
			end
		end
		setweld(weldl,false)
		setweld(weldr,true)
		local lrot = 1-math.abs(doorl.HingeConstraint.CurrentAngle+78)/72
		local rrot = 1-math.abs(doorr.HingeConstraint.CurrentAngle+102)/72
		
		wait(math.max(lrot,rrot))
		rychka.close:Play()
	else
		rychka.open:Play()
		weldl.TargetAngle = -90
		weldr.TargetAngle = -90
		wait(0.5)
		weldl.ActuatorType = Enum.ActuatorType.None
		weldr.ActuatorType = Enum.ActuatorType.None
	end
	CloseRychka()
	
	dooropen = bool
	script.Parent.Open.Value = dooropen
	waiting = false
end

if script.Parent.Open.Value then
	ChangeDoorState(true)
end

doorl.trigger.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
	ChangeDoorState(not dooropen)
end)

local function ChangeLock(bool)
	if waiting then return end
	waiting = true
	
	doorl.PartLock.Sound:Play()
	
	local rot = 0
	if bool then
		rot = 90
	end
	
	base.ts(doorl.WeldKey,TweenInfo.new(0.05),{C1 = CFrame.Angles(math.rad(rot),0,0)})
	wait(0.05)
	
	locked = bool
	
	waiting = false	
end

if script.Parent.Lock.Value and script.Parent.Open.Value == false then
	ChangeLock(true)
end

doorl.trigger2.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
	if not dooropen then
		ChangeLock(not locked)
	end
end)