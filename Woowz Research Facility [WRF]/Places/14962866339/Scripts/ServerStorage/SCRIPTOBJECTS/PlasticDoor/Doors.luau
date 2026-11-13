local base = require(game:GetService("ServerScriptService").Base)
local door = script.Parent.doorbase
local rychka = door.rychka

local dooropen = false

local waiting = false
local function ChangeDoorState(bool)
	if waiting then return end
	if dooropen == bool then return end
	waiting = true
	dooropen = bool
	
	local rand1 = math.random(1,3)/10
	base.ts(door.rychka_basa.Weld,TweenInfo.new(rand1),{C0 = CFrame.new(0, -0.15, 0.18)})
	base.ts(door.rychka_basa.Weld,TweenInfo.new(rand1),{C1 = CFrame.new() * CFrame.Angles(math.rad(-45),0, 0)})
	wait(rand1)
	local function CloseRychka()
		rand1 = math.random(1,3)/10
		base.ts(door.rychka_basa.Weld,TweenInfo.new(rand1),{C0 = CFrame.new(0, 0, 0.25)})
		base.ts(door.rychka_basa.Weld,TweenInfo.new(rand1),{C1 = CFrame.new()})
		wait(rand1)
	end
	
	if bool then
		rychka.open:Play()
		door.HingeConstraint.TargetAngle = -45
		wait(0.5)
		door.HingeConstraint.ActuatorType = Enum.ActuatorType.None
	else
		local function setweld(weld)
			weld.ActuatorType = Enum.ActuatorType.Servo
			weld.TargetAngle = 0
		end
		setweld(door.HingeConstraint)
		local lrot = math.abs(door.HingeConstraint.CurrentAngle)/90

		wait(lrot*1.5)
		rychka.close:Play()
	end
	CloseRychka()
	
	script.Parent.Open.Value = dooropen
	waiting = false
end

if script.Parent.Open.Value == true then
	ChangeDoorState(true)
end

script.Parent.doorbase.trigger.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
	ChangeDoorState(not dooropen)
end)