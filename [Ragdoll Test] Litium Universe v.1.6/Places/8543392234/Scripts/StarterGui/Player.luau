local player = game.Players.LocalPlayer
local Mouse = player:GetMouse()
local Camera = game.Scene.Camera

local character = player.Character
if not character or not character.Parent then
	character = player.CharacterAdded:wait()
end

local humanoid = character:WaitForChild("Humanoid")

local Parts = {
	Head = character:WaitForChild("Head");
	Base = character:WaitForChild("HumanoidRootPart");
	Phys = game.Scene:WaitForChild(player.UserId.." Global Additionally");
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

local PlayerNickNameObj = Parts.Phys:FindFirstChild("PlayerNickname")
		if PlayerNickNameObj then
	--PlayerNickNameObj:Destroy()
	end


local PartsTable = {Parts.Head,Parts.Torso.Lower,Parts.Torso.Upper,Parts.Arms.Left.Lower,Parts.Arms.Left.Upper,Parts.Arms.Left.Hand,Parts.Arms.Right.Lower,Parts.Arms.Right.Upper,Parts.Arms.Right.Hand,Parts.Legs.Left.Lower,Parts.Legs.Left.Upper,Parts.Legs.Left.Foot,Parts.Legs.Right.Lower,Parts.Legs.Right.Upper,Parts.Legs.Right.Foot}

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

local function Damage(power,deadtype)
	humanoid.Health = humanoid.Health - power
	if deadtype == nil then
		SetPValue("DeadType","Unknown")
	else
		SetPValue("DeadType",deadtype)
	end
end
local function Dead(deadtype)
	humanoid.Health = 0
	if deadtype == nil then
		SetPValue("DeadType","Unknown")
	else
		SetPValue("DeadType",deadtype)
	end
end

local function SetInvBody()
	for i,v in pairs(character:GetChildren()) do
		if (v:IsA("BasePart")) then
			if v.Name == "Head" then
				local head = v:FindFirstChild("HeadCollision")
				if GetPValue("FirstFaceCamera") then
					--	head.Transparency =  -math.huge
					--	head.Material = Enum.Material.ForceField
					--	head.LocalTransparencyModifier = -math.huge;
				else

				end
			else
				v.LocalTransparencyModifier = v.Transparency;
			end
		end
	end
end

local StepSounds = {
	["Plastic"] = {id = "rbxasset://sounds/action_footsteps_plastic.mp3",volume = 2, speed = 1},
	["Wood"] = {id = "rbxassetid://6133240333",volume = 2, speed = 1},
	["WoodPlanks"] = {id = "rbxassetid://6133240333",volume = 1, speed = 1},
	["Slate"] = {id = "rbxassetid://181024817",volume = 2, speed = 0.8},
	["Concrete"] = {id = "rbxassetid://7131667298",volume = 1, speed = 1.5},
	["Metal"] = {id = "rbxassetid://145180178",volume = 1, speed = 1},
	["CorrodedMetal"] = {id = "rbxassetid://145180178",volume = 1, speed = 1},
	["DiamondPlate"] = {id = "rbxassetid://145180178",volume = 1, speed = 1},
	["Foil"] = {id = "rbxassetid://8059880878",volume = 1, speed = 0.5},
	["Grass"] = {id = "rbxassetid://2647292698",volume = 2, speed = 1},
	["Ice"] = {id = "rbxassetid://3437778169",volume = 2, speed = 1},
	["Brick"] = {id = "rbxassetid://181024817",volume = 2, speed = 0.8},
	["Sand"] = {id = "rbxassetid://6596719447",volume = 1, speed = 1},
	["Fabric"] = {id = "rbxassetid://4563481375",volume = 4, speed = 1},
	["Granite"] = {id = "rbxassetid://2924940076",volume = 1, speed = 1},
	["Marble"] = {id = "rbxassetid://2924940076",volume = 1, speed = 1},
	["Pebble"] = {id = "rbxassetid://2924940076",volume = 1, speed = 1},
	["Cobblestone"] = {id = "rbxassetid://181024817",volume = 2, speed = 0.8},
	["SmoothPlastic"] = {id = "rbxasset://sounds/action_footsteps_plastic.mp3",volume = 2, speed = 1},
	["Neon"] = {id = "rbxassetid://6603998973",volume = 1, speed = 0.5},
	["Glass"] = {id = "rbxassetid://6603998973",volume = 1, speed = 0.5},
	["Asphalt"] = {id = "rbxassetid://2924940076",volume = 1, speed = 1},
	["Basalt"] = {id = "rbxassetid://181024817",volume = 2, speed = 0.8},
	["CrackedLava"] = {id = "rbxassetid://6746451498",volume = 1, speed = 1},
	["Glacier"] = {id = "rbxassetid://3437778169",volume = 2, speed = 1},
	["Ground"] = {id = "rbxassetid://4317441347",volume = 1, speed = 1},
	["LeafyGrass"] = {id = "rbxassetid://6603761498",volume = 3, speed = 1},
	["Limestone"] = {id = "rbxassetid://181024817",volume = 2, speed = 0.8},
	["Mud"] = {id = "rbxassetid://6877240587",volume = 1, speed = 1},
	["Pavement"] = {id = "rbxassetid://181024817",volume = 2, speed = 0.8},
	["Rock"] = {id = "rbxassetid://181024817",volume = 2, speed = 0.8},
	["Salt"] = {id = "rbxassetid://6596719447",volume = 1, speed = 1},
	["Sandstone"] = {id = "rbxassetid://181024817",volume = 2, speed = 0.8},
	["Snow"] = {id = "rbxassetid://6175296453",volume = 2, speed = 2},

	["ForceField"] = {id = "rbxasset://sounds/action_footsteps_plastic.mp3",volume = 0, speed = 1},
	["Air"] = {id = "rbxasset://sounds/action_footsteps_plastic.mp3",volume = 0, speed = 1},
	["Water"] = {id = "rbxasset://sounds/action_footsteps_plastic.mp3",volume = 0, speed = 1},
	["nil"] = {id = "rbxasset://sounds/action_footsteps_plastic.mp3",volume = 0, speed = 1},
	[""] = {id = "rbxasset://sounds/action_footsteps_plastic.mp3",volume = 0, speed = 1},
	[" "] = {id = "rbxasset://sounds/action_footsteps_plastic.mp3",volume = 0, speed = 1},
}

local PressedW = false
local PressedA = false
local PressedS = false
local PressedD = false

local NowFOV = 70

local ObjectCount = 0
local function GetObject(mode)
	local Object = "TestObject"
	local ObjectOffSetOrin = Vector3.zero

	local i = 1
	if mode == nil then else
		i = -1
	end

	local MaxObjects = 6

	if ObjectCount > MaxObjects then
		ObjectCount = 0
	else if ObjectCount < 0 then
			ObjectCount = MaxObjects
		else
			ObjectCount = ObjectCount + i
		end end

	if ObjectCount == 0 then
		Object = "TestObject"
	else if ObjectCount == 1 then
			Object = "Table"
		else if ObjectCount == 2 then
				Object = "Chair"
			else if ObjectCount == 3 then
					Object = "Shelf"
				else if ObjectCount == 4 then
						Object = "Lamp"
						ObjectOffSetOrin = Vector3.new(0,0,90)
					else if ObjectCount == 5 then
							Object = "C4"
						else if ObjectCount == 6 then
								Object = "Window"
							end
						end
					end
				end
				end
		end
	end

	SetPValue("ObjectSpawnOffsetOrientation",ObjectOffSetOrin)
	SetPValue("ObjectSpawn",Object)
end
local function MakeText(blacklist,text,pos,color,dwait,transp,textdis,flyspeed)
	if blacklist == nil or blacklist == {} then

	else
		for _,bklt in pairs(blacklist) do
			if bklt.UserId == player.UserId then
				return
			end
		end
	end

	local origobj = game.Scene.SavedObjects:WaitForChild("Info")
	local obj = origobj:Clone()
	obj.Parent = player:FindFirstChild("PlayerGui")
	obj.Position = pos
	obj.Text.Value = text
	obj.TextColor.Value = color
	if dwait then
		obj.DestroyWait.Value = dwait
	end
	if transp then
		obj.TransparencyWait.Value = transp
	end
	if textdis then
		obj.TextDistance.Value = textdis
	end
	if flyspeed then
		obj.FlySpeed.Value = flyspeed
	end
	obj.DestroyScript.Disabled = false


end

local function GetAllButNotOne(player)
	local players = game:GetService("Players")
	local result = {}

	for _,p in pairs(players:GetPlayers()) do
		if p.UserId == player.UserId then else
			table.insert(result,p)
		end
	end


	return result
end

local function GetObjectRay(obj)
	if obj then
		if obj.Name == "Base" or obj.Name == "Block" or obj.Name == "BlockColor" then
			print(obj.Name)
			if obj:IsA("Model") then
				local objmodel = obj.PrimaryPart
				if objmodel.Name == "Base" then
					return objmodel	
				else
					local child = obj:GetChild()
					for _,c in pairs(child) do
						if c.Name == "Base" then
							return c
						end
					end
				end
			else
				if obj.Name == "Base" then
					return obj
				else
					local obj2 = obj.Parent 
					if obj2.Name == "Base" then
						return obj2
					else
						local obj3 = obj2.Parent 
						if obj3.Name == "Base" then
							return obj3
						else
							local obj4 = obj3.Parent 
							if obj4.Name == "Base" then
								return obj4
							else
								local obj5 = obj4.Parent 
								if obj5.Name == "Base" then
									return obj5
								else
									local obj6 = obj5.Parent 
									if obj6.Name == "Base" then
										return obj6
									else

										local obj7 = obj6.Parent 
										if obj7.Name == "Base" then
											return obj7
										else

											local obj8 = obj7.Parent 
											if obj8.Name == "Base" then
												return obj8
											else

												return nil
											end
										end
									end
								end
							end
						end
					end
				end
			end

		end end


end

local MoveRagdoll = 0
local brickcolorID = 1
game:GetService("UserInputService").InputBegan:Connect(function(keycode,chatting)

	if keycode.KeyCode == Enum.KeyCode.P and not chatting and not GetPValue("Dead") then
		print(112512512512512516126126126)
		Dead()
	end

	if keycode.UserInputType == Enum.UserInputType.Keyboard and keycode.KeyCode then
		SetPValue("PlayerPressAnyButton",true)
	end

	--[[if keycode.KeyCode == Enum.KeyCode.G then
		SetPValue("SpawnFroozenObjects",not GetPValue("SpawnFroozenObjects"))
	end]]

	if keycode.KeyCode == Enum.KeyCode.Space and GetPValue("Dead") then
		SetPValue("PressRespawn",true)
	end

	if keycode.KeyCode == Enum.KeyCode.E and not chatting and not GetPValue("Dead") then
		if GetPValue("CanSpawnObjectDistance") and GetPValue("SpawnObjectsWait")<=0 then
			game.ReplicatedStorage.CreateObject:FireServer(GetPValue("ObjectSpawn"),GetPValue("MousePosition"),GetPValue("ObjectSpawnOffsetOrientation"),player)
		else
			if GetPValue("SpawnObjectsWait")<=0 then
				MakeText(nil,"You can't build here!",GetPValue("MousePosition"),Color3.new(1,0,0),nil,nil,math.huge)
			else
				MakeText(nil,"You have to wait [".. GetPValue("SpawnObjectsWait") .."] so that you can build",GetPValue("MousePosition"),Color3.new(1,0,0),nil,nil,math.huge)
			end
		end
	end
	
	if keycode.KeyCode == Enum.KeyCode.Two then
		SetPValue("ShowObjectDesc",not GetPValue("ShowObjectDesc"))
	end
	
	if keycode.KeyCode == Enum.KeyCode.Three then
		brickcolorID = brickcolorID + 1
		if brickcolorID >= 1033 then
			brickcolorID = 1
		end
		SetPValue("PlayerColor",BrickColor.new(brickcolorID))
	end
	if keycode.KeyCode == Enum.KeyCode.Four then
		brickcolorID = brickcolorID - 1
		if brickcolorID <= 0 then
			brickcolorID = 1032
		end
		SetPValue("PlayerColor",BrickColor.new(brickcolorID))
	end

	if keycode.KeyCode == Enum.KeyCode.KeypadFive and GetPValue("Credentials") == 10 then
		game.ReplicatedStorage.ClearAllObjects:FireServer(true)
	end

	if keycode.KeyCode == Enum.KeyCode.Q and not chatting then
		GetObject()
	end
	if keycode.KeyCode == Enum.KeyCode.One and not chatting then
		GetObject(true)
	end
	
	if keycode.KeyCode == Enum.KeyCode.B and not chatting then
		humanoid.Sit = not humanoid.Sit
	end

	if keycode.KeyCode == Enum.KeyCode.R and GetPValue("CursorInObject") and not GetPValue("Dead") and GetPValue("MouseDistance") < 50 then
		game.ReplicatedStorage.DestroyObject:FireServer(GetPValue("CursorInObject"))
	end

	if keycode.KeyCode == Enum.KeyCode.T and not chatting then
		game.ReplicatedStorage.ClearAllObjects:FireServer()
	end

	if keycode.KeyCode == Enum.KeyCode.C and not chatting then
		if not GetPValue("FirstFaceCamera") then
			NowFOV = 50
		end
		SetPValue("FirstFaceCamera",not GetPValue("FirstFaceCamera"))
	end

	if keycode.KeyCode == Enum.KeyCode.F and not GetPValue("Dead") and not chatting then
		game.ReplicatedStorage.PlayGlobalSound:FireServer(Parts.Phys.NedoVoice,true)
	end

	if keycode.KeyCode == Enum.KeyCode.W then
		PressedW = true
		if GetPValue("Ragdoll") and not GetPValue("Dead") then
			MoveRagdoll = -1
		end
	end
	if keycode.KeyCode == Enum.KeyCode.A then
		PressedA = true
	end
	if keycode.KeyCode == Enum.KeyCode.S then
		PressedS = true
		if GetPValue("Ragdoll") and not GetPValue("Dead") then
			MoveRagdoll = 1
		end
	end
	if keycode.KeyCode == Enum.KeyCode.D then
		PressedD = true
	end

	if keycode.KeyCode == Enum.KeyCode.LeftShift and not chatting then
		SetPValue("Running",true)
	end

end)

game:GetService("UserInputService").InputEnded:Connect(function(keycode)

	if keycode.UserInputType == Enum.UserInputType.Keyboard and keycode.KeyCode then
		SetPValue("PlayerPressAnyButton",false)
	end

	if keycode.KeyCode == Enum.KeyCode.Space and GetPValue("Dead") then
		SetPValue("PressRespawn",false)
	end

	if keycode.KeyCode == Enum.KeyCode.W then
		PressedW = false
		MoveRagdoll = 0
	end
	if keycode.KeyCode == Enum.KeyCode.A then
		PressedA = false
	end
	if keycode.KeyCode == Enum.KeyCode.S then
		PressedS = false
		MoveRagdoll = 0
	end
	if keycode.KeyCode == Enum.KeyCode.D then
		PressedD = false
	end

	if keycode.KeyCode == Enum.KeyCode.LeftShift then
		SetPValue("Running",false)
	end
end)

local HitObj = nil
local function HeadRay()
	local Ray = Ray.new(Parts.Head.CFrame.Position,Parts.Head.CFrame.LookVector*(Vector3.one*2))
	local hit, position = game.Workspace:FindPartOnRayWithIgnoreList(Ray,character:GetChildren())--{Parts.Head,Parts.Torso.Lower,Parts.Torso.Upper,Parts.Base,Parts.Legs.Left.Upper,Parts.Legs.Left.Lower,Parts.Legs.Right.Upper,Parts.Legs.Right.Lower,Parts.Legs.Left.Foot,Parts.Legs.Right.Foot,Parts.Arms.Left.Hand,Parts.Arms.Left.Lower,Parts.Arms.Left.Upper,Parts.Arms.Right.Hand,Parts.Arms.Right.Lower,Parts.Arms.Right.Upper})
	HitObj = hit
