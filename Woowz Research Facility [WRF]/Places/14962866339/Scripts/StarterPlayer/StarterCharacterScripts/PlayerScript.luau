local plrbase = require(script.Parent.PlayerBase)
local ts = game:GetService("TweenService")

local plrscript = {}

local rs = game:GetService("ReplicatedStorage")
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
plrscript.AimHand = false

plrscript.screamtimermax = 75 plrscript.screamtimer = plrscript.screamtimermax
function plrscript.Scream()
	if plrscript.screamtimer >= plrscript.screamtimermax and plrbase.Stamina>40 and not plrbase.Paralysis then
		local screams = {"6108570476","6929506713","6108569850","5169623821","5546573724"}
		rs.PlaySound:FireServer(screams[math.random(1,#screams)],plrbase.Parts.Head.Position,math.random(80,110)/100,nil,math.random(95,105)/100)
		plrscript.screamtimer = 0
	end
end

function plrscript.Splash(text)
	local splsh = plrbase.Gui:WaitForChild("Splash")
	splsh.TextLabel.Text = text
	plrscript.ts(splsh.TextLabel,TweenInfo.new(0.5),{TextTransparency = 0})
	plrscript.ts(splsh.TextLabel.UIStroke,TweenInfo.new(0.5),{Transparency = 0})
	wait(1)
	plrscript.ts(splsh.TextLabel,TweenInfo.new(3),{TextTransparency = 1})
	plrscript.ts(splsh.TextLabel.UIStroke,TweenInfo.new(3),{Transparency = 1})
end

function plrscript.GetColorFromGradient(sequence: ColorSequence, t: number)
	if tostring(t) == "nan" then
		return sequence.Keypoints[1].Value
	end
	if t <= 0 then
		return sequence.Keypoints[1].Value
	elseif t >= 1 then
		return sequence.Keypoints[#sequence.Keypoints].Value
	end

	for i = 1, #sequence.Keypoints - 1 do
		local thisKeypoint = sequence.Keypoints[i]
		local nextKeypoint = sequence.Keypoints[i + 1]
		if t >= thisKeypoint.Time and t < nextKeypoint.Time then
			local alpha = (t - thisKeypoint.Time) / (nextKeypoint.Time - thisKeypoint.Time)
			return Color3.new(
				(nextKeypoint.Value.R - thisKeypoint.Value.R) * alpha + thisKeypoint.Value.R,
				(nextKeypoint.Value.G - thisKeypoint.Value.G) * alpha + thisKeypoint.Value.G,
				(nextKeypoint.Value.B - thisKeypoint.Value.B) * alpha + thisKeypoint.Value.B
			)
		end
	end
end

function plrscript.getFlagEmoji(region)
	local regionalIndicators = {a = "🇦",b = "🇧",c = "🇨",d = "🇩",e = "🇪",f = "🇫",g = "🇬",h = "🇭",i = "🇮",	j = "🇯",k = "🇰",l = "🇱",m = "🇲",n = "🇳",o = "🇴",p = "🇵",q = "🇶",r = "🇷",s = "🇸",t = "🇹",u = "🇺",v = "🇻",w = "🇼",x = "🇽",y = "🇾",z = "🇿",
	}
	local regionID = string.lower(region)
	local l1 = string.sub(regionID ,1,1)
	local l2 = string.sub(regionID ,2,2)
	return regionalIndicators[l1]..regionalIndicators[l2]
end

function plrscript.ChangePlayerTransparency(transparency)
	for _, part in pairs(plrbase.Character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CastShadow = transparency
		end
	end
end

function plrscript.LoadAnimations()
	plrbase.Animations = {}
	plrscript.CreateAnimation("Idle","16575491058",1)
	plrscript.CreateAnimation("IdleTired","16575429726",1)
	plrscript.CreateAnimation("IdleAttack","16575573412",1)
	
	plrscript.CreateAnimation("Walk","16570968986",2)  --[[15117921055]]
	plrscript.CreateAnimation("WalkArms","16570982916",2) --[[14983832471]]
	
	plrscript.CreateAnimation("Run","16571017102",2,nil,Vector3.new(0,-0.3,-0.8)) --[[15032152120]]
	plrscript.CreateAnimation("RunArms","16571030772",2) --[[16521444433]]
	
	plrscript.CreateAnimation("Crawl","15004690708",2,nil,Vector3.new(0,-2,-1.5))
	plrscript.CreateAnimation("CrawlArms","15117613348",2)
	
	plrscript.CreateAnimation("Ragdoll","15015184117",7)
	plrscript.CreateAnimation("Died","15015195451",7,0)
	
	plrscript.CreateAnimation("Sit","14996415277",2,0.2)
	plrscript.CreateAnimation("SitArms","16429764076",2,0.1)
	
	plrscript.CreateAnimation("Tool","15032183159",3,0.5)
	plrscript.CreateAnimation("Tool_Cup","16578608328",3,0.5)
	plrscript.CreateAnimation("Tool_Drink","16578679425",4,0.75)
	
	plrscript.CreateAnimation("Arm","15112098207",3,0.2)
	plrscript.CreateAnimation("Throwing","16426380783",4,0.5,Vector3.new(0,0,0.3))
	
	plrscript.CreateAnimation("AttackPose","16575606679",3,0.75) --[[16425426367]]
	plrscript.CreateAnimation("AttackPoseRun","16535346867",3,1.25)
	plrscript.CreateAnimation("AttackPoseBlock","16426007737",3,0.75)
	
	plrscript.CreateAnimation("Punch","16435916963",4,2)
	--plrscript.CreateAnimation("PunchLegs","16543636849",1)
	plrscript.CreateAnimation("Punch2","16442691922",4,2)
	--plrscript.CreateAnimation("Punch2Legs","16543582883",1)
	plrscript.CreateAnimation("Kick","16442564057",4,2)
	plrscript.CreateAnimation("Kick2","16442807940",4,2)
	plrscript.CreateAnimation("Use","16442999585",3,1)
end

function plrscript.PlayAnimationOnce(name,transition)
	local anim = plrbase.Animations[name]
	task.spawn(function()
		plrscript.PlayAnimation(name,true,transition)
		wait(anim[1].Length/anim[1].Speed)
		plrscript.PlayAnimation(name,false,transition)
	end)
end

plrscript.CameraOffset = nil
function plrscript.PlayAnimation(name,bool,transition)
	if name == nil then return end
	if transition == nil then transition = 0.100000001 end
	local anim = plrbase.Animations[name]
	if anim == nil then return end
	if bool == nil then bool = true end
	if anim[1].Looped then
		if anim[3] ~= bool then
			anim[3] = bool
			if bool then
				if plrscript.CameraOffset == nil or plrscript.CameraOffset[5] == Vector3.zero or (plrscript.CameraOffset[6]<anim[6] and anim[5] ~= Vector3.zero) then
					plrscript.CameraOffset = anim
				end
				anim[1]:Play(transition)
				anim[1]:AdjustSpeed(anim[4])
			else
				if plrscript.CameraOffset == anim then
					plrscript.CameraOffset = nil
				end
				anim[1]:Stop(transition)
			end
		end
	else
		if anim[3] == true then
			if not bool then
				if plrscript.CameraOffset == anim then
					plrscript.CameraOffset = nil
				end
				anim[1]:Stop(transition)
				anim[3] = false
			end
		else
			if bool then
				if plrscript.CameraOffset == nil or plrscript.CameraOffset[5] == Vector3.zero or plrscript.CameraOffset[6]<anim[6] then
					plrscript.CameraOffset = anim
				end
				anim[1]:Play(transition)
				anim[1]:AdjustSpeed(anim[4])
				anim[3] = true
			end
		end
	end
end

function plrscript.CreateAnimation(name,anim,priority,speed,cameraoffset)
	if cameraoffset == nil then cameraoffset = Vector3.zero end
	local animationinfo = Instance.new("Animation")
	animationinfo.Parent = plrbase.Animator
	animationinfo.Name = name
	animationinfo.AnimationId = "http://www.roblox.com/asset/?id="..anim
	local animation = plrbase.Animator:LoadAnimation(animationinfo)
	if priority == nil then priority = 1 end
	local p = {[1] = Enum.AnimationPriority.Core,[2] = Enum.AnimationPriority.Idle,[3] = Enum.AnimationPriority.Movement,[4] = Enum.AnimationPriority.Action,[5] = Enum.AnimationPriority.Action2,[6] = Enum.AnimationPriority.Action3,[7] = Enum.AnimationPriority.Action4}
	animation.Priority = p[priority]
	if speed == nil then speed = 1 end
	animation:AdjustSpeed(speed)
	plrbase.Animations[name] = {animation,animationinfo,false,speed,cameraoffset,priority}
end

function plrscript.PlayAllAnimation(bool,transition)
	for _, name in pairs(plrbase.Animations) do
		plrscript.PlayAnimation(name,bool,transition)
	end
end

function plrscript.ChangeAnimationSpeed(name,speed)
	local anim = plrbase.Animations[name]
	if anim == nil then return end
	if anim[1].Speed ~= speed then
		anim[1]:AdjustSpeed(speed)
	end
end

function plrscript.ts(instance,tweeninfo,proptable,play : boolean?)
	local tsanim = ts:Create(instance,tweeninfo,proptable)
	if play ~= false then
		tsanim:Play()
	end
	return tsanim
end

function plrscript.Lerp(a, b, t)
	return a + (b - a) * t
end


return plrscript
