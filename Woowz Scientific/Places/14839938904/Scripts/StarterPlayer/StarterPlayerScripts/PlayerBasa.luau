local RS = game:GetService("ReplicatedStorage")
local kb = require(script.Parent:WaitForChild("Keyboard"))

local basa = {}
basa.Loaded = false
------------------------------------

function basa.SetCharacterSettings(char)
	basa.Character = char
	basa.Humanoid = basa.Character:WaitForChild("Humanoid")
	basa.RootPart = basa.Character:WaitForChild("HumanoidRootPart")
	basa.Head = basa.Character:WaitForChild("Head")
	basa.Torso = basa.Character:WaitForChild("Torso")
	basa.Neck = basa.Torso:WaitForChild("Neck")
	basa.Neck.MaxVelocity = 1/3
	basa.NeckOffset = basa.Neck.C0
	kb.ClearKeysPressed()
	local function SetCharacter()
		
		for _, part in pairs(basa.Character:GetChildren()) do
			if part:IsA("BasePart") and part.Name~="Head" then
				part:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
					part.LocalTransparencyModifier = part.Transparency
				end)

				part.LocalTransparencyModifier = part.Transparency
			end
		end
		
		for _, part in pairs(basa.Character:GetDescendants()) do
			if part:IsA("BasePart") or part:IsA("Part") or part:IsA("MeshPart") then
				part.CastShadow = false
			end
		end
		
	end
	SetCharacter()
end

basa.CameraDirection = nil
function basa.SetOtherCharacterSettings(otherbasa,otherplr)
	local function RotateHead()
		if otherbasa.CameraDirection == nil then return end
		local otherchar = otherplr.Character or otherplr.CharacterAdded:wait()
		if otherchar:WaitForChild("Torso"):WaitForChild("Neck") then
			otherchar:WaitForChild("Torso"):WaitForChild("Neck").C0 = otherbasa.CameraDirection
		end
	end
	RotateHead()
end

basa.Player = game.Players.LocalPlayer
basa.Character = nil
basa.Humanoid = nil
basa.RootPart = nil
basa.Head = nil
basa.Torso = nil
basa.Neck = nil
basa.NeckOffset = 0
basa.Camera = game.Workspace.CurrentCamera
basa.CameraShake = Vector3.zero

basa.Mouse = basa.Player:GetMouse()

basa.StatRun = false
basa.StatSneak = false
basa.StatCrawl = false

basa.JumpPower = 50

basa.SpeedDefault = 13
basa.SpeedRun = 25
basa.SpeedCrawl = 6

basa.PlayerStat = {}
basa.PlayerStat.Velocity = 0
basa.PlayerStat.MovingVelocity = 0
basa.PlayerStat.Moving = false
basa.PlayerStat.Walking = false
basa.PlayerStat.FirstPerson = false
basa.PlayerStat.FirstPersonNotFull = false

basa.Objects = {}
basa.Objects.Bottom = nil
basa.Objects.BottomRaycast = nil

RS.GetPlayerData.OnClientInvoke = function()
	return basa
end

RS.SetPlayerData.OnClientEvent:Connect(basa.SetOtherCharacterSettings)

return basa