end

local NeckStop = false
local Neck = Parts.Head:FindFirstChild("Neck")
local function RotateHead()
	local CamDir = Parts.Base.CFrame:toObjectSpace(Camera.CFrame).lookVector
	SetPValue("NeckCFrame",  CFrame.Angles(0,-math.asin(CamDir.x),0) * CFrame.Angles(math.asin(CamDir.y),0,0))
end
local face = Parts.Head:WaitForChild("face")
SetPValue("PlayerFace",face.Texture)

local walkKeyBinds = {
	Forward = { Key = Enum.KeyCode.W, Direction = Enum.NormalId.Front },
	Backward = { Key = Enum.KeyCode.S, Direction = Enum.NormalId.Back },
	Left = { Key = Enum.KeyCode.A, Direction = Enum.NormalId.Left },
	Right = { Key = Enum.KeyCode.D, Direction = Enum.NormalId.Right }
}

local function getWalkDirectionCameraSpace()
	local walkDir = Vector3.new()

	for keyBindName, keyBind in pairs(walkKeyBinds) do
		if game:GetService("UserInputService"):IsKeyDown(keyBind.Key) then
			walkDir += Vector3.FromNormalId( keyBind.Direction )
		end
	end

	if walkDir.Magnitude > 0 then 
		walkDir = walkDir.Unit
	end

	return walkDir
