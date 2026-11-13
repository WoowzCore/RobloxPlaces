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

local function GetAllObjects(obj)
	local tablet = {}
	
	for i,part in pairs(obj:GetChildren()) do
		table.insert(tablet,part)
		for i,part2 in pairs(part:GetChildren()) do
			table.insert(tablet,part2)
			for i,part3 in pairs(part2:GetChildren()) do
				table.insert(tablet,part3)
				for i,part4 in pairs(part3:GetChildren()) do
					table.insert(tablet,part4)
					for i,part5 in pairs(part4:GetChildren()) do
						table.insert(tablet,part5)
						for i,part6 in pairs(part5:GetChildren()) do
							table.insert(tablet,part6)
							for i,part7 in pairs(part6:GetChildren()) do
								table.insert(tablet,part7)
								for i,part8 in pairs(part7:GetChildren()) do
									table.insert(tablet,part8)
									for i,part9 in pairs(part8:GetChildren()) do
										table.insert(tablet,part9)
										for i,part10 in pairs(part9:GetChildren()) do
											table.insert(tablet,part10)
											for i,part11 in pairs(part10:GetChildren()) do
												table.insert(tablet,part11)
												for i,part12 in pairs(part11:GetChildren()) do
													table.insert(tablet,part12)

												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	
	return tablet
end

local function ReturnAllParts(obj)
	local tablet = {}
	for _,part in ipairs(GetAllObjects(obj)) do
		if part:IsA("Part") then
			table.insert(tablet,part)
		end
	end
	return tablet
end

RS.GetAllObjects.OnServerEvent:Connect(GetAllObjects)

local function ActiveObject(player,obj,bool)
	print("active global")
	if obj ~= nil then
		print(obj.Name)
		local activefolder = obj:FindFirstChild("Activate")
		if activefolder then
			if bool ~= nil then
				local active = activefolder:FindFirstChild("SetActivateEvent")
				if active then
					active:Fire(bool)
				end
			else
				local active = activefolder:FindFirstChild("ActivateEvent")
				if active then
					active:Fire()
				end
			end
		end 
	end
end
RS.ActivateObject.OnServerEvent:Connect(ActiveObject)

local function ActiveObjectServer(obj,bool)
	print("active global")
	if obj ~= nil then
		print(obj.Name)
		local activefolder = obj:FindFirstChild("Activate")
		if activefolder then
			if bool ~= nil then
				local active = activefolder:FindFirstChild("SetActivateEvent")
				if active then
					active:Fire(bool)
				end
			else
				local active = activefolder:FindFirstChild("ActivateEvent")
				if active then
					active:Fire()
				end
			end
		end 
	end
end
RS.ActiveObjectServer.Event:Connect(ActiveObjectServer)

local function Switch_Debug_Mode(player,bool)
	RS.SetDebug:FireClient(player,bool)
end
RS.Switch_Debug_Mode.OnServerEvent:Connect(Switch_Debug_Mode)

local function DisableCollider(obj,bool)

	if obj then
		local arm = obj:FindFirstChild("Arm")
		if arm then
			if arm.Value == nil then
		for _,physobj in pairs(ReturnAllParts(obj)) do
			local cancollide = physobj:FindFirstChild("HaveCollision")
			if cancollide then
				if not bool then
					physobj.CanCollide = cancollide.Value
				else
					physobj.CanCollide = false
				end
			else
				physobj.CanCollide = not bool
			end
				end
				end
			end
	end	
end

local function MakeObjectInPlayerData(player,obj)
	if obj then
		obj.Parent = game.Scene.Main.Inventorys:WaitForChild(player.UserId.."_Inventory")
		obj.Pickable.Value = false
		for _,physobj in pairs(ReturnAllParts(obj)) do
				DisableCollider(obj,true)
	
			physobj.CanTouch = false
			physobj.CanQuery = false
			physobj.Anchored = true
			physobj.Transparency = 1
		end
		ActiveObjectServer(obj,false)
	end
end
local function MakeObjectInServerData(player,obj)
	obj.Parent = game.Scene.Map
	obj.Pickable.Value = true
	for _,physobj in pairs(ReturnAllParts(obj)) do
		DisableCollider(obj,false)
		physobj.CanTouch = true
		physobj.CanQuery = true
		physobj.Anchored = false
		local transparency = physobj:FindFirstChild("Transparency")
		if transparency then
			physobj.Transparency = transparency.Value
		else
			physobj.Transparency = 0
		end
	end
	RS.UpdateDebug:FireClient(player)
end
RS.MakeObjectInPlayerData.OnServerEvent:Connect(MakeObjectInPlayerData)
RS.MakeObjectInServerData.OnServerEvent:Connect(MakeObjectInServerData)

