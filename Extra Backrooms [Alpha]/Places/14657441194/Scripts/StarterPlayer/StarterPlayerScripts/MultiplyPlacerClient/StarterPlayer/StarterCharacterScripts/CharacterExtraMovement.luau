local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local rootPart = char:WaitForChild("HumanoidRootPart")
local head = char:WaitForChild("Head")
local torso = char:WaitForChild("Torso")
local cam = workspace.CurrentCamera
local HeadRotations = {}

local neck = torso:WaitForChild("Neck")
local yHeadOffSet = neck.C0.Y

local function HeadRotate()
	if hum.Health > 0 then
		local camdir = rootPart.CFrame:ToObjectSpace(cam.CFrame).lookVector

		if neck then
			neck.C0 = CFrame.new(0,yHeadOffSet,0) * CFrame.Angles(-math.acos(camdir.y),0,math.pi)
		end
		
	end
	
	HeadRotations = game.ReplicatedStorage.ChangeHeadRotation:InvokeServer(neck.C0)
end

local function UpdateHeads()
	for player2id, plrneck in pairs(HeadRotations) do
		if tostring(player2id) ~= tostring(plr.UserId) and plrneck ~= "LEAVED" then
			local plr2 = game.Players:FindFirstChild(game.Players:GetNameFromUserIdAsync(player2id))
			if plr2 then
			local char2 = plr2.Character or plr2.CharacterAdded:Wait()
			local hum2 = char2:WaitForChild("Humanoid")
				if hum2.Health > 0 then
					local torso = char2:FindFirstChild("Torso")
					if torso then
						local neck2 = char2:WaitForChild("Torso"):WaitForChild("Neck")
						local neck2rot = plrneck
		
						if neck2 then
							neck2.C0 = neck2rot
						end
				end
			end
		end
		end
	end
end

game:GetService("RunService").RenderStepped:Connect(function(dt)
	if plr then
		HeadRotate()
		UpdateHeads()
	end
end)