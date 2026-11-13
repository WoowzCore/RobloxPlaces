local UIS = game:GetService("UserInputService")
local Humanoid
local Player
local Charcter
local humanoidRootPart
local Cam = game.Workspace.CurrentCamera
local UpdateRandom--Случайное число от [-1] до [1] каждый кадр

--Переменные игрока
local PlayerSpeed = 10--Скорость игрока когда он идёт
local PlayerSpeedRun = 20--Скорость игрока когда он бежит
local PlayerSlowRunSpeed = 5
local PlayerRunning = false--Игрок бежит?
local PlayerSlowWalk = false
local PlayerSpeedMultiple = 1--Ускорение взависимости от материала поверхности
local FOVpower = 80
local FOVStart = 70

local PlayerRagdoll = false

local PlayerFirstPerson = false
local PlayerCameraDistance = 10

local KeyCode_Run = Enum.KeyCode.LeftShift
local KeyCode_SlowWalk = Enum.KeyCode.LeftControl
local KeyCode_CameraMode = Enum.KeyCode.C

local PlayerSpeedFloorNormal = 1
local PlayerSpeedFloorDirt = 0.8
local PlayerSpeedFloorMud = 0.4
local PlayerSpeedFloorStone = 1.3
local PlayerSpeedFloorRoad = 1.8

--Не игровые функции

local function GetValue(name)
	return script.Parent.Value_Folder:WaitForChild(name).Value
end
local function SetValue(name,value)
	script.Parent.Value_Folder:WaitForChild(name).Value = value
end


local function Start()--Загружает данные
	Player = script.Parent.Parent
	Charcter = Player.Character
	Humanoid = Charcter:WaitForChild("Humanoid")
	humanoidRootPart = Charcter.HumanoidRootPart
	
	Player.CameraMaxZoomDistance = PlayerCameraDistance
	Player.CameraMinZoomDistance = PlayerCameraDistance
end
Start()

local function PrintPlayer(text)--Создаёт сообщение в консоли, с учётом игрока (string/Сообщение)
	print(Player.Name.." : "..text )
end

local function Random0_1()--Случайное число от [0] до [1]
	return (math.random(0,100)/100)
end

local function Random1_1()--Случайное число от [-1] до [1]
	return (math.random(-100,100)/100)
end

--Игровые функции
local function SetPlayerSpeed(speed)--Даёт новую скорость игроку (number/Скорость)
	Humanoid.WalkSpeed = speed
end
local function SetPlayerJump(hight)
	Humanoid.JumpHeight = hight
end

local function SetCameraFOV(number)--Меняет FOV у камеры (number/Новый FOV)
	Cam.FieldOfView = number
end

local function CameraFOV(count, number)--Плавно меняет FOV у камеры (int(не меньше 2)/Плавность, number(не меньше 0)/Сила FOV)
	for i = 1, count do
		SetCameraFOV((70+(i*number)))
		wait()
	end
end
local function CameraFOVBack(count, number)--Тоже самое что CameraFOV, но возращает камеру на место если вписать те же значения
	for i = 1, count do
		SetCameraFOV((80-(i*number)))
		wait()
	end
end
--Управление
local function StopRun()
	PlayerRunning = false
	PlayerSlowWalk = false
	SetPlayerSpeed(PlayerSpeed*PlayerSpeedMultiple)
	SetCameraFOV(FOVStart)
end

UIS.InputBegan:Connect(function(input,gameProcessedEvent)--Кнопка нажата
	if input.UserInputType == Enum.UserInputType.Keyboard then
		
		if input.KeyCode == KeyCode_CameraMode then
			PlayerFirstPerson = not PlayerFirstPerson
		end
		
		if humanoidRootPart.Velocity.Magnitude > 1 and not PlayerRagdoll then
			if input.KeyCode == KeyCode_Run and not PlayerSlowWalk then--Бег
			
			local i = 30
			PlayerRunning = true
			SetCameraFOV(FOVpower)
			while PlayerRunning do
				wait()
				i = i + 1
				if i >= (30+(Random0_1()*10)) then
					
				local rand = PlayerSpeedRun-(UpdateRandom*6)
				PrintPlayer("Run Speed = "..rand)
					SetPlayerSpeed(rand*PlayerSpeedMultiple)
					i = 0
					end
			end

		end
			if input.KeyCode == KeyCode_SlowWalk and not PlayerRunning then--Медленная ходьба
				PlayerSlowWalk=true
				SetPlayerSpeed(PlayerSlowRunSpeed)
				
			
			end 
		end
			end
	end)

UIS.InputEnded:Connect(function(input,gameProcessedEvent)--Кнопка отжата
	if input.UserInputType == Enum.UserInputType.Keyboard then

		if input.KeyCode == KeyCode_Run or input.KeyCode == KeyCode_SlowWalk then--Отключение бега
			StopRun()
			end
	end
end)

--Сложноное

while true do
	wait()
	
	SetValue("Player_In_First_Person",PlayerFirstPerson)
	if PlayerFirstPerson then
		Player.CameraMaxZoomDistance = 0
		Player.CameraMinZoomDistance = 0
	else
		if GetValue("Player_Driver_Car") then
		Player.CameraMaxZoomDistance = PlayerCameraDistance*2
		Player.CameraMinZoomDistance = PlayerCameraDistance*2
		else
		Player.CameraMaxZoomDistance = PlayerCameraDistance
		Player.CameraMinZoomDistance = PlayerCameraDistance
			end
	end
	
	UpdateRandom = Random1_1()
	
	PlayerRagdoll = script.Parent:WaitForChild("ragdoll"):WaitForChild("variables"):WaitForChild("ragdoll").Value	
	
	if Humanoid then
		if Humanoid.FloorMaterial == Enum.Material.Grass or Humanoid.FloorMaterial == Enum.Material.Sand or Humanoid.FloorMaterial == Enum.Material.Snow or Humanoid.FloorMaterial == Enum.Material.LeafyGrass or Humanoid.FloorMaterial == Enum.Material.Salt then
			PlayerSpeedMultiple=PlayerSpeedFloorDirt
		else if Humanoid.FloorMaterial == Enum.Material.Slate or Humanoid.FloorMaterial == Enum.Material.Concrete or Humanoid.FloorMaterial == Enum.Material.WoodPlanks or Humanoid.FloorMaterial == Enum.Material.DiamondPlate or Humanoid.FloorMaterial == Enum.Material.Ice or Humanoid.FloorMaterial == Enum.Material.Marble or Humanoid.FloorMaterial == Enum.Material.Glacier or Humanoid.FloorMaterial == Enum.Material.Asphalt   then
				PlayerSpeedMultiple=PlayerSpeedFloorStone
			else if Humanoid.FloorMaterial == Enum.Material.Mud then
					PlayerSpeedMultiple = PlayerSpeedFloorMud
				else if Humanoid.FloorMaterial == Enum.Material.Basalt then
						
						PlayerSpeedMultiple = PlayerSpeedFloorRoad
			
			else
						PlayerSpeedMultiple=PlayerSpeedFloorNormal
				
			end end end
		end
		
		
		
		
		
		if Humanoid.FloorMaterial == Enum.Material.CrackedLava then
			Humanoid.Health = Humanoid.Health -1
		end
		
		
		
		
		
		
		
		
		if Humanoid.FloorMaterial == Enum.Material.Mud then
			SetPlayerJump(0)
		else if Humanoid.FloorMaterial == Enum.Material.Foil then
				SetPlayerJump(15)
			else
				SetPlayerJump(5)
			end 
				
			
		end
		
	end 
	
	
end


