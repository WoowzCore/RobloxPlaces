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

local HereGlobalValues = game.Scene.Main.GlobalValue
local function GetValue(name)
	local Value = HereGlobalValues:WaitForChild(name)
	return Value.Value
end

local function GetPValue(name)
	local Value = player.PlayerFiles.Values:WaitForChild(name)
	return Value.Value
end

local function SetPValue(name, value)
	game.ReplicatedStorage.SetPValue:FireServer(name,value)
end



function killRagdoll(inst)
	if string.match("Corpse ",player.Name) then
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
		for _,v in pairs(humanoid:GetPlayingAnimationTracks()) do 
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
	local h = character:FindFirstChild("HumanoidRootPart")
	if h then
		h.Velocity = velocity
	end
end

local Parts = {
	Head = character:WaitForChild("Head");
	Base = character:WaitForChild("HumanoidRootPart");
	Torso = {
		Upper = character:WaitForChild("UpperTorso");
		Lower = character:WaitForChild("LowerTorso");
	};
	Arms = {
		Left = {
			Upper = character:WaitForChild("LeftUpperArm");
			Lower = character:WaitForChild("LeftLowerArm");
			Hand = character:WaitForChild("LeftHand");
		};
		Right = {
			Upper = character:WaitForChild("RightUpperArm");
			Lower = character:WaitForChild("RightLowerArm");
			Hand = character:WaitForChild("RightHand");
		};

	};
	Legs = {
		Left = {
			Upper = character:WaitForChild("LeftUpperLeg");
			Lower = character:WaitForChild("LeftLowerLeg");
			Foot = character:WaitForChild("LeftFoot");
		};
		Right = {
			Upper = character:WaitForChild("RightUpperLeg");
			Lower = character:WaitForChild("RightLowerLeg");
			Foot = character:WaitForChild("RightFoot");
		};

	};
}

game:GetService("UserInputService").InputBegan:Connect(function(keycode, chatting)
	if character then
		local c = character:FindFirstChild("HumanoidRootPart")
		if c then
			local velocity = c.Velocity
			if velocity.Magnitude < GetValue("MaxPlayerVelocity") and not GetPValue("Dead") and not chatting  and GetPValue("Stamina") > 0 then
				
				local ContextActionService = game:GetService("ContextActionService")
				
				if keycode.KeyCode == Enum.KeyCode.Z then
					humanoid.Sit = false
					if variables_ragdoll.Value == true then
						if GetPValue("RagdollWait") <=0 then
							variables_ragdoll.Value = false
						end
					else
						variables_ragdoll.Value = true
						SetPValue("RagdollWait",100)
					end
				end
				
				if game:GetService("UserInputService").TouchEnabled then
					game:GetService("UserInputService").JumpRequest:Connect(function()
						if variables_ragdoll.Value and GetPValue("RagdollWait") <=0 then
							humanoid.Sit = false
							variables_ragdoll.Value = false
						end
					end)
				end
				
				if keycode.KeyCode == Enum.KeyCode.Space and variables_ragdoll.Value and GetPValue("RagdollWait") <=0 then
					humanoid.Sit = false
					variables_ragdoll.Value = false
				end
				 end
		else
			warn("Not Have Character")
		end
	end
end)


local StopLoop = false

local function MakeRagdoll()
	SetPValue("Ragdoll",variables_ragdoll.Value)
	events_variableserver:FireServer("ragdoll",variables_ragdoll.Value,character.HumanoidRootPart.Velocity)
end

while true do
	wait(0.2)
	WaitRag = false
	if character then
		
		if GetPValue("RagdollWait") > 0 then
			SetPValue("RagdollWait",GetPValue("RagdollWait")-5)
		end
		local hum = character:FindFirstChild("HumanoidRootPart")
		if hum then
			if not variables_ragdoll.Value then
				if (character.HumanoidRootPart.Velocity.Magnitude > GetValue("MaxPlayerVelocity") or GetPValue("Dead") or GetPValue("FloorAngle") > GetPValue("MaxFloorAngle") ) and not variables_ragdoll.Value then
					
					variables_ragdoll.Value = true
				end
				if GetPValue("Stamina") <= 0 then
					variables_ragdoll.Value = true
				end
			end
				MakeRagdoll()
			end end
end

