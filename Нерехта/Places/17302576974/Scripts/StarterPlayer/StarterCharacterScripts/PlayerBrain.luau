local RS = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local PlayerData = require(script.Parent:WaitForChild("PlayerData"))
local Camera = workspace.CurrentCamera
local Mouse = PlayerData.Player:GetMouse()

RS.CheckBodyPositionAndGyroClient.OnClientInvoke = function(part)
	local result = false
	if part:FindFirstChildOfClass("BodyPosition") or part:FindFirstChildOfClass("BodyGyro") then
		result = true
	end
	return result
end

--[[ Получить массу объекта ]]
function GetMass(object)
	if object:IsA("BasePart") then
		return object:GetMass()
	elseif object:IsA("Model") or object:IsA("Folder") then
		local result = 0
		for _, part in pairs(object:GetDescendants()) do
			if part:IsA("BasePart") then
				result += part:GetMass()
			end
		end
		return result
	end
end

--[[ Перезапуск персонажа игрока ]]
function RestartPlayer(died)
	RS.LoadPlayer:FireServer(PlayerData.Player,died or false)
end

--[[ Загрузка скрипта ]]
function LoadBrain()
	PlayerData.Humanoid.Died:Connect(PlayerDied)
end
script.Parent.PlayerData.LoadBrain.Event:Connect(LoadBrain)

--[[ Получить главный предмет из парта ]]
function GetItemParent(parent)
	local CheckParent = function(p)
		if p == nil then return true end
		if p == workspace then return true end
		
		return p.Name == "--Map--"
	end

	for i=0,10 do
		if CheckParent(parent.Parent) then
			if parent.Parent == workspace then
				return nil
			end
			break
		else
			parent = parent.Parent
		end
	end
	return parent
end

--[[ Предмет в инвентарь ]]
function ItemToInventory()
	local pi = PlayerData.PickedItem
	UnpickItem(pi)
	local item = GetItemParent(pi)
	RS.ChangeParent:FireServer(item,PlayerData.Backpack)
	local pos = workspace.PlayersInfo.ItemsPlatform.Position
	RS.ChangeCFrame:FireServer(item,CFrame.new(pos.X+math.random(-35,35),pos.Y+math.random(5,20),pos.Z+math.random(-35,35)))
end

--[[ Предмет в мир ]]
function ItemFromInventory(pos)
	
end

--[[ Проверить WoowzJoint и Anchored ]]
function CheckJointsAnchored(part)
	local result = true
	local joints = {}
	for _, p in pairs(GetItemParent(part):GetDescendants()) do
		if p:IsA("BasePart") then
			for _2, j in pairs(p:GetJoints()) do
				table.insert(joints,j)
			end
		end
	end
	
	for _, joint in pairs(joints) do
		if joint.Name == "WoowzJoint" then
			if joint.Part0.Anchored == true or joint.Part1.Anchored == true then
				result = false
			end
		end
	end
	return result
end

----------------------------------------------- PickUpProp ----------------------------------------------------

local TweenService = game:GetService("TweenService")

local Props = workspace:WaitForChild("--Map--")
local PickupPropEvent = game.ReplicatedStorage:WaitForChild("SetNetworkOwner") 

local BodyGyro = nil
local BodyPosition = nil

local StartCFrame = CFrame.new(0,0,0)
local StartCameraCFrame = CFrame.new(0,0,0)
function Pick(Prop)
	PlayerData.PickedItem = Prop
	PlayerData.PickedParentItem = GetItemParent(PlayerData.PickedItem)
	PlayerData.ItemMass = GetMass(PlayerData.PickedParentItem)
	
	PickupPropEvent:FireServer(Prop) 

	local mass = math.max(1,PlayerData.ItemMass)

	local MaxForce = Vector3.new(1000,1000,1000)
	local BodyGyro_ = Instance.new("BodyGyro")
	BodyGyro_.Name = "Pick_Gyro"
	BodyGyro_.MaxTorque = MaxForce/50
	BodyGyro_.D = 50
	BodyGyro_.P = 0
	BodyGyro_.Parent = Prop
	BodyGyro = BodyGyro_ 

	local BodyPosition_ = Instance.new("BodyPosition")
	BodyPosition_.Name = "Pick_Position"
	BodyPosition_.MaxForce = MaxForce
	BodyPosition_.D = 60
	BodyPosition_.P = 0
	BodyPosition_.Parent = Prop
	BodyPosition = BodyPosition_

	StartCFrame = Prop.CFrame
	StartCameraCFrame = Camera.CFrame + Camera.CFrame.LookVector * PlayerData.HoldDistance

	local Info = TweenInfo.new(0.7)
	TweenService:Create(BodyPosition, Info, {P = 1200/mass}):Play()
	TweenService:Create(BodyGyro, Info, {P = 700/mass}):Play()
end

