local FE = script.Parent.Parent.DoorLockFE
local Anim = script.Parent.Parent.LocalAnim.Value
local Toggle = Anim.DoorLock
local Button = script.Parent

if Toggle.Value == false then
	Button.BackgroundColor3 = Color3.new(255,0,0)
else
	Button.BackgroundColor3 = Color3.new(0,255,0)
end

function Lock()
	if Toggle.Value == false then
		Toggle.Value = true
		Button.BackgroundColor3 = Color3.new(0,255,0)
		Anim.FLDoor.Script.Disabled = true
		Anim.FRDoor.Script.Disabled = true
		Anim.RLDoor.Script.Disabled = true
		Anim.RRDoor.Script.Disabled = true
		Anim.FLDoor.ClickDetector.MaxActivationDistance = 0
		Anim.FRDoor.ClickDetector.MaxActivationDistance = 0
		Anim.RLDoor.ClickDetector.MaxActivationDistance = 0
		Anim.RRDoor.ClickDetector.MaxActivationDistance = 0
		Anim.FLDoor.A.Motor.DesiredAngle = 0
		Anim.FRDoor.A.Motor.DesiredAngle = 0
		Anim.RLDoor.A.Motor.DesiredAngle = 0
		Anim.RRDoor.A.Motor.DesiredAngle = 0
	else
		Toggle.Value = false
		Button.BackgroundColor3 = Color3.new(255,0,0)
		Anim.FLDoor.Script.Disabled = false
		Anim.FRDoor.Script.Disabled = false
		Anim.RLDoor.Script.Disabled = false
		Anim.RLDoor.Script.Disabled = false
		Anim.FLDoor.ClickDetector.MaxActivationDistance = 10
		Anim.FRDoor.ClickDetector.MaxActivationDistance = 10
		Anim.RLDoor.ClickDetector.MaxActivationDistance = 10
		Anim.RRDoor.ClickDetector.MaxActivationDistance = 10
	end
end

FE.OnServerEvent:Connect(Lock)
