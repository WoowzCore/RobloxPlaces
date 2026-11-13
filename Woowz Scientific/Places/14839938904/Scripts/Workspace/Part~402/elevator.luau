local elevator = script.Parent

local etashicframes = {Vector3.new(-374, -0.36, 41),Vector3.new(-374, -199.396, 41),Vector3.new(-374, -923.799, 41),Vector3.new(-374, -2261.337, 41)}
local lastetashcframe = Vector3.new(-374, -0.36, 41)

local function Move(e,i)
	game:GetService("TweenService"):Create(elevator,TweenInfo.new(i,Enum.EasingStyle.Linear),{CFrame = CFrame.new(etashicframes[e]) * CFrame.Angles(0, 0, math.rad(-90))}):Play()
end

local etash = 1
local back = false

local function Dvig()
	lastetashcframe = etashicframes[etash]
	wait(15)
	if back then
		etash -= 1
		if etash == 1 then
			back = false
		end
	else
		etash += 1
		if etash == 4 then
			back = true
		end
	end
	local i = math.abs((math.abs(lastetashcframe.Magnitude))-(math.abs(etashicframes[etash].Magnitude)))/8
	Move(etash,i)
	wait(i)
	Dvig()
end
Dvig()