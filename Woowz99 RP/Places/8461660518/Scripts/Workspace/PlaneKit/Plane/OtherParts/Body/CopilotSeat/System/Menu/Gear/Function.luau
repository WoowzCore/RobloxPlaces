local FE = script.Parent.Parent.GearFE
local Anim = script.Parent.Parent.LocalAnim.Value
local HeadLight = script.Parent.Parent.LightSystem.LocalHeadLight.Value
local HeadLightValue = script.Parent.Parent.LightSystem.LocalLight.Value.HeadValue
local Toggle = Anim.Gear
local Button = script.Parent
local HeadLightButton = script.Parent.Parent.LightSystem.HeadLight

if Toggle.Value == true then
	Button.BackgroundColor3 = Color3.new(0,255,0)
else
	Button.BackgroundColor3 = Color3.new(255,0,0)
end

function LowGear()
	Anim.NGear.Wheel.A.Motor.C1 = Anim.NGear.Wheel.A.Motor.C1 * CFrame.new(0,-0.1,0)
	Anim.LGear.Gear.Wheel.A.Motor.C1 = Anim.LGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,-0.1,0)
	Anim.RGear.Gear.Wheel.A.Motor.C1 = Anim.RGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,-0.1,0)
	wait(0.02)
	Anim.NGear.Wheel.A.Motor.C1 = Anim.NGear.Wheel.A.Motor.C1 * CFrame.new(0,-0.1,0)
	Anim.LGear.Gear.Wheel.A.Motor.C1 = Anim.LGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,-0.1,0)
	Anim.RGear.Gear.Wheel.A.Motor.C1 = Anim.RGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,-0.1,0)
	wait(0.02)
	Anim.NGear.Wheel.A.Motor.C1 = Anim.NGear.Wheel.A.Motor.C1 * CFrame.new(0,-0.1,0)
	Anim.LGear.Gear.Wheel.A.Motor.C1 = Anim.LGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,-0.1,0)
	Anim.RGear.Gear.Wheel.A.Motor.C1 = Anim.RGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,-0.1,0)
	wait(0.02)
	Anim.NGear.Wheel.A.Motor.C1 = Anim.NGear.Wheel.A.Motor.C1 * CFrame.new(0,-0.1,0)
	Anim.LGear.Gear.Wheel.A.Motor.C1 = Anim.LGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,-0.1,0)
	Anim.RGear.Gear.Wheel.A.Motor.C1 = Anim.RGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,-0.1,0)
	wait(0.02)
	Anim.NGear.Wheel.A.Motor.C1 = Anim.NGear.Wheel.A.Motor.C1 * CFrame.new(0,-0.1,0)
	Anim.LGear.Gear.Wheel.A.Motor.C1 = Anim.LGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,-0.1,0)
	Anim.RGear.Gear.Wheel.A.Motor.C1 = Anim.RGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,-0.1,0)
	wait(0.02)
	Anim.NGear.Wheel.A.Motor.C1 = Anim.NGear.Wheel.A.Motor.C1 * CFrame.new(0,-0.1,0)
	Anim.LGear.Gear.Wheel.A.Motor.C1 = Anim.LGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,-0.1,0)
	Anim.RGear.Gear.Wheel.A.Motor.C1 = Anim.RGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,-0.1,0)
end

function RaiseGear()
	Anim.NGear.Wheel.A.Motor.C1 = Anim.NGear.Wheel.A.Motor.C1 * CFrame.new(0,0.1,0)
	Anim.LGear.Gear.Wheel.A.Motor.C1 = Anim.LGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,0.1,0)
	Anim.RGear.Gear.Wheel.A.Motor.C1 = Anim.RGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,0.1,0)
	wait(0.02)
	Anim.NGear.Wheel.A.Motor.C1 = Anim.NGear.Wheel.A.Motor.C1 * CFrame.new(0,0.1,0)
	Anim.LGear.Gear.Wheel.A.Motor.C1 = Anim.LGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,0.1,0)
	Anim.RGear.Gear.Wheel.A.Motor.C1 = Anim.RGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,0.1,0)
	wait(0.02)
	Anim.NGear.Wheel.A.Motor.C1 = Anim.NGear.Wheel.A.Motor.C1 * CFrame.new(0,0.1,0)
	Anim.LGear.Gear.Wheel.A.Motor.C1 = Anim.LGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,0.1,0)
	Anim.RGear.Gear.Wheel.A.Motor.C1 = Anim.RGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,0.1,0)
	wait(0.02)
	Anim.NGear.Wheel.A.Motor.C1 = Anim.NGear.Wheel.A.Motor.C1 * CFrame.new(0,0.1,0)
	Anim.LGear.Gear.Wheel.A.Motor.C1 = Anim.LGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,0.1,0)
	Anim.RGear.Gear.Wheel.A.Motor.C1 = Anim.RGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,0.1,0)
	wait(0.02)
	Anim.NGear.Wheel.A.Motor.C1 = Anim.NGear.Wheel.A.Motor.C1 * CFrame.new(0,0.1,0)
	Anim.LGear.Gear.Wheel.A.Motor.C1 = Anim.LGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,0.1,0)
	Anim.RGear.Gear.Wheel.A.Motor.C1 = Anim.RGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,0.1,0)
	wait(0.02)
	Anim.NGear.Wheel.A.Motor.C1 = Anim.NGear.Wheel.A.Motor.C1 * CFrame.new(0,0.1,0)
	Anim.LGear.Gear.Wheel.A.Motor.C1 = Anim.LGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,0.1,0)
	Anim.RGear.Gear.Wheel.A.Motor.C1 = Anim.RGear.Gear.Wheel.A.Motor.C1 * CFrame.new(0,0.1,0)
