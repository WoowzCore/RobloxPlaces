local plrbase = require(script.Parent:WaitForChild("PlayerBase"))
local plrscript = require(script.Parent:WaitForChild("PlayerScript"))
local hbase = require(plrbase.Gui:WaitForChild("Hotbar"):WaitForChild("HotbarBase"))
local uis = game:GetService("UserInputService")
local rs = game:GetService("ReplicatedStorage")
local us = UserSettings():GetService("UserGameSettings")

local MovingWait = false
local MovingTime = 0

local function ChangeTransparencyBody()
	for _, part in pairs(plrbase.Character:GetChildren()) do
		if part:IsA("BasePart") then
			if part.Name ~= "Head" then
				part.LocalTransparencyModifier = part.Transparency
				part:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
					part.LocalTransparencyModifier = part.Transparency
				end)
			else
				plrbase.Data.Camera.FirstPerson = (plrbase.Parts.Head.LocalTransparencyModifier == 1)
				plrbase.Parts.Head:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
					plrbase.Data.Camera.FirstPerson = (plrbase.Parts.Head.LocalTransparencyModifier == 1)
				end)
			end
		end
	end
end

ChangeTransparencyBody()

local needdrop = false

uis.InputBegan:Connect(function(key,chat)
	key = key.KeyCode
	plrbase.KeyboradIGNORECHAT[tostring(key)] = true
	if chat then return end
	plrbase.Keyboard[tostring(key)] = true
	if plrbase.BaseDontDestroy.LoadingScreen then return end
	if plrbase.SettingsChangeKeyCode then return end
	if not plrbase.Settings then return end
	if not plrbase.Settings.Loaded then return end

	if key == plrbase.Settings.Keys.Jump and not plrbase.Died then
		if plrbase.MovingData.Crawl then
			plrbase.MovingData.Crawl = false
		end
	end

	if key == plrbase.Settings.Keys.Crawl and not plrbase.Died and not (plrbase.PartsDead.RightLeg and plrbase.PartsDead.LeftLeg) then
		if not plrbase.MovingData.Sit and not plrbase.Input.Ragdoll then
			if not MovingWait then 
			MovingWait = true
				plrbase.MovingData.Crawl = not plrbase.MovingData.Crawl
			end
		end
	end

	if key == plrbase.Settings.Keys.Ragdoll or (plrbase.Input.Ragdoll == true and (key == plrbase.Settings.Keys.Jump or key == plrbase.Settings.Keys.Crawl)) and not plrbase.Died then
		if not MovingWait then 
			MovingWait = true
			plrbase.MovingData.Crawl = (key == plrbase.Settings.Keys.Crawl)
			plrbase.Input.Ragdoll = not plrbase.Input.Ragdoll
		end
	end

	if key == plrbase.Settings.Keys.SettingsKey then
		if not plrbase.Gui:FindFirstChild("Settings").ChangedValue.Value then 
			plrbase.GuiActives.Settings = not plrbase.GuiActives.Settings 
		end
	end

	if key == plrbase.Settings.Keys.VisibleGui then
		plrbase.VisibleGUI = not plrbase.VisibleGUI
	end

	if key == plrbase.Settings.Keys.Help then
		plrbase.GuiActives.Help = not plrbase.GuiActives.Help
	end

	if key == plrbase.Settings.Keys.Admin and plrbase.Admin then
		plrbase.GuiActives.Admin = not plrbase.GuiActives.Admin
	end

	if key == plrbase.Settings.Keys.Debug then
		plrbase.GuiActives.Debug = not plrbase.GuiActives.Debug
	end
	
	if key == plrbase.Settings.Keys.Log and plrbase.Admin then
		plrbase.GuiActives.Console = not plrbase.GuiActives.Console 
	end
	
	local hotbarkeys = true
	
	if plrbase.Tool then
		if plrbase.Tool:FindFirstChild("BlockKeys") then
			hotbarkeys = false
		end
	end
	
	if hotbarkeys then
		if key == plrbase.Settings.Keys.Item1 then
			hbase.GetItem(1)
		end
		if key == plrbase.Settings.Keys.Item2 then
			hbase.GetItem(2)
		end
		if key == plrbase.Settings.Keys.Item3 then
			hbase.GetItem(3)
		end
		if key == plrbase.Settings.Keys.Item4 then
			hbase.GetItem(4)
		end
		if key == plrbase.Settings.Keys.Item5 then
			hbase.GetItem(5)
		end
		if key == plrbase.Settings.Keys.Item6 then
			hbase.GetItem(6)
		end
		if key == plrbase.Settings.Keys.Item7 then
			hbase.GetItem(7)
		end
		if key == plrbase.Settings.Keys.Item8 then
			hbase.GetItem(8)
		end
		if key == plrbase.Settings.Keys.Item9 then
			hbase.GetItem(9)
		end
		if key == plrbase.Settings.Keys.Item10 then
			hbase.GetItem(10)
		end
	end

	if key == plrbase.Settings.Keys.AttackMode then
		plrbase.AttackMode = not plrbase.AttackMode
	end
	
	if key == plrbase.Settings.Keys.Scream then
		plrscript.Scream()
	end

	if key == plrbase.Settings.Keys.Die and not plrbase.Died then
		rs.Hurt:FireServer(plrbase.Parts.Head,"none",math.huge)
		rs.Hurt:FireServer(plrbase.Parts.Torso,"none",math.huge)
		rs.Hurt:FireServer(plrbase.Parts.RightArm,"none",math.huge)
		rs.Hurt:FireServer(plrbase.Parts.LeftArm,"none",math.huge)
		rs.Hurt:FireServer(plrbase.Parts.RightLeg,"none",math.huge)
		rs.Hurt:FireServer(plrbase.Parts.LeftLeg,"none",math.huge)
	end
end)

