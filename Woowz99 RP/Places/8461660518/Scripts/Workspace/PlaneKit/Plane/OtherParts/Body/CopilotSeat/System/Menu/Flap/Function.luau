local FE = script.Parent.Parent.FlapFE
local Anim = script.Parent.Parent.LocalAnim.Value
local Toggle = Anim.Flap
local Button = script.Parent

if Toggle.Value == 0 then
	Button.Text = "Flap [0]"
	Button.BackgroundColor3 = Color3.new(255,0,0)
elseif Toggle.Value == 1 then
	Button.Text = "Flap [5]"
	Button.BackgroundColor3 = Color3.new(0,255,0)
elseif Toggle.Value == 2 then
	Button.Text = "Flap [10]"
	Button.BackgroundColor3 = Color3.new(0,255,0)
elseif Toggle.Value == 3 then
	Button.Text = "Flap [15]"
	Button.BackgroundColor3 = Color3.new(0,255,0)
elseif Toggle.Value == 4 then
	Button.Text = "Flap [20]"
	Button.BackgroundColor3 = Color3.new(0,255,0)
elseif Toggle.Value == 5 then
	Button.Text = "Flap [30]"
	Button.BackgroundColor3 = Color3.new(0,255,0)
elseif Toggle.Value == 6 then
	Button.Text = "Flap [40]"
	Button.BackgroundColor3 = Color3.new(0,255,0)
end

