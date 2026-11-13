local body = script.Parent
local face = body["3DImage"].Face

local spawnpos = body.Position

local EBL = require(game:GetService("ServerScriptService"):WaitForChild("EBLibbary"))

local angry = false
local attack = false

local timer = 0
local timermax = 0

local savedplayer = nil
local savedchar = nil

local invisible = body.Invisible.Value
local inv = 1

function FaceUpdate()
	if invisible then
		face.ImageTransparency = inv
		body.Loop.Volume = 1 - inv
		if inv >= 1 then
			body.Dark.Enabled = false
		else
			body.Dark.Enabled = true
		end
	end
	if not angry then return end
	local i = 20
	if attack then i = 80 end
	face.Position = UDim2.new(0.1,math.random(-i,i)/10,0.1,math.random(-i,i)/10)
	if not invisible then
		face.ImageTransparency = math.random(0,20)/100
	end
	local col = math.random(255-i,255)
	face.ImageColor3 = Color3.fromRGB(255,col,col)
end

local function GetPlayersWithinDistance(from : Vector3, distance : number)
	local t = {}
	for _, v in pairs(game.Players:GetPlayers()) do
		if v.Character and v:DistanceFromCharacter(from) < distance then
			table.insert(t, v)
		end
	end
	if #t > 0 then
		savedplayer = t[math.random(1,#t)]
		savedchar = savedplayer.Character or savedplayer.CharacterAdded:Wait()
	else
		savedplayer = nil
		savedchar = nil
	end
	return t 
end

function Move(pos1,pos2,dist2)
	if pos1 == nil or pos2 == nil then return end
	local dir = (pos1 - pos2).Unit
	local dist = (pos1 - pos2).Magnitude
	
	local speed = 100
	if dist2 and not angry then
		speed = dist
	end
	if angry and not attack then
		speed = 0
	end
	
	if dist > 0 then
		body.CFrame = body.CFrame + dir * speed * math.min(dist,1/60)
	end
end

function Restart()
	angry = false
	attack = false
	face.Position = UDim2.new(0.1,0,0.1,0)
	face.ImageTransparency = 0
	face.ImageColor3 = Color3.fromRGB(255,255,255)
	body.LoopAttack:Stop()
end

function MoveUpdate()
	if not attack then
		Move(spawnpos,body.Position,true)
	return end
	if savedplayer ~= nil then 
		local plrpos = savedchar:WaitForChild("HumanoidRootPart").Position
		local objpos = body.Position
	
		Move(plrpos,objpos)
		if savedchar.Humanoid.MoveDirection.Magnitude > 5 and math.random(0,100) >= 99 then
			Restart()
		end
	end
end

function Attact()
	GetPlayersWithinDistance(body.Position,100)
	body.Attack:Play()
	body.LoopAttack:Play()
end

body.Touched:Connect(function(hit)
	if hit.Name == "LightTrigger" then
		angry = true
		timer = 0
		timermax = math.random(50,500)
	elseif hit.Parent:FindFirstChild("Humanoid") then
		if (invisible and inv <= 0.9) or (not invisible) then
			EBL.DetectHurt(hit.Parent:WaitForChild("Torso"),"kill","Sharp")
			body.Attack:Play()
			Restart()
		end
	end
end)

while wait() do
	FaceUpdate()
	MoveUpdate()
	if invisible then
		if angry then
			if inv > 0 then
				inv -= 0.01
			else
				inv = 0
			end
		else
			if inv < 1 then
				inv += 0.01
			else
				inv = 1
			end
		end
	end
	if angry and not attack then
		timer+=1
		if timer >= timermax then
			attack = true
			Attact()
		end
	end
end