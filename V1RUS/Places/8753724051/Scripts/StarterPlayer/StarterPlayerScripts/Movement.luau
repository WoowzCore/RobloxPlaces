--[[========================================================]]
local function GetValue(name)
	local value = game.Scene.Main.GlobalValues:WaitForChild(name)
	return value.Value
end
local function SetValue(name,val)
	local value = game.Scene.Main.GlobalValues:WaitForChild(name)
	value.Value = val
end
local function GetPlayerValue(name)
	local value = game:GetService("Players").LocalPlayer:WaitForChild("PlayerValues"):WaitForChild(name)
	return value.Value
end
local function SetPlayerValue(name,val)
	game.RStorage.SetPlayerValue:FireServer(name,val)
	wait()
end
--[[========================================================]]
local function InversePlayerValue(name)
	local value = game:GetService("Players").LocalPlayer:WaitForChild("PlayerValues"):WaitForChild(name)
	if value:IsA("BoolValue") then
		SetPlayerValue(name, not GetPlayerValue(name) )
	end
end

local function IfNumberMoreOtherNumber(number1,number2,mode)
	local m = 0
	if mode ~= nil then
		if mode == "<" then
			m = 1
		else if mode == "=" then
				m = 2
			end
		end
	end

	local result = false

	if m == 0 then
		if number1 > number2 then
			result = true
		else
			result = false
		end
	end
	if m == 1 then
		if number1 < number2 then
			result = true
		else
			result = false
		end
	end
	if m == 2 then
		if number1 == number2 then
			result = true
		else
			result = false
		end
	end

	return result
end

local function ActivateObject(obj)
	print("active local")
	game.RStorage.ActivateObject:FireServer(obj)
end

--[[========================================================]]
local KeyCode_MoveRightArm = Enum.UserInputType.MouseButton2
local KeyCode_OpenInventory = Enum.KeyCode.Tab
local KeyCode_PickUp = Enum.KeyCode.E
local KeyCode_Drop = Enum.KeyCode.Q
local KeyCode_ChangeArm = Enum.KeyCode.F
local KeyCode_DebugMode = Enum.KeyCode.KeypadOne
local KeyCode_ActiveObject = Enum.UserInputType.MouseButton1

local PickUpMaxDistance = 5
--[[========================================================]]
local RS = game.RStorage
local player = game:GetService("Players").LocalPlayer
local mouse = player:GetMouse()
local cam = game.Scene.CurrentCamera
local character = player.Character or player.CharacterAdded:Wait()
wait()
if character then
	print("Character Loaded in script {".. script.Name .."}")
	local humanoid = character:WaitForChild("Humanoid")
	
	local PickObjectsTimer = 100
	--[[========================================================]]
	
	game:GetService("UserInputService").InputBegan:Connect(function(input,InChat)
		local KC = input.KeyCode

		if input.UserInputType == KeyCode_MoveRightArm then
			InversePlayerValue("MovementArm")
		end
		
		if input.UserInputType == KeyCode_ActiveObject then
			print("active keycode")
			local obj = GetPlayerValue("ObjectInHand")
			if GetPlayerValue("NowMoveLeftArm") == true then
				obj = GetPlayerValue("ObjectInHand2")
			end
			ActivateObject(obj)
		end

		if KC == KeyCode_OpenInventory then
			InversePlayerValue("InventoryOpen")
		end
		
		if KC == KeyCode_ChangeArm then
			InversePlayerValue("NowMoveLeftArm")
		end
		
		if KC == KeyCode_DebugMode then
			RS.Switch_Debug_Mode:FireServer(not GetPlayerValue("ShowDebug"))
		end

		if KC == KeyCode_PickUp and GetPlayerValue("MovementArm") and (character:FindFirstChild("Torso").Position-GetPlayerValue("MousePosition")).Magnitude < 6 and PickObjectsTimer >=100 then
			local pickupobj = GetPlayerValue("CursorInPickableObject")
			if pickupobj then
				local Pickable = pickupobj:FindFirstChild("Pickable")
				if Pickable then
					if Pickable.Value == true then
						RS.PickUpObjectServer:FireServer(pickupobj)
						PickObjectsTimer = 0
					end
				end
			end
		end

		if KC == KeyCode_Drop then
			if GetPlayerValue("NowMoveLeftArm") then
				if GetPlayerValue("ObjectInHand2") then
					RS.SetObjectInArm:FireServer(nil)
				end
			else
				if GetPlayerValue("ObjectInHand") then
					RS.SetObjectInArm:FireServer(nil)
				end
			end
		end
	end)

	local function CheckObject(obj)
		local result = nil

		if obj.Name == "Object" and obj:IsA("Model") then
			result = obj
		end

		return result
	end

	local function GetObject(target)
		local result = nil
		if target then

			if CheckObject(target) ~= nil then
				result = CheckObject(target)
			else
				local parent = target.Parent
				if parent then

					if CheckObject(parent) ~= nil then
						result = CheckObject(parent)
					else
						local parent2 = parent.Parent
						if parent2 then

						end
					end

				end
			end

		end
		return result
	end

	local function GetMouseTarget()
		local MouseObject = mouse.Target
		SetPlayerValue("CursorInThis",MouseObject)
		SetPlayerValue("CursorInPickableObject",GetObject(MouseObject))
	end

	game:GetService("RunService").RenderStepped:Connect(function()
		if humanoid then
			GetMouseTarget()

			SetPlayerValue("PlayerMovement", IfNumberMoreOtherNumber(humanoid.MoveDirection.Magnitude,0) )
			if PickObjectsTimer < 100 then
				PickObjectsTimer = PickObjectsTimer + 1
			end

		end
	end)









end