local plr = game:GetService("Players").LocalPlayer
local p = require(script.Parent.PlayerModule)
local pd = require(script.Parent.PlayerData)
local rs = game:GetService("ReplicatedStorage")
local sg = game:GetService("StarterGui")

local m = {}

m.RagdollPlayer = function(bool)
	pd.Ragdoll = bool
end

m.GeneratePlayer = function()
	
	workspace.Camera.CameraSubject = workspace.Player.Eyes
	workspace.Camera.CFrame = workspace.Player.Eyes.CFrame
	workspace.Camera.FieldOfView = 90
	--workspace.Camera.CameraType = Enum.CameraType.Follow
	--plr.CameraMode = Enum.CameraMode.LockFirstPerson
	local gamegui = sg.GameScreen:Clone()
	gamegui.Enabled = true
	gamegui.Parent = plr.PlayerGui
	
	workspace.Player.Body.Touched:Connect(function(part)
		if part:IsA("BasePart") then
			if part.Anchored == false then
				if part.AssemblyLinearVelocity.Magnitude >= 50 then
					m.RagdollPlayer(true)
				end
			else
				if workspace.Player.Body.AssemblyLinearVelocity.Magnitude >= 50 then
					m.RagdollPlayer(true)
				end
			end
		end
	end)
	
	p.loaded = true
	
end

m.MovePlayerToSpawnPoint = function()
	workspace.Player:MoveTo(workspace.SpawnPoint.CFrame.Position)
end

m.UpdatePhyisc = function()
	rs.UpdatePhysic:FireServer()
end

m.StartGame = function()

	m.GeneratePlayer()
	m.MovePlayerToSpawnPoint()
	m.UpdatePhyisc()

end

return m
