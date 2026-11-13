-- Created by ShowAboutKids 11/15/2021
-- This is V2 of my Frying Pan Weapon

-- It should work more efficently now

local tool = script.Parent
local sounds = tool:FindFirstChild("Sounds")
local pan = tool:FindFirstChild("Pan")
local sound = math.random(0, 2)

local equipped = false

function touched(hit)
	sound = math.random(0, 2)		
	
	local humanoid = hit.Parent:FindFirstChildWhichIsA("Humanoid")		

	if humanoid then
		local scream, smack1, smack2 = sounds:FindFirstChild("Scream"), sounds:FindFirstChild("Smack"), sounds:FindFirstChild("Smack2")
		
		humanoid.Health = humanoid.Health - 10
		
		if humanoid.Health == 0 then
			scream:Play()
		end

		if humanoid.Health > 20 then
			if sound == 1 then
				smack1:Play()
			end

			if sound == 2 then
				smack2:Play()
			end				
		end			
	end
end

tool.Equipped:Connect(function()
	equipped = true
end)

tool.Unequipped:Connect(function()
	equipped = false
end)

pan.Touched:Connect(touched)