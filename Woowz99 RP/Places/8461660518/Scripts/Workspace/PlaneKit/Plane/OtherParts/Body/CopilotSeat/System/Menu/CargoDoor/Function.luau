local FE = script.Parent.Parent.CargoDoorFE
local Anim = script.Parent.Parent.LocalAnim.Value
local Toggle = Anim.CargoDoor
local Button = script.Parent

if Toggle.Value == false then
	Button.BackgroundColor3 = Color3.new(255,0,0)
else
	Button.BackgroundColor3 = Color3.new(0,255,0)
end

function Cargo()
	if Toggle.Value == false then
		Toggle.Value = true
		Button.BackgroundColor3 = Color3.new(0,255,0)
		Anim.CDoor1.A.Motor.DesiredAngle = 0.9
		Anim.CDoor2.A.Motor.DesiredAngle = 0.9
	else
		Toggle.Value = false
		Button.BackgroundColor3 = Color3.new(255,0,0)
		Anim.CDoor1.A.Motor.DesiredAngle = 0
		Anim.CDoor2.A.Motor.DesiredAngle = 0
	end
end

FE.OnServerEvent:Connect(Cargo)
