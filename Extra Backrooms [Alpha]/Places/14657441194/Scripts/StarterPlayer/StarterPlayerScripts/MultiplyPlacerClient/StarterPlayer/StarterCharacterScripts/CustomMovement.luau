local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local rootPart = char:WaitForChild("HumanoidRootPart")
rootPart.CanCollide = false
local u = game:GetService("UserInputService")
local head = char:WaitForChild("Head")
local EBL = require(script.Parent:WaitForChild("EBLibbary"))

local keyboard = require(char:WaitForChild("KeyBoard"))

local defaultspeed = 13
local defaultjump = 1.5

local NeedSwim = false
local InWater = false
local Wet = false
local LeftSPressed = false
local LeftCPressed = false
local FloorAngle = 0

--================================== [Crawl]

local sitkey = Enum.KeyCode.Z

local crawlkey = Enum.KeyCode.C
local crawlanimationid = 14509557921

local crawlanimation = Instance.new("Animation")
crawlanimation.AnimationId = "rbxassetid://"..crawlanimationid
crawlanimation.Name = "Crawl"

local crawlanimtTrack = hum:WaitForChild("Animator"):LoadAnimation(crawlanimation)
crawlanimtTrack.Priority = Enum.AnimationPriority.Action

local crawl = false
local swim = false
local animationtimeoutmax = 50
local PlayerHeight = 4

local InAir = false
local HasCeiling = false

local FootStepTimer = 0

--==================================

local function CreateFootstepSound(soundId,volume,pos)
	local vol = (math.random(10,15)/10*volume)
	game.ReplicatedStorage.PlaySound:FireServer(soundId,vol,rootPart.Position,Vector2.new(40,0),pos)
end

local function FootStep()
	if rootPart.AssemblyLinearVelocity.Magnitude > 4 then
		local m = char.Humanoid.FloorMaterial
		local volum = 1
		if Wet then
			m = Enum.Material.Water
			volum = 0.5
		end
		if not crawl and not swim and not InAir  then
			CreateFootstepSound(EBL.GetFootStepSound(m),volum)
		end
	end
end

--==================================

local animationtimeout = animationtimeoutmax
function ChangeSpeed()
	local StaminaModifer = math.max(EBL.GetStats("Stamina")/800,0.8)
	local MentalModifer = (1+(1-EBL.GetStats("Mental")/1000)/4)
	if not swim then
		
	local newspeed = defaultspeed/2
	if not crawl then
		if LeftCPressed then
			newspeed = defaultspeed/4
		else if LeftSPressed then
				newspeed = defaultspeed
			end 
		end
	end
	
	if InWater then
		newspeed /= 2
	end
	
	local result = newspeed
	
	if crawl then
		result /= 1.5
	end
		return result * StaminaModifer * MentalModifer
		
	else
		return 10.01 * StaminaModifer * MentalModifer
	end
end

function ChangeJump()
	if swim or InWater or crawl or InAir or hum.Sit then
		return 0
	else
		return defaultjump
	end
end

u.InputBegan:Connect(function(key,chat)
	if chat then return end
	
	if key.KeyCode == Enum.KeyCode.Space then
		if hum.Sit then
			hum.Sit = false
		end
	end
	
	if key.KeyCode == sitkey then
		if hum.Sit then
			hum.Sit = false
		else
			if not InWater and not InAir and not crawl and animationtimeout >= animationtimeoutmax then
				animationtimeout = 0
				EBL.ChangeSurvivalStats("Stamina",false,-25)
				hum.Sit = true
			end
		end
	else if key.KeyCode == crawlkey then
		if crawl then
			if not HasCeiling then
				crawl = false
				crawlanimtTrack:Stop()
			end
		else
				if animationtimeout >= animationtimeoutmax and not InAir and not hum.Sit and not InWater and not Wet then
				animationtimeout = 0
				crawl = true
				crawlanimtTrack:Play()
			end
			end
			
		end	
	end	
end)

