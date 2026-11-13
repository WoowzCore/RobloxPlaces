local runService = game:GetService("RunService")

local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local humrootpart = chr:WaitForChild("HumanoidRootPart")
local hum = chr:WaitForChild("Humanoid")
local cam = workspace.Camera
local head = chr:WaitForChild("Head")
local u = game:GetService("UserInputService")

local keyboard = require(chr:WaitForChild("KeyBoard"))

local tiltSpeedZ = 0.1
local bobbingSpeed = 0.1
local walktilt = 0.5

local tilt = 0 
local sinValue = 0

local Crawl = false

local Zoom = false
local ZoomKey = Enum.KeyCode.F

function lerp(a, b, t)
	return a + (b - a) * t
end

local startfov = cam.FieldOfView

--==================================================

chr.Humanoid.CameraOffset = Vector3.new(0,0,-1)

for i, v in pairs(chr:GetChildren()) do
	if v:IsA("BasePart") and v.Name ~= "Head" then
		v.LocalTransparencyModifier = v.Transparency
		v:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
			v.LocalTransparencyModifier = v.Transparency
		end)
	end
end

--==================================================

local ignorelist = nil
local function UpdateIgnoreList()
	ignorelist = {}
	for _, player2 in pairs(game.Players:GetPlayers()) do
		for _2, part in pairs(player2.Character:GetDescendants()) do
			table.insert(ignorelist,part)
		end
	end
end
game:GetService("ReplicatedStorage").UpdateIgnoreListCamera.OnClientEvent:Connect(UpdateIgnoreList)

local fov = 0
local Turn = 0

local function ChangeMouseDeltaSensitivity()
	local mouseDeltaSensitivity = 0.35 / UserSettings():GetService("UserGameSettings").MouseSensitivity 
	game:GetService("UserInputService").MouseDeltaSensitivity = mouseDeltaSensitivity
end
ChangeMouseDeltaSensitivity()

UserSettings():GetService("UserGameSettings"):GetPropertyChangedSignal("MouseSensitivity"):Connect(ChangeMouseDeltaSensitivity)

runService.RenderStepped:Connect(function(dt)
	
	Zoom = keyboard.Keys[ZoomKey]
	
	--==================================================
	
	Crawl = script.Parent.Crawl.Value
	
	--==================================================
	
	local movementVector = cam.CFrame:vectorToObjectSpace(humrootpart.Velocity / math.max(hum.WalkSpeed, 0.01))
	local speedModifier = (hum.WalkSpeed / 16)
	tilt = math.clamp(lerp(tilt, movementVector.X * tiltSpeedZ, 0.1), -0.25, 0.1) 
	sinValue += bobbingSpeed * speedModifier
	local xangl = 0
	if not Zoom then
		xangl = math.sin((sinValue/2))/900
	end
	local MouseDelta = u:GetMouseDelta()
	Turn = lerp(Turn, math.clamp(MouseDelta.X, -6, 6), (6 * dt))
	cam.CFrame *= CFrame.Angles(xangl, 0,  -tilt + math.rad(Turn))
	
	--==================================================
	
	local ray = Ray.new(head.Position, head.CFrame.LookVector)
	if ignorelist == nil then
		ignorelist = chr:GetDescendants()
	end
	local hit, pos = game.Workspace:FindPartOnRayWithIgnoreList(ray,ignorelist)
	local x = (math.sin(sinValue)*(humrootpart.AssemblyLinearVelocity.Magnitude/13))/(10*walktilt)
	local y = 0
	local z = -1
	if Crawl then
		y = -3.2
		z = -2
	end
	local CT = tick()
	local h = chr:WaitForChild("Humanoid")
	
	local fovwall = (head.Position - pos).magnitude
	local cameraoffset = Vector3.new(x,y,z * fovwall)
	
	if h.MoveDirection.Magnitude > 0 then
		local BobbleX = math.cos(CT*5)*0.25
		local BobbleY = math.abs(math.sin(CT*5))*0.25
		local Bobble = Vector3.new(cameraoffset.X + (BobbleX * (humrootpart.AssemblyLinearVelocity.Magnitude/13)),cameraoffset.Y + (BobbleY * (humrootpart.AssemblyLinearVelocity.Magnitude/13)),cameraoffset.Z)
		h.CameraOffset = Bobble
	else
		h.CameraOffset = cameraoffset
	end
	
	local spedfov = 0.5
	if humrootpart.AssemblyLinearVelocity.Magnitude > 13 then
		fov = math.min(fov+spedfov,30)
	else
		fov = math.max(0,fov-spedfov)
	end
	
	local zoomfov = 1
	if Zoom then
		zoomfov = 3
	end
	
	cam.FieldOfView = (startfov + fov) / zoomfov
end)