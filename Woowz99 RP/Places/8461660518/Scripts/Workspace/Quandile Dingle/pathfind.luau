local PFS = game:GetService("PathfindingService")
local debris = game:GetService("Debris")
local RunService = game:GetService("RunService")

local NPC = script.Parent
local h = NPC.Humanoid
local folder = NPC.Waypoints

local function findAndGoTo(destination)
	local path = PFS:FindPathAsync(NPC.HumanoidRootPart.Position, destination.Position)
	if path.Status == Enum.PathStatus.Success then
		folder:ClearAllChildren()
		for i,v  in ipairs(path:GetWaypoints()) do
			local part = Instance.new("Part", folder)
			part.Name = "Waypoint_" .. i
			part.Size = Vector3.new(1,1,1)
			part.Position = v.Position
			part.Anchored = true
			part.BrickColor = BrickColor.new("Really red")
			part.Material = Enum.Material.Neon
			part.CanCollide = false
			part.Transparency = 1
		end
		for i,v  in ipairs(path:GetWaypoints()) do
			h:MoveTo(v.Position)
			h.MoveToFinished:Wait()
			if v.Action == Enum.PathWaypointAction.Jump then
				h.JumpPower = 100 + math.abs(destination.Position.Y - NPC.HumanoidRootPart.Position.Y)
				h.Jump = true
			end
		end
	else
		h:MoveTo(destination.Position)
		if destination.Position.Y - NPC.HumanoidRootPart.Position.Y then
			if math.sqrt(math.pow((destination.Position.X-NPC.HumanoidRootPart.Position.X), 2) + math.pow((destination.Position.Z-NPC.HumanoidRootPart.Position.Z), 2)) <= 100 then
				h.JumpPower = 100 + math.abs(destination.Position.Y - NPC.HumanoidRootPart.Position.Y)
				h.Jump = true
			end
		end
	end
end



local function getNearest()
	local nearestChar, nearestDist = nil, nil
	for i, player in pairs(workspace:GetChildren()) do
		if player:FindFirstChild("Humanoid") and player ~= script.Parent and not player:FindFirstChild("NPC") then
			if player.Humanoid.Health ~= 0 then
				local distance = 0
				local thisPath = PFS:FindPathAsync(NPC.HumanoidRootPart.Position, player.HumanoidRootPart.Position)
				local prevPos
				if thisPath.Status == Enum.PathStatus.Success then
					for i,v  in ipairs(thisPath:GetWaypoints()) do
						if i ~= 1 then
							distance = distance + (prevPos - v.Position).magnitude
						end
						prevPos = v.Position
					end
				else
					distance = (NPC.HumanoidRootPart.Position - player.HumanoidRootPart.Position).magnitude
				end
				if nearestDist == nil then
					nearestChar = player
					nearestDist = distance
				else
					if distance < nearestDist then
						nearestChar = player
						nearestDist = distance

					end
				end
				if distance <= 4.5 then
					if not nearestChar.HumanoidRootPart:FindFirstChild("BodyVelocity") then
						local bv1 = Instance.new("BodyForce", nearestChar.HumanoidRootPart)
						bv1.Force = (nearestChar.HumanoidRootPart.Position - NPC.HumanoidRootPart.Position).Unit * 20000 + Vector3.new(0, 5000, 0)
					end
					
					nearestChar.Humanoid.Health = 0
					
					--Use this is you have Ragdoll after death installed (you'll have to change some things in code here)
					local ragdoll = workspace:WaitForChild(nearestChar.Name .. "-2")
					if not ragdoll.HumanoidRootPart:FindFirstChild("BodyVelocity") then
						local bv2 = Instance.new("BodyForce", ragdoll:FindFirstChild("HumanoidRootPart"))
						bv2.Force = (ragdoll.HumanoidRootPart.Position - NPC.HumanoidRootPart.Position).Unit * 20000 + Vector3.new(0, 5000, 0)
						debris:AddItem(bv2, 1)
					end
				end
			end
		end
	end
	return nearestChar
end

local count = 0

RunService.Heartbeat:Connect(function()
	h.Health = h.MaxHealth
	local nearestChar = getNearest()
	if nearestChar ~= nil then
		if nearestChar:FindFirstChild("HumanoidRootPart") then
			local ray = Ray.new(NPC.HumanoidRootPart.Position, (nearestChar.HumanoidRootPart.Position - NPC.HumanoidRootPart.Position).Unit * 1000000000)
			local hit,position = workspace:FindPartOnRayWithIgnoreList(ray,{script.Parent})
			if hit then
				if hit:IsDescendantOf(nearestChar) then
					h:MoveTo(nearestChar.HumanoidRootPart.Position)
				else
					if count >= 100 then
						count = 0
						findAndGoTo(nearestChar.HumanoidRootPart)
					else
						count = count + 1
					end
				end
			end
		end
	end
end)