local InWaterSplash = false
local WaterSplashsSounds = {"142431247","9119482201","9120585252","9119477732","9116325419"}
game:GetService("RunService").RenderStepped:Connect(function(dt)
	LeftCPressed = keyboard.Keys[Enum.KeyCode.LeftControl]
	LeftSPressed = keyboard.Keys[Enum.KeyCode.LeftShift]
	
	if keyboard.Keys[Enum.KeyCode.Space] and not hum.Sit and not InAir and not crawl and not InWater then
		EBL.ChangeSurvivalStats("Stamina",false,-2)
	end
	
	--==================================
	
	local ray = Ray.new(rootPart.Position, Vector3.new(0,-PlayerHeight,0))
	local hit, pos = game.Workspace:FindPartOnRayWithIgnoreList(ray,char:GetChildren(),false,true)
	
	InAir = not (hit ~= nil)
	
	local ray2 = Ray.new(Vector3.new(rootPart.Position.x,rootPart.Position.y-1,rootPart.Position.z), Vector3.new(0,3.25,0))
	local hit2, pos2 = game.Workspace:FindPartOnRayWithIgnoreList(ray2,char:GetChildren(),false,true)
	
	HasCeiling = (hit2 ~= nil)
	
	--==================================
	
	local min = head.Position - Vector3.new(0,1,0)
	local max = head.Position
	local region = Region3.new(min,max):ExpandToGrid(4)
	local region2 = Region3.new(min - Vector3.new(0,1,0),max + Vector3.new(0,1,0)):ExpandToGrid(4)
	local region3 = Region3.new(min + Vector3.new(0,2,0),max + Vector3.new(0,2,0)):ExpandToGrid(4)
	
	if workspace.Terrain:ReadVoxels(region2,4) ~= nil then
		if workspace.Terrain:ReadVoxels(region2,4)[1] ~= nil and workspace.Terrain:ReadVoxels(region2,4)[1][1] ~= nil and workspace.Terrain:ReadVoxels(region2,4)[1][1][1] ~= nil then
			local material = workspace.Terrain:ReadVoxels(region2,4)[1][1][1] 
			Wet = (material == Enum.Material.Water)
		end
	else
		Wet = false
	end
	
	if workspace.Terrain:ReadVoxels(region,4) ~= nil then
		if workspace.Terrain:ReadVoxels(region,4)[1] ~= nil  and workspace.Terrain:ReadVoxels(region,4)[1][1] ~= nil  and workspace.Terrain:ReadVoxels(region,4)[1][1][1] ~= nil then
			local material = workspace.Terrain:ReadVoxels(region,4)[1][1][1] 
			InWater = (material == Enum.Material.Water)
		end
	else
		InWater = false
	end
	
	if workspace.Terrain:ReadVoxels(region3,4) ~= nil then
		if workspace.Terrain:ReadVoxels(region3,4)[1] ~= nil and workspace.Terrain:ReadVoxels(region3,4)[1][1] ~= nil and workspace.Terrain:ReadVoxels(region3,4)[1][1][1] ~= nil then
			local material = workspace.Terrain:ReadVoxels(region3,4)[1][1][1] 
			NeedSwim = (material == Enum.Material.Water)
		end
	else
		NeedSwim = false
	end	
	
	--==================================
	
	if NeedSwim then
		if not swim then
			if crawlanimtTrack.IsPlaying then crawlanimtTrack:Stop() end
			swim = true
			hum:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
		end
	else
		if swim then
			swim = false
			hum:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
		end
	end
	
	--==================================
	
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = {char}
	local result = workspace:Raycast(rootPart.Position, Vector3.new(0,-PlayerHeight,0),params)

	if result then
		FloorAngle = result.Normal.X * 90
	else
		FloorAngle = 0
	end
	
	--==================================
	
	if hum.MoveDirection.Magnitude>0 then
		crawlanimtTrack:AdjustSpeed(1)
	else
		crawlanimtTrack:AdjustSpeed(0)
	end
	
	--==================================
	
	if hum.Sit or swim then
		local camx,camy,camz = workspace.Camera:GetRenderCFrame():ToOrientation()
		rootPart.CFrame = CFrame.new(rootPart.Position) * CFrame.Angles(0,camy,0)
	end
	
	--==================================
	
	if InWater and hum.Sit then
		hum.Sit = false
	end
	
	--==================================
	
	if not InWaterSplash then
		if Wet and rootPart.AssemblyLinearVelocity.Magnitude >= 14 then
			InWaterSplash = true
			CreateFootstepSound(WaterSplashsSounds[math.random(1,#WaterSplashsSounds)],1,0.3)
		end
	else
		if not Wet then
			InWaterSplash = false
		end
	end
	
	--==================================
	
	animationtimeout += 1
	
	script.Parent.Crawl.Value = crawl
	
	--==================================
	
	FootStepTimer += (rootPart.AssemblyLinearVelocity.Magnitude)/(dt*175)
	if FootStepTimer >= 100 then
		FootStepTimer = 0
		FootStep()
	end
	
	--==================================
	
	if swim then
		EBL.ChangeSurvivalStats("Oxygen",false,-20*dt)
	end
	
	if hum.Sit and EBL.GetStats("water") > 0 and EBL.GetStats("food") > 0 then
		EBL.ChangeSurvivalStats("Stamina",false, (45 * (3-EBL.GetStats("mental")/1000) * (EBL.GetStats("Water")/1000) * (EBL.GetStats("Food")/1000) )*dt )
	elseif rootPart.AssemblyLinearVelocity.Magnitude >= 0.1 then
		if LeftSPressed and not crawl then
			EBL.ChangeSurvivalStats("Stamina",false,( -10 - (1-EBL.GetStats("Water")/1000)*16 ) *dt)
		else
			EBL.ChangeSurvivalStats("Stamina",false, (-1 - (1-EBL.GetStats("Food")/1000)*20 ) *dt)
		end
	end
	
	--==================================
	
	hum.WalkSpeed = ChangeSpeed()
	hum.JumpHeight = ChangeJump()
	if hum.JumpHeight == 0 or InAir then
		hum:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
	else
		wait(0.1)
		hum:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
	end
end)