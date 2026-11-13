local ValueHolder = Instance.new("Folder",script.Parent)
local Player = script.Parent.Parent
local Charcter = Player.Character
local Humanoid = Charcter:WaitForChild("Humanoid")
ValueHolder.Name = "Value_Folder"
local ValueHolderFinal = ValueHolder

--[======================== (Создание параметров) ==========================]
local function CreateValue(ValueType,ValueName,Value)
	local ValueTypeInstance = ""
	if ValueType == "Bool" then
		ValueTypeInstance = "Bool"
		else if ValueType == "Int" then
			ValueTypeInstance = "Int"
			else if ValueType == "Float" or ValueType == "Number" then
				ValueTypeInstance = "Number"
				else if ValueType == "String" or ValueType == "Text" then
					ValueTypeInstance = "String"
					else if ValueType == "Color" or ValueType == "Color3" then
						ValueTypeInstance = "Color3"
						else if ValueType == "BrickColor" then
							ValueTypeInstance = "BrickColor"
							else if ValueType == "CFrame" then
								ValueTypeInstance = "CFrame"
								else if ValueType == "Object" or ValueType == "Obj" then
									ValueTypeInstance = "Ovject"
									else if ValueType == "Ray" then
										ValueTypeInstance = "Ray"
										else if ValueType == "Vector3" or ValueType == "Vector2" then
											ValueTypeInstance = "Vector3"
										end end end end end end end end end end
											local ValueObject = Instance.new(ValueTypeInstance.."Value")
											ValueObject.Name = ValueName
											ValueObject.Value = Value
											ValueObject.Parent = ValueHolderFinal
										end 

--[======================== (Получение параметров игрока) ==========================]
local Path = script.Parent
local function GetValue(name)
	return Path.Value_Folder:WaitForChild(name).Value
end
local function SetValue(name,value)
	Path.Value_Folder:WaitForChild(name).Value = value
end
--[======================== (Статичные параметры игрока) ==========================]


--[======================== (Параметры игрока) ==========================]
CreateValue("Bool","Player_In_First_Person",false)--Игрок находится в первом лице?
CreateValue("Bool","Player_Sit",false)--Игрок сидит?
CreateValue("Bool","Player_Driver_Car",false)--Игрок сидит в автомобиле?

--[======================== (Update) ==========================]
while true do
	wait()
	
	SetValue("Player_Sit",Humanoid.Sit)
	if Humanoid.SeatPart then
		SetValue("Player_Driver_Car",Humanoid.SeatPart:IsA("VehicleSeat"))
	else
		SetValue("Player_Driver_Car",false)
	end
end