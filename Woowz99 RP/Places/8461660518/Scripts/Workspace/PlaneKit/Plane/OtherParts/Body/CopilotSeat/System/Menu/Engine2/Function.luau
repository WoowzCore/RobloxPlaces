local FE = script.Parent.Parent.Engine2FE
local Anim = script.Parent.Parent.LocalAnim.Value
local Main = script.Parent.Parent.Main.Value.Parent.Sound2
local Toggle = Anim.Engine1Value
local Button = script.Parent

if Toggle.Value == false then
	Button.BackgroundColor3 = Color3.new(255,0,0)
else
	Button.BackgroundColor3 = Color3.new(0,255,0)
end

function Engine()
	if Toggle.Value == false then
		Button.BackgroundColor3 = Color3.new(255,255,0)
		Main.ON:Play()
		repeat
			Anim.Engine2.A.Motor.MaxVelocity = Anim.Engine2.A.Motor.MaxVelocity + 0.001
			wait()
			Anim.Engine2.A.Motor.MaxVelocity = Anim.Engine2.A.Motor.MaxVelocity + 0.001
		until Anim.Engine2.A.Motor.MaxVelocity > 0.999
		Main.Normal.Volume = 3
		Main.Reverse.Volume = 1
		Toggle.Value = true
		Button.BackgroundColor3 = Color3.new(0,255,0)
	else
		Button.BackgroundColor3 = Color3.new(255,255,0)
		Main.OFF:Play()
		Main.Normal.Volume = 0
		Main.Reverse.Volume = 0
		repeat
			Anim.Engine2.A.Motor.MaxVelocity = Anim.Engine2.A.Motor.MaxVelocity - 0.001
			wait()
			Anim.Engine2.A.Motor.MaxVelocity = Anim.Engine2.A.Motor.MaxVelocity - 0.001
		until Anim.Engine2.A.Motor.MaxVelocity < 0.001
		Toggle.Value = false
		Button.BackgroundColor3 = Color3.new(255,0,0)
	end
end

FE.OnServerEvent:Connect(Engine)