end

local function GetAllChildrens(obj)
	local childrens = {}

	local tablet
	if type(obj) == "table" then
		tablet = obj
	else
		tablet = obj:GetChildren()
	end

	for _,c in ipairs(tablet) do
		for _,c2 in ipairs(c:GetChildren()) do
			for _,c3 in ipairs(c2:GetChildren()) do
				for _,c4 in ipairs(c3:GetChildren()) do
					for _,c5 in ipairs(c4:GetChildren()) do
						for _,c6 in ipairs(c5:GetChildren()) do
							for _,c7 in ipairs(c6:GetChildren()) do
								for _,c8 in ipairs(c7:GetChildren()) do
									for _,c9 in ipairs(c8:GetChildren()) do
										table.insert(childrens,c9)
									end
									table.insert(childrens,c8)
								end
								table.insert(childrens,c7)
							end
							table.insert(childrens,c6)
						end
						table.insert(childrens,c5)
					end
					table.insert(childrens,c4)
				end
				table.insert(childrens,c3)
			end
			table.insert(childrens,c2)
		end
		table.insert(childrens,c)
	end
	
	local oldchildrens = childrens
	for _,c in ipairs(oldchildrens) do
		if c.Name == "ObjectDescription" then
				local num = table.find(childrens,c)
				table.remove(childrens,num)
		end
	end
	
	return childrens