uis.InputEnded:Connect(function(key,chat)
	key = key.KeyCode
	plrbase.KeyboradIGNORECHAT[tostring(key)] = false
	if chat then return end
	plrbase.Keyboard[tostring(key)] = false
	
	if key == plrbase.Settings.Keys.DropItem then
		needdrop = true
	end
end)

local speedtimer = 0
local function UpdateSpeed()
	local legdead = plrbase.PartsDead.RightLeg or plrbase.PartsDead.LeftLeg
	
	local back = 1
	if plrbase.MovingData.Back and not plrbase.MovingData.Slow then
		back = 0.6
	end
	local byhealthmnojitel = math.max(plrbase.Humanoid.Health/plrbase.Humanoid.MaxHealth,0.5)
	
	local result = plrscript.Lerp(plrbase.MovingData.WalkSpeed,plrbase.MovingData.RunSpeed,speedtimer)
	if plrbase.MovingData.Running then
		speedtimer = math.min(speedtimer+0.05,1)
	else
		speedtimer = math.max(speedtimer-0.2,0)
		if plrbase.MovingData.Slow or plrbase.MovingData.Crawl then
			byhealthmnojitel = 1
			result = plrbase.MovingData.CrawlSpeed
		end
	end
	
	if legdead then
		if plrbase.MovingData.Running then
			result = plrscript.Lerp(plrbase.MovingData.CrawlSpeed,plrbase.MovingData.WalkSpeed,speedtimer)
		else
			result = plrbase.MovingData.CrawlSpeed
		end
	end

	if plrbase.Ragdoll or not plrbase.MovingData.CanMove then
		result = 0
	end
	
	if result>20 then
		plrbase.Stamina = math.max(plrbase.Stamina-0.15/plrbase.Drinks.StaminaSpending[1],0)
	else
		plrbase.Stamina = math.min(plrbase.Stamina+0.2*plrbase.Drinks.StaminaRecovery[1],100)
	end
	
	local staminadebaf = 1
	if plrbase.MovingData.Running then
		staminadebaf = (math.max(plrbase.Stamina/100,0.5))
	end
	
	plrbase.Humanoid.WalkSpeed = result*back*byhealthmnojitel*staminadebaf*plrbase.Drinks.Speed[1]*(math.max(0.3,(100-plrbase.Drunk)/100))*(math.max(1-plrbase.Poison/300,0.5))
end

local function UpdateCrawl()
	local result = 0
	if plrbase.MovingData.Crawl then
		result = -1.45
	end

	plrbase.Humanoid.HipHeight = result
end

local function UpdateJump()
	local result = plrbase.MovingData.JumpPower
	if not plrbase.MovingData.Running then
		result = result/1.25
	end
	if plrbase.MovingData.Crawl or plrbase.Ragdoll or not plrbase.MovingData.CanMove then
		result = 0
	end
	plrbase.Humanoid.JumpPower = result
end

plrbase.Humanoid.Jumping:Connect(function()
	if plrbase.Humanoid.JumpPower~=0 then
		plrbase.Stamina = math.max(plrbase.Stamina-5/plrbase.Drinks.StaminaSpending[1],0)
	end
end)

