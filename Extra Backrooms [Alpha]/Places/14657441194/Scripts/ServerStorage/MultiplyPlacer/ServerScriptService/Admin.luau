local AdminsData = game:GetService("ServerStorage").Admins
local Players = game:GetService("Players")
local woowz11 = "1734081766"
local EBL = require(game:GetService("ServerScriptService"):WaitForChild("EBLibbary"))

local bools = {
	["true"] = true,
	["false"] = false,
	["enable"] = true,
	["disable"] = false,
	["on"] = true,
	["off"] = false,
	["yes"] = true,
	["no"] = false,
	["y"] = true,
	["n"] = false,
	["1"] = true,
	["0"] = false
}

local function GetPlayers()
	return Players:GetPlayers()	
end

local function GetPlayer(name,accetpEveryone)
	if bools[name] ~= nil then return nil end
	if name == "" or name == nil then return nil end
	if accetpEveryone and (name:lower() == "all" or name:lower() == "everyone") then
		return Players:GetPlayers()	
	else
		for _, plr in pairs(Players:GetPlayers()) do
		if plr.Name:lower() == name:lower() then
			return plr
		end
		
		if plr.DisplayName:lower() == name:lower() then
			return plr
		end
	end
	end
	print("Admin: Player ["..name.."] not found!")
	return nil
end

local function GetBool(bool)
	if bool == nil then return nil end
	local itsplayer = GetPlayer(bool,true)
	if bools[bool:lower()] ~= nil then
		return bools[bool:lower()]
	end
	if not itsplayer then
		print("Admin: Bool ["..tostring(bool).."] It doesn't exist! (Try [true,false; enable,disable; on,off; y,n; 1,0])")
		return "error"
	else
		return nil
	end
end

local function CheckOP(player)
	for _, tag in pairs(AdminsData:GetChildren()) do
		if tag.Value == tostring(player.UserId) then
			return true
		end
	end
	return false
end

local function CheckPlayer(player)
	if player == nil then return false end
	return (type(player) == "userdata")
end

local function ChangeOP(plr,bool,mainplr)
	if plr then
		if bool then --[[OP]]
			for _, tag in pairs(AdminsData:GetChildren()) do
				if tag.Value == tostring(plr.UserId) then
					print("Admin: Alredy have ["..tag.Name.."]")
					return
				end
			end
			
			local newtag = Instance.new("StringValue")
			newtag.Name = plr.Name
			newtag.Value = plr.UserId
			newtag.Parent = AdminsData
			print("Admin: Player ["..plr.Name.."] get op!")
		else --[[DEOP]]
			for _, tag in pairs(AdminsData:GetChildren()) do
				if tag.Value == tostring(plr.UserId) then
					if tostring(plr.UserId) == woowz11 then print("Admin: You can't") return end
					tag:Destroy()
					print("Admin: Player ["..plr.Name.."] clear op!")
				end
			end
		end
	end
end

local function TeleportChar(pos1,pos2)
	if pos1.UserId == pos2.UserId then return end
	local char1 = pos1.Character or pos1.CharacterAdded:Wait()
	local char2 = pos2.Character or pos2.CharacterAdded:Wait()
	if char1:FindFirstChild("HumanoidRootPart") == nil then return end
	if char2:FindFirstChild("HumanoidRootPart") == nil then return end
	local Position1 = char1:WaitForChild("HumanoidRootPart").Position
	local Position2 = char2:WaitForChild("HumanoidRootPart").Position

	char1:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Position2)
	print("Admin: Player ["..pos1.Name.."] Teleported to ["..pos2.Name.."]")
end

local function Teleport(pos1,pos2)
	if pos1 and pos2 then
		if typeof(pos1) == "Instance" then
			TeleportChar(pos1,pos2)
		else
			print("Admin: Teleported Everyone's Playes to ["..pos2.Name.."]")
			for i,plr in pairs(pos1) do
				TeleportChar(plr,pos2)
			end
		end
		
	end
end

local function ChangeLighting(plr,bool)
	if bool ~= nil then
		print("Admin: Light Change Player ["..plr.Name.."] to ["..tostring(bool).."]")
	else
		print("Admin: Light Change Player ["..plr.Name.."]")
	end
	game:GetService("ReplicatedStorage").ADMINchangeLighting:FireClient(plr,bool)
