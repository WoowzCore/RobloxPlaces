local HereGlobalValues = game.Scene.Main.GlobalValue

local function SetValue(name,value)
	local Value = HereGlobalValues:WaitForChild(name)
	Value.Value = value
end

local function GetValue(name)
	local Value = HereGlobalValues:WaitForChild(name)
	return Value.Value
end

local function GetPValue(player,name)
	local Value = player:WaitForChild("PlayerFiles").Values:WaitForChild(name)
	return Value.Value
end

local function SetPValue(player,name, value)
	local Value = player.PlayerFiles.Values:WaitForChild(name)
	Value.Value = value

end

local function GetRank(player)
	local have = false
	local Ranks = game.Scene.Main.PlayerList
	for _,rank in ipairs(Ranks:GetChildren()) do
		if rank.Value == player.UserId then
			have = true
			return rank.Name
		end
	end
	if not have then
		return ""
	end
end

local function GetRankImage(rank)
	local id = 8548397383
	
	if rank == "Dev" then
		id = 8702159497
	else if rank == "DevHelp" then
			id = 8702216464
		else if rank == "Friend6" then
				id = 8702219519
			else if rank == "Friend5" then
					id = 8702367315
				else if rank == "Friend4" then
						id = 8702369463
					else if rank == "Friend3" then
							id = 8702371940
						else if rank == "Friend2" then
								id = 8702373737
							else if rank == "Friend1" then
									id = 8702376352
								else
									id = 8548397383
								end
							end
						end
					end
				end
			end
		end
	end
	
	return "rbxassetid://"..id
end

game.Players.PlayerAdded:Connect(function(player)

	local CopyThis = game.Scene.Main.Debug.PlayerFiles
	local PlayerFiles = CopyThis:Clone()
	PlayerFiles.Parent = player

	player.CharacterAdded:Connect(function(character)
		
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
		
		local CopyThis2 = game.Scene.Main.Debug.Objects.PlayerCharacter
		local CopyHere = Instance.new("Folder",game.Scene)
		CopyHere.Name = player.UserId.." Additionally"

		local MyCharacter = CopyThis2:Clone()
		MyCharacter.Parent = CopyHere
		print("Create non global")

		local GlobObj = game.Scene.Main.Debug.Objects.PlayerObjects.PlayerGlobalObj:Clone()
		GlobObj.Parent = game.Scene
		GlobObj.Name = player.UserId.." Global Additionally"
		print("Create global")
		
		local PlayerNicknameObj = GlobObj.PlayerNickname
		PlayerNicknameObj.Parent = Parts.Base
		PlayerNicknameObj.StudsOffsetWorldSpace = Vector3.new(0,4.5,0)
		PlayerNicknameObj.NickName.Text = player.DisplayName
		
		local rank = GetRank(player)
		if rank == "Ban" then
			player:Kick("You are on the ban list of the server!")
		end
		SetPValue(player,"Rank",rank)
		local Credentials = 0
		if rank == "Dev" or rank == "DevHelp" then
			Credentials = 10
		end
		
		SetPValue(player,"Credentials",Credentials)
		
		PlayerNicknameObj.Rank.Image = GetRankImage(rank)

		local humanoid = character:FindFirstChild("Humanoid")
		SetPValue(player,"Stamina",GetPValue(player,"MaxStamina"))
		SetPValue(player,"Oxygen",GetPValue(player,"MaxOxygen"))
		humanoid.Health = GetPValue(player,"MaxHealth")
		SetPValue(player,"DeadType","Unknown")

		local playergui = player:WaitForChild("PlayerGui")
		local freecam = playergui:FindFirstChild("Freecam")
		if freecam then
			freecam:Destroy()
		end
		

	end)

	player:LoadCharacter()
end)



local RS = game.ReplicatedStorage
RS.SetPValue.OnServerEvent:Connect(SetPValue)

