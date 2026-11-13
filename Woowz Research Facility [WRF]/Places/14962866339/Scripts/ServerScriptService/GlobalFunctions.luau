local rs = game:GetService("ReplicatedStorage")
local base = require(script.Parent.Base)
local log = game:GetService("LogService")
local ss = game:GetService("ServerStorage")
local data = script.Parent.ServerInfo.Data

rs.ActivateClickDetector.OnServerEvent:Connect(function(plr,detector)
	if detector:IsA("ClickDetector") then
		if detector:FindFirstChild("ClickDetectorScript") then
			base.ClickDetector(plr,detector)
		end
	end
end)

rs.GiveLog.OnServerInvoke = function()
	return log:GetLogHistory()
end

log.MessageOut:Connect(function(m,t)
	rs.PrintResult:FireAllClients(m,t)
end)

rs.GetWorkspace.OnServerInvoke = function()
	return game.Workspace:GetDescendants()
end

rs.ToArmOrBackpack.OnServerEvent:Connect(function(plr,tool,backpack)
	if tool == nil then return end
	local backpack_ = plr:WaitForChild("Backpack")
	local chr = plr.Character or plr.CharacterAdded:Wait()
	if backpack then
		tool.Parent = backpack_
	else
		tool.Parent = chr
	end
end)

rs.UpdateDragDetector.OnServerEvent:Connect(function(plr,drag,enabled)
	drag.Enabled = enabled
	if not enabled then
		drag:RestartDrag()
	end
end)

local function DropItem(item,cframe : CFrame?)
	if item ~= nil then
		base.ChangeItemPositionID(item,0)
		item.Parent = game.Workspace
		if cframe ~= nil then
			item.Handle.CFrame = cframe
		end
	end
end
rs.DropItem.OnServerEvent:Connect(function(plr,item,cframe)
	DropItem(item,cframe)
end)
rs.DropItemSERVER.Event:Connect(DropItem)

rs.ThrowItem.OnServerEvent:Connect(function(plr,item,cframe,power,angle)
	DropItem(item,cframe)
	local part = item.Handle
	local mass = part.AssemblyMass
	mass = math.max(0.24,mass)
	mass = math.min(2,mass)
	part:ApplyImpulse(angle * mass * power)
	base.PlaySound(444895479,part.Position,math.random(5,10)/10,10,math.random(90,110)/100)
end)

rs.Punch.OnServerEvent:Connect(function(plr,pos,part,leg)
	local power = 15
	if leg then
		power = 35
	end
	part.Velocity = (part.Position - pos).Unit * power
end)

local function ReplaceMotor6D(motor,bool)
	if bool then
		local ball = Instance.new("BallSocketConstraint")
		ball.Name = motor.Name.."_ball"
		ball.Parent = motor.Parent
		ball.MaxFrictionTorque = 1
		ball.LimitsEnabled = true
		ball.UpperAngle = 45
		local at1,at2 = nil,nil
		if motor.Name == "Neck" then
			at1 = motor.Parent.RagdollH
			at2 = motor.Parent.Parent.Head.RagdollH
		end
		if motor.Name == "Left Shoulder" then
			at1 = motor.Parent.RagdollAL
			at2 = motor.Parent.Parent["Left Arm"].RagdollAL
		end
		if motor.Name == "Right Shoulder" then
			at1 = motor.Parent.RagdollAR
			at2 = motor.Parent.Parent["Right Arm"].RagdollAR
		end
		if motor.Name == "Left Hip" then
			at1 = motor.Parent.RagdollLL
			at2 = motor.Parent.Parent["Left Leg"].RagdollLL
		end
		if motor.Name == "Right Hip" then
			at1 = motor.Parent.RagdollLR
			at2 = motor.Parent.Parent["Right Leg"].RagdollLR
		end
		ball.Attachment0 = at1
		ball.Attachment1 = at2
		motor.Enabled = false
	else
		local ball = motor.Parent:FindFirstChild(motor.Name.."_ball")
		ball:Destroy()
		motor.Enabled = true
	end
end

local masses = {}

local function ChangeObjectMassles(obj,change : boolean,bool : boolean?)
	local masses2 = masses[obj:GetFullName()]
	if masses2 == nil then
		masses[obj:GetFullName()] = {}
		for _, part in pairs(obj:GetDescendants()) do
			if part:IsA("BasePart") then
				masses[obj:GetFullName()][part:GetFullName()] = part.Massless
			end
		end
		masses2 = masses[obj:GetFullName()]
	end
	
	for _, part in pairs(obj:GetDescendants()) do
		if part:IsA("BasePart") then
			if change then
				part.Massless = bool
			else
				part.Massless = masses2[part:GetFullName()]
			end
		end
	end
end

local collisionschar = {}