end

function LowGearDoor()
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(-0.05,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(-0.05,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(-0.1,0,0)
end

function RaiseGearDoor()
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(0.05,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(0.05,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	wait(0.02)
	Anim.LGDoor.Door.A.Motor.C1 = Anim.LGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
	Anim.RGDoor.Door.A.Motor.C1 = Anim.RGDoor.Door.A.Motor.C1 * CFrame.new(0.1,0,0)
end

function DisableHeadLight()
	HeadLightValue.Value = false
	HeadLight.Material = Enum.Material.Glass
	HeadLight.Light.Enabled = false
	HeadLight.Dynamic.Enabled = false
	HeadLight.White.Enabled = false
	HeadLightButton.Function.Disabled = true
	HeadLightButton.Remote.Disabled = true
	HeadLightButton.BackgroundColor3 = Color3.new(255,0,0)
end

function EnableHeadLight()
	HeadLightButton.Function.Disabled = false
	HeadLightButton.Remote.Disabled = false
end

function Gear()
	if Toggle.Value == true then
		Button.BackgroundColor3 = Color3.new(255,255,0)
		DisableHeadLight()
		RaiseGear()
		wait(1)
		Anim.NGear.A.Motor.DesiredAngle = 1.8
		Anim.LGear.A.Motor.DesiredAngle = 1.4
		Anim.LGear.Gear.A.Motor.DesiredAngle = 0.1
		Anim.RGear.A.Motor.DesiredAngle = 1.4
		Anim.RGear.Gear.A.Motor.DesiredAngle = 0.1
		Anim.LGear.Gear.Strut.A.Motor.DesiredAngle = 0.9
		Anim.RGear.Gear.Strut.A.Motor.DesiredAngle = 0.9
		Anim.LGDoor.A.Motor.DesiredAngle = 0
		Anim.RGDoor.A.Motor.DesiredAngle = 0
		wait(1)
		Anim.LGDoor.Door.Door.A.Motor.DesiredAngle = 0
		Anim.RGDoor.Door.Door.A.Motor.DesiredAngle = 0
		RaiseGearDoor()
		wait(4)
		Anim.NGDoorL.A.Motor.DesiredAngle = 0
		Anim.NGDoorR.A.Motor.DesiredAngle = 0
		wait(1)
		Toggle.Value = false
		Button.BackgroundColor3 = Color3.new(255,0,0)
	else
		Button.BackgroundColor3 = Color3.new(255,255,0)
		Anim.NGDoorL.A.Motor.DesiredAngle = 1.35
		Anim.NGDoorR.A.Motor.DesiredAngle = 1.35
		wait(1)
		Anim.NGear.A.Motor.DesiredAngle = 0
		Anim.LGear.A.Motor.DesiredAngle = 0
		Anim.RGear.A.Motor.DesiredAngle = 0
		Anim.LGDoor.A.Motor.DesiredAngle = 1.5
		Anim.RGDoor.A.Motor.DesiredAngle = 1.5
		Anim.LGDoor.Door.Door.A.Motor.DesiredAngle = 1
		Anim.RGDoor.Door.Door.A.Motor.DesiredAngle = 1
		wait(1)
		LowGearDoor()
		wait(2)
		Anim.LGear.Gear.A.Motor.DesiredAngle = 0
		Anim.RGear.Gear.A.Motor.DesiredAngle = 0
		Anim.LGear.Gear.Strut.A.Motor.DesiredAngle = 0
		Anim.RGear.Gear.Strut.A.Motor.DesiredAngle = 0
		wait(1)
		LowGear()
		EnableHeadLight()
		Toggle.Value = true
		Button.BackgroundColor3 = Color3.new(0,255,0)
	end
end

FE.OnServerEvent:Connect(Gear)