function Flap()
	if Toggle.Value == 0 then
		Toggle.Value = 1
		Button.Text = "Flap [5]"
		Button.BackgroundColor3 = Color3.new(0,255,0)
		Anim.F1.A.Motor.DesiredAngle = 0.1
		Anim.F2.A.Motor.DesiredAngle = 0.1
		Anim.F3.A.Motor.DesiredAngle = 0.1
		Anim.F4.A.Motor.DesiredAngle = 0.1
		Anim.F1.T.A.Motor.DesiredAngle = 0.1
		Anim.F2.T.A.Motor.DesiredAngle = 0.1
		Anim.F3.T.A.Motor.DesiredAngle = 0.1
		Anim.F4.T.A.Motor.DesiredAngle = 0.1
		Anim.FF1.A.Motor.DesiredAngle = 0.2
		Anim.FF2.A.Motor.DesiredAngle = 0.2
		Anim.FF3.A.Motor.DesiredAngle = 0.2
		Anim.FF4.A.Motor.DesiredAngle = 0.2
		Anim.SL1.A.Motor.DesiredAngle = 0.1
		Anim.SL2.A.Motor.DesiredAngle = 0.1
		Anim.SL3.A.Motor.DesiredAngle = 0.1
		Anim.SL4.A.Motor.DesiredAngle = 0.1
	elseif  Toggle.Value == 1 then
		Toggle.Value = 2
		Button.Text = "Flap [10]"
		Button.BackgroundColor3 = Color3.new(0,255,0)
		Anim.F1.A.Motor.DesiredAngle = 0.2
		Anim.F2.A.Motor.DesiredAngle = 0.2
		Anim.F3.A.Motor.DesiredAngle = 0.2
		Anim.F4.A.Motor.DesiredAngle = 0.2
		Anim.F1.T.A.Motor.DesiredAngle = 0.2
		Anim.F2.T.A.Motor.DesiredAngle = 0.2
		Anim.F3.T.A.Motor.DesiredAngle = 0.2
		Anim.F4.T.A.Motor.DesiredAngle = 0.2
		Anim.FF1.A.Motor.DesiredAngle = 0.3
		Anim.FF2.A.Motor.DesiredAngle = 0.3
		Anim.FF3.A.Motor.DesiredAngle = 0.3
		Anim.FF4.A.Motor.DesiredAngle = 0.3
		Anim.SL1.A.Motor.DesiredAngle = 0.2
		Anim.SL2.A.Motor.DesiredAngle = 0.2
		Anim.SL3.A.Motor.DesiredAngle = 0.2
		Anim.SL4.A.Motor.DesiredAngle = 0.2
	elseif  Toggle.Value == 2 then
		Toggle.Value = 3
		Button.Text = "Flap [15]"
		Button.BackgroundColor3 = Color3.new(0,255,0)
		Anim.F1.A.Motor.DesiredAngle = 0.3
		Anim.F2.A.Motor.DesiredAngle = 0.3
		Anim.F3.A.Motor.DesiredAngle = 0.3
		Anim.F4.A.Motor.DesiredAngle = 0.3
		Anim.F1.T.A.Motor.DesiredAngle = 0.3
		Anim.F2.T.A.Motor.DesiredAngle = 0.3
		Anim.F3.T.A.Motor.DesiredAngle = 0.3
		Anim.F4.T.A.Motor.DesiredAngle = 0.3
		Anim.FF1.A.Motor.DesiredAngle = 0.4
		Anim.FF2.A.Motor.DesiredAngle = 0.4
		Anim.FF3.A.Motor.DesiredAngle = 0.4
		Anim.FF4.A.Motor.DesiredAngle = 0.4
		Anim.SL1.A.Motor.DesiredAngle = 0.3
		Anim.SL2.A.Motor.DesiredAngle = 0.3
		Anim.SL3.A.Motor.DesiredAngle = 0.3
		Anim.SL4.A.Motor.DesiredAngle = 0.3
	elseif  Toggle.Value == 3 then
		Toggle.Value = 4
		Button.Text = "Flap [20]"
		Button.BackgroundColor3 = Color3.new(0,255,0)
		Anim.F1.A.Motor.DesiredAngle = 0.4
		Anim.F2.A.Motor.DesiredAngle = 0.4
		Anim.F3.A.Motor.DesiredAngle = 0.4
		Anim.F4.A.Motor.DesiredAngle = 0.4
		Anim.F1.T.A.Motor.DesiredAngle = 0.4
		Anim.F2.T.A.Motor.DesiredAngle = 0.4
		Anim.F3.T.A.Motor.DesiredAngle = 0.4
		Anim.F4.T.A.Motor.DesiredAngle = 0.4
		Anim.FF1.A.Motor.DesiredAngle = 0.5
		Anim.FF2.A.Motor.DesiredAngle = 0.5
		Anim.FF3.A.Motor.DesiredAngle = 0.5
		Anim.FF4.A.Motor.DesiredAngle = 0.5
		Anim.SL1.A.Motor.DesiredAngle = 0.4
		Anim.SL2.A.Motor.DesiredAngle = 0.4
		Anim.SL3.A.Motor.DesiredAngle = 0.4
		Anim.SL4.A.Motor.DesiredAngle = 0.4
	elseif  Toggle.Value == 4 then
		Toggle.Value = 5
		Button.Text = "Flap [30]"
		Button.BackgroundColor3 = Color3.new(0,255,0)
		Anim.F1.A.Motor.DesiredAngle = 0.5
		Anim.F2.A.Motor.DesiredAngle = 0.5
		Anim.F3.A.Motor.DesiredAngle = 0.5
		Anim.F4.A.Motor.DesiredAngle = 0.5
		Anim.F1.T.A.Motor.DesiredAngle = 0.5
		Anim.F2.T.A.Motor.DesiredAngle = 0.5
		Anim.F3.T.A.Motor.DesiredAngle = 0.5
		Anim.F4.T.A.Motor.DesiredAngle = 0.5
		Anim.FF1.A.Motor.DesiredAngle = 0.6
		Anim.FF2.A.Motor.DesiredAngle = 0.6
		Anim.FF3.A.Motor.DesiredAngle = 0.6
		Anim.FF4.A.Motor.DesiredAngle = 0.6
		Anim.SL1.A.Motor.DesiredAngle = 0.5
		Anim.SL2.A.Motor.DesiredAngle = 0.5
		Anim.SL3.A.Motor.DesiredAngle = 0.5
		Anim.SL4.A.Motor.DesiredAngle = 0.5
	elseif  Toggle.Value == 5 then
		Toggle.Value = 6
		Button.Text = "Flap [40]"
		Button.BackgroundColor3 = Color3.new(0,255,0)
		Anim.F1.A.Motor.DesiredAngle = 0.6
		Anim.F2.A.Motor.DesiredAngle = 0.6
		Anim.F3.A.Motor.DesiredAngle = 0.6
		Anim.F4.A.Motor.DesiredAngle = 0.6
		Anim.F1.T.A.Motor.DesiredAngle = 0.6
		Anim.F2.T.A.Motor.DesiredAngle = 0.6
		Anim.F3.T.A.Motor.DesiredAngle = 0.6
		Anim.F4.T.A.Motor.DesiredAngle = 0.6
		Anim.FF1.A.Motor.DesiredAngle = 0.7
		Anim.FF2.A.Motor.DesiredAngle = 0.7
		Anim.FF3.A.Motor.DesiredAngle = 0.7
		Anim.FF4.A.Motor.DesiredAngle = 0.7
		Anim.SL1.A.Motor.DesiredAngle = 0.6
		Anim.SL2.A.Motor.DesiredAngle = 0.6
		Anim.SL3.A.Motor.DesiredAngle = 0.6
		Anim.SL4.A.Motor.DesiredAngle = 0.6
	elseif  Toggle.Value == 6 then
		Toggle.Value = 0
		Button.Text = "Flap [0]"
		Button.BackgroundColor3 = Color3.new(255,0,0)
		Anim.F1.A.Motor.DesiredAngle = 0
		Anim.F2.A.Motor.DesiredAngle = 0
		Anim.F3.A.Motor.DesiredAngle = 0
		Anim.F4.A.Motor.DesiredAngle = 0
		Anim.F1.T.A.Motor.DesiredAngle = 0
		Anim.F2.T.A.Motor.DesiredAngle = 0
		Anim.F3.T.A.Motor.DesiredAngle = 0
		Anim.F4.T.A.Motor.DesiredAngle = 0
		Anim.FF1.A.Motor.DesiredAngle = 0
		Anim.FF2.A.Motor.DesiredAngle = 0
		Anim.FF3.A.Motor.DesiredAngle = 0
		Anim.FF4.A.Motor.DesiredAngle = 0
		Anim.SL1.A.Motor.DesiredAngle = 0
		Anim.SL2.A.Motor.DesiredAngle = 0
		Anim.SL3.A.Motor.DesiredAngle = 0
		Anim.SL4.A.Motor.DesiredAngle = 0
	end
end

FE.OnServerEvent:Connect(Flap)
