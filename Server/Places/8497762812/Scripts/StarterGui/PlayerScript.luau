--Script Creator {Woowz11 (In ROBLOX "Woowz14")}
local function GetValue(name)
	local ValuesHere = script.Parent:WaitForChild("PlayerStarting").PlayerVariables
	return ValuesHere:WaitForChild(name).Value
end
local function SetValue(name,value)
	local ValuesHere = script.Parent:WaitForChild("PlayerStarting").PlayerVariables
	ValuesHere:WaitForChild(name).Value = value
end

local function GetGlobalValue(name)
	local ValuesHere = game.Workspace["Game Files"].WorldVariables
	return ValuesHere:WaitForChild(name).Value
end

local Player = script.Parent.Parent--Игрок
local Character = Player.Character--Тело игрока

if Character:WaitForChild("HumanoidRootPart") then

	local PlayerParts = {
		Base = Character:WaitForChild("HumanoidRootPart");--Туловище игрока
		Torse = {--Пояс игрока
			Upper = Character:WaitForChild("UpperTorso");
			Lower = Character:WaitForChild("LowerTorso");
		};
		Head = Character:WaitForChild("Head");--Голова игрока
		Legs = {
			Left = {
				Lower = Character:WaitForChild("LeftLowerLeg");
				Upper = Character:WaitForChild("LeftUpperLeg");
				Foot = Character:WaitForChild("LeftFoot");
			};
			Right = {
				Lower = Character:WaitForChild("RightLowerLeg");
				Upper = Character:WaitForChild("RightUpperLeg");
				Foot = Character:WaitForChild("RightFoot");
			};
		};
		Arms = {
			Left = {
				Lower = Character:WaitForChild("LeftLowerArm");
				Upper = Character:WaitForChild("LeftUpperArm");
				Hand = Character:WaitForChild("LeftHand");
			};
			Right = {
				Lower = Character:WaitForChild("RightLowerArm");
				Upper = Character:WaitForChild("RightUpperArm");
				Hand = Character:WaitForChild("RightHand");
			};
		};
	}

	local Humanoid = Character.Humanoid

	local Mouse = Player:GetMouse()

	--[====(Описание переменных за скриптом)====]
	--(Тип)-Название-Значение

	--(Bool)-PlayerMoving-Игрок двигается?
	--(Bool)-PlayerSit-Игрок сидит?
	--(Bool)-PlayerSitDriver-Игрок сидит за рулём?
	--(Bool)-PlayerDead-Игрок мёртв?
	--(Bool)-PlayerLookInObject-Игрок смотрит на объект?
	--(Bool)-PlayerInFloor-Игрок находится на поверхности?
	--(Bool)-PlayerFly-Игрок летает?
	--(Bool)-PlayerRunning-Игрок бежит?
	--(Bool)-PlayerInWater-Игрок в воде?
	--(Bool)-PlayerFalling-Игрок падает?
	--(Bool)-PlayerRising-Игрок возвышается?
	--(Bool)-PlayerDraggedObjects-Игрок держит объект?
	--(Bool)-PlayerUnreached-Игрок дотягивается до объекта?

	--(Number)-PlayerHealth-Здоровье игрока
	--(Number)-PlayerDistanceMouse-Растояние между PlayerMousePosition и PlayerPosition
	--(Number)-PlayerVelocity-Скорость игрока
	--(Number)-PlayerFlySpeedNormal-Скорость полёта
	--(Number)-PlayerFlySpeedRun-Скорость полёта при беге
	--(Number)-PlayerUnreachedValue-При каком числе игрок не будет дотягиватся курсором мыши до объектов
	--(Number)-PlayerArmsLength-Длина рук (Не в прямом плане), определяет доскольки дотягивается курсор

	--(Vector3)-PlayerPosition-Позиция игрока
	--(Vector3)-PlayerRotate-Поворот игрока
	--(Vector3)-PlayerHeadPosition-Позиция головы игрока
	--(Vector3)-PlayerHeadRotate-Поворот головы игрока
	--(Vector3)-PlayerMousePosition-Позиция курсора игрока в игровом пространстве
	--(Vector3)-PlayerVelocityVector-Скорость игрока

	--(String)-PlayerFloorMaterial-Получение материалла под ногами игрока

	--(Object)-PlayerLookingObject-Объект на который смотрит игрок
	--(Object)-DraggedObject-Объект который взял игрок

	--[==================( Переменные )=======================]
	local PlayerFlySpeed = GetValue("PlayerFlySpeedNormal")--Скорость полёта игрока
	local PlayerSpeeds = GetGlobalValue("PlayersSpeed")--Скорость ходьбы игрока
	local PlayerFlyYType = 0
	local Drag = {
		DragObject = nil;
		DragObjectPos = Vector3.zero;
		Att = nil;
	}
	local DragObject = nil
	local DragObjectPos = Vector3.zero


	--[==================( Не игровые функции )=======================]
	local function ReplaceInString(original,replace,tothis)--Заменить в original, replace на tothis
		return string.gsub(original,replace,tothis)
	end

	local function ClearInString(original,clear)--Удалить clear в original
		return ReplaceInString(original,clear,"")
	end

	local function GetDistanceTwoVectors(vector1,vector2)--Получает дистанцию между двумя Vector3
		return math.abs((vector1-vector2).Magnitude)
	end

	local function IfInt(typ,number,min,max)--[typ==0] Если Number больше Min то TRUE
		--[typ==1] Если Number больше Min, и Number меньше Max то TRUE
		local result = false
		if typ == 1 then
			if number < max and number > min then
				result = true
			else
				result = false
			end
			return result
		else if typ == 0 then
				if number > min then
					result = true
				else
					result = false
				end
				return result
			end
		end
	end

	local function IfEqually(orig,need)--Если Orig совпадает с Need то TRUE
		if orig == need then
			return true
		else
			return false
		end
	end

	local function And(n1,n2,n3,n4,n5,n6,n7,n8,n9,n10)--Функция And в одну строчку
		local f1 = not n1
		local f2 = not n2
		local f3 = not n3
		local f4 = not n4
		local f5 = not n5
		local f6 = not n6
		local f7 = not n7
		local f8 = not n8
		local f9 = not n9
		local f10 = not n10
		if f1 and f2 and f3 and f4 and f5 and f6 and f7 and f8 and f9 and f10 then
			return false
		else
			return true
		end
	end

	local function SetValueInvertBool(name)--Инвертирует Value [РАБОТАЕТ ТОЛЬКО НА BOOL]
		SetValue(name,not GetValue(name))
	end
	--[==================( Игровые функции )=======================]
	local function SetPlayerSpeed(speed)--Изменяет игроку скорость ходьбы
		Humanoid.WalkSpeed = speed
	end

	local function SetPlayerGravity(gravity)--Изменяет гравитацию игроку
		game.Workspace.Gravity = gravity
	end

	local function Start()--Функция которая загружает различное
		SetPlayerGravity(GetGlobalValue("Gravity"))
		SetPlayerSpeed(PlayerSpeeds)

	end
	Start()

	local function SetNilMass(obj)
		local Body = Instance.new("BodyForce")
		Body.Force = Vector3.new(0,obj:GetMass()*game.Workspace.Gravity,0)
		Body.Parent = obj
		Body.Name = "NilMass"
	end
	local function ClearNilMass(obj)
		local Body = obj:WaitForChild("NilMass")
		Body:Destroy()
	end

	local function SetNilMassPlayer()
		SetNilMass(PlayerParts.Base)
		SetNilMass(PlayerParts.Head)
		SetNilMass(PlayerParts.Torse.Lower)
		SetNilMass(PlayerParts.Torse.Upper)
		SetNilMass(PlayerParts.Arms.Left.Hand)
		SetNilMass(PlayerParts.Arms.Right.Hand)
		SetNilMass(PlayerParts.Arms.Left.Lower)
		SetNilMass(PlayerParts.Arms.Right.Lower)
		SetNilMass(PlayerParts.Arms.Left.Upper)
		SetNilMass(PlayerParts.Arms.Right.Upper)
		SetNilMass(PlayerParts.Legs.Left.Foot)
		SetNilMass(PlayerParts.Legs.Right.Foot)
		SetNilMass(PlayerParts.Legs.Left.Lower)
		SetNilMass(PlayerParts.Legs.Right.Lower)
		SetNilMass(PlayerParts.Legs.Left.Upper)
		SetNilMass(PlayerParts.Legs.Right.Upper)
	end
	local function ClearNilMassPlayer()
		ClearNilMass(PlayerParts.Base)
		ClearNilMass(PlayerParts.Head)
		ClearNilMass(PlayerParts.Torse.Lower)
		ClearNilMass(PlayerParts.Torse.Upper)
		ClearNilMass(PlayerParts.Arms.Left.Hand)
		ClearNilMass(PlayerParts.Arms.Right.Hand)
		ClearNilMass(PlayerParts.Arms.Left.Lower)
		ClearNilMass(PlayerParts.Arms.Right.Lower)
		ClearNilMass(PlayerParts.Arms.Left.Upper)
		ClearNilMass(PlayerParts.Arms.Right.Upper)
		ClearNilMass(PlayerParts.Legs.Left.Foot)
		ClearNilMass(PlayerParts.Legs.Right.Foot)
		ClearNilMass(PlayerParts.Legs.Left.Lower)
		ClearNilMass(PlayerParts.Legs.Right.Lower)
		ClearNilMass(PlayerParts.Legs.Left.Upper)
		ClearNilMass(PlayerParts.Legs.Right.Upper)
	end

	local function SetFlyMode(bool)--Включить, выключить fly mode
		if bool then
			SetNilMassPlayer()
			SetValue("PlayerFly",true)
		else
			ClearNilMassPlayer()
			SetPlayerSpeed(PlayerSpeeds)
			SetValue("PlayerFly",false)
		end
	end

	local function SetPlayerVelocity(velocity)--Применить силу на игрока
		PlayerParts.Base.Velocity = velocity
	end

	local function SetPlayerPosition(pos)--Изменить позицию игроку
		PlayerParts.Base.CFrame = CFrame.new(pos.x,pos.y,pos.z)
	end

	local function IgnoreMouse(obj)--mouse.ray теперь игнорирует этот объект
		Mouse.TargetFilter = obj
	end

	local function DragProp(obj)--Функция на поднятия предмета
		local DragObj = Instance.new("Part",game.Workspace)
		DragObj.Name = "DragProp"
		DragObj.Size = Vector3.new(0.5,0.5,0.5)
		DragObj.Transparency = 1
		DragObj.CanCollide = false
		DragObj.Anchored = true
		DragObj.BrickColor = BrickColor.new(255,0,0)
		DragObj.Position = GetValue("PlayerHeadPosition")+((GetValue("PlayerMousePosition")-GetValue("PlayerHeadPosition")).Unit*GetValue("PlayerArmsLength"))
		DragObj.CanTouch = false
		DragObj.Material = Enum.Material.Neon
		DragObj.Shape = Enum.PartType.Ball
		Drag.DragObject = DragObj
		IgnoreMouse(DragObject)
		
		local AttInDrag = Instance.new("Attachment",Drag.DragObject)
		AttInDrag.Name = "Point"
		
		local AttInObj = Instance.new("Attachment",obj)
		AttInObj.CFrame = obj.CFrame:ToObjectSpace(Mouse.Hit)
		AttInObj.Name = "Point"
		Drag.Att = AttInObj
		
		local spring = Instance.new("SpringConstraint",Drag.DragObject)
		spring.Visible = true
		spring.Attachment0 = AttInDrag
		spring.Attachment1 = AttInObj
		spring.Stiffness = 3*obj:GetMass()
		spring.Coils = 0
		spring.FreeLength = 0
		spring.Thickness = 0.5
		spring.Color = BrickColor.Red()

	end
	local function ClearDragProp()
		SetValue("DraggedObject",nil)
		SetValue("PlayerDraggedObjects",false)
		Drag.DragObject:Destroy()
		Drag.Att:Destroy()
	end

	local UIS = game:GetService("UserInputService")--Клавиша нажата
	UIS.InputBegan:Connect(function(input, gameProcessedEvent)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then--ПКМ
			if GetValue("PlayerLookingObject") then
				if not GetValue("PlayerLookingObject").Anchored then
					local havethis =  GetValue("PlayerLookingObject"):FindFirstChild("PlayerCanDragThis")
					if havethis then
						if havethis.Value then
							if not GetValue("PlayerUnreached") then
							SetValue("DraggedObject",GetValue("PlayerLookingObject"))
							SetValue("PlayerDraggedObjects",true)
							DragProp(GetValue("PlayerLookingObject"))
							end
						end
					end
				end
			end
		end


		if input.UserInputType == Enum.UserInputType.Keyboard then--Клавиатура

			if input.KeyCode == Enum.KeyCode.V then--Включение, выключение полёта
				SetFlyMode(not GetValue("PlayerFly"))
			end
			if GetValue("PlayerFly") then
				if input.KeyCode == Enum.KeyCode.Space and PlayerFlyYType == 0 then
					PlayerFlyYType = 1
				end
				if input.KeyCode == Enum.KeyCode.LeftControl and PlayerFlyYType == 0 then
					PlayerFlyYType = -1
				end
			end
			if input.KeyCode == Enum.KeyCode.LeftShift then
				SetValue("PlayerRunning",true)
			end

		end
	end)

	local UIS = game:GetService("UserInputService")--Клавиша отжата
	UIS.InputEnded:Connect(function(input, gameProcessedEvent)

		if input.UserInputType == Enum.UserInputType.MouseButton1 then--ПКМ
			ClearDragProp()
		end

		if input.UserInputType == Enum.UserInputType.Keyboard then--Клавиатура
			if input.KeyCode == Enum.KeyCode.Space then
				PlayerFlyYType = 0
			end
			if input.KeyCode == Enum.KeyCode.LeftControl then
				PlayerFlyYType = 0
			end
			if input.KeyCode == Enum.KeyCode.LeftShift then
				SetValue("PlayerRunning",false)
			end

		end
	end)

	local function PlayerUpdate()

		if GetValue("PlayerRunning") then
			PlayerFlySpeed = GetValue("PlayerFlySpeedRun")
		else
			PlayerFlySpeed = GetValue("PlayerFlySpeedNormal")
		end

		if GetValue("PlayerFly") then
			SetPlayerVelocity(Vector3.new(PlayerParts.Base.Velocity.x,PlayerFlySpeed*PlayerFlyYType,PlayerParts.Base.Velocity.z))
			SetPlayerSpeed(PlayerFlySpeed)
		end

		if GetValue("PlayerDead") then
			SetFlyMode(false)
		end

		if GetValue("PlayerDraggedObjects") then
			Drag.DragObject.Position = GetValue("PlayerHeadPosition")+((GetValue("PlayerMousePosition")-GetValue("PlayerHeadPosition")).Unit*20)
		end

	end


	--[============================================================]
	local function SetsValue()
		SetValue("PlayerPosition",PlayerParts.Base.Position)
		SetValue("PlayerHeadPosition",PlayerParts.Head.Position)
		SetValue("PlayerRotate",PlayerParts.Base.Orientation)
		SetValue("PlayerHeadRotate",PlayerParts.Head.Orientation)
		SetValue("PlayerMousePosition",Mouse.Hit.Position)
		SetValue("PlayerHealth",Humanoid.Health)
		SetValue("PlayerDead",not IfInt(0,Humanoid.Health,0))
		SetValue("PlayerSit",Humanoid.Sit)
		SetValue("PlayerDistanceMouse",GetDistanceTwoVectors(GetValue("PlayerPosition"),GetValue("PlayerMousePosition")))
		SetValue("PlayerFloorMaterial",ClearInString(tostring(Humanoid.FloorMaterial),"Enum.Material."))
		SetValue("PlayerLookInObject",not IfInt(0,GetValue("PlayerDistanceMouse"),9900))
		SetValue("PlayerVelocityVector",PlayerParts.Base.Velocity)
		SetValue("PlayerVelocity",GetValue("PlayerVelocityVector").Magnitude)
		SetValue("PlayerMoving",IfInt(0,GetValue("PlayerVelocity"),0.1))
		SetValue("PlayerLookingObject",Mouse.Target)
		SetValue("PlayerInFloor",not IfEqually(GetValue("PlayerFloorMaterial"),"Air"))
		SetValue("PlayerInWater",IfEqually(Humanoid:GetState(),Enum.HumanoidStateType.Swimming))
		SetValue("PlayerFalling",IfInt(0,-GetValue("PlayerVelocityVector").y,0.1))
		SetValue("PlayerRising",IfInt(0,GetValue("PlayerVelocityVector").y,0.1))
		SetValue("PlayerUnreached",IfInt(0,GetValue("PlayerDistanceMouse"),GetValue("PlayerUnreachedValue")))
	end
	while true do
		wait()
		PlayerUpdate()
		SetsValue()

	end -- while true do
end--if PlayerBase then
