local FE = script.Parent.Parent.SpoilerFE
local Anim = script.Parent.Parent.LocalAnim.Value
local Toggle = Anim.Spoiler
local Button = script.Parent

if Toggle.Value == 0 then
	Button.Text = "Spoiler [Unarmed]"
	Button.BackgroundColor3 = Color3.new(255,0,0)
elseif Toggle.Value == 1 then
	Button.Text = "Spoiler [Flight]"
	Button.BackgroundColor3 = Color3.new(0,255,0)
elseif Toggle.Value == 2 then
	Button.Text = "Spoiler [Armed]"
	Button.BackgroundColor3 = Color3.new(0,255,0)
end

function Spoiler()
	if Toggle.Value == 0 then
		Button.Text = "Spoiler [Flight]"
		Toggle.Value = 1
		Button.BackgroundColor3 = Color3.new(0,255,0)
		Anim.S1.A.Motor.DesiredAngle = 0.3
		Anim.S2.A.Motor.DesiredAngle = 0.3
		Anim.S3.A.Motor.DesiredAngle = 0.3
		Anim.S4.A.Motor.DesiredAngle = 0.3
	elseif Toggle.Value == 1 then
		Button.Text = "Spoiler [Armed]"
		Toggle.Value = 2
		Button.BackgroundColor3 = Color3.new(0,255,0)
		Anim.S1.A.Motor.DesiredAngle = 0.8
		Anim.S2.A.Motor.DesiredAngle = 0.8
		Anim.S3.A.Motor.DesiredAngle = 0.8
		Anim.S4.A.Motor.DesiredAngle = 0.8
	elseif Toggle.Value == 2 then
		Button.Text = "Spoiler [Unarmed]"
		Toggle.Value = 0
		Button.BackgroundColor3 = Color3.new(255,0,0)
		Anim.S1.A.Motor.DesiredAngle = 0
		Anim.S2.A.Motor.DesiredAngle = 0
		Anim.S3.A.Motor.DesiredAngle = 0
		Anim.S4.A.Motor.DesiredAngle = 0
	end
end

FE.OnServerEvent:Connect(Spoiler)
