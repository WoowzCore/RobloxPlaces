local pb = require(script.Parent:WaitForChild("PlayerBase"))
local ps = require(script.Parent:WaitForChild("PlayerScript"))
local rs = game:GetService("ReplicatedStorage")
rs.Player.PlayAnimationOnce.OnClientEvent:Connect(ps.PlayAnimationOnce)

local toolanim = nil
while wait() do
	local anims = {}
	local function anim(anim_,default)
		if default == nil then default = false end
		local anim1 = anims[anim_]
		if anim1 == nil then
			return default
		else
			return anim1
		end
	end
	
	local stopall = false
	local aimhand = false
	
	if pb.Tool then
		local v = false
		if pb.Tool:FindFirstChild("MoveArm") then
			v = pb.Tool:FindFirstChild("MoveArm").Value
		end
		aimhand = v or (pb.ToolFirearm and pb.AttackMode)
	end
	
	if pb.Drag then
		aimhand = true
	end
	
	if not pb.Died then
		if not pb.Ragdoll then
			if pb.MovingData.Crawl then
				anims["Crawl"] = true
				anims["CrawlArms"] = true
			else
				anims["AttackPose"] = (pb.AttackMode and not pb.AttackBlock and not pb.ToolFirearm)
				anims["AttackPoseBlock"] = pb.AttackBlock
				anims["Throwing"] = (pb.ThrowPower>0)
				if not pb.MovingData.Sit then
					if pb.Humanoid.MoveDirection.Magnitude > 0.1 then
						anims["Run"] = pb.Humanoid.WalkSpeed > 18
						anims["RunArms"] = anims["Run"]
						anims["Walk"] = not anims["Run"]
						anims["WalkArms"] = not anims["RunArms"]
					end
				else
					anims["Sit"] = true
					anims["SitArms"] = not anims["AttackPose"]
				end
			end
		
		else
			stopall = true
			anims["Ragdoll"] = pb.Ragdoll
		end
	else
		stopall = true
		anims["Died"] = true
	end
	
	local function StopToolAnims()
		if toolanim ~= nil then
			ps.PlayAnimation(toolanim,false)
			toolanim = nil
		end
	end

	if pb.Tool ~= nil then
		if pb.Tool:FindFirstChild("Animation") and ((pb.AttackMode and pb.Tool:FindFirstChild("UseOnlyAttackMode") and not pb.ToolFirearm) or (not pb.AttackMode)) then
			if pb.Tool:FindFirstChild("Animation").Value ~= toolanim then
				ps.PlayAnimation(toolanim,false)
				toolanim = pb.Tool:FindFirstChild("Animation").Value
				ps.PlayAnimation(toolanim,true)
			end
		else
			StopToolAnims()
		end
	else
		StopToolAnims()
	end

	if pb.MovingData.Crawl and pb.Tool then
		StopToolAnims()
	end
	
	if stopall then
		ps.PlayAllAnimation(false)
	end
	
	local back = 1
	if pb.MovingData.Back then
		back = -1
	end
	
	if not (anim("Ragdoll") or anim("Died")) then
		anims["Idle"] = true
		if pb.Stamina < 80 then
			anims["IdleTired"] = true
		end
	end
	
	ps.PlayAnimation("Walk",anim("Walk"))
	ps.ChangeAnimationSpeed("Walk",(pb.Humanoid.MoveDirection.Magnitude*(pb.Humanoid.WalkSpeed/pb.MovingData.WalkSpeed)*back)/1.4)
	ps.PlayAnimation("WalkArms",anim("WalkArms"),0.5)
	ps.ChangeAnimationSpeed("WalkArms",pb.Humanoid.MoveDirection.Magnitude*(pb.Humanoid.WalkSpeed/pb.MovingData.WalkSpeed)/1.4)
	
	ps.PlayAnimation("Run",anim("Run"))
	ps.ChangeAnimationSpeed("Run",(pb.Humanoid.MoveDirection.Magnitude*(pb.Humanoid.WalkSpeed/pb.MovingData.RunSpeed)*back))
	ps.PlayAnimation("RunArms",anim("RunArms") and not anim("AttackPose"),0.5)
	ps.ChangeAnimationSpeed("RunArms",(pb.Humanoid.MoveDirection.Magnitude*(pb.Humanoid.WalkSpeed/pb.MovingData.RunSpeed)))
	
	ps.PlayAnimation("Crawl",anim("Crawl"))
	ps.ChangeAnimationSpeed("Crawl",pb.Humanoid.MoveDirection.Magnitude)
	ps.PlayAnimation("CrawlArms",anim("CrawlArms"))
	ps.ChangeAnimationSpeed("CrawlArms",pb.Humanoid.MoveDirection.Magnitude)
	
	ps.PlayAnimation("AttackPoseBlock",anim("AttackPoseBlock"))
	ps.PlayAnimation("AttackPose",anim("AttackPose") and not anim("RunArms"))
	ps.PlayAnimation("AttackPoseRun",anim("AttackPose") and anim("RunArms"))
	
	ps.PlayAnimation("Sit",anim("Sit"))
	ps.PlayAnimation("SitArms",anim("SitArms"),0.25)
	
	ps.PlayAnimation("Throwing",anim("Throwing"),0.5)

	ps.PlayAnimation("Ragdoll",anim("Ragdoll"))
	ps.PlayAnimation("Died",anim("Died"))
	
	ps.PlayAnimation("IdleTired",anim("IdleTired"),1)
	ps.PlayAnimation("Idle",anim("Idle") and not anim("IdleTired") and not pb.AttackMode,1)
	ps.PlayAnimation("IdleAttack",anim("Idle") and pb.AttackMode and not anim("IdleTired"),1)
	
	if (anims["AttackPose"] or anims["AttackPoseBlock"]) and not pb.ToolFirearm then
		aimhand = false
	end
	
	if anims["Throwing"] or anims["Ragdoll"] or anims["Died"] or anims["CrawlArms"] or anims["Crawl"] or anims["RunArms"] then
		aimhand = false
	end
	
	ps.PlayAnimation("Arm",aimhand)
	ps.AimHand = aimhand
end