end

local PlayerAddit = game.Scene:WaitForChild(player.UserId.." Additionally"):WaitForChild("PlayerCharacter").Weather
local ObjectDesc = PlayerAddit:WaitForChild("ObjectDescription")
local DeadSound = PlayerAddit.DeadSound

local function getWalkDirectionWorldSpace()
	local walkDir = Camera.CFrame:VectorToWorldSpace( getWalkDirectionCameraSpace() )
	walkDir *= Vector3.new(1, 0, 1) 

	if walkDir.Magnitude > 0 then 
		walkDir = walkDir.Unit
	end

	return walkDir
end

local RunMaterialMultiply = 1
local NeedFOV = 70

local function IfMaterial(mat)
	local Step = Parts.Base:FindFirstChild("Running")
	if Step then
		if mat == nil or mat == "nil" or mat == "" or mat == " " then

		else
			local id = StepSounds[tostring(mat)].id
			local volume = StepSounds[tostring(mat)].volume
			local speed = StepSounds[tostring(mat)].speed
			if id then
				Step.SoundId = id
				Step.Volume = volume/2
				Step.PlaybackSpeed = (humanoid.WalkSpeed/10)*speed
				Step.RollOffMinDistance = 30
			end
		end end

	if mat == "Mud" then
		RunMaterialMultiply = 0.4
	else if mat == "Sand" or mat == "Snow" then
			RunMaterialMultiply = 0.6
		else if mat == "Grass" then
				RunMaterialMultiply = 0.8
			else if mat == "Basalt" then
					RunMaterialMultiply = 1.2
				else 
					RunMaterialMultiply = 1
				end
			end
		end
	end

	if mat == "Ice" or mat == "Glacier" then
		if GetValue("Weather") == "Rain" and not GetPValue("HaveRoof") then
			SetPValue("Friction",80)
		else
			SetPValue("Friction",60)
		end

	else if mat == "Mud" then
			if GetValue("Weather") == "Rain" and not GetPValue("HaveRoof") then
				SetPValue("Friction",60)
			else
				SetPValue("Friction",30)
			end

		else
			if GetValue("Weather") == "Rain" and not GetPValue("HaveRoof") then
				SetPValue("Friction",30)
			else
				SetPValue("Friction",0)
			end

		end
	end