plrbase.Died = false
plrbase.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
	if plrbase.Humanoid.Health <= 0 then
		plrbase.Died = true
	end
end)

local function ShakeCamera()
	local pos = plrbase.Camera.CFrame.Position
	local intensivity = 0
	for _, shakecam in pairs(game.Workspace.CameraShake:GetChildren()) do
		local scpos = shakecam:GetAttribute("Position")
		local power = shakecam:GetAttribute("Power")
		local distance = shakecam:GetAttribute("Distance")
		local t = shakecam:GetAttribute("t")
		if t == math.huge then
			t = 1
		else
			t = shakecam.Value/t
		end

		local mag = ((math.max(distance - math.abs(pos.Magnitude - scpos.Magnitude),0))/distance*power)*t
		if distance == math.huge then
			mag = power*t
		end
		intensivity = math.max(intensivity,mag)
	end
	intensivity *= plrbase.Settings.Gameplay.ShakeMultiplier
	if intensivity == 0 then
		plrbase.CameraInfo.CameraShake = Vector3.zero
	else
		plrbase.CameraInfo.CameraShake = Vector3.new(math.random(-intensivity,intensivity)/100,math.random(-intensivity,intensivity)/100,math.random(-intensivity,intensivity)/100)
	end
	plrbase.Parts.Head.ShakeSound.Volume = intensivity/30
end

local camoffset_alpha = 0
local camoffset = Vector3.zero
local savedcamoffset = nil
local function UpdateCameraOffset(dt)
	local result = Vector3.zero

	if plrbase.MovingData.Crawl and not plrbase.Ragdoll then
		result = Vector3.new(0,-2,-1.5)
	end

	if plrbase.Data.Camera.FirstPerson then
		if savedcamoffset ~= plrscript.CameraOffset then
			camoffset_alpha = 0
			savedcamoffset = plrscript.CameraOffset
		end
		result = camoffset+Vector3.new(0,0,-1)
		local co = Vector3.zero
		if plrscript.CameraOffset ~= nil then
			co = plrscript.CameraOffset[5]
		end
		camoffset_alpha = math.clamp(camoffset_alpha+dt,0,1)
		camoffset = camoffset:Lerp(co,camoffset_alpha)
		result = camoffset+Vector3.new(0,0,-1)
	else
		camoffset = Vector3.zero
	end

	plrbase.Humanoid.CameraOffset = result + plrbase.CameraInfo.OffsetMoving + plrbase.CameraInfo.CameraShake
end

local zoom = 0
local function UpdateFOV(dt)
	local result = 70
	if plrbase.Data.Camera.FirstPerson then
		result = 80
	end

	if plrbase.Keyboard[tostring(plrbase.Settings.Keys.Zoom)]  then
		zoom += dt*128
		zoom = math.min(zoom,result-30)
		result = math.max(result - zoom,30)
	else
		zoom -= dt*128
		zoom = math.max(0,zoom)
		result = math.max(result - zoom,30)
	end

	plrbase.Camera.FieldOfView = result
end

local sirenid = ""
local sirenid2 = ""
local sirenmultiply = 1
rs.SetSirensToPlayers.OnClientEvent:Connect(function(sirens,sirendata,sirentype)
	plrbase.Sirens = sirens
	plrbase.SirenData = sirendata
	sirenid2 = sirentype
end)

local function UpdateSirens()
	if plrbase.Parts.Head:FindFirstChild("Siren") and plrbase.SirenData ~= nil and plrbase.Parts.Root then
		local result = 0
		local siren = plrbase.Parts.Head:FindFirstChild("Siren")
		
		for i, pos in pairs(plrbase.Sirens) do
			local distance = 1-math.clamp(math.abs(math.abs(pos.Magnitude) - math.abs(plrbase.Camera.CFrame.Position.Magnitude)),0,(sirenmultiply))/(sirenmultiply)
			result = math.min(result+distance,2)
		end	
		siren.Volume = result
		if sirenid ~= sirenid2 then
			sirenid = sirenid2
			if sirenid ~= "empty" then
				siren.SoundId = "rbxassetid://"..plrbase.SirenData[1][1]
				siren.PlaybackSpeed = plrbase.SirenData[1][2]
				sirenmultiply = plrbase.SirenData[1][3]
				siren:Play()
			else
				sirenmultiply = 1
			end
		end
	end
end

