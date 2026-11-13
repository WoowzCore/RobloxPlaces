wait(0.2)

local RS = game.ReplicatedStorage.Global
local PlayersSaves = game:GetService("DataStoreService")
local PlayerData = PlayersSaves:GetDataStore("PlayerData")
local PlayerStarter = game.Workspace.MainFolder.PlayerStarter

local function IsValueSave(value)--Узнаёт переменная должная сохранятся или нет
	local value2 = string.gsub(value,"S_","")
	local value3 = string.gsub(value,value2,"")
	if value3 == "S_" then
		return true
	else
		return false
	end
end

local function LoadPValue(player,name,value)--Сохраняет переменную
	local valueObj = player.PlayerStarter.Values:WaitForChild(name)
	valueObj.Value = value
end
local function GetPValue(player,name)--Загружает переменную
	local valueObj = player.PlayerStarter.Values:WaitForChild(name)
	return valueObj.Value
end

local function PlayerLoadingValues(player, values)--Загружает в игрока переменные
	
	for i, v in pairs(values:GetChildren()) do
		if IsValueSave(v.Name) then
			local data = PlayerData:GetAsync(player.UserId.."_KeyValue_"..string.gsub(v.Name,"S_",""))
			if data then
			v.Value = data
			end
		end
	end
	
end

local function PlayerSavingValues(player, values)--Сохраняет переменные игрока
	for i, v in pairs(values:GetChildren()) do
		if IsValueSave(v.Name) then
			PlayerData:SetAsync(player.UserId.."_KeyValue_"..string.gsub(v.Name,"S_",""),v.Value)
			print(player.Name.." : Value ["..string.gsub(v.Name,"S_","").."] Saved in ("..v.Value..")")
		end
	end
end

local function GetCharacter(player)
	if player:WaitForChildren("Character") then
		return player:WaitForChildren("Character")
	end
end

local function GetPlayerPart(player, part)
	return GetCharacter(player):WaitForChild(part);
end

local function GetPlayerBase(player)
	return GetPlayerPart(player, "HumanoidRootPart")
end

local function PlayerTeleport(player, pos)
	GetPlayerBase(player).Position = pos
end

local function PlayerJoinFunction(player)
	PlayerTeleport(player, GetPValue(player,"S_LastLocation"))
end

local function PlayerJoin(player)--Когда игрок заходит на сервер
	local PlayerStarterNEW = PlayerStarter:Clone()
	PlayerStarterNEW.Parent = player
	local PlayerValues = PlayerStarterNEW.Values
	
	PlayerLoadingValues(player,PlayerValues)
	PlayerJoinFunction(player)
	
end

local function PlayerExit(player)--Когда игрок выходит с сервера
	PlayerSavingValues(player, player.PlayerStarter.Values)
end

local function AllConnections()--Подключает functions

	local Ps = game.Players
	Ps.PlayerAdded:Connect(PlayerJoin)
	Ps.PlayerRemoving:Connect(PlayerExit)

end
AllConnections()

local function PlayerValues(player,parts)--Update функция игрока
	if player.Character.HumanoidRootPart then
	LoadPValue(player, "S_ID", player.UserId)
	LoadPValue(player,"PlayerPosition",parts.Base.Position)
	LoadPValue(player,"S_LastLocation",GetPValue(player,"PlayerPosition"))
	end
end

local function SaveInRS()--Подключает к RS
	RS.PlayerValues.OnServerEvent:Connect(PlayerValues)
end
SaveInRS()
