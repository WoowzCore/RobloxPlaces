local InventoryGUI = script.Parent
local PlayerGui = InventoryGUI.Parent
local Player = PlayerGui.Parent
local UserInputService = game:GetService("UserInputService")
local Values = PlayerGui:WaitForChild("Values")
local RS = game:GetService("ReplicatedStorage")
local DropTool_RS = RS.DropTool
local Backpack = PlayerGui.Parent.Backpack

function UpdateToolsInArm()
	local RightArm_Tool = InventoryGUI.RightArm.Object.Value
	local LeftArm_Tool = InventoryGUI.LeftArm.Object.Value

	Values.Data.RightArm_tool.Value = RightArm_Tool
	Values.Data.LeftArm_tool.Value = LeftArm_Tool

	ChangeTool(RightArm_Tool,"Right")
	ChangeTool(LeftArm_Tool,"Left")
end

function ClearToolInCell(cell)
	local Cell = PlayerGui.Inventory:WaitForChild(cell)
	Cell.Object.Value = nil
	Cell.Image = Values.Data.Null_Inventory_Cell.Value
end

function SetToolInCell(tool,cell)
	if tool ~= nil then
	tool.Inventory_ID.Value = cell
	local cell = PlayerGui.Inventory:WaitForChild(cell)
	cell.Object.Value = tool
	local Icon = tool:FindFirstChild("Icon")
	local Icon_result = Values.Data.Error_Texture.Value
	if Icon ~= nil then
		Icon_result = Icon.Value
	end
		cell.Image = Icon_result
	else
		ClearToolInCell(cell)
	end
	UpdateToolsInArm()
end

function ChangeTool(tool,arm)
	RS.ChangeTool:FireServer(tool,arm)
end

function GetTool(tool)
	local inv_cell_id = "LeftArm"
	local leftarm_no = false
	if InventoryGUI.LeftArm.Object.Value ~= nil then
		inv_cell_id = "RightArm"
		leftarm_no = true
	end
	if inv_cell_id == "LeftArm" and leftarm_no then
		return nil
	else
		SetToolInCell(tool,inv_cell_id)
	end
	UpdateToolsInArm()
end
RS.GetTool.OnClientEvent:Connect(GetTool)

function DropTool(Slot_id)
	local Cell = PlayerGui.Inventory:WaitForChild(Slot_id)
	local Tool = Cell.Object.Value
	DropTool_RS:FireServer(Tool)
	ClearToolInCell(Slot_id)
	UpdateToolsInArm()
end

local PlayerPressedMouse1 = false

local SavedAnchorPoint = Vector2.zero
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local MousePos = Vector3.zero
local MousePosAlt = UDim2.new(0,0,0,0)

function UpdateMouse()
	MousePos = Vector3.new(Mouse.X,Mouse.Y,0)
	MousePosAlt = UDim2.new(MousePos.X/workspace.CurrentCamera.ViewportSize.X,0,MousePos.Y/workspace.CurrentCamera.ViewportSize.Y,0)
end

function SetPlayerPressedMouse(bool)
	local val = Values.Player_pressed_mouse1
	if val.Value ~= bool then
		val.Value = bool
		if Values.Player_take_cell.Value ~= nil then
			if not bool then
				if Values.Cursor_on_cell.Value == nil then
					DropTool(Values.Player_take_cell.Value.Name)
				else
					if Values.Cursor_on_cell.Value ~= Values.Player_take_cell.Value then
						local FirstTool = Values.Cursor_on_cell.Value.Object.Value
						local SecondTool = Values.Player_take_cell.Value.Object.Value
						local FirstId = Values.Cursor_on_cell.Value.Name
						local SecondId = Values.Player_take_cell.Value.Name
						SetToolInCell(FirstTool,SecondId)
						SetToolInCell(SecondTool,FirstId)
					end
				end
				Values.Player_take_cell.Value.ImageTransparency = 0
				Values.Player_take_cell.Value = nil
			else
				local Cell = Values.Player_take_cell.Value
				Cell.ImageTransparency = 1
				UpdateMouse()
				SavedAnchorPoint = Vector2.new(MousePosAlt.Width.Scale*10-Cell.Position.Width.Scale*10,0.1)
			end
		end
	end
end

local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input,gameP)
	if Values.InventoryOpen.Value then
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			SetPlayerPressedMouse(true)
		end
	end
end)
UIS.InputEnded:Connect(function(input,gameP)
	if Values.InventoryOpen.Value then
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			SetPlayerPressedMouse(false)
		end
	end
end)

local TakenCell = InventoryGUI.TakenCell
function TakenCellUpdate()
	UpdateMouse()
	local OrigCell = Values.Player_take_cell.Value
	TakenCell.AnchorPoint = SavedAnchorPoint
	TakenCell.Image = OrigCell.Image
	TakenCell.Position = MousePosAlt

end

while wait() do
	if not Values.InventoryOpen.Value then
		SetPlayerPressedMouse(false)
		Values.Cursor_on_cell.Value = nil
	else
		if Values.Player_take_cell.Value ~= nil then
			TakenCellUpdate()
			TakenCell.Visible = true
		else
			TakenCell.Visible = false
		end
	end
end