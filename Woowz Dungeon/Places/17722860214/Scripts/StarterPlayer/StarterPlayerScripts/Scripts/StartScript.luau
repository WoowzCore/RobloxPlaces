local m =   require(script.Parent.GameManager)
local pm = require(script.Parent.PlayerModule)
local rs =  game:GetService("ReplicatedStorage")
local sg =  game:GetService("StarterGui")
local u =   game:GetService("UserInputService")
local plr = game:GetService("Players").LocalPlayer
rs.Start.OnClientEvent:Connect(function()
	sg:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,false)
	sg:SetCoreGuiEnabled(Enum.CoreGuiType.Health,false)
	sg:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)
	sg:SetCoreGuiEnabled(Enum.CoreGuiType.Captures,false)
	sg:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu,false)
	sg:SetCoreGuiEnabled(Enum.CoreGuiType.Chat,false)
	sg:SetCoreGuiEnabled(Enum.CoreGuiType.All,false)
	
	local mainmenu = sg.MainMenu:Clone()
	mainmenu.Enabled = true
	mainmenu.Parent = plr.PlayerGui
	
	wait(1)
	
	while true do
		local Success, _ = pcall(sg.SetCore, sg, "ResetButtonCallback", false)
		if Success then break else task.wait() end
	end
	
	while true do
		local Success, _ = pcall(sg.SetCore, sg, "TopbarEnabled", false)
		if Success then break else task.wait() end
	end
end)