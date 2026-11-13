local chr = script.Parent
local hum = chr:WaitForChild("Humanoid")

local head = chr:WaitForChild("Head")
local torso = chr:WaitForChild("Torso")
local arm_l = chr:WaitForChild("Left Arm")
local arm_r = chr:WaitForChild("Right Arm")
local leg_l = chr:WaitForChild("Left Leg")
local leg_r = chr:WaitForChild("Right Leg")
local root = chr:WaitForChild("HumanoidRootPart")

wait(0.5)
while wait() do
	if chr:FindFirstChild("Head") and chr:FindFirstChild("Torso") and chr:FindFirstChild("HumanoidRootPart") then
		local result = hum.MaxHealth 
			* (head.Health.Value/hum.MaxHealth) 
			* (torso.Health.Value/hum.MaxHealth) 
			+ ( (arm_l.Health.Value-hum.MaxHealth)/4 ) 
			+ ( (arm_r.Health.Value-hum.MaxHealth)/4 ) 
			+ ( (leg_l.Health.Value-hum.MaxHealth)/4 ) 
			+ ( (leg_r.Health.Value-hum.MaxHealth)/4 )
		hum.Health = math.max(math.min(result,hum.MaxHealth),0)
		
		if root.CFrame.Position.y <= -500 then
			chr:MoveTo(Vector3.new(0,1000,0))
		end
	else
		hum.Health = 0
	end
end