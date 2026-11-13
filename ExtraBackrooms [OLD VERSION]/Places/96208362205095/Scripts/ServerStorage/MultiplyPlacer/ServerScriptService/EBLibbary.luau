local baseSERVER = {}

baseSERVER.CreppySound = {"1371567007","149600359","245156785","3474804136","2016700368","9114828835","157636421","9080161598","1268835840","407034089","7641312805","1842432379","9119542307","8877015814","4667262705","5083035644","2019949374"}

baseSERVER.StartPlace = 14492839796

baseSERVER.Data = script.Parent.Data

baseSERVER.PlaceIds = {
	["94"] = 14657441194,
	["0"] = 14492839796
}

function baseSERVER.GetPlaceId(name)
	local newname = name:lower()
	newname = string.gsub(newname," ","")
	newname = string.gsub(newname,"level","")
	if baseSERVER.PlaceIds[newname] ~= nil then
		return baseSERVER.PlaceIds[newname]
	end
	print("Place ["..name.."] It doesn't exist!") 
	return nil
end

function baseSERVER.CheckNPC(obj)
	local result = false
	local npc = nil
	if obj == nil then return result end
	npc = obj:FindFirstChild("NPC") or obj.Parent:FindFirstChild("NPC") or obj.Parent.Parent:FindFirstChild("NPC")
	if npc ~= nil then
		result = npc.Value
	end
	return result
end

--======================

function baseSERVER.NPCCollisions(npc)
	for _, part in pairs(npc:GetDescendants()) do
		if part:IsA("Part") or part:IsA("MeshPart") then
			part.CollisionGroup = "Players"
		end
	end
end

function baseSERVER.RotateNPCHead(npc,target,savedneck)
	--[[if npc == nil then return end
	local rot = nil
	if target ~= nil then
		local camdir = npc.Head.CFrame:ToObjectSpace(target.CFrame).lookVector

		npc.Torso.Neck.C0 = CFrame.new(0,savedneck.Y,0) * CFrame.Angles(-math.acos(camdir.y),0,math.pi)
	end]]
end

function baseSERVER.GetNearPlayer(pos : Vector3 ,dist : number)
	local result = nil
	for i, player in pairs(game.Workspace:GetChildren()) do
		if player:FindFirstChild("Humanoid") and player:IsA("Model") then
				if not baseSERVER.CheckNPC(player) then
					local distance = (pos - player.PrimaryPart.Position).Magnitude
					if distance < dist then
						result = player
					end
				end
		end
	end
	return result
end

local PFS = game:GetService("PathfindingService")
function baseSERVER.MoveTo(npc,pos : Vector3)
	if pos then
		local path = PFS:CreatePath()
		local npcpos = npc.PrimaryPart.Position
		path:ComputeAsync(npcpos,pos)
		local waypoints = path:GetWaypoints()
		for _, waypoint in pairs(waypoints) do
			npc.Humanoid:MoveTo(waypoint.Position)
		end
	end
	wait()
end

--======================

function baseSERVER.GetSettingValue(name,def)
	if game:GetService("ReplicatedStorage"):FindFirstChild("Settings") then
		local s = game:GetService("ReplicatedStorage"):FindFirstChild("Settings")
		if s:FindFirstChild(name) then
			return s:FindFirstChild(name).Value
		end
	end
	return def
end

game:GetService("ReplicatedStorage"):WaitForChild("GetSetting").OnServerInvoke = function(plr,name,def)
	return baseSERVER.GetSettingValue(name,def)
end

function baseSERVER.ChangeStat(plr, stat, SetNum, num)
	if stat:lower() == "health" then
		local char = plr.Character or plr.CharacterAdded:Wait()
		baseSERVER.DetectHurt(char:WaitForChild("Torso"),-num,"nil")
	else
		game:GetService("ReplicatedStorage").ChangeStat:FireClient(plr,stat,SetNum,num)
	end
end

