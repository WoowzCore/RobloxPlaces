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

local World = game.World
local Weather = game.Weather
local Clouds = World.Terrain.Clouds

local function MakeRandomStartCloud()
	Clouds.Cover = math.random(0,100)/100
	Clouds.Density = math.random(0,100)/100
	Clouds.Color = Color3.new(1,1,1)
end



local function Start()
	MakeRandomStartCloud()
end
Start()