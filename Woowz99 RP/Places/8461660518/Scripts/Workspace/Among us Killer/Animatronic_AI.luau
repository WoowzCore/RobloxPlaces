local zomb = script.Parent:WaitForChild("Humanoid")
local info = script.Parent:WaitForChild("Info")
local jumpscare = script:WaitForChild("ONO")
local shades = nil

local lines = {
	'WE ALL FLOAT DOWN HERE!',
	'BEEP BEEP RICHIE',
	'do you want a balloon.',
    "You'll float too.",
	'HAHAHAHAHA!'
}

local distance = 100
local detectdistance = 80
local detectspeed = 10

Spawn(function()
if script.Parent:FindFirstChild("Hair") then
local W = Instance.new("Weld")
W.Part0 = script.Parent.Head
W.Part1 = script.Parent.Hair
W.C0 = script.Parent.Head.CFrame:inverse()*CFrame.new(script.Parent.Head.Position)
W.C1 = script.Parent.Hair.CFrame:inverse()*CFrame.new(script.Parent.Head.Position)
W.Parent = script.Parent.Torso
script.Parent:FindFirstChild("Hair").Anchored = false
end
if script.Parent:FindFirstChild("Eye1") then
local W = Instance.new("Weld")
W.Part0 = script.Parent.Head
W.Part1 = script.Parent.Eye1
W.C0 = script.Parent.Head.CFrame:inverse()*CFrame.new(script.Parent.Head.Position)
W.C1 = script.Parent.Eye1.CFrame:inverse()*CFrame.new(script.Parent.Head.Position)
W.Parent = script.Parent.Torso
script.Parent:FindFirstChild("Eye1").Anchored = false
end
if script.Parent:FindFirstChild("Eye2") then
local W = Instance.new("Weld")
W.Part0 = script.Parent.Head
W.Part1 = script.Parent.Eye2
W.C0 = script.Parent.Head.CFrame:inverse()*CFrame.new(script.Parent.Head.Position)
W.C1 = script.Parent.Eye2.CFrame:inverse()*CFrame.new(script.Parent.Head.Position)
W.Parent = script.Parent.Torso
script.Parent:FindFirstChild("Eye2").Anchored = false
end
if script.Parent:FindFirstChild("Top") then
local W = Instance.new("Weld")
W.Part0 = script.Parent.Head
W.Part1 = script.Parent.Top
W.C0 = script.Parent.Head.CFrame:inverse()*CFrame.new(script.Parent.Head.Position)
W.C1 = script.Parent.Top.CFrame:inverse()*CFrame.new(script.Parent.Head.Position)
W.Parent = script.Parent.Torso
script.Parent:FindFirstChild("Top").Anchored = false
end
if script.Parent:FindFirstChild("Jaw") then
local W = Instance.new("Weld")
W.Part0 = script.Parent.Head
W.Part1 = script.Parent.Jaw
W.C0 = script.Parent.Head.CFrame:inverse()*CFrame.new(script.Parent.Head.Position)
W.C1 = script.Parent.Jaw.CFrame:inverse()*CFrame.new(script.Parent.Head.Position)
W.Parent = script.Parent.Torso
script.Parent:FindFirstChild("Jaw").Anchored = false
end
if script.Parent:FindFirstChild("Shades") then
shades = script.Parent:FindFirstChild("Shades")
local W = Instance.new("Weld")
W.Part0 = script.Parent.Head
W.Part1 = script.Parent.Shades
W.C0 = script.Parent.Head.CFrame:inverse()*CFrame.new(script.Parent.Head.Position)
W.C1 = script.Parent.Shades.CFrame:inverse()*CFrame.new(script.Parent.Head.Position)
W.Parent = script.Parent.Torso
shades.Anchored = false
shades.Transparency = 0
end
end)

function findNearestTorso(pos)
	local list = game.Workspace:children()
	local torso = nil
	local dist = distance
	local temp = nil
	local human = nil
	local temp2 = nil
	for x = 1, #list do
		temp2 = list[x]
		if (temp2.className == "Model") and (temp2 ~= script.Parent) then
			temp = temp2:findFirstChild("Torso")
			human = temp2:findFirstChild("Humanoid")
			if (temp ~= nil) and (human ~= nil) and (human.Health > 0) then
				if (temp.Position - pos).magnitude < dist then
					torso = temp
					dist = (temp.Position - pos).magnitude
				end
			end
		end
	end
	return torso
end

damage = true
function Hit(hit)
	local plr = game.Players:GetPlayerFromCharacter(hit.Parent)
	if plr and damage == true and info.Mode.Value == "Angry" then
		damage = false
		jumpscare:Clone().Parent = plr.PlayerGui
		info.Mode.Value = "Walk"
		wait(2)
		damage = true
	end
end

script.Parent["Left Arm"].Touched:connect(Hit)
script.Parent["Right Arm"].Touched:connect(Hit)
script.Parent["Left Leg"].Touched:connect(Hit)
script.Parent["Right Leg"].Touched:connect(Hit)
script.Parent["Torso"].Touched:connect(Hit)
script.Parent["Head"].Touched:connect(Hit)

walked = true
low = true

info.Mode.Changed:connect(function()
while info.Mode.Value == "Walk" do
  wait(0.1)
     Spawn(function() 
	  if walked == true then
	  walked = false
	  a = 1024
	  zomb:MoveTo(Vector3.new(math.random(-a, a), 0, math.random(-a, a)), game.Workspace.Terrain)
	  wait(12) 
	  walked = true
	  end 
     end)
     Spawn(function()
	  if info.DetectPercent.Value > 0 and low == true then
		 low = false
         wait(5)
         info.DetectPercent.Value = info.DetectPercent.Value - 5
         low = true
	  end
     end)

    if shades then shades.Transparency = 0 end
	zomb.WalkSpeed = 100
	local target = findNearestTorso(script.Parent.Head.Position)
	if target ~= nil then
		info.DetectPercent.Value = info.DetectPercent.Value + detectspeed
		
		if info.DetectPercent.Value >= 100  then
		info.DetectPercent.Value = 100
		info.Mode.Value = "Angry"
		 game:GetService("Chat"):Chat(script.Parent.Head,lines[math.random(1, #lines)],"Red")
		end
		
		if info.DetectPercent.Value < 0 then
		info.DetectPercent.Value = 0
		end

	end
	target = nil
end

while info.Mode.Value == "Angry" do
	wait(0.1)
	if shades then shades.Transparency = 1 end
	zomb.WalkSpeed = 100
	local target = findNearestTorso(script.Parent.Head.Position)
	if target ~= nil then
	zomb:MoveTo(target.Position+(Vector3.new(1,1,1)*(2*((math.random()*2)-1))),target)
	else
	  info.Mode.Value = "Walk"
	  info.DetectPercent.Value = 0
	end
	target = nil
end
end)
info.Mode.Value = "Walk" 