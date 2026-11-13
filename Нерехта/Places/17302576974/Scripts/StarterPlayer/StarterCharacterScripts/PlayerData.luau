local PlayerService = game:GetService("Players")

local plrdata = {}

plrdata.PlayerLoaded = false
plrdata.Player = PlayerService.LocalPlayer
plrdata.Character = nil
plrdata.Humanoid = nil
plrdata.Keys = {}
plrdata.SlowWalk = false
plrdata.Running = false
plrdata.Crawl = false
plrdata.Laying = false
plrdata.ItemFromEyes = nil
plrdata.ItemParentFromEyes = nil
plrdata.PickedItem = nil
plrdata.PickedParentItem = nil
plrdata.RootPart = nil
plrdata.MouseWheel = 0
plrdata.UI = nil
plrdata.ItemSize = 0
plrdata.PlayerFolder = nil
plrdata.Backpack = nil
plrdata.ItemHoldDistance = Vector2.new(0.5,7)
plrdata.HoldDistance = plrdata.ItemHoldDistance.Y/2
plrdata.PickupPosition = Vector3.zero
plrdata.ItemMass = 0
plrdata.UnlockMouse = false
plrdata.RotationItem = CFrame.new(0,0,0)

plrdata.StartPlayerData = function(died) --[[Пофиксить потом что заместо true приходит игрок в died]]
	plrdata.Character = plrdata.Player.Character or plrdata.Player.CharacterAdded:Wait()
	plrdata.RootPart = plrdata.Character:WaitForChild("HumanoidRootPart")
	plrdata.Humanoid = plrdata.Character:WaitForChild("Humanoid")
	plrdata.UI = plrdata.Player:WaitForChild("PlayerGui")
	plrdata.PlayerFolder = workspace.PlayersInfo:WaitForChild(plrdata.Player.UserId)
	plrdata.Backpack = plrdata.PlayerFolder:WaitForChild("Backpack")
	
	script.LoadBrain:Fire()
	plrdata.PlayerLoaded = true
end

--[[ Позиция между двумя точками ]]
plrdata.GetDistance = function(point1, point2)
	local dx = point1.X - point2.X
	local dy = point1.Y - point2.Y
	local dz = point1.Z - point2.Z

	return math.sqrt(dx*dx + dy*dy + dz*dz)
end

return plrdata
