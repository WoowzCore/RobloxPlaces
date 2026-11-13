local player = script.Parent.Parent.Parent

local c = player.Character
if not c or not c.Parent then
	c = player.CharacterAdded:Wait()
end

local hum = c:FindFirstChild("Humanoid")

local function LoadValue(name)
	local v = player.PlayerStarter.Values
	return v:FindFirstChild(name).Value
end

local function SetValue(name,value)
	local v = player.PlayerStarter.Values
	local v2 = v:FindFirstChild(name)
	v2.Value = value
end

local function LoadScript(name)
	local v = player.PlayerStarter.Values.Scripts
	local v2 = v:FindFirstChild(name)
	return v2.Value
end

local shiftpress = false
local speedboost = 0
local normalspeed = 0

local deadStamina = false

local fly = false

local flyUp = false
local flyDown = false

local function MakeNilGravityOne(part)
	local force = Instance.new("BodyForce",part)
	force.Name = "Fly"
	force.Force = Vector3.new(0,part:GetMass()*game.workspace.Gravity,0)
end


local function MakeNilGravity()
	MakeNilGravityOne(c.Head)
	MakeNilGravityOne(c.HumanoidRootPart)
	MakeNilGravityOne(c.Torso)
	MakeNilGravityOne(c["Left Arm"])
	MakeNilGravityOne(c["Right Arm"])
	MakeNilGravityOne(c["Left Leg"])
	MakeNilGravityOne(c["Right Leg"])
end

local function ReturnGravity(part)
	if part:WaitForChild("Fly") then
		part:WaitForChild("Fly"):Destroy()
	end
end

local function ReturnGravityAll()
	ReturnGravity(c.Head)
	ReturnGravity(c.HumanoidRootPart)
	ReturnGravity(c.Torso)
	ReturnGravity(c["Left Arm"])
	ReturnGravity(c["Right Arm"])
	ReturnGravity(c["Left Leg"])
	ReturnGravity(c["Right Leg"])
end

game:GetService("UserInputService").InputBegan:Connect(function(input,gameProcessedEvent)

	if input.KeyCode == Enum.KeyCode.LeftShift and LoadScript("HaveRun") then
		shiftpress = true
	end

	if input.KeyCode == Enum.KeyCode.V then
		if fly then
			fly = false
			ReturnGravityAll()

		else if not fly and LoadScript("CanFly") then
				fly = true
				MakeNilGravity()
			end
		end

	end

	if LoadValue("CanMoreFly")  then
		if input.KeyCode == Enum.KeyCode.LeftControl then
			flyDown = true
		end
		if input.KeyCode == Enum.KeyCode.Space then
			flyUp = true
		end
	end

end)

game:GetService("UserInputService").InputEnded:Connect(function(input,gameProcessedEvent)

	if input.KeyCode == Enum.KeyCode.LeftShift then
		shiftpress = false
		c.Humanoid.WalkSpeed = normalspeed
	end

	if input.KeyCode == Enum.KeyCode.LeftControl then
		flyDown = false
	end
	if input.KeyCode == Enum.KeyCode.Space then
		flyUp = false
	end

end)


while true do
	wait()
	
	
	if LoadValue("Stamina") <= 0 then
		deadStamina = true
	else
		--wait(5)
		deadStamina = false
	end
	if not fly and not shiftpress then
		if LoadValue("Stamina") < LoadValue("MaxStamina") then
			if LoadValue("PlayerPlaying") then
				SetValue("Stamina",LoadValue("Stamina")+0.25)
			else
				SetValue("Stamina",LoadValue("MaxStamina"))
			end
		end
	end
	
	if deadStamina then
		ReturnGravityAll()
		fly = false
		shiftpress = false
	end
	
	if fly and not LoadScript("CanFly") then
		ReturnGravityAll()
		fly = false
	end
	if fly and not deadStamina and LoadValue("PlayerPlaying") then
		
		SetValue("Stamina",LoadValue("Stamina")-0.5)
		if not LoadValue("CanMoreFly") then
			c.HumanoidRootPart.Velocity = Vector3.new(c.HumanoidRootPart.Velocity.x,0,c.HumanoidRootPart.Velocity.z)
		else
			if flyUp and not flyDown then
				c.HumanoidRootPart.Velocity = Vector3.new(c.HumanoidRootPart.Velocity.x,10,c.HumanoidRootPart.Velocity.z)
			end
			if not flyUp and flyDown then
				c.HumanoidRootPart.Velocity = Vector3.new(c.HumanoidRootPart.Velocity.x,-10,c.HumanoidRootPart.Velocity.z)
			end

			if not flyUp and not flyDown then
				c.HumanoidRootPart.Velocity = Vector3.new(c.HumanoidRootPart.Velocity.x,0,c.HumanoidRootPart.Velocity.z)
			end
		end

	end
	if shiftpress and not deadStamina and LoadValue("PlayerPlaying") then
		
		SetValue("Stamina",LoadValue("Stamina")-0.5)
		c.Humanoid.WalkSpeed = normalspeed * LoadValue("ShiftSpeedBoost")
	else

		normalspeed = c.Humanoid.WalkSpeed

	end
	if LoadValue("Stamina") < LoadValue("MaxStamina") then
		print("Stamina : "..LoadValue("Stamina"))
	end
end