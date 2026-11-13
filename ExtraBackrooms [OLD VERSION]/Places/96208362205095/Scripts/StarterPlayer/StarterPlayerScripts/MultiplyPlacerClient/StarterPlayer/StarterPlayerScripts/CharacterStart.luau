local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local EBL = require(char:WaitForChild("EBLibbary"))

local function ChangeSurivalStats()
	EBL.ChangeSurvivalStats("Water",true,math.random(500,1000))
	EBL.ChangeSurvivalStats("Food",true,math.random(500,1000))
	EBL.ChangeSurvivalStats("Mental",true,math.random(800,1000))
end

local function HasProperty(object,prop)
	local t = object[prop]
end

local function updchar()
	local char = plr.Character or plr.CharacterAdded:Wait()
	local hum = char:WaitForChild("Humanoid")
	local anim = char:WaitForChild("Animate")
	hum:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)

	anim:WaitForChild("sit"):WaitForChild("SitAnim").AnimationId = "http://www.roblox.com/asset/?id=14522811961"

	for _, v in pairs(char:GetChildren()) do
		if v:IsA("Part") then
			v.CastShadow = false
		elseif v:IsA("Accessory") then
			for _2, a in pairs(v:GetDescendants()) do
				local success = pcall(function() HasProperty(a,"CastShadow") end)
				if success then
					a.CastShadow = false
				end
			end
		end
		
		if v.Name == "Health" then
			v:Destroy()
		end
		
		if v.Name == "HumanoidRootPart"  then
			for _2, v2 in pairs(v:GetChildren()) do
				if v2.Name == "Climbing"
					or v2.Name == "Died"
					or v2.Name == "FreeFalling"
					or v2.Name == "GettingUp"
					or v2.Name == "Jumping"
					or v2.Name == "Landing"
					or v2.Name == "Running"
					or v2.Name == "Splash"
					or v2.Name == "Swimming" then
					v2:Destroy()
				end
			end
		end
	end
	
	for _, v in pairs(plr:WaitForChild("PlayerScripts"):GetChildren()) do
		if v.Name == "RbxCharacterSounds" then
			v:Destroy()
		end
	end
	
	local head = char:WaitForChild("Head")
	if head then
		local light = Instance.new("PointLight")
		light.Name = "Eyes"
		light.Parent = head
		light.Shadows = false
		light.Brightness = 0.07
		light.Range = 9
		
	end
	
	if plr:GetJoinData().TeleportData == nil then
		ChangeSurivalStats()
	end
	
	print("Character ["..plr.Name.."] Loaded!")
end

game:GetService("ReplicatedStorage").ChangeCharacter.OnClientEvent:Connect(updchar)