local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
local ScreenGui = PlayerGui:WaitForChild("ScreenGui")
local NotScreenGui = PlayerGui:WaitForChild("NotScreenGui")
local MainScreenGui = PlayerGui:WaitForChild("MainScreenGui")
local button = MainScreenGui.ChangeScreen

local InMobile = script.Parent.Values.Player_in_Phone.Value

local Graphics = game:GetService("Lighting")

local function SetDefaultHumanoid(char,hum)
	for i,v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") or v:IsA("Decal") then 
			v.Transparency = 1 
		end
	end
	hum.MaxSlopeAngle = 90
end

local function SetPlayerCharacterType(bool)
	local player = nil
	if not game:GetService('Players').LocalPlayer.Character or not game:GetService('Players').LocalPlayer.Character.Parent then
		player = game:GetService('Players').LocalPlayer.CharacterAdded:Wait()
	else
		player = game:GetService('Players').LocalPlayer.Character
	end
	if player ~= nil then
		local hum = player:WaitForChild("Humanoid")
		SetDefaultHumanoid(player,hum)

		if not bool then
			hum.WalkSpeed = 20
			hum.JumpPower = 20
			hum.JumpHeight = 5
		else
			hum.WalkSpeed = 0
			hum.JumpPower = 0
			hum.JumpHeight = 0
		end
		
		if InMobile then
			Graphics.BlurWhenPlaying.Enabled = false
			ScreenGui.Background.BackgroundTransparency = 0
			MainScreenGui.ChangeScreen.Visible = false
		else
			Graphics.BlurWhenPlaying.Enabled = bool
		end
	else
		error("ERROR")
	end
end

local ChangeScreenBool = true

local function UpdateScreenGui()
	ScreenGui.Enabled = ChangeScreenBool
	NotScreenGui.Enabled = not ChangeScreenBool	
	SetPlayerCharacterType(ChangeScreenBool)
end
UpdateScreenGui()

local function ChangeScreenGui()
	ChangeScreenBool = not ChangeScreenBool
	UpdateScreenGui()
end

button.MouseButton1Click:Connect(ChangeScreenGui)