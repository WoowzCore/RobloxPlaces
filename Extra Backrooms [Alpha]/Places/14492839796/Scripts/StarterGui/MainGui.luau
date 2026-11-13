local sg = game:GetService("StarterGui")
sg:SetCoreGuiEnabled(Enum.CoreGuiType.Health,false)
sg:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,false)
sg:SetCoreGuiEnabled(Enum.CoreGuiType.Captures,false)
sg:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu,false)

local bind = Instance.new("BindableEvent")
bind.Event:Connect(function()
	print("Busy wait") 
end)

while true do
	Success, _ = pcall(sg.SetCore, sg, "ResetButtonCallback", false)
	if Success then break else task.wait() end
end