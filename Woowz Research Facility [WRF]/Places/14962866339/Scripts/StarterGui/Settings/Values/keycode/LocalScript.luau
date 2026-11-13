local setting = script.Parent
local changed = false
local u = game:GetService("UserInputService")
local m = game.Players.LocalPlayer:GetMouse()
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local plrbase = require(chr:WaitForChild("PlayerBase"))

local function ConvertKeycodeToString(key)
	return string.split(tostring(key),".")[#string.split(tostring(key),".")]
end
local selectedkey = Enum.KeyCode[string.gsub(setting.Value.Value,"%(KEYCODE%)","")]

local function isHoveringOverObj(obj)
	local tx = obj.AbsolutePosition.X
	local ty = obj.AbsolutePosition.Y
	local bx = tx + obj.AbsoluteSize.X
	local by = ty + obj.AbsoluteSize.Y
	return (m.X >= tx and m.Y >= ty and m.X <= bx and m.Y <= by)
end

local function upd()
	if setting.Value.Value == "" then return end
	selectedkey = Enum.KeyCode[string.gsub(setting.Value.Value,"%(KEYCODE%)","")]
	setting.TextButton.Text = ConvertKeycodeToString(selectedkey)
	wait(0.01)
	changed = false
	plrbase.SettingsChangeKeyCode = false
end

setting.Value:GetPropertyChangedSignal("Value"):Connect(function()
	upd()
end)

u.InputBegan:Connect(function(key,chat)
	if key.UserInputType == Enum.UserInputType.MouseButton1 then
		if isHoveringOverObj(setting.TextButton) and setting.Parent.Visible then
			if changed then return end
			changed = true
			plrbase.SettingsChangeKeyCode = true
			setting.TextButton.Text = "Press Key"
		else
			setting.TextButton.Text = ConvertKeycodeToString(selectedkey)
			changed = false
		end
	end
	
	if chat then return end
	if changed then
		if key.UserInputType == Enum.UserInputType.Keyboard then
			if setting.Value.Value == "(KEYCODE)"..ConvertKeycodeToString(key.KeyCode) then upd() end
			setting.Value.Value = "(KEYCODE)"..ConvertKeycodeToString(key.KeyCode)
			setting.TextButton.Text = ConvertKeycodeToString(selectedkey)
		end
	end
end)

local maingui = script.Parent.Parent.Parent.Parent.Parent.Parent
maingui:GetPropertyChangedSignal("Visible"):Connect(function()
	if maingui.Visible == false then
		selectedkey = Enum.KeyCode[string.gsub(setting.Value.Value,"%(KEYCODE%)","")]
		setting.TextButton.Text = ConvertKeycodeToString(selectedkey)
		wait(0.01)
		changed = false
		plrbase.SettingsChangeKeyCode = false
	end
end)