end

local function Command(com,other,mainplayer,fullmsg)
	
	if com == "op" then 
		if other[2] == nil then return true end 
		if tostring(mainplayer.UserId) == woowz11 then	
			ChangeOP(GetPlayer(other[2]),true)
		end
		return true
	elseif com == "deop" then
		if other[2] == nil then return true end
		if GetPlayer(other[2]) == nil then return end
		if tostring(mainplayer.UserId) == woowz11 or tostring(mainplayer.UserId) == tostring(GetPlayer(other[2]).UserId) then	
			ChangeOP(GetPlayer(other[2]),false)
		end
		return true
	elseif com == "tp" or com == "teleport" or com == "t" then
		local plr1 = other[2]
		local plr2 = GetPlayer(other[3])
		
		if plr2 == nil then
			plr2 = GetPlayer(plr1)
			plr1 = GetPlayer(mainplayer.Name)
		else
			plr1 = GetPlayer(plr1,true)
		end
		
		Teleport(plr1,plr2)
		return true
	elseif com == "light" or com == "lighting" or com == "l" then
		local plr = GetBool(other[2])
		if plr == nil then
			if other[2] == nil then
				ChangeLighting(mainplayer,nil)
				return true
			else
				local plr = GetPlayer(other[2],true)
				if CheckPlayer(plr) then
					ChangeLighting(GetPlayer(other[2]),GetBool(other[3]))
					return true
				else
					for _, plr2 in pairs(plr) do
						ChangeLighting(plr2,GetBool(other[3]))
					end
					return true
				end
			end
		else
			ChangeLighting(mainplayer,plr)
			return true
		end
	elseif com == "spawnitem" or com == "getitem" or com == "giveitem" or com == "item" or com == "give" or com == "i" then
		local plr = GetPlayer(other[2],true)
		local item = string.gsub(fullmsg,"/"..com.." "..other[2].." ","")
		print("Admin: Operator ["..mainplayer.Name.."] Tries to give the Item ["..item.."] to ["..other[2].."]")
		if CheckPlayer(plr) then
			EBL.SpawnItemToPlayer(item,plr)
		else
			if plr == nil then return true end
			print("Admin: Operator ["..mainplayer.Name.."] Give Item ["..item.."] To All")
			for _,plr2 in pairs(plr) do
				EBL.SpawnItemToPlayer(item,plr2)
			end
		end
		return true
	elseif com == "creppysound" or com == "creppy" or com == "scream" or com == "scary" or com == "c" then
		local plr = mainplayer
		if other[2] ~= nil then plr = GetPlayer(other[2],true) end
		if CheckPlayer(plr) then
			print("Admin: Creppy Sound Playing to Player ["..plr.Name.."]")
			EBL.PlaySound(plr,EBL.CreppySound[math.random(1,#EBL.CreppySound)],math.random(1,10)/10,nil,{8,0},nil,true)	
		else
			local onesound = EBL.CreppySound[math.random(1,#EBL.CreppySound)]
			for _, plrs in pairs(plr) do
				print("Admin: Creppy Sound Playing to Player ["..plrs.Name.."]")
				EBL.PlaySound(plrs,onesound,math.random(1,10)/10,nil,{8,0})	
			end
		end
		
		return true
	elseif com == "checkop" or com == "operators" or com == "ops" then
		local plr2 = GetPlayer(other[2],true)
		if plr2 == nil then plr2 = GetPlayers() end
		if CheckPlayer(plr2) then
			if CheckOP(plr2) then
				print("Admin: Player ["..plr2.Name.."] Have OP!")
			else
				print("Admin: Player ["..plr2.Name.."] NOT Have OP!")
			end
		else
			for _,plr in pairs(plr2) do
				if CheckOP(plr) then
					print("Admin: Player ["..plr.Name.."] Have OP!")
				else
					print("Admin: Player ["..plr.Name.."] NOT Have OP!")
				end
			end
		end
		return true
	elseif com == "stat" or com == "changestat" then
		local itsop = (tostring(mainplayer.UserId) == woowz11)
		local plr = GetPlayer(other[2],itsop)
		if tostring(mainplayer.UserId) ~= woowz11 then
			if tostring(plr.UserId) == woowz11 then print("Admin: You can't") return end
		end 
		local stat = other[3]
		local num = other[4]
		if plr == nil or stat == nil or num == nil then return true end
		num = tonumber(num) or "Error"
		if num == "Error" then return true end
		if (num > 1000 and stat:lower() ~= "health") or num < 0 then return true end
		
		local function ChangePlr(plr3)
			local char = plr3.Character or plr3.CharacterAdded:Wait()
			local hum = char:WaitForChild("Humanoid")
			if stat:lower() == "health" and num > hum.MaxHealth*10 then return true end
			print("Admin: Operator ["..mainplayer.Name.."] Change Player ["..plr3.Name.."] Stat ["..stat.." -> "..tostring(num).."]")
			if stat:lower() == "health" then
				hum.Health = num/10
			else
				EBL.ChangeStat(plr3,stat,true,num)
			end
		end
		
		if CheckPlayer(plr) then
			ChangePlr(plr)
		else
			for _, plr2 in pairs(plr) do
				ChangePlr(plr2)
			end
		end
		return true
	elseif com == "kill" or com == "k" then
		local plr = GetPlayer(other[2])
		if plr == nil then plr = mainplayer end
		if tostring(mainplayer.UserId) ~= woowz11 then
			if tostring(plr.UserId) == woowz11 then print("Admin: You can't") return end
		end 
		EBL.DetectHurt(plr,"kill","")
		return true
	elseif com == "fixstat" or com == "maxstat" or com == "fillstat" or com == "newstat" or com == "s" then
		local plr = GetPlayer(other[2],true)
		if plr == nil then plr = mainplayer end
		if CheckPlayer(plr) then
			local char = plr.Character or plr.CharacterAdded:Wait()
			local hum = char:WaitForChild("Humanoid")
			hum.Health = hum.MaxHealth
			EBL.ChangeStat(plr,"stamina",true,1000)
			EBL.ChangeStat(plr,"water",true,1000)
			EBL.ChangeStat(plr,"food",true,1000)
			EBL.ChangeStat(plr,"mental",true,1000)
		else
			for _, plrs in pairs(plr) do
				local char2 = plrs.Character or plrs.CharacterAdded:Wait()
				local hum2 = char2:WaitForChild("Humanoid")
				hum2.Health = hum2.MaxHealth
				EBL.ChangeStat(plrs,"stamina",true,1000)
				EBL.ChangeStat(plrs,"water",true,1000)
				EBL.ChangeStat(plrs,"food",true,1000)
				EBL.ChangeStat(plrs,"mental",true,1000)
			end
		end
		return true
	elseif com == "spawn" or com == "spawnentity" or com == "entity" or com == "e" then
		local plr = GetPlayer(other[2])
		if plr == nil then return end
		local entity = string.gsub(fullmsg,"/"..com.." "..other[2].." ","")
		local can = EBL.FullSpawnEntity(entity,plr)
		if can then
			print("Admin: Operator ["..mainplayer.Name.."] Spawn Entity ["..entity.."]")
		end
		return true
	end
	return false
end

game:GetService("ReplicatedStorage").GetAdmins.OnServerInvoke = function()
	local newadmins = {}
	for _,adm in pairs(AdminsData:GetChildren()) do
		table.insert(newadmins,adm.Value)
	end
	return table.concat(newadmins,"~")
end

local function Chatted(Player)
	Player.Chatted:Connect(function(msg)
		local plroptext = "[Admin] "
		if not CheckOP(Player) then
			plroptext = ""
		end 
		print("-- "..plroptext..Player.Name..": "..msg)
		local message = string.split(msg," ")
		local startsymbol = message[1]:sub(1,1)
		if startsymbol ~= "/" then return end
		local command = message[1]:sub(2)
		if not CheckOP(Player) then return end
		local have = Command(command:lower(),message,Player,msg)
		if have == false then
			if command == "" then return end
			print("Command ["..command.."] doesn't exist!")
		end
	end)
end

for _, player in game.Players:GetPlayers() do
	task.spawn(function()
		Chatted(player)
	end)
end

game.Players.PlayerAdded:Connect(Chatted)