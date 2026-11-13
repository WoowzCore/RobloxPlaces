local keycode = Enum.KeyCode.Z
local MaxVelocity = 55
local RagdollRotate = 50

repeat wait() until script.Parent.Parent.Parent:IsA("Player")
repeat wait() until script.Parent.Parent.Parent.Character:FindFirstChild("Humanoid")

local player = game.Players.LocalPlayer
local character = player.Character
local humanoid = character:WaitForChild("Humanoid")

local variables = script.Parent:WaitForChild("variables")
local variables_ragdoll = variables:WaitForChild("ragdoll")
local variables_ragdollonclient = variables:WaitForChild("ragdollonclient")

local events = script.Parent:WaitForChild("events")
local events_variableserver = events:WaitForChild("variableserver")
local events_resetclient = events:WaitForChild("resetclient")

local functions = script.Parent:WaitForChild("functions")
local functions_remoteragdoll = functions:WaitForChild("remoteragdoll")
local functions_remoteragdollvelocity = functions:WaitForChild("remoteragdollvelocity")

local function GetValue(name)
	return script.Parent.Parent:WaitForChild("Value_Folder"):WaitForChild(name).Value
end
local function SetValue(name,value)
	script.Parent.Parent:WaitForChild("Value_Folder"):WaitForChild(name).Value = value
end

function killRagdoll(inst)
	if string.match(inst.Name,"'s Ragdoll") then
		local hum = inst:WaitForChild("Humanoid")
		hum.Health = 1
		hum.Health = 0
	end
end

for _,v in pairs(workspace:GetChildren()) do
	killRagdoll(v)
end

workspace.ChildAdded:Connect(function(child)
	killRagdoll(child)
end)

function functions_remoteragdoll.OnClientInvoke(mode,velocity)
	if mode then
		humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		humanoid.AutoRotate = false
		pcall(function() character.Animate.Disabled = true end)
		for _,v in pairs(humanoid:GetPlayingAnimationTracks()) do --use this to prevent certain animations from stopping, anim names don't replicate through FE.
			if v.Name ~= "DummyAnim" and v.Animation.AnimationId ~= "rbxassetid://0" then
				v:Stop(0)
			end
		end
		if velocity then
			character.HumanoidRootPart.Velocity = velocity
		end
		variables_ragdollonclient.Value = true
	else
		humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		humanoid.AutoRotate = true
		pcall(function() character.Animate.Disabled = false end)
		variables_ragdollonclient.Value = false
		for _,v in pairs(character:GetChildren()) do
			if v:IsA("BasePart") then
				v.Velocity = Vector3.new(0,0,0)
				v.RotVelocity = Vector3.new(0,0,0)
			end
		end
	end
end


function functions_remoteragdollvelocity.OnClientInvoke(velocity)
	character.HumanoidRootPart.Velocity = velocity
end

local KeyCodeRagdollRotatePressW = false
local KeyCodeRagdollRotatePressS = false
local KeyCodeRagdollRotatePressA = false
local KeyCodeRagdollRotatePressD = false

local arms = {
	left = character.LeftLowerArm;
	right = character.RightLowerArm;
	left2 = character.LeftUpperArm;
	right2 = character.RightUpperArm;
}

