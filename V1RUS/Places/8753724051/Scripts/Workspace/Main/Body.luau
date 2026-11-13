--[[========================================================]]
local function GetValue(name)
	local value = game.Scene.Main.GlobalValues:WaitForChild(name)
	return value.Value
end
local function SetValue(name,val)
	local value = game.Scene.Main.GlobalValues:WaitForChild(name)
	value.Value = val
end
local function GetPlayerValue(player,name)
	local value = player:WaitForChild("PlayerValues"):WaitForChild(name)
	return value.Value
end
local function SetPlayerValue(player,name,val)
	local value = player:WaitForChild("PlayerValues"):WaitForChild(name)
	value.Value = val
	wait()
end
--[[========================================================]]
local RS = game.RStorage
local SSS = game.SSS

local function RotateHead(player,ch,camera)
	if ch then
		local neck = ch.Torso.Neck
		neck.C0 = camera
	end
end
RS.RotateHead.OnServerEvent:Connect(RotateHead)
local function CreatePickArm(ch,npc,left)
	local direction = "Right"
	if left then
		direction = "Left"
	end
	local Arm = ch:WaitForChild(direction.." Arm");
	local Torso = ch:WaitForChild("Torso");
	
	
	if not npc then
		local RightArmWeld = Instance.new("Weld",Arm)
		RightArmWeld.Name = "Hand Rotation"
		RightArmWeld.Part0 = Torso
		RightArmWeld.Part1 = Arm
		local RightArmC0 = Arm.CFrame.Position
		RightArmWeld.C0 = Torso.CFrame:ToObjectSpace(Arm.CFrame)
	end
	
	local PickPivot = Instance.new("Part")
	PickPivot.Name = "PickPosition"
	PickPivot.Position = Arm.Position
	PickPivot.Parent = Arm
	PickPivot.Size = Vector3.one
	PickPivot.CanCollide = false
	PickPivot.CanTouch = false
	PickPivot.CanQuery = false
	PickPivot.Transparency = 1
	local panch = Instance.new("BoolValue",PickPivot)
	panch.Name = "This_Sharp"
	local PickPivotConnection = Instance.new("Weld",PickPivot)
	PickPivotConnection.Name = "PickPositionConnection"
	PickPivotConnection.Part0 = Arm
	PickPivotConnection.Part1 = PickPivot
	PickPivotConnection.C0 = CFrame.new(0,-0.75,0)
	
end

local function MakeThisHumanoidNormal(ch)
	local ThisNPC = true
	if ch.Name ~= "Humanoid" then
		ThisNPC = false
	end
	
	local RightArm = ch:WaitForChild("Right Arm");
	local Torso = ch:WaitForChild("Torso");
	
	CreatePickArm(ch,ThisNPC,false)
	CreatePickArm(ch,ThisNPC,true)
	
	local DamagesORIG = game.Scene.Main.DamageScript
	local Damages = DamagesORIG:Clone()
	Damages.Parent = ch
	Damages.Disabled = false
	
	
end
RS.MakeThisHumanoidNormal.Event:Connect(MakeThisHumanoidNormal)

local function MakeThisHumanoidHuman(player)
	local ch = player.Character or player.CharacterAdded:Wait()
	
	local Humanoid = ch:WaitForChild("Humanoid")

	MakeThisHumanoidNormal(ch)
end
RS.MakeThisHumanoidHuman.Event:Connect(MakeThisHumanoidHuman)

local function GetCharacter(player)
	local character = player.Character or player.CharacterAdded:Wait()
	return character
end

local function SetMovementArm(player,bool)
	local ch = GetCharacter(player)
	if ch then
		local direct = "Right"
		local armcframe = CFrame.new(1.5,0.5,0)
		local ArmObject = GetPlayerValue(player,"ObjectInHand")
		if GetPlayerValue(player,"NowMoveLeftArm") then
			direct = "Left"
			armcframe = CFrame.new(-1.5,0.5,0)
			ArmObject = GetPlayerValue(player,"ObjectInHand2")
		end
		local RightArmWeld = ch:WaitForChild(direct.." Arm"):FindFirstChild("Hand Rotation")
		if bool and RightArmWeld then
			--[[local pickWeld = RightArmWeld.Parent:WaitForChild("PickPosition"):WaitForChild("PickPositionConnection")
			if ArmObject and pickWeld then
				pickWeld.C1 =  RightArmWeld.Parent.CFrame:ToObjectSpace(ArmObject:GetPrimaryPartCFrame())
			end]]
			local newRightArmCFrame = CFrame.new((ch:WaitForChild("Torso").CFrame * armcframe).Position,GetPlayerValue(player,"MousePositionArm")) * CFrame.new(0,0,-0.5) * CFrame.Angles(math.pi/2,0,0)
			RightArmWeld.C0 = ch:WaitForChild("Torso").CFrame:toObjectSpace(newRightArmCFrame)
		end
	end	
end



local function BodyScript(player)
	SetMovementArm(player,GetPlayerValue(player,"MovementArm"))
end
SSS.Scripts.BodyScript.Event:Connect(BodyScript)