local function UpdateSens()
	local sens = 0.3
	
	if (plrbase.Data.Camera.FirstPerson and plrbase.MovingData.Crawl) or plrbase.Drunk >= 75 then
		sens = 0.06
	end
	
	return sens
end

local function UpdateDrinks()
	if not plrbase.Died then
		local speed = 0.01
		plrbase.Drinks.StaminaRecovery[2] = math.max(0,plrbase.Drinks.StaminaRecovery[2]-speed)
		if plrbase.Drinks.StaminaRecovery[2] <= 0 then
			plrbase.Drinks.StaminaRecovery[1] = 1
		end
		plrbase.Drinks.StaminaSpending[2] = math.max(0,plrbase.Drinks.StaminaSpending[2]-speed)
		if plrbase.Drinks.StaminaSpending[2] <= 0 then
			plrbase.Drinks.StaminaSpending[1] = 1
		end
		plrbase.Drinks.Speed[2] = math.max(0,plrbase.Drinks.Speed[2]-speed)
		if plrbase.Drinks.Speed[2] <= 0 then
			plrbase.Drinks.Speed[1] = 1
		end
		plrbase.Drinks.Paralize = math.max(0,plrbase.Drinks.Paralize-speed)
		plrbase.Poison = math.max(0,plrbase.Poison-(speed/2))
		plrbase.Drunk = math.max(0,plrbase.Drunk-speed)
		
		if (plrbase.Drunk > 65 or plrbase.Poison > 65) and math.random(0,1000)>998 then
			plrbase.Drinks.Paralize = plrbase.Drinks.Paralize + math.random(1,5)
		end
	end
end