game:GetService("UserInputService").InputBegan:Connect(function(input,gameProcessedEvent)
	if humanoid.Health > 0  then
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if variables_ragdoll.Value == true then
				print(player:GetMouse().UnitRay.Direction.magnitude)
				end
		end

	if input.UserInputType == Enum.UserInputType.Keyboard then
		
			if variables_ragdoll.Value == true and character.HumanoidRootPart then
		
		if input.KeyCode == Enum.KeyCode.W then
				KeyCodeRagdollRotatePressW = true
				print(tostring(CFrame.LookVector))
				while KeyCodeRagdollRotatePressW do
					wait(0.05)
				--	character.RightLowerLeg.AssemblyAngularVelocity = character.RightLowerLeg.AssemblyAngularVelocity + Vector3.new(RagdollRotate,0,0)
				--	character.LeftLowerLeg.AssemblyAngularVelocity = character.LeftLowerLeg.AssemblyAngularVelocity + Vector3.new(RagdollRotate,0,0)
					
				--	character.RightLowerArm.AssemblyAngularVelocity = character.RightLowerArm.AssemblyAngularVelocity + Vector3.new(RagdollRotate,0,0)
				--	character.LeftLowerArm.AssemblyAngularVelocity = character.LeftLowerArm.AssemblyAngularVelocity + Vector3.new(RagdollRotate,0,0)
				
			end
			
		end
		if input.KeyCode == Enum.KeyCode.S then
				KeyCodeRagdollRotatePressS = true
				while KeyCodeRagdollRotatePressS do
					wait(0.05)
				--	character.RightLowerLeg.AssemblyAngularVelocity = character.RightLowerLeg.AssemblyAngularVelocity + Vector3.new(-RagdollRotate,0,0)
				--	character.LeftLowerLeg.AssemblyAngularVelocity = character.LeftLowerLeg.AssemblyAngularVelocity + Vector3.new(-RagdollRotate,0,0)
					
				--	character.RightLowerArm.AssemblyAngularVelocity = character.RightLowerArm.AssemblyAngularVelocity + Vector3.new(-RagdollRotate,0,0)
				--	character.LeftLowerArm.AssemblyAngularVelocity = character.LeftLowerArm.AssemblyAngularVelocity + Vector3.new(-RagdollRotate,0,0)
			end

		end
		if input.KeyCode == Enum.KeyCode.A then
				KeyCodeRagdollRotatePressA = true
				while KeyCodeRagdollRotatePressA do
					wait(0.05)
				--	character.RightLowerLeg.AssemblyAngularVelocity = character.RightLowerLeg.AssemblyAngularVelocity + Vector3.new(0,0,-RagdollRotate)
				--	character.LeftLowerLeg.AssemblyAngularVelocity = character.LeftLowerLeg.AssemblyAngularVelocity + Vector3.new(0,0,-RagdollRotate)
					
				--	character.RightLowerArm.AssemblyAngularVelocity = character.RightLowerArm.AssemblyAngularVelocity + Vector3.new(0,0,-RagdollRotate)
				--	character.LeftLowerArm.AssemblyAngularVelocity = character.LeftLowerArm.AssemblyAngularVelocity + Vector3.new(0,0,-RagdollRotate)
				
			end

		end
		if input.KeyCode == Enum.KeyCode.D then
				KeyCodeRagdollRotatePressD = true
				while KeyCodeRagdollRotatePressD do
					wait(0.05)
				--	character.RightLowerLeg.AssemblyAngularVelocity = character.RightLowerLeg.AssemblyAngularVelocity + Vector3.new(0,0,RagdollRotate)
				--	character.LeftLowerLeg.AssemblyAngularVelocity = character.LeftLowerLeg.AssemblyAngularVelocity + Vector3.new(0,0,RagdollRotate)
					
				--	character.RightLowerArm.AssemblyAngularVelocity = character.RightLowerArm.AssemblyAngularVelocity + Vector3.new(0,0,RagdollRotate)
				--	character.LeftLowerArm.AssemblyAngularVelocity = character.LeftLowerArm.AssemblyAngularVelocity + Vector3.new(0,0,RagdollRotate)
				
			end

		end
		end
		
			if input.KeyCode == keycode then
				if variables_ragdoll.Value==false then
					if not GetValue("Player_Driver_Car") then
						variables_ragdoll.Value = not variables_ragdoll.Value
						events_variableserver:FireServer("ragdoll",variables_ragdoll.Value)
					end
					
				else
					variables_ragdoll.Value = not variables_ragdoll.Value
					events_variableserver:FireServer("ragdoll",variables_ragdoll.Value)
				end
				

		end
		if input.KeyCode == Enum.KeyCode.Space then
			if variables_ragdoll.Value == true then
				variables_ragdoll.Value = false
				events_variableserver:FireServer("ragdoll",variables_ragdoll.Value)
			end
			
		end
	end end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input,gameProcessedEvent)--Кнопка отжата
	
	if input.UserInputType == Enum.UserInputType.Keyboard then
		
		if variables_ragdoll.Value == true and character.HumanoidRootPart then

			if input.KeyCode == Enum.KeyCode.W then
				KeyCodeRagdollRotatePressW = false
				

			end
			if input.KeyCode == Enum.KeyCode.S then
				KeyCodeRagdollRotatePressS = false


			end
			if input.KeyCode == Enum.KeyCode.A then
				KeyCodeRagdollRotatePressA = false


			end
			if input.KeyCode == Enum.KeyCode.D then
				KeyCodeRagdollRotatePressD = false
end end
	end
	
end)


while true do
	wait()
	if variables_ragdoll.Value == false then
		--character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,0,0)
		if character.HumanoidRootPart.Velocity.Magnitude > MaxVelocity and not humanoid.Sit then
			variables_ragdoll.Value = true
		events_variableserver:FireServer("ragdoll",variables_ragdoll.Value)
		end		
		end
end



game:GetService("ContextActionService"):SetTitle("RagdollToggle", "Ragdoll")
game:GetService("ContextActionService"):SetPosition("RagdollToggle", UDim2.new(1, -110, 0, 15))

script.Parent.events.variableserver.OnClientEvent:Connect(function()
	events_variableserver:FireServer("ragdoll",variables_ragdoll.Value)
end)
