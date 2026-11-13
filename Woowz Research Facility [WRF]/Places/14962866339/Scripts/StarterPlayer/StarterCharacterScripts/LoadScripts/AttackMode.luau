local base = require(script.Parent:WaitForChild("PlayerBase"))
local ps = require(script.Parent:WaitForChild("PlayerScript"))
local rs = game:GetService("ReplicatedStorage")
local plr = game:GetService("Players").LocalPlayer
local plrs = game:GetService("Players")
local mouse = plr:GetMouse()
base.AttackBlock = false
base.AttackMode = false
local attackmode = false
local attacktimer = 20
local firearm = false
local aim = false
local mousepressed = false

local blockattack = false

local function LoadAttacksTriggers()
	local function createtrigger(arm,leg)
		local trigger = Instance.new("Part",arm)
		trigger.CanCollide = false
		trigger.CFrame = arm.CFrame * CFrame.new(0,-1.2,0)
		trigger.Color = Color3.new(1,0,0)
		trigger.Size = Vector3.new(1.25,1.25,1.25)
		if leg	 then
			trigger.Size = Vector3.new(1.25,1.5,1.25)
			trigger.CFrame = arm.CFrame * CFrame.new(0,-0.9,0)
		end
		trigger.Name = "AttackTrigger"
		trigger.CastShadow = false
		trigger.Massless = true
		trigger.Transparency = 1
		local weld = Instance.new("WeldConstraint",trigger)
		weld.Part0 = arm
		weld.Part1 = trigger
	end
	createtrigger(base.Parts.RightArm,false)
	createtrigger(base.Parts.LeftArm,false)
	createtrigger(base.Parts.RightLeg,true)
	createtrigger(base.Parts.LeftLeg,true)
end
script.LoadTriggers.Event:Connect(LoadAttacksTriggers)

local attackhumanoid = false
local function AttackTrigger(anim,trigger,leg)
	attackhumanoid = false
	rs.PlaySound:FireServer("5835032207",trigger.Position,math.random(5,10)/100,nil,math.random(95,105)/100)
	local e = trigger.Touched:Connect(function(part)
		if part:IsA("BasePart") then
			print(part.Name)
			if part.Parent:FindFirstChildOfClass("Humanoid") then
				local hum = part.Parent:FindFirstChildOfClass("Humanoid")
				if hum ~= base.Humanoid then
					if hum.Health <= 0 then
						if not part.Anchored then
							rs.Punch:FireServer(trigger.Position,part,leg)
						end
					else
						local hitthis = part
						local plr_ = plrs:GetPlayerFromCharacter(part.Parent)
						local attackpower = math.random(1,5)
						if plr_ ~= nil then
							local data = rs.GetPlayerDataClient:InvokeServer(tostring(plr_.UserId))
							if data.AttackBlock then
								if math.random(0,100)>50 then
									hitthis = part.Parent:FindFirstChild("Left Arm")
								else
									hitthis = part.Parent:FindFirstChild("Right Arm")
								end
								attackpower = math.random(0,2)
							end
						end
						if attackhumanoid == false then
							attackhumanoid = true
							local punchsounds = {"8646342913","743886825","8595975458","8278630896","9117969878"}
							rs.PlaySound:FireServer(punchsounds[math.random(1,#punchsounds)],trigger.Position,math.random(40,60)/100,nil,math.random(95,105)/100)
							rs.ShakeCamera:FireServer(trigger.Position,10,3,0.4,true)
						end
						rs.Hurt:FireServer(hitthis,"impact",attackpower)
					end
				end
			else
				if not part.Anchored then
					rs.Punch:FireServer(trigger.Position,part,leg)
				end
			end
		end
	end)
	wait(base.Animations[anim][1].Length/base.Animations[anim][1].Speed-0.2)
	e:Disconnect()
end

local function Attack()
	if base.Stamina <= 10 then return end
	if not base.ToolFirearm and not base.MovingData.Running then
		local stop = false
		if base.Tool ~= nil then
			if base.Tool:FindFirstChild("UseOnlyAttackMode") then
				stop = true
			end
		end
		
		if not stop then
			attacktimer = 0
			local attacktype = nil
			if base.Data.Camera.LookBottom and base.Humanoid.MoveDirection.Magnitude <= 0.1 then
				if math.random(0,100)>50 then
					attacktype = {{"Kick"},base.Parts.RightLeg:FindFirstChild("AttackTrigger"),true,0.05}
				else
					attacktype = {{"Kick2"},base.Parts.LeftLeg:FindFirstChild("AttackTrigger"),true,0.05}
				end
			else
				if math.random(0,100)>50 then
					attacktype = {{"Punch2","Punch2Legs"},base.Parts.LeftArm:FindFirstChild("AttackTrigger"),false,0.1}
				else
					attacktype = {{"Punch","PunchLegs"},base.Parts.RightArm:FindFirstChild("AttackTrigger"),false,0.1}
				end
			end
			ps.PlayAnimationOnce(attacktype[1][1],attacktype[4])
			if attacktype[1][2]~=nil then
				--ps.PlayAnimationOnce(attacktype[1][2],attacktype[4])
			end
			base.Stamina = math.max(base.Stamina-10/base.Drinks.StaminaSpending[1],0)
			AttackTrigger(attacktype[1][1],attacktype[2],attacktype[3])
		end
	end
end

local function StartBlock()
	base.AttackBlock = true
end

local function EndBlock()
	base.AttackBlock = false
end

local function StartAim()
	print("Start aim")
end

local function EndAim()
	print("End aim")
end

mouse.Button1Down:Connect(function()
	mousepressed = true
	if attackmode and not blockattack then
		local next_ = true
		if base.Tool then
			if base.Tool:FindFirstChild("UseOnlyAttackMode") then
				next_ = false
			end
		end
		if attacktimer >= 20 and next_ then
			Attack()
		end
	end	
end)

mouse.Button1Up:Connect(function()
	mousepressed = false
end)

mouse.Button2Down:Connect(function()
	if attackmode then
		if firearm then
			aim = true
			StartAim()
		else
			blockattack = true
			StartBlock()
		end
	end
end)

mouse.Button2Up:Connect(function()
	if attackmode then
		if firearm then
			aim = false
			EndAim()
		else
			if blockattack then
				blockattack = false
				EndBlock()
			end
		end
	end
end)

while wait() do
	attackmode = (base.AttackMode and not base.MovingData.Sit and not base.MovingData.Crawl and not base.Ragdoll)
	if (base.PartsDead.RightArm and base.PartsDead.LeftArm) then
		base.AttackMode = false
	end
	firearm = base.ToolFirearm
	attacktimer += 1
	if attackmode then
		if firearm and blockattack then
			EndBlock()
			blockattack = false
		end
		if not firearm and aim then
			EndAim()
			aim = false
		end
	else
		if aim then
			EndAim()
			aim = false
		end
		if blockattack then
			EndBlock()
			blockattack = false
		end
	end
	
	if mousepressed then
		if attackmode and not blockattack and attacktimer >= 10 then
			Attack()
		end
	end
end