end

game.ReplicatedStorage.MakeText.OnClientEvent:Connect(MakeText)

local Friction = Vector3.zero
local RandomRunningSpeed = 1

local GetRandomRunningSpeedBool = true
local function GetRandomRunningSpeed()
	if GetRandomRunningSpeedBool then
		GetRandomRunningSpeedBool = false
		GetRandomRunningSpeedBool = true
		RandomRunningSpeed = math.random(8,13)/10
	end
end

humanoid:GetPropertyChangedSignal("Jump"):Connect(function() if GetPValue("Stamina") > 0 and not GetPValue("Ragdoll") and not GetPValue("InWater") then SetPValue("Stamina",GetPValue("Stamina")-50) end end)

local function FrictionFunc()
	if GetPValue("PlayerWalk") then
		if getWalkDirectionWorldSpace().Magnitude>0.1 then
			Friction = getWalkDirectionWorldSpace()*GetPValue("Friction")
		end
	else
		local x = Friction.x
		local z = Friction.z
		if x > 0 then
			x = x - 1
		end
		if z > 0 then
			z = z - 1
		end

		if x < 0 then
			x = x + 1
		end
		if z < 0 then
			z = z + 1
		end

		Friction = Vector3.new(x,Friction.y,z)
	end
	if not GetPValue("Ragdoll") then
		Parts.Base:ApplyImpulse(Friction)
	end
end

local function FOV()

	if NowFOV < NeedFOV then
		NowFOV = NowFOV + 0.5
	else if NowFOV > NeedFOV then
			NowFOV = NowFOV - 0.5
		end
	end
	Camera.FieldOfView = NowFOV
end

local GUI = player.PlayerGui.GUI

local function ReadTerrain(pos)
	local Region = Region3.new(pos,pos + Vector3.new(1, 1, 1))
	local ExpandedRegion = Region:ExpandToGrid(4)

	local material, occupancy = workspace.Terrain:ReadVoxels(ExpandedRegion, 4)

	material = material[1][1][1]

	if material then
		return material
	else
		return Enum.Material.Air
	end
end

