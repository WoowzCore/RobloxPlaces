local Player = script.Parent.Parent
local Character = Player.Character
if not Character or not Character.Parent then
	Character = Player.CharacterAdded:Wait()
end
local Humanoid = Character:WaitForChild("Humanoid")
local HumRootPart = Character:WaitForChild("HumanoidRootPart")

local Shift_pressed = false
local Ctrl_pressed = false
local Shift_Ctrl_Speed_Multiply = 1
local Speed_Buttons_Multipy = {
	slow = 0.5, normal = 1, fast = 1.25
}

function ConvertAngle_to_number(vec)
	return (math.abs(((vec.X + vec.Y + vec.Z)/3)-(1/3)))*100
end

local Angle = 0
function UpdateGroundAngle()
	local r = Ray.new(HumRootPart.Position, Vector3.new(0,-(Character.Humanoid.HipHeight+4),0))
	local _,_,n = workspace:FindPartOnRayWithIgnoreList(r,{Character})
	Angle = ConvertAngle_to_number(n)
end

local buttons = game:GetService("UserInputService")
buttons.InputBegan:Connect(function(input,gp)
	local k = input.KeyCode
	if k == Enum.KeyCode.LeftShift then
		print("press")
		Shift_pressed = true
	end
	if k == Enum.KeyCode.LeftControl then
		Ctrl_pressed = true
	end
end)
buttons.InputEnded:Connect(function(input,gp)
	local k = input.KeyCode
	if k == Enum.KeyCode.LeftShift then
		print("unpress")
		Shift_pressed = false
	end
	if k == Enum.KeyCode.LeftControl then
		Ctrl_pressed = false
	end
end)

while wait() do
	UpdateGroundAngle()
	if Shift_pressed then
		if Ctrl_pressed then
			Shift_Ctrl_Speed_Multiply = Speed_Buttons_Multipy.normal
		else
			Shift_Ctrl_Speed_Multiply = Speed_Buttons_Multipy.fast
		end
	else
		if Ctrl_pressed then
			if Shift_pressed then
				Shift_Ctrl_Speed_Multiply = Speed_Buttons_Multipy.normal
			else
				Shift_Ctrl_Speed_Multiply = Speed_Buttons_Multipy.slow
			end
		else
			Shift_Ctrl_Speed_Multiply = Speed_Buttons_Multipy.normal
		end
	end
	Humanoid.WalkSpeed = (15*Shift_Ctrl_Speed_Multiply) - (Angle/(4/Shift_Ctrl_Speed_Multiply))
	print(Humanoid.WalkSpeed)
end

