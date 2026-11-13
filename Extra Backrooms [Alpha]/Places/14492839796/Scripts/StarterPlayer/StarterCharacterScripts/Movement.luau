local uis = game:GetService("UserInputService")
local plrdata = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerData)
local s = require(plrdata.Script)

wait(1)

uis.InputBegan:Connect(function(key, initerface)
	if not initerface then
		plrdata.Keys[key.KeyCode] = true
	end
end)

uis.InputEnded:Connect(function(key, initerface)
	if not initerface then
		plrdata.Keys[key.KeyCode] = false
	end
end)

function UpdateKeys()
	plrdata.WalkStatus.Slow = plrdata.Keys[Enum.KeyCode.LeftControl]
	plrdata.WalkStatus.Running = plrdata.Keys[Enum.KeyCode.LeftShift]
end

function UpdateWalkSpeed()
	local result = plrdata.WalkSpeedValues.Default

	if plrdata.WalkStatus.Slow then
		result = plrdata.WalkSpeedValues.Slow
	end

	if plrdata.WalkStatus.Running then
		result = plrdata.WalkSpeedValues.Run
	end

	plrdata.WalkSpeed = s.Lerp(plrdata.WalkSpeed,result,plrdata.LerpValues.WalkSpeed)
	plrdata.Humanoid.WalkSpeed = plrdata.WalkSpeed
end

local JumpTimerMax = 1.5
local JumpTimer = JumpTimerMax
function UpdateJumpPower(dt)
	local result = plrdata.JumpPowerValues.Default

	if not plrdata.HasFloor then
		result = 0
	end
	
	plrdata.JumpPower = result
	plrdata.Humanoid.JumpPower = plrdata.JumpPower
	
	if JumpTimer < JumpTimerMax and plrdata.HasFloor then
		JumpTimer += dt
	end
end

plrdata.Humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
	if plrdata.Humanoid.Jump then
		if JumpTimer >= JumpTimerMax then
			JumpTimer = 0
		else
			plrdata.Humanoid.Jump = false
		end
	end
end)

local createOnce = false
local vectorVel = nil
function FreeFalling()
	if not plrdata.HasFloor then
		if not createOnce then
			createOnce = true	

			vectorVel = Instance.new("BodyVelocity")
			vectorVel.Name = "FreeFallingVector"
			vectorVel.MaxForce = Vector3.new(10000,0,10000)
			vectorVel.P = 1000
			vectorVel.Parent = plrdata.Character.HumanoidRootPart
			vectorVel.Velocity = (plrdata.Humanoid.MoveDirection) * plrdata.Humanoid.WalkSpeed

			repeat
				for _, v in pairs(plrdata.Character:GetChildren()) do
					if v:IsA("BasePart") then
						if v.CanCollide and v.CanTouch then
							v.Touched:Connect(function(hit)
								if hit and hit.Parent ~= plrdata.Character or hit ~= plrdata.Character then	
									vectorVel.Velocity = -plrdata.Character.HumanoidRootPart.CFrame.LookVector * .7
								end	
							end)
						end
					end
				end
				task.wait()
			until plrdata.HasFloor
		end
	else
		if vectorVel then
			createOnce = false
			vectorVel:Destroy()
		end
	end
end

game:GetService("RunService").RenderStepped:Connect(function(dt)
	UpdateKeys()
	UpdateWalkSpeed()
	UpdateJumpPower(dt)
	plrdata.HasFloor = plrdata.Humanoid.FloorMaterial ~= Enum.Material.Air
	plrdata.Walk = plrdata.Humanoid.MoveDirection.Magnitude > 0
	plrdata.WalkBackward = math.round(plrdata.Character.HumanoidRootPart.CFrame.LookVector:Dot((plrdata.Character.HumanoidRootPart.Velocity * Vector3.new(1, 0, 1)).Unit)) < 0
	FreeFalling()
end)