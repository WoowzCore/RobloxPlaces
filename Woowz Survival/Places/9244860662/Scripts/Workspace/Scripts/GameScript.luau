--######################################################################
local function SetValue(name, value)
	local V = workspace.Map_Values:WaitForChild(name)
	if V == nil then
		print("Global value ["..name.."] can't find")
	else
		V.Value = value
	end
end

local function GetValue(name)
	local V = workspace.Map_Values:WaitForChild(name)
	if V == nil then
		print("Global value ["..name.."] can't find")
		return nil
	else
		return V.Value
	end
end

local function SetPValue(player,name,value)
	local V = player:WaitForChild("PlayerScripts"):WaitForChild("Values"):WaitForChild(name)
	if V == nil then
		print("Player ["..player.Name.."] value ["..name.."] can't find")
		return nil
	else
		V.Value = value
	end
end

local function GetPValue(player,name)
	local V = player:WaitForChild("PlayerScripts"):WaitForChild("Values"):WaitForChild(name)
	if V == nil then
		print("Player ["..player.Name.."] value ["..name.."] can't find")
		return nil
	else
		return V.Value
	end
end
--######################################################################
local GameStarted = false

local World = game.World
local Weather = game.Weather

local function StartGame()
	GameStarted = true
	SetValue("Game_Started",true)
end
local function StopGame()
	GameStarted = false
	SetValue("Game_Started",false)
	SetValue("Game_Time",0.01)
	SetValue("Game_Day",0)
end

local function NextDay()
	SetValue("Game_Day",GetValue("Game_Day")+1)
	
	
end

StartGame()
while wait() do
	if GameStarted  then
		SetValue("Game_Time",GetValue("Game_Time")+1)
		
	end
end