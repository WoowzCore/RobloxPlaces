plr = game.Players.LocalPlayer;
repeat
	wait()
until plr.Character
char = plr.Character
m = plr:GetMouse()
local IsEquipped = false

local ArmsPositions = {}

local origRightS = char:WaitForChild("Torso"):WaitForChild("Right Shoulder").C0
local origLeftS = char:WaitForChild("Torso"):WaitForChild("Left Shoulder").C0
local origNeck = char:WaitForChild("Torso"):WaitForChild("Neck").C0
local camera = game.Workspace.CurrentCamera

local UIS = game:GetService("UserInputService")

local hum = char:WaitForChild("Humanoid")

local c = game.Workspace.CurrentCamera

local Crawl = false

local function UpdateArmPosition()
	local tors = char:FindFirstChild("Torso")
	if tors == nil then return end
	local ra = tors:FindFirstChild("Right Shoulder")
	if ra == nil then return end
	if IsEquipped == true and not Crawl then
		if ra then
			ra.C0 = ra.C0:Lerp(CFrame.new(1, 0.65, 0) * CFrame.Angles(-math.asin((m.Origin.p - m.Hit.p).unit.y), 1.55, 0) , 0.1)
		end
	else

		if ra then
			ra.C0 = ra.C0:lerp(origRightS, 0.1)
		end
	end
	
	if char.Torso:FindFirstChild("Right Shoulder") then
		ArmsPositions = game.ReplicatedStorage.ChangeArmsPosition:InvokeServer(char.Torso["Right Shoulder"].C0)
	end
end

local function UpdateArmsPositions()
	for player2id, plrshoulder in pairs(ArmsPositions) do
		if tostring(player2id) ~= tostring(plr.UserId) and plrshoulder ~= "LEAVED" then
			local plr2 = game.Players:FindFirstChild(game.Players:GetNameFromUserIdAsync(player2id))
			if plr2 then
				local char2 = plr2.Character or plr2.CharacterAdded:Wait()
				local hum2 = char2:WaitForChild("Humanoid")
				if hum2.Health > 0 then
					if char2:FindFirstChild("Torso") == nil then return end
					local shoulder2 = char2:WaitForChild("Torso"):WaitForChild("Right Shoulder")
					local shoulder2rot = plrshoulder

					if shoulder2 then
						shoulder2.C0 = plrshoulder
					end
				end
			end
		end
	end
end

game:GetService("RunService").RenderStepped:Connect(function(delta)
	local animations = {}
	for i, v in pairs(hum:WaitForChild("Animator"):GetPlayingAnimationTracks()) do
		table.insert(animations,v.Name)
	end
	Crawl = (table.find(animations,"Crawl"))
	
    if plr then
		UpdateArmPosition()
		UpdateArmsPositions()
	end

end)


char.ChildAdded:Connect(function(instance)
	for i,v in pairs(char:GetChildren()) do
		if v:IsA("Tool") then
			if v:FindFirstChild("HoldArmsStill") then

			else
				IsEquipped = true
			end
		end
	end
end)

char.ChildRemoved:Connect(function(instance)	
	if instance:IsA("Tool") then
		IsEquipped = false
	end
end)
