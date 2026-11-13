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
local CameraOffSet = Vector3.new(0,0,-1)
local CameraFOVOffSet = 90
local CameraBobbingPower = 0.5
local CameraMovingXlimit = Vector2.new(-65,90)
--[[========================================================]]
local player = game:GetService("Players").LocalPlayer
local cam = game.Scene.CurrentCamera
local character = player.Character or player.CharacterAdded:Wait()
if character then
	print("Character Loaded in script {".. script.Name .."}")
	local humanoid = character:WaitForChild("Humanoid")
	local GUIorig = script.Parent.Parent
	local GUI = GUIorig.Screen

	local CameraMovingVector = Vector3.zero
	local Head = character:WaitForChild("Head")
	--[[========================================================]]


	cam.FieldOfView = CameraFOVOffSet

	local freecam = GUIorig:FindFirstChild("Freecam")
	if freecam then
		freecam:Destroy()
	end

	local function SetCameraFrezze(bool)
		SetPlayerValue("CameraFrezze",bool)
		game:GetService("UserInputService").MouseIconEnabled = bool
		GUI.UnLockMouse.Visible = bool
	end

	local function CameraBobbing()
		if GetPlayerValue("PlayerMovement") then
			local BobbleX = math.cos(tick() * 10) * CameraBobbingPower
			local BobbleY = math.abs(math.sin(tick() * 10)) * CameraBobbingPower
			CameraMovingVector = CameraOffSet + Vector3.new(BobbleX,BobbleY,0)
		else
			CameraMovingVector = CameraOffSet
		end
	end

	local function MousePosition_Hit()
		local filter = RaycastParams.new()

		local filtertabl = {}
		table.insert(filtertabl,character:WaitForChild("Right Arm"))
		table.insert(filtertabl,character:WaitForChild("Head"))
		local objinhand = GetPlayerValue("ObjectInHand")
		local objinhand2 = GetPlayerValue("ObjectInHand2")
		if objinhand then
			table.insert(filtertabl,objinhand)
		end
		if objinhand2 then
			table.insert(filtertabl,objinhand2)
		end

		for _,plr in pairs(game:GetService("Players"):GetPlayers()) do
			if plr.UserId ~= player.UserId then
				local ch = plr.Character or plr.CharacterAdded:Wait()
				if ch then
					for _,parts in pairs(ch:GetChildren()) do
						table.insert(filtertabl,parts)
					end
				end
			end
		end

		filter.FilterDescendantsInstances = filtertabl
		filter.FilterType = Enum.RaycastFilterType.Blacklist

		local ray = cam:ScreenPointToRay(player:GetMouse().X,player:GetMouse().Y)
		local hit = game.Scene:Raycast(ray.Origin,ray.Direction*500,filter)

		if hit then
			SetPlayerValue("MousePosition",hit.Position) 
		end
	end

	local function MousePosition()
		MousePosition_Hit()
		local filter = RaycastParams.new()
		
		local ObjectInHand = nil
		
		local filtertabl = {}
		for _,part in pairs(character:GetChildren()) do
			if part.Name ~= "Head" then
				if GetPlayerValue("NowMoveLeftArm") then
					if part.Name ~= "Left Arm" then
						table.insert(filtertabl,part)
						local objinhand = GetPlayerValue("ObjectInHand")
						ObjectInHand = GetPlayerValue("ObjectInHand2")
						if objinhand then
							table.insert(filtertabl,objinhand)
						end
					end
				else
					if part.Name ~= "Right Arm" then
						table.insert(filtertabl,part)
						local objinhand = GetPlayerValue("ObjectInHand2")
						ObjectInHand = GetPlayerValue("ObjectInHand")
						if objinhand then
							table.insert(filtertabl,objinhand)
						end
					end
				end
			end
		end

		filter.FilterDescendantsInstances = filtertabl
		filter.FilterType = Enum.RaycastFilterType.Whitelist
		
		
		local ray = cam:ScreenPointToRay(player:GetMouse().X,player:GetMouse().Y,100)
		local rayhit = cam:ScreenPointToRay(player:GetMouse().X,player:GetMouse().Y)
		local hit = game.Scene:Raycast(rayhit.Origin,rayhit.Direction*5000000,filter)
		
		local getray = ray
		
		--[[if ObjectInHand then
			local HandLookPosition = ObjectInHand:FindFirstChild("HandLookPosition")
			if HandLookPosition then
				local pos1 = HandLookPosition.Position
				local mousepos = (ray.Origin + (ray.Direction.Magnitude * ray.Direction.Unit))
				local pos2 = (mousepos-pos1).Unit * (pos1-mousepos).Magnitude
				game.Scene.Part.Position = pos1
				game.Scene.Part2.Position = pos2
				local raynew = Ray.new(pos1,pos2)
				getray = raynew
			end
		end]]
		

		if hit then
			SetPlayerValue("MousePositionArm",hit.Position)
		else
			SetPlayerValue("MousePositionArm",getray.Origin + (getray.Direction.Magnitude * getray.Direction.Unit))
		end
	end
	
	local function CameraRotationLimit()
		local x,y,z = cam.CFrame:ToOrientation()
		local val = math.clamp(math.deg(x),CameraMovingXlimit.X,CameraMovingXlimit.Y)
		cam.CFrame = CFrame.new(cam.CFrame.Position) * CFrame.fromOrientation(math.rad(val),math.rad(math.deg(y)),math.rad(math.deg(z)))
	end

	game:GetService("RunService").RenderStepped:Connect(function()
		if humanoid then
			CameraRotationLimit()
			
			MousePosition()

			CameraBobbing()

			humanoid.CameraOffset = CameraOffSet:Lerp(CameraMovingVector,0.25)

			SetCameraFrezze(GetPlayerValue("MovementArm"))
		end
	end)








end