local function SetPick(obj,bool)
	print(obj.Name)
	DisableCollider(obj,bool)
	obj.Pickable.Value = not bool
end

local function CreateCFrame(pos,rot)
	local PosCFrame = nil
	local RotCFrame = nil
	if pos ~= nil then
		local posvec = Vector3.zero
		if pos:IsA("Vector3Value") then
			posvec = pos.Value
		else
			posvec = pos
		end
		PosCFrame = CFrame.new(posvec.x,posvec.y,posvec.z)
	end
	if rot ~= nil then
		local rotX = 0
		local rotY = 0
		local rotZ = 0

		local rotvec = nil
		if rot:IsA("Vector3Value") then
			rotvec = rot.Value
		else
			rotvec = rot
		end
		rotX = rotvec.x
		rotY = rotvec.y
		rotZ = rotvec.z


		RotCFrame = CFrame.Angles(math.rad(rotX),math.rad(rotY),math.rad(rotZ)) 
	end


	return PosCFrame * RotCFrame
end

local function SetObjectInArm(player,obj)
	local direction = "Right"
	local RightArm = true
	local directionId = ""
	if GetPlayerValue(player,"NowMoveLeftArm") then
		direction = "Left"
		RightArm = false
		directionId = "2"
	end
	local ch = player.Character
	local arm = ch:WaitForChild(direction.." Arm");
	local bool = false
	
	if obj ~= nil then
		print("Show object {true} to object [".. obj.Name .."]")
	else
		print("Show object {false}")
	end
	
	if obj ~= nil then
		if GetPlayerValue(player,"ObjectInHand"..directionId) ~= nil then
			MakeObjectInPlayerData(player,GetPlayerValue(player,"ObjectInHand"..directionId))
		end
		
		local ArmValue = obj:FindFirstChild("Arm")
		ArmValue.Value = arm
		local motor = Instance.new("Motor6D",arm)
		motor.Name = "Pick"
		motor.Part0 = arm
		motor.Part1 = obj.PrimaryPart
		if RightArm then
			motor.Part1 = obj.PrimaryPart
		else
			local leftpick = obj.PrimaryPart:FindFirstChild("PickPositionLeft")
			if leftpick then
				motor.Part1 = leftpick
			else
				motor.Part1 = obj.PrimaryPart
			end
		end
		SetPick(obj,true)
	else
		local motor = arm:FindFirstChild("Pick")
		local arm =GetPlayerValue(player,"ObjectInHand"..directionId)
		if arm then
		local armValue = arm:FindFirstChild("Arm")
		if motor then
			SetPick(GetPlayerValue(player,"ObjectInHand"..directionId),false)
		--	GetPlayerValue(player,"ObjectInHand"..directionId):SetNetworkOwner(player)
			armValue.Value = nil
			motor:Destroy()
			SetPlayerValue(player,"ObjectInHand"..directionId,nil)
			end
			end
	end
end
RS.SetObjectInArm.OnServerEvent:Connect(SetObjectInArm)
local function PickUpObjectServer(player,obj)
	RS.PickUpThis:FireClient(player,obj)
end
RS.PickUpObjectServer.OnServerEvent:Connect(PickUpObjectServer)

local function ApplyScript(obj,scriptt)
	local scripttNEW = scriptt:Clone()
	scripttNEW.Parent = obj
	scripttNEW.Disabled = false
end

local function CreateZombie(pos)
	local ZombieMain = game.Scene.Main.Zombie
	local zombieNeedCopy = ZombieMain.Zombie
	local Zombie = zombieNeedCopy:Clone()
	local ZombieHumanoid = Zombie.Humanoid
	ApplyScript(ZombieHumanoid,ZombieMain.ZombieDecor)
	ApplyScript(ZombieHumanoid,ZombieMain.ZombieAI)
	Zombie:SetPrimaryPartCFrame(CFrame.new(pos) * CFrame.Angles( 0,math.rad(math.random(0,380)),0 ))
	Zombie.Parent = game.Scene.Map.Zombies
	game.RStorage.MakeThisHumanoidNormal:Fire(ZombieHumanoid)
	ZombieHumanoid.ID.Value = GetValue("ZombieCount")
	Zombie.Name = "Zombie_"..GetValue("ZombieCount")
	SetValue("ZombieCount",GetValue("ZombieCount")+1)
end

wait(5)
local pluspos = 6.471
for i=0,5 do
	CreateZombie(Vector3.new(-24.878 + (pluspos*(i+1)), 3, -168.576))
end
--CreateZombie(Vector3.new(13.838, 3, -13.918))