function Drop(kick)
	BodyPosition:Destroy()
	BodyGyro:Destroy()

	PlayerData.PickedItem.Velocity = PlayerData.PickedItem.Velocity / 3

	if kick then
		PlayerData.PickedItem.Velocity = (PlayerData.PickedItem.CFrame.Position - Camera.CFrame.Position).Unit * 30 / math.max(1,(PlayerData.PickedItem:GetMass()/2))
	end

	PlayerData.PickedItem = nil
end

function UpdatePropSystem()
	if PlayerData.PickedItem then
		if BodyPosition and BodyGyro then
			local HoldPos = Camera.CFrame + Camera.CFrame.LookVector * PlayerData.HoldDistance
			PlayerData.PickupPosition = HoldPos.Position

			local x,y,z = StartCFrame:ToOrientation()
			local x2,y2,z2 = HoldPos:ToOrientation()
			local x3,y3,z3 = StartCameraCFrame:ToOrientation()

			local rotation = ((math.abs(math.deg(y3-y)/180)-0.5)*2)

			local minusx = 1
			if ((math.abs(math.deg(y3-y)/180)-0.5)*2)<0 then
				minusx = -1
			end

			local minusz = 1
			if ((math.abs((math.deg(y3+y)+90)/180)-0.5)*2)<0 then --Фикс что если проп на 90 градусов повернуть то криво поворачивается и т.д
				minusz = -1
			end

			local xresult = (x+(x3-x2)*minusx)*math.abs(rotation)
			local yresult = y+(y2-y3)
			local zresult = (x+(x3-x2)*minusz)*(1-math.abs(rotation))
			local cf = CFrame.fromOrientation(xresult,yresult,zresult) + HoldPos.Position
			BodyGyro.CFrame = cf * PlayerData.RotationItem
			BodyPosition.Position = HoldPos.Position

			local Distance = PlayerData.GetDistance(PlayerData.PickedItem.CFrame.Position,PlayerData.PickupPosition)

			if (Distance>PlayerData.ItemHoldDistance.Y) then
				UnpickItem(PlayerData.PickedItem)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------

--[[ Поднять предмет ]]
local DistancePickItem = PlayerData.ItemHoldDistance.Y/2
function PickItem(Part)
	if CheckJointsAnchored(Part) then
		local checkbodyposition = nil
		local success, errorMessage = pcall(function()
			checkbodyposition = RS.CheckBodyPositionAndGyro:InvokeServer(Part)
		end)
		print(checkbodyposition)
		if checkbodyposition==false or checkbodyposition==nil then
			DistancePickItem = math.clamp(PlayerData.GetDistance(Part.CFrame.Position,Camera.CFrame),PlayerData.ItemHoldDistance.X,PlayerData.ItemHoldDistance.Y)
			Pick(Part)
		end
	end
end

--[[ Бросить предмет ]]
local TakeItem = false
local KickTimer = 0
function UnpickItem(Part,Kick)
	if Kick == nil then Kick = false end
	TakeItem = false
	KickTimer = 0
	
	Drop(Kick)
end

--[[ Функция когда игрок умерает ]]
function PlayerDied()
	if PlayerData.PickedItem then
		UnpickItem(PlayerData.PickedItem)
	end
	wait()
	RestartPlayer(true)
end


--[[ Запись нажимания клавиш ]]
UIS.InputBegan:Connect(function(input,chat)
	if (not chat) then
		local key = input.KeyCode
		PlayerData.Keys[key] = true
		
		if(key == Enum.KeyCode.C) then
			if(PlayerData.Crawl)then
				PlayerData.Laying = true
			else
				PlayerData.Crawl = true
			end
		end
		if(key == Enum.KeyCode.Space) then
			wait(0.5)
			if(PlayerData.Crawl)then
				PlayerData.Crawl = false
			elseif(PlayerData.Laying)then
				PlayerData.Laying = false
			end
		end
		if(key == Enum.KeyCode.E)then
			if PlayerData.PickedItem then
				TakeItem = true
			else
				if(PlayerData.ItemFromEyes~=nil and PlayerData.ItemParentFromEyes~=nil)then
					PickItem(PlayerData.ItemFromEyes)
				end
			end
		end
		if(key == Enum.KeyCode.Q)then
			if PlayerData.PickedItem~=nil then
				if PlayerData.ItemSize<4 then
					ItemToInventory()
				end
			end
		end
	end
end)
UIS.InputEnded:Connect(function(input,chat)
	if (not chat) then
		local key = input.KeyCode
		PlayerData.Keys[key] = false
		
		if(key == Enum.KeyCode.E) then
			if(PlayerData.PickedItem and TakeItem)then
				UnpickItem(PlayerData.PickedItem,KickTimer>1)
			end
		end
	end
end)
UIS.InputChanged:Connect(function(input,chat)
	if (not chat) then
		if input.UserInputType == Enum.UserInputType.MouseWheel then
			PlayerData.MouseWheel = math.clamp(PlayerData.MouseWheel+(input.Position.Z/2),-1,1)
		end
	end
end)
Mouse.Button1Down:Connect(function()
	
end)

