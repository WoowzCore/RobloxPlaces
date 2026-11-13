repeat wait() until game.Players.LocalPlayer.Character

local Player = game.Players.LocalPlayer
local Char = Player.Character
local Humanoid = Char:WaitForChild("Humanoid")

local Cam = game.Workspace.CurrentCamera
local UIS = game:GetService("UserInputService")

local ignoreCode = script:WaitForChild("ignoreCode")
repeat wait() until ignoreCode.Value ~= 0
local ignoreModel = game.Workspace:WaitForChild("ignoreModel_"..ignoreCode.Value)
local gunIgnore = ignoreModel:FindFirstChild("gunIgnore_"..Player.Name)

Cam.FieldOfView = 70
Cam.CameraType = Enum.CameraType.Custom
Cam:ClearAllChildren()

UIS.MouseBehavior = Enum.MouseBehavior.Default
UIS.MouseIconEnabled = true

Player.CameraMode = Enum.CameraMode.Classic

Humanoid.WalkSpeed = 16
Humanoid.AutoRotate = true

if gunIgnore then gunIgnore:Destroy() end