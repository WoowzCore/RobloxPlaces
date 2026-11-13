local plrbase = require(script.Parent.PlayerBase)
local uts = game:GetService("UserInputService")
local sgui = game:GetService("StarterGui")
sgui:SetCore("ResetButtonCallback",false)

local plr = game:GetService("Players").LocalPlayer

plrbase.Mouse.Icon = "rbxassetid://15261860214"

local saved_showchat = plrbase.GuiActives.Settings
while wait() do
	if plrbase.Gui then
		local visiblegui = not (plrbase.VisibleGUI == false or plrbase.VisibleGUI_DisableGameGui == true)
		local other = plrbase.GuiActives.Other
		local showchat = not plrbase.GuiActives.Settings and not plrbase.GuiActives.Console and not plrbase.BaseDontDestroy.LoadingScreen and not plrbase.GuiActives.Other
		local guies = plrbase.Gui
		local dot = plrbase.Data.Camera.FirstPerson
		local admin = plrbase.GuiActives.Admin
		local debugui = plrbase.GuiActives.Debug
		local setting = not plrbase.Died and plrbase.Settings.Loaded
		
		local iteminarm_number = 0
		if plrbase.Tool ~= nil then
			iteminarm_number = 1
		end
		local hotbar = (#plr.Backpack:GetChildren()+iteminarm_number>0)
		guies.SettingsLoading.Enabled = not plrbase.Settings.Loaded
		local cursor = not dot and not plrbase.BaseDontDestroy.LoadingScreen
		if not visiblegui then
			dot = false
			admin = false
			cursor = plrbase.VisibleGUI_DisableGameGui
			setting = false
			showchat = false
			other = false
			hotbar = plrbase.VisibleGUI_DisableGameGui
		end
		guies.OtherPanel.Enabled = other
		guies.Dot.Enabled = dot
		guies.Settings.Enabled = setting
		guies.Settings.background.Visible = plrbase.GuiActives.Settings
		guies.AdminMenu.Enabled = admin
		guies.SmallInfo.Enabled = visiblegui
		guies.LeftButtons.Enabled = visiblegui and not plrbase.GuiActives.Settings
		guies.Health.Enabled = visiblegui
		guies.Help.Enabled = plrbase.GuiActives.Help
		guies.DebugInfo.Enabled = debugui
		guies.Console.Enabled = plrbase.GuiActives.Console
		guies.Hotbar.Enabled = hotbar
		guies.Splash.Enabled = visiblegui
		uts.MouseIconEnabled = cursor
		if saved_showchat ~= showchat then
			saved_showchat = showchat
			sgui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat,showchat)
		end
		
		sgui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,visiblegui)
	end
end