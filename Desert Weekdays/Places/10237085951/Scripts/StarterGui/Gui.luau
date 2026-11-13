local StarterGui = game:GetService("StarterGui")
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local Values = PlayerGui:WaitForChild("Values")
local InventoryGUI = PlayerGui:WaitForChild("Inventory")
InventoryGUI.Enabled = false
local FreeCam = PlayerGui:FindFirstChild("Freecam")
if FreeCam ~= nil then
	FreeCam:Destroy()
end

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
UserInputService.MouseIconEnabled = false

local InventoryOpen_TAB = Enum.KeyCode.Tab
local InventoryOpen_E = Enum.KeyCode.E
local InventoryOpen_I = Enum.KeyCode.I

local function OpenOrCloseInventory(keycode)
	local InvBool = Values.InventoryOpen
	if keycode == Enum.KeyCode.Escape then
		if InvBool.Value == true then
			InvBool.Value = false
		else
			return
		end
	else
		InvBool.Value = not InvBool.Value
	end
	
	InventoryGUI.Enabled = InvBool.Value
	UserInputService.MouseIconEnabled = InvBool.Value
end

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == InventoryOpen_TAB or input.KeyCode == InventoryOpen_E or input.KeyCode == InventoryOpen_I or input.KeyCode == Enum.KeyCode.Escape then
		OpenOrCloseInventory(input.KeyCode)
	end
end)