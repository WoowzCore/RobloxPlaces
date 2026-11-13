local FE = script.Parent.Parent.ReverseFE
local Anim = script.Parent.Parent.LocalAnim.Value
local Main = script.Parent.Parent.Main.Value.Parent
local Toggle = Anim.Reverser
local Button = script.Parent

if Toggle.Value == false then
	Button.BackgroundColor3 = Color3.new(255,0,0)
else
	Button.BackgroundColor3 = Color3.new(0,255,0)
end

function MoveOut()
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,-0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,-0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,-0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,-0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,-0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,-0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,-0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,-0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,-0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,-0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,-0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,-0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,-0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,-0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,-0.1)
end

function MoveIn()
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,0.1)
	wait(0.01)
	Anim.RThrust.A.Motor.C1 = Anim.RThrust.A.Motor.C1 * CFrame.new(0,0,0.1)
end

function Reverse()
	if Toggle.Value == false then
		Button.BackgroundColor3 = Color3.new(255,255,0)
		Main.Sound1.Reverse:Play()
		Main.Sound2.Reverse:Play()
		MoveOut()
		Toggle.Value = true
		Button.BackgroundColor3 = Color3.new(0,255,0)
	else
		Button.BackgroundColor3 = Color3.new(255,255,0)
		Main.Sound1.Reverse:Stop()
		Main.Sound2.Reverse:Stop()
		MoveIn()
		Toggle.Value = false
		Button.BackgroundColor3 = Color3.new(255,0,0)
	end
end

FE.OnServerEvent:Connect(Reverse)
