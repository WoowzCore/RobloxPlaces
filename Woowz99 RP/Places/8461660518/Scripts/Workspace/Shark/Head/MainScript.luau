local Head = script.Parent
local Humanoid = Head.Parent:WaitForChild("Humanoid")
local BodyPos = Head:WaitForChild("BodyPosition")
local BodyGyro = Head:WaitForChild("BodyGyro")
local AttackDistance = Head.Parent:WaitForChild("AttackDistance", 25) and Head.Parent:FindFirstChild("AttackDistance").Value or 100
local Speed = Head:WaitForChild("Speed").Value
BodyPos.Position = Head.Position
BodyGyro.CFrame = Head.CFrame
local MainTarget

local function Move(Target)
	local Dir = (Target.Position - Head.Position).Unit
	local SpawnPos = Head.Position
	local Pos = SpawnPos + (Dir * 1)
	BodyGyro.CFrame = CFrame.new(Pos,  Pos + Dir)
	BodyGyro.MaxTorque = Vector3.new(9000, 9000, 9000)
end

local function MoveTo(Target)
	BodyPos.Position = Target.Position
	BodyPos.MaxForce = Vector3.new(10000, 10000, 10000) * Speed
end

Humanoid.HealthChanged:Connect(function()
	local CreatorTag = Humanoid:FindFirstChild("creator") or Humanoid:FindFirstChild("Creator")
	if CreatorTag then
		local Tagged = CreatorTag.Value
		if Tagged and Tagged:IsA("Player") then
			MainTarget = Tagged.Character and Tagged.Character:FindFirstChildOfClass("Humanoid") or MainTarget
		else
			MainTarget = Tagged
		end
	end
end)

-- // The function for finding a target
local function FindNearestTorso(pos, Distance)
	local Torso
	for _, Obj in ipairs(workspace:GetChildren()) do
		if Obj:IsA("Model") and Obj ~= Head.Parent and Obj.Name ~= Head.Parent then
			local Humanoid = Obj:FindFirstChildOfClass("Humanoid")
			if Humanoid and Humanoid.Health > 0 then
				local Temp = Humanoid.RootPart
				if Temp and (Temp.Position - pos).Magnitude < Distance then
					Torso = Temp
					Distance = (Torso.Position - pos).Magnitude
				end
			end
		end
	end
	return Torso
end

if Head.Angry.Playing == false then
	Head.Angry:Play()
end

while true do
	if MainTarget and MainTarget.Health > 0 and MainTarget.RootPart and (Head.Position - MainTarget.RootPart.Position).Magnitude > AttackDistance then
		Move(MainTarget.RootPart)
		MoveTo(MainTarget.RootPart)
	else
		local Torso = FindNearestTorso(Head.Position, AttackDistance)
		if Torso then
			Move(Torso)
			MoveTo(Torso)
			MainTarget = Torso.Parent:FindFirstChildOfClass("Humanoid")
		else
			task.wait(2)
		end
	end
	task.wait(1)
end