local function GetObjectInMap()
	local obj = nil
	if Mouse.Target then
		--if Mouse.Target.Parent then
		--local own = Mouse.Target.Parent:FindFirstChild("Owner")
		--if own then
		--obj = Mouse.Target.Parent
		--end
		--end
		obj = GetObjectRay(Mouse.Target)
		if obj then
			SetPValue("CursorInObject",obj)
			if GetPValue("ShowObjectDesc") then
			local objgui = ObjectDesc.Gui
			ObjectDesc.Position = obj.Position
				objgui.MaxDistance = math.huge
				objgui.Color.BackgroundColor3 = obj.Parent:WaitForChild("Color").Value.Color
			local AllChildrens = GetAllChildrens(obj)
				objgui.Info.Text = "Name = {".. obj.Parent.Name .."} ; Polygons* = {".. #AllChildrens .."}        Author = {".. game:GetService("Players"):GetNameFromUserIdAsync(obj.Parent:WaitForChild("Owner").Value) .."} ;                             Time Created = {".. obj.Parent:WaitForChild("CreateTime").Value .."}" 
			end
		else
			SetPValue("CursorInObject",nil)
			ObjectDesc.Position = Vector3.new(0,-1000,0)
			local objgui = ObjectDesc.Gui
			objgui.MaxDistance = 1
		end
	end
end
local function HeDead()
	DeadSound.Playing = true
	SetPValue("Stamina",GetPValue("MaxStamina"))
	SetPValue("Oxygen",GetPValue("MaxOxygen"))
end

local function GetFloorAngle()
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = {character:GetChildren()}
	params.FilterType = Enum.RaycastFilterType.Blacklist
	local result = workspace:Raycast(Parts.Torso.Lower.Position, Vector3.new(0,-10,0), params)

	local FloorAngle = 0
	local FloorAngleVec = Vector3.zero

	if result then
		local x = math.deg(math.asin(result.Normal.X))
		local z = math.deg(math.asin(result.Normal.Z))

		FloorAngleVec = Vector3.new(x,0,z)
		FloorAngle = FloorAngleVec.Magnitude

		SetPValue("FloorAngleVector",result.Normal)

	else
		FloorAngle = 0

		SetPValue("FloorAngleVector",Vector3.zero)
	end
	SetPValue("FloorAngle",FloorAngle)
end

local function GetCFrameWithRotation(obj,raylist)
	--[[local Xunit = Vector3.new(1, 0, 0)
	local Yunit = Vector3.new(0, 1, 0)
	local Zunit = Vector3.new(0, 0, 1)
	
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = raylist
	params.FilterType = Enum.RaycastFilterType.Blacklist
	
	local Wetnormal = workspace:Raycast(obj.Position, Vector3.new(0,-10,0), params)
	if Wetnormal then
	local normal = Wetnormal.Normal
	local checkVector = obj.CFrame.UpVector 
	
	local checkAngleX, normalAngleX = math.acos(checkVector:Dot(Xunit) / (checkVector.Magnitude * Xunit.Magnitude)), math.acos(normal:Dot(Xunit) / (normal.Magnitude * Xunit.Magnitude)) 

	local diffX = checkAngleX - normalAngleX 

	local checkAngleZ, normalAngleZ = math.acos(checkVector:Dot(Zunit) / (checkVector.Magnitude * Zunit.Magnitude)), math.acos(normal:Dot(Zunit) / (normal.Magnitude * Zunit.Magnitude))
	local diffZ = checkAngleZ - normalAngleZ
	
	return obj.CFrame * CFrame.Angles(diffZ, 0, -diffX)
	end]]
	local newRay = Ray.new(obj.Position, Vector3.new(0, -10, 0))
	local part, position, normal = workspace:FindPartOnRay(newRay)
	return CFrame.new(position,position+normal)
end