local function ChangeCollisionsCharacter(plr,change : boolean,bool : boolean?)
	local cs = collisionschar[tostring(plr.UserId)]
	local chr = plr.Character or plr.CharacterAdded:Wait()
	if cs == nil then
		collisionschar[tostring(plr.UserId)] = {}
		for _, part in pairs(chr:GetDescendants()) do
			if part:IsA("BasePart") then
				collisionschar[tostring(plr.UserId)][part:GetFullName()] = {part.CanCollide,part.CollisionGroup}
			end
		end
	end
	
	for _, part in pairs(chr:GetDescendants()) do
		if part:IsA("Part") and not part.Parent:IsA("Tool") and not part.Parent.Parent:IsA("Tool") and not part.Parent:IsA("Accessory") and part.Name ~= "Nickname_Data" and part.Name ~= "Skeleton" and part.Name ~= "GoreBase" and part.Parent.Name ~= "GoreBase" and part.Name ~= "SmartDecal" and part.Name ~= "AttackTrigger" then
			if change then
				local b = bool
				if part.Name == "HumanoidRootPart" then
					b = not bool
				end
				part.CanCollide = b
				local layer = "Default"
				if part.Name == "HumanoidRootPart" or part.Name == "Head" or part.Name == "Torso" or part.Name == "Right Arm" or part.Name == "Left Arm" or part.Name == "Right Leg" or part.Name == "Left Leg" then layer = "PlayerBase" end
				part.CollisionGroup = layer
			else
				local layer = cs[part:GetFullName()][2]
				if part.Name == "HumanoidRootPart" or part.Name == "Head" or part.Name == "Torso" or part.Name == "Right Arm" or part.Name == "Left Arm" or part.Name == "Right Leg" or part.Name == "Left Leg" then layer = "PlayerBase" end
				part.CanCollide = cs[part:GetFullName()][1]
				part.CollisionGroup = layer
			end
		end
	end
end

local function PlayerSeat(plr,bool,sw)
	local char = plr.Character or plr.CharacterAdded:Wait()
	if bool then
		ChangeObjectMassles(char,true,true)
		if sw ~= nil then
			sw.C0 = CFrame.new(0,0.30,0) * CFrame.Angles(math.rad(-90),0,math.rad(180))
		end
	else
		ChangeObjectMassles(char,false)
		if sw ~= nil then
			sw:Destroy()
		end
	end
end

local function Ragdollize(plr,bool,corpse)
	local chr = nil
	local npc = false
	if not plr:IsA("Model") then
		chr = plr.Character or plr.CharacterAdded:Wait()
	else
		chr = plr
		npc = true
	end
	local hum = chr:FindFirstChild("Humanoid")
	if chr ~= nil then		
		if bool then
			if not npc then ChangeCollisionsCharacter(plr,true,true) end
		else
			hum:ChangeState(Enum.HumanoidStateType.GettingUp)
			if not npc then  ChangeCollisionsCharacter(plr,false) end
		end
		for _, part in pairs(chr:GetDescendants()) do
			if part:IsA("Motor6D") and part.Name ~= "RootJoint" then
				ReplaceMotor6D(part,bool)
			end
			if part:IsA("BasePart") then
				if bool then
					local dragdetector = part:FindFirstChild("DragDetector")
					if not dragdetector then
						dragdetector = ss.SCRIPTS.DragDetector:Clone()
						dragdetector.Parent = part
						dragdetector.Responsiveness = 30
						dragdetector.MaxForce = 3000
						dragdetector.MaxTorque = 3000
					end
				else
					local dragdetector = part:FindFirstChild("DragDetector")
					if dragdetector then
						dragdetector:Destroy()
					end
				end
			end
		end
	end
	
	if corpse == true then
		if plr.Name ~= "Dummy" then
			print("Игрок ["..plr.Name.." ("..plr.UserId..")] Умер!")
			rs.DataStorage.Update:Fire(plr)
			task.wait(1)
		end
		if chr:FindFirstChild("Head") and chr:FindFirstChild("Torso") and chr:FindFirstChild("HumanoidRootPart") then
			base.CreateCorpse(chr,plr)
		end
	end
end


rs.PlayerSeat.OnServerEvent:Connect(PlayerSeat)
rs.Ragdollize.OnServerEvent:Connect(Ragdollize)
rs.RagdollizeSERVER.Event:Connect(Ragdollize)
rs.ShakeCamera.OnServerEvent:Connect(function(plr,position, power : number, distance : number, t : number, faststart : boolean?, fastend : boolean?)
	base.ShakeCamera(position,power,distance,t,faststart,fastend)
end)

game.Workspace.DescendantAdded:Connect(function(part)
	if part:IsA("Highlight") then
		data.TotalHightlight.Value += 1
	end
end)

game.Workspace.DescendantRemoving:Connect(function(part)
	if part:IsA("Highlight") then
		data.TotalHightlight.Value -= 1
	end
end)