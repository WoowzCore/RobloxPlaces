local Click = script.Parent.ClickDetector
local Hinge = script.Parent.A
local Toggle = false

function DoorOpen()
	if Toggle == false then
		Toggle = true
		Hinge.Motor.DesiredAngle = 3
	else
		Toggle = false
		Hinge.Motor.DesiredAngle = 0
	end
end


Click.MouseClick:Connect(DoorOpen)