SetPValue("LAnkleY",Parts.Legs.Left.Foot.LeftAnkle.C0.Y)
SetPValue("NeckY",Neck.C0.Y)
local PlayerGui = player:WaitForChild("PlayerGui")
while true do
	wait()
	if humanoid and Parts.Base then

		--game.ReplicatedStorage.SetPosition:FireServer(Parts.Phys,Parts.Head.Position)

		GetFloorAngle()

		if GetPValue("Dead") then
			GUI.DeadText.Visible = true
			GUI.DeadText2.Visible = true
			if GetPValue("DeadType") == "Unknown" then
			else
				GUI.DeadText3.Visible = true
			end
		else
			GUI.DeadText.Visible = false
			GUI.DeadText2.Visible = false
			GUI.DeadText3.Visible = false
		end
		GUI.DeadText3.Text = "{Reason : ".. GetPValue("DeadType") .." }"

		if GetPValue("SpawnObjectsWait") > 0 then
			SetPValue("SpawnObjectsWait",GetPValue("SpawnObjectsWait")-1)
		end

		local temp = GetPValue("TempiratureOffSet")-(Parts.Base.Position.Y/4)
		if temp > -273 then
			SetPValue("MapTempirature",temp)
		end
		if GetPValue("HeadInWater") or GetPValue("InWater") then
			SetPValue("PlayerTempirature",36-math.abs((temp/(GetPValue("SavingTemperature")))))
		else
			SetPValue("PlayerTempirature",36+(temp/(GetPValue("SavingTemperature"))))
		end

		if GetPValue("PlayerTempirature") > 40 then
			Damage((math.abs(40-GetPValue("PlayerTempirature")))/4,"Thermal Shock")
		end
		if GetPValue("PlayerTempirature") < 30 then
			Damage((math.abs(30-GetPValue("PlayerTempirature")))/4,"Hyperthermia")
		end

		if GetPValue("Stamina") > 200 then
			local LookDir = CFrame.lookAt(Parts.Base.Position,game.Scene.Camera.CFrame.Position).LookVector*MoveRagdoll
			Parts.Torso.Upper:ApplyAngularImpulse(LookDir*15)
			Parts.Arms.Left.Upper:ApplyImpulse(LookDir*5)
			Parts.Legs.Right.Upper:ApplyImpulse(LookDir*5)
			Parts.Legs.Left.Upper:ApplyImpulse(LookDir*5)
			Parts.Arms.Right.Upper:ApplyImpulse(LookDir*5)


			if GetPValue("Ragdoll") and Parts.Base.Velocity.Magnitude > GetValue("MaxPlayerVelocity") and not GetPValue("Dead") then
				Parts.Arms.Right.Upper:ApplyAngularImpulse(Vector3.new(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))))
				Parts.Arms.Left.Upper:ApplyAngularImpulse(Vector3.new(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))))

				Parts.Legs.Right.Upper:ApplyAngularImpulse(Vector3.new(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))))
				Parts.Legs.Left.Upper:ApplyAngularImpulse(Vector3.new(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))))
			end
		end

		GUI.SpawnThis.Text = GetPValue("ObjectSpawn")
		GetObjectInMap()
		
		if GetPValue("BodyWet") > 0 then
			SetPValue("BodyWet",GetPValue("BodyWet")-0.01)
		end

		if (ReadTerrain(Camera.CFrame.Position + Vector3.new(0,1.5,0)) == Enum.Material.Water) or (ReadTerrain(Camera.CFrame.Position + Vector3.new(0,1.5,-1)) == Enum.Material.Water) or (ReadTerrain(Camera.CFrame.Position + Vector3.new(0,1.5,1)) == Enum.Material.Water) or (ReadTerrain(Camera.CFrame.Position + Vector3.new(-1,1.5,0)) == Enum.Material.Water) or (ReadTerrain(Camera.CFrame.Position + Vector3.new(1,1.5,0)) == Enum.Material.Water) then
			if not GetPValue("CameraInWater") then
				SetPValue("WaterYposition",Camera.CFrame.Position.Y)
			end
			SetPValue("CameraInWater",true)
		else
			SetPValue("CameraInWater",false)
			SetPValue("WaterYposition",0)
		end
		
		if ReadTerrain(Camera.CFrame.Position - Vector3.new(0,0.5,0)) == Enum.Material.Water then
			SetPValue("CameraInWaterOld",true)
		else
			SetPValue("CameraInWaterOld",false)
		end
		
		if GetPValue("CameraInWater") then
			SetPValue("WaterDeepnes",GetPValue("WaterYposition")-Camera.CFrame.Position.Y)
		else
			SetPValue("WaterDeepnes",0)
		end
		
		if GetPValue("WaterDeepnes") <= 0 then
			SetPValue("WaterDeepnesOne",0)
		else if GetPValue("WaterDeepnes")>20 then
				SetPValue("WaterDeepnesOne",20)
			else
				SetPValue("WaterDeepnesOne",GetPValue("WaterDeepnes"))
			end end

		if ReadTerrain(Parts.Head.CFrame.Position+Vector3.new(0,0.5,0)) == Enum.Material.Water then
			SetPValue("HeadInWater",true)
			SetPValue("BodyWet",1)
		else
			SetPValue("HeadInWater",false)
		end

		SetPValue("MouseDistance",(Parts.Base.Position-GetPValue("MousePosition")).Magnitude)

		if GetPValue("MouseDistance") > 4 and GetPValue("MouseDistance") < 50 then
			SetPValue("CanSpawnObjectDistance",true)
		else
			SetPValue("CanSpawnObjectDistance",false)
		end

		SetPValue("MousePosition",Mouse.Hit.Position)

		FOV()
		GetRandomRunningSpeed()

		SetPValue("FloorMaterial",string.gsub(tostring(humanoid.FloorMaterial),"Enum.Material.",""))

		IfMaterial(GetPValue("FloorMaterial"))	

		if PressedW or PressedS or PressedA or PressedD then
			SetPValue("PlayerWalk",false)
			if PressedW and PressedS then
				SetPValue("PlayerWalk",false)
			else if PressedA and PressedD then
					SetPValue("PlayerWalk",false)
				else if PressedD and PressedA and PressedW and PressedS then
						SetPValue("PlayerWalk",false)
					else
						SetPValue("PlayerWalk",true)
					end
				end
			end
		else
			SetPValue("PlayerWalk",false)
		end

		FrictionFunc()

		if humanoid.Health <= 0 then
			if not GetPValue("Dead") then
				HeDead()
			end
			SetPValue("Dead",true)
		else
			SetPValue("Dead",false)
		end

		if GetPValue("Running") and not GetPValue("Dead") and not GetPValue("Ragdoll") and GetPValue("PlayerWalk") then
			humanoid.WalkSpeed = GetPValue("PlayerSpeed") * GetPValue("RunningSpeed") * RandomRunningSpeed * RunMaterialMultiply * (1-(1-(GetPValue("Stamina")/GetPValue("MaxStamina")))/4)
		else
			if GetPValue("InWater") then
				humanoid.WalkSpeed = GetPValue("PlayerSpeed") * 1.5 
			else
				humanoid.WalkSpeed = GetPValue("PlayerSpeed") * RunMaterialMultiply * (1-(1-(GetPValue("Stamina")/GetPValue("MaxStamina")))/4)
			end
		end

		if GetPValue("FirstFaceCamera") then
			NeedFOV = 60 -math.floor(((GetPValue("MaxStamina")-GetPValue("Stamina"))/50))
			if GetPValue("Ragdoll") then
				Camera.CFrame = Parts.Head.CFrame
				game:GetService("UserInputService").MouseDeltaSensitivity = 0
			else
				game:GetService("UserInputService").MouseDeltaSensitivity = 1
			end
		else
			game:GetService("UserInputService").MouseDeltaSensitivity = 1
			NeedFOV = 70+ math.floor(Parts.Base.Velocity.Magnitude) - math.floor(((GetPValue("MaxStamina")-GetPValue("Stamina"))/50))
		end

		if humanoid:GetState() == Enum.HumanoidStateType.Swimming then
			SetPValue("InWater",true)
		else
			SetPValue("InWater",false)
		end

		GUI.PlayerInfo.Text = "Health = ".. math.floor(humanoid.Health) ..";   Stamina = ".. GetPValue("Stamina") ..";   Oxygen = ".. GetPValue("Oxygen") ..";  Temperature = ".. (math.floor(GetPValue("PlayerTempirature")*10)/10) ..";"
		GUI.Id.Text = "Your Id {".. player.UserId .."}"
		GUI.PlayerColor.Text = "Color {".. brickcolorID .."}"
		GUI.PlayerColor.TextColor3 = BrickColor.new(brickcolorID).Color
		
		if GetPValue("InWater") then
			SetPValue("MaxFloorAngle",360)
		else
			local run = 1
			if GetPValue("Running") then
				run = 0.8
			else
				run = 1
			end
			SetPValue("MaxFloorAngle",55 / (1+(GetPValue("Friction")/60)) * run)
		end

		if not GetPValue("Dead") then
			if not GetPValue("InWater") and not GetPValue("PlayerWalk") then
				if GetPValue("Stamina") < GetPValue("MaxStamina") then
					SetPValue("Stamina",GetPValue("Stamina")+2)
				end
			end

			if GetPValue("InWater") then
				if GetPValue("Stamina") > 0 and not GetPValue("Ragdoll") then
					SetPValue("Stamina",GetPValue("Stamina")-1)
				end
			end

			if GetPValue("Running") and GetPValue("PlayerWalk") then
				if GetPValue("Stamina") > 0 and not GetPValue("Ragdoll") then
					SetPValue("Stamina",GetPValue("Stamina")-2)
				end
			end

			if GetPValue("HeadInWater") then
				if GetPValue("Oxygen") > 0 then
					SetPValue("Oxygen",GetPValue("Oxygen")-1)
				end
			else
				if GetPValue("Oxygen") < GetPValue("MaxOxygen") then
					SetPValue("Oxygen",GetPValue("Oxygen")+1)
				end
			end end

		if GetPValue("Oxygen") <= 0 then
			Dead("Drowned")
		end

		if Neck then
			RotateHead()
		end
		SetInvBody()
		if GetPValue("FirstFaceCamera") then
			HeadRay()
			Mouse.Icon = "rbxassetid://8633666579"--8548397383"
			player.CameraMaxZoomDistance = 0
			player.CameraMinZoomDistance = 0
			if HitObj and not GetPValue("InWater") then
				humanoid.CameraOffset = Vector3.zero
			else
				humanoid.CameraOffset = Vector3.new(0,0,-1.2)
			end
		else
			if GetPValue("CanSpawnObjectDistance") and GetPValue("SpawnObjectsWait")<=0 then
				Mouse.Icon = "rbxassetid://8608869309"
			else
				Mouse.Icon = "rbxassetid://8608870485"
			end
			player.CameraMaxZoomDistance = 12
			player.CameraMinZoomDistance = 12
			humanoid.CameraOffset = Vector3.zero


		end

	end
end