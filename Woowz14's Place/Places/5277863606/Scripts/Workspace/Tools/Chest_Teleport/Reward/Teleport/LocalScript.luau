local tool = script.Parent
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local function onActivate()
	local character = tool.Parent
	local hit = mouse.Hit
	
	local ray = Ray.new(mouse.UnitRay.Origin, mouse.UnitRay.Direction * 500)
	local part, point, normal = game.Workspace:FindPartOnRay(ray, character)

	local toCharacter = character.HumanoidRootPart.Position - point
	if toCharacter.magnitude <= 5 then
		return
	end

	local collisionSphere = Instance.new("Part", game.Workspace)
	collisionSphere.Shape = Enum.PartType.Ball
	collisionSphere.Size = Vector3.new(4, 4, 4)
	collisionSphere.Anchored = true	
	
	collisionSphere.CFrame = CFrame.new(point + normal * 2.5)
	
	
	local foundSpace = false
	local tries = 0
	repeat
		tries = tries + 1
		
		local parts = collisionSphere:GetTouchingParts()
		
		if #parts == 0 then
			foundSpace = true
		else
			collisionSphere.CFrame = collisionSphere.CFrame + toCharacter.unit * 4
			-- make sure sphere isn't further than the character
			local sphereToPoint = point - collisionSphere.Position
			if sphereToPoint.magnitude >= toCharacter.magnitude then
				tries = 5
				foundSpace = false
			end
		end
	until foundSpace or tries > 5
	
	if foundSpace then
		local toSphere = collisionSphere.Position - character.HumanoidRootPart.Position
		script.Parent.TeleportEvent:FireServer(toSphere)
	end
	collisionSphere:Destroy()
end

tool.Activated:connect(onActivate)