local function PlayGlobalSound(player,sound,mode)
	sound.Playing = mode
end
RS.PlayGlobalSound.OnServerEvent:Connect(PlayGlobalSound)

local function SetPosition(player,obj,pos)
	obj.Position = pos
end
RS.SetPosition.OnServerEvent:Connect(SetPosition)
local function RotateHeads(player,cframe)
	local character = player.Character
	if character then
		if GetPValue(player,"NeckY") == 0 then
			warn("NeckY Null")
		else
			local head = character:FindFirstChild("Head")
			if head then


				character:WaitForChild("Head").Neck.C0 = CFrame.new(0,GetPValue(player,"NeckY"),0) * cframe 
			else
				warn("Null Head")
			end

		end else
		warn ("Character Null")
	end
end
local function BackHeads(player)
	local character = player.Character
	if character then
		if GetPValue(player,"NeckY") == 0 then
			warn("NeckY Null")
		else
			local head = character:FindFirstChild("Head")
			if head then

				character:WaitForChild("Head").Neck.C0 = CFrame.new(0,GetPValue(player,"NeckY"),0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
			else
				warn("Null Head")
			end

		end else
		warn ("Character Null")
	end
end

local function Kill(player,leave)
	local DelThis = game.Scene:WaitForChild(player.UserId.." Additionally")
	print("Not Global")
	DelThis:Destroy()
	if leave then
	local DelThis2 = game.Scene:WaitForChild(player.UserId.." Global Additionally")
	print("Global")
		DelThis2:Destroy()
	end
end

local function PlayerDead(player)
	if GetPValue(player,"Dead") then
		if GetPValue(player,"PressRespawn") then
			wait()
			player:LoadCharacter()
			Kill(player)
		end
	end
end

game.Players.PlayerRemoving:Connect(function(player)
	Kill(player,true)
end)

local function SetObjectFrezze(obj,mode)
	if mode == true then

	else

	end
end
local SavedObjects = game.Scene.SavedObjects
local function MakeText(bklt,text,players,pos,color,dwait,transp,textdis,flyspeed)


	RS.MakeText:FireAllClients(bklt,text,pos,color,dwait,transp,textdis,flyspeed)


end

local function GetAllButNotOne(player)
	local players = game:GetService("Players")
	local result = {}

	for _,p in pairs(players:GetPlayers()) do
		if p.UserId ~= player.UserId then
			table.insert(result,p)
		end
	end


	return result
end

local function DestroyJoints(obj,rand)
	if obj then
		if obj.Name == "Base" then

			for _,j in ipairs(obj:GetChildren()) do
				if j:IsA("Motor6D") then
					local random = math.random(0,100)
					if random > rand then
						j:Destroy()
					end
				else
					for _,j2 in ipairs(j:GetChildren()) do
						if j2:IsA("Motor6D") then
							local random = math.random(0,100)
							if random > rand then
								j2:Destroy()
							end
						else
							for _,j3 in ipairs(j2:GetChildren()) do
								if j3:IsA("Motor6D") then
									local random = math.random(0,100)
									if random > rand then
										j3:Destroy()
									end
								else
									for _,j4 in ipairs(j3:GetChildren()) do
										if j4:IsA("Motor6D") then
											local random = math.random(0,100)
											if random > rand then
												j4:Destroy()
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

local function DestroyObjectPairs(obj)
	if obj then
		local tablet
		if type(obj) == "table" then
			tablet = obj
		else
			tablet = obj:GetChildren()
		end
		for _,o in ipairs(tablet) do
			if o:IsA("Decal") then
				o.Transparency = o.Transparency + 0.05
			end
			if o:IsA("Part") or o:IsA("MeshPart") then
				o.Transparency = o.Transparency + 0.05
				--o.Anchored = true
			end 
		end 
	end
end

local function DestroyObject(player,obj)
	if obj then
		DestroyJoints(obj,0)
		for i = 0,20 do
			wait()
			local tablet = obj:GetChildren()
			local model = obj.Parent
			table.insert(tablet,obj)
			if obj.Transparency>=1 or obj==nil then
				if model then
				MakeText({player},player.Name,GetAllButNotOne(player),obj.Position,Color3.new(1,0,0))
					model:Destroy()
					end
			end

			for _,o in ipairs(tablet) do
				for _,o2 in ipairs(o:GetChildren()) do
					for _,o3 in ipairs(o2:GetChildren()) do
						DestroyObjectPairs(o3)
					end
					DestroyObjectPairs(o2)
				end
				DestroyObjectPairs(o)
			end
			DestroyObjectPairs(tablet)
		end end
end

local function ClearAllObjects(player,typ)
	local obj = game.Scene.Map:GetChildren()
	for _,o in pairs(obj) do
		print(o.Name)
		for _,o2 in ipairs(o:GetChildren()) do
			if o2:IsA("IntValue") then
				if o2.Name == "Owner" then
					if typ == nil then
						if o2.Value == player.UserId then
							local Base = o.PrimaryPart
							if Base then
								MakeText({player},player.Name,GetAllButNotOne(player),Base.Position,Color3.new(1,0,0))
							end
							o:Destroy()
						end
					else
						local Base = o.PrimaryPart
						if Base then
							MakeText(nil,"Server",GetAllButNotOne(player),Base.Position,Color3.new(1,0,0))
						end
						o:Destroy()
					end end
			end end
	end
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
	print(#childrens)
	return childrens
end

local function Explosion(pos,power)
	local exp = Instance.new("Explosion",game.Scene.Map)
	exp.Position = pos
	exp.BlastRadius = power
	exp.ExplosionType = Enum.ExplosionType.NoCraters
	exp.DestroyJointRadiusPercent = 0
	print("eXPLOSIV")
end

game.ServerScriptService.Explosive.Event:Connect(Explosion)

local function CreateObject(player,name,pos,rot)
	local OrigObj = SavedObjects:WaitForChild(name)
	if OrigObj then
		local Obj = OrigObj:Clone()
		Obj.Parent = game.Scene.Map

		Obj:SetPrimaryPartCFrame(CFrame.new(pos+Vector3.new(0,2,0)) * CFrame.Angles(math.rad(rot.X),math.rad(rot.Y),math.rad(rot.Z)))
		local Owner = Instance.new("IntValue")
		Owner.Parent = Obj
		Owner.Name = "Owner"
		Owner.Value = player.UserId
		
		local CreateTime = Instance.new("StringValue")
		CreateTime.Parent = Obj
		CreateTime.Name = "CreateTime"
		CreateTime.Value = os.date("%c",os.time())
		
		local Color = Instance.new("BrickColorValue")
		Color.Parent = Obj
		Color.Name = "Color"
		Color.Value = GetPValue(player,"PlayerColor")
		
		local Base = Obj.PrimaryPart
		if Base then
			Base:SetNetworkOwner(player)
			MakeText({player},player.Name,GetAllButNotOne(player),Base.Position,Color3.new(0,1,0))
			
			local objs = Base:GetChildren()
			table.insert(objs,Base)
			
			
			for _,o in ipairs(GetAllChildrens(objs)) do
				if o:IsA("Decal") then
					if o.Name == "DecalColor" then
						o.Color3 = Color.Value.Color
					end
				end
				if o:IsA("Part") or o:IsA("MeshPart") then
					print(o.Name)
					
					if o.Name == "BlockColor" then
						o.BrickColor = Color.Value
					end
					
					local havesound = o:FindFirstChild(o.Name.."Sound")
					if not havesound then
						local sound = game.Scene.Main.Debug.ObjectHit
						local newsound = sound:Clone()
						newsound.Name = o.Name.."Sound"
						newsound.Parent = o
					end
					
					
					local havescript = o:FindFirstChild("PartPhysic")
					if not havescript then
					local scriptt = game.Scene.Main.Debug.PartPhysic
						local newscript = scriptt:Clone()
					newscript.Parent = o
					newscript.Disabled = false
					end
					
				end
			end
		else
			warn(Obj.Name.." Not Have Primary Part")
		end
		if GetPValue(player,"SpawnFroozenObjects") then
			local objs = Base:GetChildren()
			table.insert(objs,Base)
			for _,parts in pairs(objs) do
				if parts:IsA("Part") or parts:IsA("MeshPart") then
					parts.Anchored = true
				end
			end
		end

		SetPValue(player,"SpawnObjectsWait",10)
	else
		warn("Nil Spawn Object")
	end
end
RS.CreateObject.OnServerEvent:Connect(CreateObject)
RS.DestroyObject.OnServerEvent:Connect(DestroyObject)
RS.ClearAllObjects.OnServerEvent:Connect(ClearAllObjects)

local WaterPower = 1
local MakeToThisWaterPower = 1
local Terrain = game.Scene.Terrain
local function FuncWaterPower()
	local pow = 0.001
	if WaterPower > MakeToThisWaterPower then
		WaterPower = WaterPower - pow 
	end

	if WaterPower < MakeToThisWaterPower then
		WaterPower = WaterPower + pow
	end

end

local function SmoothColor(colorOne,colorTwo,times)

	local r1 = colorOne.R
	local g1 = colorOne.G
	local b1 = colorOne.B

	local r2 = colorTwo.R
	local g2 = colorTwo.G
	local b2 = colorTwo.B

	local rBool = true
	local gBool = true
	local bBool = true

	if r1 < r2 then
		rBool = false
		r1 = r1 + times
		wait(times)
		rBool = true
	end

	if r1 > r2 then
		rBool = false
		r1 = r1 - times
		wait(times)
		rBool = true
	end

	if g1 < g2 then
		gBool = false
		g1 = g1 + times
		wait(times)
		gBool = true
	end

	if g1 > g2 then
		gBool = false
		g1 = g1 - times
		wait(times)
		gBool = true
	end

	if b1 < b2 then
		bBool = false
		b1 = b1 + times
		wait(times)
		bBool = true
	end
	if b1 > b2 then
		bBool = false
		b1 = b1 - times
		wait(times)
		bBool = true
	end

	return Color3.new(r1,g1,b1)
end

local function SetWater()
	local pow = 0.001

	if Terrain.WaterTransparency > GetValue("WaterAlpha") then
		SetValue("WaterAlphaNew",GetValue("WaterAlphaNew")- pow)
	end
	if Terrain.WaterTransparency < GetValue("WaterAlpha") then
		SetValue("WaterAlphaNew",GetValue("WaterAlphaNew")+ pow)
	end

	if Terrain.WaterReflectance > GetValue("WaterRef") then
		Terrain.WaterReflectance = Terrain.WaterReflectance - pow
	end
	if Terrain.WaterReflectance < GetValue("WaterRef") then
		Terrain.WaterReflectance = Terrain.WaterReflectance + pow
	end


end

while true do
	wait()
	SetWater()
	Terrain.WaterColor = SmoothColor(Terrain.WaterColor,GetValue("WaterColor"),0.001)

	FuncWaterPower()
	MakeToThisWaterPower = math.abs(GetValue("WindPower"))
	Terrain.WaterWaveSpeed = WaterPower*10+1

	for _,player in pairs(game:GetService("Players"):GetPlayers()) do
		if player then

			local character = player.Character
			if not character or not character.Parent then
				character = player.CharacterAdded:wait()
			end
			if character then
				if not GetPValue(player,"Dead") then
					RotateHeads(player,GetPValue(player,"NeckCFrame"))
				else
					BackHeads(player)
				end
			else
				warn("Not have character")
			end
			PlayerDead(player)
		end
	end
end