--[[ Обработка нажатия клавиш ]]
function Keys()
	PlayerData.Running = (PlayerData.Keys[Enum.KeyCode.LeftShift])
	PlayerData.SlowWalk = (PlayerData.Keys[Enum.KeyCode.LeftControl] and not PlayerData.Running)
end

--[[ Изменение данных камеры ]]
function ChangeCamera()
	local Offset = Vector3.new(0,0,-1)
	
	PlayerData.Humanoid.CameraOffset = Offset
end

--[[ Обновлять позицию поднятого предмета ]]
function UpdatePickItemPosition(dt)
	DistancePickItem = math.clamp(DistancePickItem + PlayerData.MouseWheel*dt,PlayerData.ItemHoldDistance.X,PlayerData.ItemHoldDistance.Y)
end

--[[ Изменение скорости игрока ]]
function ChangeWalkSpeed()
	local result = 12
	if PlayerData.SlowWalk then
		result = 6
	end
	if PlayerData.Running then
		result = 20
	end
	if PlayerData.Crawl then
		result = 6
	end
	if PlayerData.Laying then
		result = 4
	end
	if PlayerData.PickedItem then
		result = math.max(0.5,result - ((PlayerData.PickedItem:GetMass())))
	end
	return result
end

--[[ Изменение силы прыжка ]]
function ChangeJumpPower()
	local result = 15
	if (PlayerData.Running) then
		result = 13
	end
	if (PlayerData.Crawl) then
		result = 0
	end
	return result
end

function ChangeMouseSensitivity()
	local result = 0.2
	
	if PlayerData.Laying then
		result = 0.05
	end
	
	if PlayerData.PickedItem then
		result = math.max(0.025,result - ((PlayerData.PickedItem:GetMass()/20)))
	end
	
	return result
end

--[[ Получить объект по позиции курсора ]]
function GetItemFromEyes()
	local result = nil
	
	local Params = RaycastParams.new()
	Params.IgnoreWater = true
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.FilterDescendantsInstances = PlayerData.Character:GetDescendants()
	
	local RaycastResult = workspace:Raycast(Camera.CFrame.Position, Camera.CFrame.LookVector * PlayerData.ItemHoldDistance.Y, Params)
	if RaycastResult == nil then return nil end
	
	local Part = RaycastResult.Instance
	
	if Part:IsA("BasePart") then
		if not Part.Anchored then
			result = Part
		end
	end
	
	return result
end

--[[ Получить размер объекта ]] 
function GetItemSize()
	local result = 0
	
	local item = PlayerData.ItemFromEyes
	if(item~=nil)then
		local parent = GetItemParent(item)
		
		if parent~=nil then
			local GetSizeFromThis = Vector3.zero
			if parent:IsA("BasePart") then
				GetSizeFromThis = parent.Size
			elseif parent:IsA("Model") then
				GetSizeFromThis = parent:GetExtentsSize()
			elseif parent:IsA("Folder") then
				local model = Instance.new("Model")
				local clone = parent:Clone()
				clone.Parent = model
				GetSizeFromThis = model:GetExtentsSize()
				model:Destroy()
			end
		
			PlayerData.ItemParentFromEyes = parent
			result = math.max(GetSizeFromThis.x,math.max(GetSizeFromThis.y,GetSizeFromThis.z))
		end
	else
		PlayerData.ItemParentFromEyes = nil
	end
	
	return result
end

--[[ Функция каждый кадр ]]
game:GetService("RunService").RenderStepped:Connect(function(dt)
	if (PlayerData.PlayerLoaded) then	
		Keys()
		
		if PlayerData.MouseWheel>0.1 or PlayerData.MouseWheel<-0.1 then
			if PlayerData.MouseWheel>0.1 then
				PlayerData.MouseWheel -= dt
			else
				PlayerData.MouseWheel += dt				
			end
		else
			PlayerData.MouseWheel = 0
		end
		
		if TakeItem then
			KickTimer += dt
			DistancePickItem = math.max(PlayerData.ItemHoldDistance.X,DistancePickItem-dt)
		end
		
		ChangeCamera()
		PlayerData.Humanoid.WalkSpeed = ChangeWalkSpeed()
		PlayerData.Humanoid.JumpPower = ChangeJumpPower()
		PlayerData.ItemFromEyes = GetItemFromEyes()
		UIS.MouseDeltaSensitivity = ChangeMouseSensitivity()
		if (PlayerData.PickedItem ~= nil) then
			local parent = GetItemParent(PlayerData.PickedItem)	
			PlayerData.PickedParentItem = GetItemParent(PlayerData.PickedItem)
			UpdatePickItemPosition(dt) PlayerData.HoldDistance = DistancePickItem
		else
			PlayerData.PickedParentItem = nil
		end
		if (PlayerData.PickedParentItem ~= nil) then
			PlayerData.ItemMass = GetMass(PlayerData.PickedParentItem)
		end
		PlayerData.ItemSize = GetItemSize()
		
		UpdatePropSystem()
	end
end)