function baseSERVER.CheckPosPlayer(pos)
	if pos == nil then return nil end
	local isplayer = (type(pos) == "userdata")
	if isplayer then
		local char = pos.Character or pos.CharacterAdded:Wait()
		local root = char:WaitForChild("HumanoidRootPart")
		return root.Position
	else
		return pos
	end
end

function baseSERVER.GetItem(plr, item)
	local backpack = plr:WaitForChild("Backpack")
	local count = #backpack:GetChildren()
	local char = plr.Character or plr.CharacterAdded:Wait()
	local toolinarm = char:FindFirstChildOfClass("Tool")
	if toolinarm then
		count += 1
	end
	if count < 9 then
		item.Parent = backpack
		return true
	else
		return false
	end
end

function baseSERVER.PlaySound(player,soundId,volume,Position,Roll,AudioPosStart,Debug)
	if volume == nil then
		volume = 1
	end

	if volume > 0 and soundId ~= nil and soundId ~= "" then
		local soundbase = Instance.new("Part")
		soundbase.Parent = game.Workspace
		if Position ~= nil then
			soundbase.Position = Position
		else
			if player then
				local char = player.Character or player.CharacterAdded:Wait()
				local rootPart = char:WaitForChild("HumanoidRootPart")
				soundbase.Position = rootPart.Position
			end
		end
		soundbase.Anchored = true
		soundbase.CanCollide = false
		soundbase.CanQuery = false
		soundbase.CanTouch = false
		soundbase.Transparency = 1
		soundbase.Name = "RealSound"

		local sound = Instance.new("Sound")
		sound.SoundGroup = game:GetService("SoundService").Basa
		sound.Parent = soundbase
		if soundId:match("rbxassetid://") then
			sound.SoundId = soundId
		else
			sound.SoundId = "rbxassetid://"..soundId
		end
		sound.Volume = volume
		sound.RollOffMode = Enum.RollOffMode.Linear
		if Roll ~= nil then
			if typeof(Roll) == "Vector2" then
				sound.RollOffMaxDistance = Roll.X
				sound.RollOffMinDistance = Roll.Y
			else
				sound.RollOffMaxDistance = Roll[1]
				sound.RollOffMinDistance = Roll[2]
			end
		end

		if AudioPosStart ~= nil then
			sound.TimePosition = sound.TimeLength*AudioPosStart
		end

		sound:Play()
		sound.Ended:Wait()
		if not Debug then
			soundbase:Destroy()
		end
	end
end

baseSERVER.LootingTable = {
	["Level 0"] = {
		{"",10},
		{"Almond Water",10},
		{"Chocolate Bar",5},
		{"Chips",6},
		{"Water",5},
		{"Old Flashlight",4},
		{"Candy",2},
		{"Pill",1},
		{"Flashlight",2},
		{"Knife",1}
	},
	["Level 0 Kitchen"] = {
		{"",5},
		{"Candy",4},
		{"Water",10},
		{"Chips",3},
		{"Chocolate Bar",4},
		{"Almond Water",3},
		{"Pill",1},
		{"Knife",2}
	},
	["Level 0 Rare"] = {
		{"Almond Water",10},
		{"Old Flashlight",7},
		{"Chocolate Bar",5},
		{"Chips",7},
		{"Flashlight",4},
		{"Knife",1},
		{"Pill",5},
		{"Candy",5},
		{"UV Flashlight",2}
	},
	["Level 1"] = {
		{"",10},
		{"Water",10},
		{"Chips",5},
		{"Candy",2},
		{"Chocolate Bar",5},
		{"Almond Water",10},
		{"Old Flashlight",2},
		{"Pill",2},
		{"Flashlight",4}
	},
	["Level 0 Box"] = {
		{"",5},
		{"Water",2},
		{"Chips",3},
		{"Pill",1},
		{"Chocolate Bar",3}
	},
	["Car"] = {
		{"Old Flashlight",4},
		{"Chocolate Bar",10},
		{"Water",1},
		{"Chips",3},
		{"Candy",10},
		{"Flashlight",2},
		{"Knife",1},
		{"Pill",3},
		{"UV Flashlight",2}
	},
	["Trash"] = {
		{"",10},
		{"Candy",4},
		{"Pill",3}
	},
	["Level 27"] = {
		{"",1}
	},
	["Level 6"] = {
		{"",10},
		{"Flashlight",20},
		{"Old Flashlight",15},
		{"UV Flashlight",2},
		{"Water",10},
		{"Chocolate Bar",5}
	},
	["Automat"] = {
		{"Almond Water",1},
		{"Water",1}
	},
	["Only Flashlight"] = {
		{"Flashlight",3},
		{"Old Flashlight",3},
		{"UV Flashlight",1}
	},
	["Cave"] = {
		{"Flashlight",3},
		{"Old Flashlight",3},
		{"UV Flashlight",1}
	}	
}

