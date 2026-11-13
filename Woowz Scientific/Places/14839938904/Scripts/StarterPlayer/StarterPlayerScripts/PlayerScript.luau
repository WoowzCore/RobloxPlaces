local function Play()
	local basa = require(script.Parent:WaitForChild("PlayerBasa"))
	basa.Character = basa.Player.Character
	basa.SetCharacterSettings(basa.Character)
	local kb = require(script.Parent.Keyboard)
	local rs = game:GetService("RunService")

	local Animations = {}

	local AnimationPlaying = {}

	local CrawlCameraOffset = Vector3.new(0,-1.5,-1.2)

	---------------------------------------------------------------

	local function InstallAnimations() --Установка анимаций
		local function CreateAnimations(name,id,speed) --Добавить анимацию (название, айди, скорость анимации [ быстрее<1<медленнее ])
			local animation = Instance.new("Animation")
			animation.AnimationId = "rbxassetid://"..id
			local animator = basa.Humanoid:WaitForChild("Animator")
			animation.Parent = animator
			local animationtrack = animator:LoadAnimation(animation)
			animationtrack.Priority = Enum.AnimationPriority.Action
			if speed == nil then speed = 1 end
			animationtrack:AdjustSpeed(speed)
			animation.Name = name
			Animations[name] = {animationtrack,animation,speed}
		end

		CreateAnimations("Crawl",14840486726,2)
		CreateAnimations("CrawlIdle",14843849682,2)
	end
	InstallAnimations()

	local function PlayAnimation(name,loop,speed)--Проиграть анимацию (название, зацикленная?)
		if AnimationPlaying[name] ~= true then
			if loop then
				Animations[name][1].Looped = loop
			end
			if speed == nil then speed = 1 end
			Animations[name][1]:AdjustSpeed(Animations[name][3]*speed)
			Animations[name][1]:Play()
			AnimationPlaying[name] = true
		end
	end
	local function StopAnimation(name)--Остановить анимацию
		if AnimationPlaying[name] ~= false then
			Animations[name][1]:Stop()
			AnimationPlaying[name] = false
		end
	end

	---------------------------------------------------------------

	local function CameraUpdate()
		local CameraFirstPerson = 0
		if basa.PlayerStat.FirstPersonNotFull then CameraFirstPerson = -1 end
		local CameraOffset = Vector3.new(0,0,CameraFirstPerson)
		if basa.StatCrawl then
			CameraOffset += CrawlCameraOffset
		end

		basa.Humanoid.CameraOffset = Vector3.new(CameraOffset.x+basa.CameraShake.x,CameraOffset.y+basa.CameraShake.y,CameraOffset.z+basa.CameraShake.z)
	end

	local function UpdateJumpPower()
		local JumpPower = basa.JumpPower

		if basa.StatCrawl then
			JumpPower = 0
		end

		basa.Humanoid.JumpPower = JumpPower
	end

	local function UpdateSpeed()
		local speed = basa.SpeedDefault
		if basa.StatRun then
			speed = basa.SpeedRun
		elseif basa.StatCrawl then
			speed = basa.SpeedCrawl
		end

		basa.Humanoid.WalkSpeed = speed
	end

	local function UpdateAnimations()
		if basa.StatCrawl then
			if not basa.PlayerStat.Walking then
				PlayAnimation("CrawlIdle",true)
				StopAnimation("Crawl")
			else
				PlayAnimation("Crawl",true)
				StopAnimation("CrawlIdle")
			end
			basa.Humanoid.HipHeight = -2
		else
			StopAnimation("Crawl")
			StopAnimation("CrawlIdle")
			basa.Humanoid.HipHeight = 0
		end
	end
	
	local function RotateHead()
		if basa.RootPart == nil or basa.Camera == nil then return end
		basa.CameraDirection = CFrame.new(0,basa.NeckOffset.Y,0) * CFrame.Angles(math.asin(basa.RootPart.CFrame:ToObjectSpace(basa.Mouse.Hit).LookVector.Y),-math.asin(basa.RootPart.CFrame:ToObjectSpace(basa.Mouse.Hit).LookVector.X),0) * CFrame.Angles(math.rad(90),math.rad(180),0)
	end

	---------------------------------------------------------

	---------------------------------------------------------
	
	basa.Loaded = true
	rs.RenderStepped:Connect(function(dt)
		basa.StatRun = (kb.Keys[Enum.KeyCode.LeftShift] and not basa.StatCrawl and not basa.StatSneak) or false
		basa.StatSneak = (kb.Keys[Enum.KeyCode.LeftControl] and not basa.StatCrawl and not basa.StatRun) or false
		basa.StatCrawl = (kb.KeysPressed[Enum.KeyCode.C]) or false

		basa.PlayerStat.Velocity = basa.RootPart.Velocity.Magnitude
		basa.PlayerStat.Moving = basa.PlayerStat.Velocity>0.1
		basa.PlayerStat.MovingVelocity = basa.Humanoid.MoveDirection.Magnitude
		basa.PlayerStat.Walking = basa.PlayerStat.MovingVelocity>0

		basa.PlayerStat.FirstPerson = basa.Head.LocalTransparencyModifier > 0.6
		basa.PlayerStat.FirstPersonNotFull = basa.Head.LocalTransparencyModifier > 0
		
		local params = RaycastParams.new() 
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = {basa.Character}
		basa.Objects.BottomRaycast = workspace:Raycast(basa.RootPart.Position,Vector3.new(0,-5,0),params)
		if basa.Objects.BottomRaycast ~= nil then
			basa.Objects.Bottom = basa.Objects.BottomRaycast.Instance
		else
			basa.Objects.Bottom = nil
		end
		
		UpdateSpeed()
		UpdateJumpPower()
		UpdateAnimations()
		CameraUpdate()
		RotateHead()
	end)
end

game:GetService("ReplicatedStorage").PlayerScriptStart.OnClientEvent:Connect(Play)