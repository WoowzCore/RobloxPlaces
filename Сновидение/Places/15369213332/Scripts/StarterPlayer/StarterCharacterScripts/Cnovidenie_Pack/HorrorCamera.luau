local base = require(script.Parent:WaitForChild("PlayerBase"))
repeat wait() until base.Character ~= nil
local runService = game:GetService("RunService")
local u = game:GetService("UserInputService")
local players = game:GetService("Players")
local light = game:GetService("Lighting")
local ts = game:GetService("TweenService")

local function GetBlur()
	if light:FindFirstChild("Camera_Blur") then
		return light:FindFirstChild("Camera_Blur")
	else
		local blur = Instance.new("BlurEffect",light)
		blur.Name = "Camera_Blur"
		blur.Size = 0
		return blur
	end
end

CanToggleMouse = {allowed = true}
Sensitivity = 0.6		
Smoothness = 0.05		
FieldOfView = 90		

local cam = game.Workspace.CurrentCamera
local player = players.LocalPlayer


local character = player.Character or player.CharacterAdded:wait()
local humanoidpart = character.HumanoidRootPart
local hum = character:WaitForChild("Humanoid")

local head = character:WaitForChild("Head")
local CamPos,TargetCamPos = cam.CoordinateFrame.p,cam.CoordinateFrame.p 
local AngleX,TargetAngleX = 0,0
local AngleY,TargetAngleY = 0,0

local running = true
local freemouse = false

u.InputChanged:connect(function(inputObject)
	if inputObject.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = Vector2.new(inputObject.Delta.x/Sensitivity,inputObject.Delta.y/Sensitivity) * Smoothness

		local X = TargetAngleX - delta.y 
		TargetAngleX = (X >= 80 and 80) or (X <= -80 and -80) or X 
		TargetAngleY = (TargetAngleY - delta.x) %360 
	end	
end)

u.InputBegan:connect(function(inputObject)
	if inputObject.UserInputType == Enum.UserInputType.MouseButton3 or inputObject.KeyCode == Enum.KeyCode.Tab or inputObject.KeyCode == Enum.KeyCode.Q then
		if CanToggleMouse.allowed and freemouse == false then
			freemouse = true
		else
			freemouse = false
		end
	end
end)

local Lerp = function(a, b, t)
	return a + (b - a) * t
end

local Turn = 0

local counter, dampener = 1, 5
local prevLookVector = cam.CFrame.LookVector
local allowedRange, maxBlur = 10, 100
local ti = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut) 

local playing, completed = Enum.PlaybackState.Playing, Enum.PlaybackState.Completed
local style, dir = Enum.EasingStyle.Sine, Enum.EasingDirection.InOut
local sin = script:WaitForChild("Sine")
local isSprinting = base.Running
local dur, durSprint = 0.675, 0.5
local ti, tiSprint = TweenInfo.new(dur, style, dir, 0, true), TweenInfo.new(durSprint, style, dir, 0, true)
local oneTween, oneSprintTween = ts:Create(sin, ti, {Value = 1}), ts:Create(sin, tiSprint, {Value = 1})
local offset, maxRandomBounds = 0.25, 0.5
local point0, point2 = Vector3.new(offset, 0, 0), Vector3.new(-offset, 0, 0) 
local point1 = Vector3.new(0, -offset, 0)
local ti2 = TweenInfo.new(dur / 2, style, dir)
local tweenBack = ts:Create(hum, ti2, {CameraOffset = Vector3.new(0, 0, 0)})
local begTween = ts:Create(hum, ti2, {CameraOffset = point0}) 
local counter, counterInc = 1, 0.1
local running2 = false

runService.RenderStepped:connect(function(dt)
	 
	if running then
		CamPos = CamPos + (TargetCamPos - CamPos) * 0.28 
		AngleX = AngleX + (TargetAngleX - AngleX) * 0.35 
		local dist = TargetAngleY - AngleY 
		dist = math.abs(dist) > 180 and dist - (dist / math.abs(dist)) * 360 or dist 
		AngleY = (AngleY + dist *0.35) %360
		cam.CameraType = Enum.CameraType.Scriptable
		
		local MouseDelta = u:GetMouseDelta()
		Turn = Lerp(Turn, math.clamp(MouseDelta.X, -6, 6), (5 * dt))
		
		local middle = 2
		cam.CFrame = CFrame.new(Vector3.new((head.Position.X+humanoidpart.Position.X)/middle,head.Position.Y,(head.Position.Z+humanoidpart.Position.Z)/middle)) 
		* CFrame.Angles(0,math.rad(AngleY),0) 
		* CFrame.Angles(math.rad(AngleX),0,0)
		* CFrame.new(0,0.5,0) 
		* CFrame.Angles(0, 0, math.rad(Turn))
		* CFrame.new(hum.CameraOffset)
		
		humanoidpart.CFrame=CFrame.new(humanoidpart.Position)*CFrame.Angles(0,math.rad(AngleY),0)
		else game:GetService("UserInputService").MouseBehavior = Enum.MouseBehavior.Default
	end

	if (cam.Focus.p-cam.CFrame.p).magnitude < 1 then
		running = false
	else
		running = true
		if freemouse == true then
			u.MouseIconEnabled = true
			u.MouseBehavior = Enum.MouseBehavior.Default
		else
			u.MouseIconEnabled = false
			u.MouseBehavior = Enum.MouseBehavior.LockCenter
		end
	end
	
	if not CanToggleMouse.allowed then
		freemouse = false
	end
	
	cam.FieldOfView = FieldOfView

	----------------------------------------------
	
	if counter % dampener == 0 then
		
		local function degreesToDot() return math.cos(math.rad(allowedRange)) end
		
		local dot = prevLookVector:Dot(cam.CFrame.LookVector)

		if dot >= degreesToDot() then

			ts:Create(GetBlur(), ti, {Size = 0}):Play() 

		elseif dot < degreesToDot() then

			local equation = (1 - dot) * (maxBlur)
			ts:Create(GetBlur(), ti, {Size = equation}):Play()

		end

	end

	prevLookVector = cam.CFrame.LookVector
	counter = counter + 1

	----------------------------------------------
	
	if hum.MoveDirection:Dot(hum.MoveDirection) > 0 then

		local function curve(t, p0, p1, p2)

			if t == 0 then return p0 elseif t == 1 then return p2 end

			return (((1 - t)^2) * p0) + (2 * (1 - t) * t * p1) + (t^2 * p2)
		end

		local function sprint()

			if oneTween.PlaybackState ~= playing and isSprinting == false then 

				oneTween:Play()

			end

			if oneSprintTween.PlaybackState ~= playing and isSprinting == true then

				oneSprintTween:Play()

			end

		end

		if (not running2) then begTween:Play() running2 = true end

		if begTween.PlaybackState == completed then 

			if sin.Value == 0 then 

				counter = counter + counterInc

				point1 = Vector3.new(math.clamp(math.noise(counter), -maxRandomBounds, maxRandomBounds), -offset, 0)

				local coro = coroutine.wrap(sprint) 
				coro()

			end
				
			hum.CameraOffset = curve(sin.Value, point0, point1, point2)*2

		end

	else 

		tweenBack:Play() 
		oneTween:Cancel()
		oneSprintTween:Cancel()
		sin.Value = 0 
		running2 = false 

	end
	
end)
