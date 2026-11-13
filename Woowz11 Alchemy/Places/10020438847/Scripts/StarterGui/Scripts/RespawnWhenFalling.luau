local p = game.Players.LocalPlayer
local ch = nil
if not p.Character or not p.Character.Parent then
	ch = p.CharacterAdded:Wait()
else
	ch = p.Character
end

local Player = ch:WaitForChild("HumanoidRootPart")
local SpawnPoint = workspace.SpawnLocation

local MinYtoTeleport = -50

local function Teleport(y)
	
	if y <= MinYtoTeleport then
		ch:MoveTo(SpawnPoint.Position)
	end
	
end

while wait() do
	Teleport(Player.Position.Y)
end