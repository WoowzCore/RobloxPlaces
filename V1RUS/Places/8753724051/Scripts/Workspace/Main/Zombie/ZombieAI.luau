local Zombie = script.Parent
local ZombieBase = Zombie.HumanoidRootPart
local Humanoid = Zombie.Humanoid
local PathFinding = game:GetService("PathfindingService")
local Path = nil

--[[==========================================================]]
local WalkSpeed = 5
local JumpSettings = {Power = 1; Height = 2;}
local FeelingSAVE = {Smell_Humanity = 100; Smell_Zombity = 50; Sound = 10;}
--[[==========================================================]]
local IQ = math.random(0,2)
local Social = math.random(0,1)

local Feeling = {Smell_Humanity = FeelingSAVE.Smell_Humanity + math.random(-95,30); Smell_Zombity = FeelingSAVE.Smell_Zombity; Sound = FeelingSAVE.Sound;}
Humanoid.WalkSpeed = WalkSpeed + (math.random(-40,40)/10)
Humanoid.JumpHeight = JumpSettings.Height
Humanoid.JumpPower = JumpSettings.Power

Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)

local MoveTo = nil

local function SetMove(pos)
	MoveTo = pos
end

local function FoundMoving()
	local move = nil
	local followplayer = nil
	local followzombie = nil
	
	if Social==1 then
		for _,zombies in ipairs(game.Scene.Map.Zombies:GetChildren()) do
			local ZOMBIE = zombies.Humanoid
			if ZOMBIE.ID.Value ~= Zombie.ID.Value then
				local base = ZOMBIE:WaitForChild("HumanoidRootPart")
					if base then
					if (base.Position-ZombieBase.Position).Magnitude < Feeling.Smell_Zombity then
						if math.random(0,100) > 199 then
							followzombie = base.Position
						end
						end
					end
			end
		end
	end
	
	for _,players in ipairs(game:GetService("Players"):GetPlayers()) do
		local character = players.Character or players.CharacterAdded:Wait()
		if character then
			local base = character:WaitForChild("HumanoidRootPart")
			if base then
				if (base.Position-ZombieBase.Position).Magnitude < Feeling.Smell_Humanity then
					followplayer = base.Position
				end
			end
		end
	end



	if followplayer then
		move = followplayer
	else
		if followzombie then
			move = followzombie
		end
	end

	if move then
		SetMove(move)
	else
		local rand = math.random(0,100)
		if rand > 99 then
			local zompos = ZombieBase.Position
			local pos = Vector3.new(zompos.x+math.random(-30,30),zompos.y,zompos.z+math.random(-30,30))
			SetMove(pos)
		end
	end
end

local function Moving()
	FoundMoving()
	if MoveTo then
		
		Path = PathFinding:CreatePath()
		Path:ComputeAsync(ZombieBase.Position,MoveTo)

		local WPs = Path:GetWaypoints()

		for i,wp in pairs(WPs) do
			local WalkType = wp.Action
			if WalkType == Enum.PathWaypointAction.Jump then
				Humanoid.Jump = true
			end
			
			Humanoid:MoveTo(wp.Position)
			if MoveTo then
				if (MoveTo-ZombieBase.Position).Magnitude <= 3.1 then
					SetMove(nil)
				end
			end
			
			if wp then
				if (wp.Position - ZombieBase.Position).Magnitude > 60 then
					SetMove(nil)
				end
			end

		end
	end
end

while wait(0.1) do
	Moving()
	if MoveTo == nil then
		print("NOW HAVE MOVETO")
	end
end