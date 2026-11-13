--[[========================================================]]
local function GetValue(name)
	local value = game.Scene.Main.GlobalValues:WaitForChild(name)
	return value.Value
end
local function SetValue(name,val)
	local value = game.Scene.Main.GlobalValues:WaitForChild(name)
	value.Value = val
end
local function GetPlayerValue(name)
	local value = game:GetService("Players").LocalPlayer:WaitForChild("PlayerValues"):WaitForChild(name)
	return value.Value
end
local function SetPlayerValue(name,val)
	game.RStorage.SetPlayerValue:FireServer(name,val)
	wait()
end
--[[========================================================]]

local player = game:GetService("Players").LocalPlayer
local mouse = player:GetMouse()

local Inventory = script.Parent

local SavedsUI = Inventory.Saved

local BlankGRID = SavedsUI.GRID

local Grids = {}

local GUI = Inventory.Parent.Parent

local function GetGridInfo(gridobj)
	local result = nil
	for _,grid in pairs(Grids) do
		if grid.grid == gridobj then
			result = grid
		end
	end
	return result
end

local function CreateBlankGRID(where)
	local GRID = BlankGRID:Clone()
	GRID.Visible = true
	GRID.Parent = where

	local GridInfo = {
		parent = where;
		obj = nil;
		grid = GRID;
	}

	table.insert(Grids,GridInfo)
end

local function LoadedGrids()
	local test = Inventory.GRIDS_Humanoid.Items

	for i=0,8 do
		CreateBlankGRID(test)
	end

end
LoadedGrids()

local function GetNilGRID()
	local GRID = nil

	for _,grid in ipairs(Grids) do
		if grid.obj == nil then
			return grid
		end
	end

	return GRID
end

local function ClearGRID(grid)
	grid.obj = nil
	grid.grid.ItemButton.ImageColor3 = Color3.new(1,1,1)
end

local function SetObjInGRID(obj,grid)
	grid.obj = obj
	grid.grid.ItemButton.ImageColor3 = Color3.new(0.2,0.2,0.2)
end

local RS = game.RStorage

local function PickUpThis(obj)
	local directionId = ""
	if GetPlayerValue("NowMoveLeftArm") then
		directionId = "2"
	end
	local grid = GetNilGRID()
	if grid ~= nil then
		if GetPlayerValue("ObjectInHand"..directionId) == nil then
		RS.SetObjectInArm:FireServer(obj)
			SetPlayerValue("ObjectInHand"..directionId,obj)
			
	else
		RS.MakeObjectInPlayerData:FireServer(obj)
		print(obj.Name.." Picked!")
		SetObjInGRID(obj,grid)
		end
	else
		if GetPlayerValue("ObjectInHand"..directionId) == nil then
			RS.SetObjectInArm:FireServer(obj)
			SetPlayerValue("ObjectInHand"..directionId,obj)
		end
	end
end
RS.PickUpThis.OnClientEvent:Connect(PickUpThis)

local function ShowObject(obj,bool)
	if bool then
		RS.MakeObjectInServerData:FireServer(obj)
	else
		RS.MakeObjectInPlayerData:FireServer(obj)
	end
end

local function MakeObjectInArm(obj,drop)
	RS.SetObjectInArm:FireServer(obj,drop)
end

local function GetObjectInHand(gridobj)
	local directionId = ""
	if GetPlayerValue("NowMoveLeftArm") then
		directionId = "2"
	end
	
	print(gridobj.Name)
	local grid = GetGridInfo(gridobj)
	local obj = grid.obj
	ClearGRID(grid)
	
	if obj then
		ShowObject(GetPlayerValue("ObjectInHand"..directionId),false)
		MakeObjectInArm(nil)
		MakeObjectInArm(obj)
		ShowObject(obj,true)
	else
		ShowObject(GetPlayerValue("ObjectInHand"..directionId),false)
		MakeObjectInArm(nil)
	end
	
	if GetPlayerValue("ObjectInHand") ~= nil then
		SetObjInGRID(GetPlayerValue("ObjectInHand"..directionId),grid)
	end

	SetPlayerValue("ObjectInHand"..directionId,obj)
end

local function GetMouseGRID()
	local result = nil
	local pos = GetPlayerValue("MouseInGRID")
	if pos then
	local GUIObjects = GUI:GetGuiObjectsAtPosition(pos.x,pos.y)
		local gui = GUIObjects[1]
		if gui then
			local maybeGRID = gui.Parent
			if maybeGRID then
				if maybeGRID.Name == "GRID" then
					result = maybeGRID
				end
			end
		end
	end
	return result
end

local function GRIDUpdate()
	local GUIObjects = GUI:GetGuiObjectsAtPosition(mouse.X,mouse.Y)
	local gui = GUIObjects[1]

	local result = Vector3.zero
	if gui then
		local maybeGRID = gui.Parent
		if maybeGRID then
			if maybeGRID.Name == "GRID" then
				result = Vector3.new(mouse.X,mouse.Y,0)
			end
		end
	end
	SetPlayerValue("MouseInGRID",result)
end

game:GetService("UserInputService").InputBegan:Connect(function(input,InChat)
	if GetMouseGRID() ~= nil then
		if input.UserInputType == Enum.UserInputType.MouseButton1 then

			GetObjectInHand(GetMouseGRID())

		end
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	GRIDUpdate()
	
	Inventory.GRIDS_Humanoid.Visible = GetPlayerValue("InventoryOpen")
	
end)

