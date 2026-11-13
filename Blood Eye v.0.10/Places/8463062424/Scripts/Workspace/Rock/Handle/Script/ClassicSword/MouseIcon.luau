--Made by Luckymaxer

local Mouse_Icon = "rbxasset://textures/GunCursor.png"
local Reloading_Icon = "rbxasset://textures/GunWaitCursor.png"

local Tool = script.Parent

local Mouse = nil

local function UpdateIcon()
	if Mouse then
		Mouse.Icon = Tool.Enabled and Mouse_Icon or Reloading_Icon
	end
end

local function OnEquipped(ToolMouse)
	Mouse = ToolMouse
	UpdateIcon()
end

local function OnChanged(Property)
	if Property == "Enabled" then
		UpdateIcon()
	end
end

Tool.Equipped:Connect(OnEquipped)
Tool.Changed:Connect(OnChanged)