local function UpdatePoison()
	if not plrbase.Died then
		local p = plrbase.Poison
		if p>30 then
			if math.random(0,1000)>998 then
				plrscript.Splash("Живот болит!")
				rs.Hurt:FireServer(plrbase.Parts.Torso,"none",math.random(1,3))
			end
			
			if p>70 then


				if p>130 then
					if math.random(0,100)>98 then
						local parts = {plrbase.Parts.LeftLeg,plrbase.Parts.RightLeg,plrbase.Parts.LeftArm,plrbase.Parts.RightArm}
						rs.Hurt:FireServer(parts[math.random(1,#parts)],"none",math.random(10,30))
					end
					if p>250 then

					end
				end
			end
		end
	end
end

local lastragdoll = plrbase.Ragdoll
local lastdied = false
local CanTakeItem_TimeOut_i = 0

game:GetService("RunService").RenderStepped:Connect(function(dt)
	UpdateCameraOffset(dt)
	UpdateFOV(dt)
end)

rs.Player.GetPlayerData.OnClientInvoke = function()
	return plrbase
end

local dropitem_timer = 0
while wait() do
	if MovingWait then
		MovingTime += 1
		if MovingTime >= 10 then
			MovingWait = false
			MovingTime = 0
		end
	end

	if plrbase.CanTakeItem_TimeOut then
		CanTakeItem_TimeOut_i += 1
		if CanTakeItem_TimeOut_i >= 10 then
			plrbase.CanTakeItem_TimeOut = false
			CanTakeItem_TimeOut_i = 0
		end
	end
	
	if plrbase.Keyboard[tostring(plrbase.Settings.Keys.DropItem)] then
		if not plrbase.CanTakeItem_TimeOut then
			if plrbase.Tool then
				dropitem_timer += 1
				if dropitem_timer >= 5 and not (plrbase.PartsDead.RightArm and plrbase.PartsDead.LeftArm) and not plrbase.Ragdoll and not plrbase.MovingData.Crawl then
					plrbase.ThrowPower = math.min(plrbase.ThrowPower+2,100)
				end
			else
				plrbase.ThrowPower = 0
			end
		end
	else
		if plrbase.Tool then
			if needdrop then
				if dropitem_timer < 5 then
					rs.DropItem:FireServer(plrbase.Tool,plrbase.Tool.Handle.CFrame)
					plrbase.CanTakeItem_TimeOut = true
					dropitem_timer = 0
				else
					local angle = plrbase.Parts.Torso.CFrame.LookVector
					if plrbase.Data.Camera.FirstPerson then
						angle = plrbase.Parts.Head.CFrame.LookVector
					end
					rs.ThrowItem:FireServer(plrbase.Tool,plrbase.Tool.Handle.CFrame,plrbase.ThrowPower/2,angle)
					plrbase.ThrowPower = 0
					dropitem_timer = 0
				end
			end
		else
			needdrop = false
		end
	end
	
	plrbase.MovingData.CanMove = not plrbase.BaseDontDestroy.LoadingScreen and not plrbase.Died and not plrbase.SettingsChangeKeyCode
	local CanChangeMovingData = not plrbase.Ragdoll and not plrbase.MovingData.Sit and not plrbase.MovingData.Crawl and plrbase.MovingData.CanMove
	plrbase.MovingData.Running = (plrbase.Keyboard[tostring(plrbase.Settings.Keys.WalkFast)] and CanChangeMovingData)
	plrbase.MovingData.Slow = (plrbase.Keyboard[tostring(plrbase.Settings.Keys.WalkSlow)] and CanChangeMovingData)
	plrbase.MovingData.Sit = plrbase.Humanoid.Sit
	plrbase.Seat = plrbase.Humanoid.SeatPart
	if plrbase.Seat then
		plrbase.SeatWeld = plrbase.Seat:FindFirstChild("SeatWeld")
	else
		plrbase.SeatWeld = nil
	end
	
	if plrbase.PartsDead.RightLeg and plrbase.PartsDead.LeftLeg then
		plrbase.MovingData.Crawl = true
	end

	plrbase.Paralysis = plrbase.Drinks.Paralize>0
	plrbase.Ragdoll = (plrbase.Input.Ragdoll or plrbase.Paralysis)

	if plrbase.Died ~= lastdied then
		lastdied = plrbase.Died
		rs.Ragdollize:FireServer(true,true)
		plrbase.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
	end

	if lastragdoll ~= plrbase.Ragdoll and not plrbase.Died then
		lastragdoll = plrbase.Ragdoll
		plrbase.Humanoid.AutoRotate = not plrbase.Ragdoll
		rs.PlayerSeat:FireServer(not plrbase.Ragdoll,plrbase.SeatWeld)
		rs.Ragdollize:FireServer(plrbase.Ragdoll)
		if plrbase.Ragdoll then
			plrbase.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		else
			plrbase.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	end

	if not plrbase.Admin then
		plrbase.GuiActives.Admin = false
		plrbase.GuiActives.Console = false
	end

	plrbase.Tool = plrbase.Character:FindFirstChildOfClass("Tool")
	if plrbase.Tool ~= nil then
		plrbase.ToolName = plrbase.Tool.Name
		plrbase.ToolInArmID = plrbase.Tool:FindFirstChild("InventoryIDPosition").Value
		plrbase.ToolFirearm = (plrbase.Tool:FindFirstChild("Firearm")~=nil)
	else
		plrbase.ToolName = ""
		plrbase.ToolInArmID = 0
		plrbase.ToolFirearm = false
	end

	plrbase.GraphicLevel = us.SavedQualityLevel.Value

	if plrbase.Parts.Head then
		if plrbase.Parts.Head:FindFirstChild("Tinnitus") then
			if plrbase.Died then
				plrbase.Parts.Head.Tinnitus.Volume = 0
			else
				local tinnituesenabled = plrbase.Settings.Gameplay.TinnitusEnabled
				local tinnitusresult = 0
				if tinnituesenabled then
					tinnitusresult = math.max(plrbase.Parts.Head.Tinnitus.Volume-0.0025,0)
				end
				plrbase.Parts.Head.Tinnitus.Volume = tinnitusresult
			end
		end
		
		local headrot = plrbase.Parts.Head.CFrame:ToOrientation()
		plrbase.Data.Camera.LookTop = (headrot >= 0.65)
		plrbase.Data.Camera.LookBottom = (headrot <= -0.65)
	end
	
	plrbase.MovingData.Back = ((plrbase.Humanoid.MoveDirection:Dot(plrbase.Camera.CFrame.LookVector)) < -0.75 and plrbase.Data.Camera.FirstPerson)
	
	local breathingrunning = 0.3
	if plrbase.MovingData.Running then
		breathingrunning = 1
	end
	plrbase.Parts.Head.Breathing.Volume = (math.abs((plrbase.Stamina/100)-1))*0.7*breathingrunning
	
	plrbase.Typing = (uis:GetFocusedTextBox() ~= nil)
	UpdateSpeed()
	UpdateCrawl()
	UpdateJump()
	ShakeCamera()
	UpdateSirens()
	UpdateDrinks()
	UpdatePoison()
	plrbase.Sensitivity = UpdateSens()
end