function baseSERVER.ChangeItemPosition(item,pos)
	item.Handle.CFrame = CFrame.new(pos)
end

function baseSERVER.SpawnItem(item,pos)
	local itemobj = nil
	local items = game:GetService("ReplicatedStorage").Items:GetChildren()
	if item ~= "" then
		for i=1,#items do
			if items[i].Name:lower() == item:lower() then
				itemobj = items[i]:Clone()
			end
		end
	if itemobj then
		itemobj.Parent = game.Workspace
		pos = baseSERVER.CheckPosPlayer(pos)	
		baseSERVER.ChangeItemPosition(itemobj,pos)
		if itemobj.Name == "Pill" then
			local pill_effects = string.split(itemobj.Effects.Value," ")
			itemobj.EffectTop.Value = pill_effects[math.random(1,#pill_effects)]
			itemobj.EffectBottom.Value = pill_effects[math.random(1,#pill_effects)]
		end
		return itemobj
	else
		return false
	end
	end
	
end

baseSERVER.Entites = {
	["Level 0 Dark"] = {
		"Entity 3"
	},
	["Level 0"] = {
		"Entity 10"
	},
	["Cave"] = {
		"Entity 3","Entity 10"
	}
}

function baseSERVER.FullSpawnEntity(entityname,pos)
	local entity = baseSERVER.SpawnEntity(entityname,pos)
	if entity == nil then return nil end
	if entity.Name == "Entity 3" then
		entity.Invisible.Value = (math.random(1,100) > 50)
		entity.AI.Enabled = true
	elseif entity.Name == "Entity 10" then
		entity.AI.Enabled = true
	end
	
	return entity
end

function baseSERVER.SpawnEntity(entity,pos)
	local entityobj = nil
	local entities = game:GetService("ReplicatedStorage").Entities:GetChildren()
	if entity ~= "" and entity ~= nil then
		for i=1, #entities do
			if entities[i].Name:lower() == entity:lower() then
				entityobj = entities[i]:Clone()
			end
		end
		if entityobj == nil then
			for i=1, #entities do
				if string.split(entities[i].Name," ")[2] == entity then
					entityobj = entities[i]:Clone()
				end
			end
		end
	if entityobj then
		entityobj.Parent = game.Workspace
		pos = baseSERVER.CheckPosPlayer(pos)
		if entityobj:IsA("Model") then
			entityobj.PrimaryPart.CFrame = CFrame.new(pos)
		else
			entityobj.CFrame = CFrame.new(pos)
		end
		return entityobj
	else
		print("Admin: Entity ["..entity.."] doesn't exist!")	
		return nil
	end
	end
end

function baseSERVER.SpawnItemToPlayer(item,plr)
	local itemobj = baseSERVER.SpawnItem(item,Vector3.new(-1000,-1000,-1000))
	if itemobj == false then print("Admin: Item ["..item.."] not exsist!") return end
	local can = baseSERVER.GetItem(plr, itemobj)
	if not can then
		itemobj:Destroy()
		print("Admin: Full Inventory ["..plr.Name.."]!")
		return nil
	else
		print("Admin: Player ["..plr.Name.."] Get Item ["..item.."]")
		return itemobj
	end
end

function baseSERVER.Looting(loottype,interact)
	local loottable = loottype
	if typeof(loottype) == "string" then
		loottable = baseSERVER.LootingTable[loottype]
	end
	local newloottable = {}
	for i=1,#loottable do
		local j = loottable[i]
		if typeof(j) == "string" then
			table.insert(newloottable,j)
		else
			for t=1,j[2] do
				table.insert(newloottable,j[1])
			end
		end
	end
	
	baseSERVER.SpawnItem(newloottable[math.random(1,#newloottable)],interact.Position)
	
end

baseSERVER.Sounds = {
	["sharp"] = {"851453784","785201669"},
	["nil"] = {""}, [""] = {""},
	["fall"] = {"8029615457","9113542363","6930015332","9113538216"}
}
function baseSERVER.DetectHurt(part, power, hurttype : string) --[[nil,sharp,fall]]
	local kill = false
	if baseSERVER.CheckNPC(part) then return end
	if not part:IsA("Part") then
		if not part.Parent:IsA("Part") and part.Parent ~= game.Workspace then
			local char = part.Character or part.CharacterAdded:Wait()
			part = char:WaitForChild("Torso")
		end
	end
	if part:IsA("Part") then
		local char = part.Parent
		if char == nil then return end
		if char:FindFirstChildOfClass("Humanoid") then
			local hum = char:FindFirstChildOfClass("Humanoid")
			local player = game:GetService("Players"):GetPlayerFromCharacter(char)
			local bodytype = part.Name
			if part.Name == "Right Arm" or part.Name == "Left Arm" then
				bodytype = "Arm"
			elseif part.Name == "Right Leg" or part.Name == "Left Leg" then
				bodytype = "Leg"
			end
			local bodyhurtmultiply = 1
			if bodytype == "Head" then
				bodyhurtmultiply = 2
			elseif bodytype == "Leg" or bodytype == "Arm" then
				bodyhurtmultiply = 0.5
			end
			
			if typeof(power) == "string" then
				hum.Health = 0
				kill = true
				power = 50
			else
				if power <= 0 then
					hum.Health += -power
				else
					hum.Health -= (power + math.random(0,power*10)/10) * bodyhurtmultiply
					kill = (hum.Health <= 0)
				end
			end
			
			if hurttype ~= nil then
				if baseSERVER.Sounds[hurttype:lower()] ~= "" then
					baseSERVER.PlaySound(player,baseSERVER.Sounds[hurttype:lower()][math.random(1,#baseSERVER.Sounds[hurttype:lower()])], power/50, part.Position,{6,0},nil,true)
				end
			end
		end
	end
	return kill
end

--======================

function baseSERVER.ConvertStringToTable(s,ravno,zapataia,numerations)
	local ravno2 = "="
	local zapataia2 = ","
	if ravno ~= nil then ravno2 = ravno end
	if zapataia ~= nil then zapataia2 = zapataia end
	
	local objs = string.split(s,zapataia2)
	local tabl = {}
	local tabl2 = {}
	for _,i in pairs(objs) do
		if i ~= "" then
		local j = string.split(i,ravno2)
		if numerations then
				tabl[#tabl+1] = j[1]
				tabl2[#tabl2+1] = j[2]
			else
				tabl[j[1]] = j[2]
			end
		end
	end
	if numerations then
		return {tabl,tabl2}
	else
		return tabl
	end
end

function baseSERVER.ConvertTableToString(t,ravno,zapataia)
	local result = ""
	local ravno2 = "="
	local zapataia2 = ","
	if ravno ~= nil then ravno2 = ravno end
	if zapataia ~= nil then zapataia2 = zapataia end
	for stat,i in pairs(t) do
		result = result .. stat .. ravno2 .. tostring(i) .. zapataia2
	end
	return result
end

function baseSERVER.GetData(ply)
	local tabl = {}
	tabl["stat"] = game:GetService("ReplicatedStorage"):WaitForChild("GetSurvivalStat"):InvokeClient(ply)
	tabl["backpack"] = game:GetService("ReplicatedStorage"):WaitForChild("GetInventory"):InvokeClient(ply)
	tabl["gui"] = game:GetService("ReplicatedStorage"):WaitForChild("GetGui"):InvokeClient(ply)

	return tabl
end

function baseSERVER.ConvertStringToBoolean(s)
	if s == "true" then return true else return false end
end

function baseSERVER.ConvertToolToString(tool)
	local result = ""
	local values = {}
	for i,part in pairs(tool:GetDescendants()) do

		if part:IsA("StringValue") or part:IsA("BoolValue") or part:IsA("BrickColorValue") or part:IsA("CFrameValue") or part:IsA("Color3Value") or part:IsA("IntValue") or part:IsA("NumberValue") or part:IsA("ObjectValue") or part:IsA("RayValue") or part:IsA("Vector3Value") then
			values[part.Name] = tostring(part.Value) .. "|" .. part.className
		end
	end
	result = baseSERVER.ConvertTableToString(values,"*","`")
	return result
end

function baseSERVER.SetValuesToItem(item,values)
	print(values)
	local valuestab = baseSERVER.ConvertStringToTable(values,"*","`")
	for i,part in pairs(item:GetDescendants()) do
		if part:IsA("StringValue") or part:IsA("BoolValue") or part:IsA("BrickColorValue") or part:IsA("CFrameValue") or part:IsA("Color3Value") or part:IsA("IntValue") or part:IsA("NumberValue") or part:IsA("ObjectValue") or part:IsA("RayValue") or part:IsA("Vector3Value") then
			
			local value = valuestab[part.Name]
			local valueextra = string.split(value,"|")
			value = valueextra[1]
			local valuetype = valueextra[2]
			if valuetype == "BoolValue" then
				value = baseSERVER.ConvertStringToBoolean(value)
			end
			part.Value = value
		end
	end
end

function baseSERVER.SetData(ply,data)
	local bp = data["backpack"]
	local stat = data["stat"]
	local gui = data["gui"]

	local stats_ = baseSERVER.ConvertStringToTable(stat)
	
	local items = baseSERVER.ConvertStringToTable(bp,"$","%",true)
	wait(1)
	
	for i,item in pairs(items[1]) do
		local it = baseSERVER.SpawnItemToPlayer(item,ply)
		if it ~= nil then
			baseSERVER.SetValuesToItem(it,items[2][i])
		end
	end

	game:GetService("ReplicatedStorage"):WaitForChild("SetSurvivalStat"):FireClient(ply,stats_)
	game:GetService("ReplicatedStorage"):WaitForChild("GetGui"):InvokeClient(ply,true,gui)
end

function baseSERVER.TeleportPlayer(ply,placename,extra)
	local t = game:GetService("TeleportService")
	local id = baseSERVER.GetPlaceId(placename)
	if id == nil then return end
	t:Teleport(id,ply,baseSERVER.ConvertTableToString(baseSERVER.GetData(ply),"~",";"))
end

function baseSERVER.PlayerJoin(plr)
	local data = plr:GetJoinData().TeleportData
	if data ~= nil then
		baseSERVER.SetData(plr,baseSERVER.ConvertStringToTable(data,"~",";"))
	end
end

game.Players.PlayerAdded:Connect(baseSERVER.PlayerJoin)

--======================

game:GetService("ReplicatedStorage").DetectHurt.OnServerEvent:Connect(function(plr,part, power, hurttype : string)
	baseSERVER.DetectHurt(part,power,hurttype)
end)
game:GetService("Players").PlayerAdded:Connect(function(player)
	print("Admin: Player ["..player.Name.." ("..player.UserId..")] Joined!")
	player.CharacterAdded:Connect(function(character)
		character:WaitForChild("Humanoid").Died:Connect(function()
			
			--baseSERVER.SetData(player,baseSERVER.ConvertStringToTable(baseSERVER.ConvertTableToString(baseSERVER.GetData(player),"~",";"),"~",";"))
			
			print("Admin: Player ["..character.Name.."] Died!")
		end)
		
	end)
end)

game:GetService("Players").PlayerRemoving:Connect(function(player)
	print("Admin: Player ["..player.Name.." ("..player.UserId..")] Leaved!")
end)
return baseSERVER
