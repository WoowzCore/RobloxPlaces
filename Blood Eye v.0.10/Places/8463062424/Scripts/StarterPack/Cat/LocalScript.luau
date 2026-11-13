local tool = script.Parent
local player = game:GetService("Players").LocalPlayer
	if workspace.FilteringEnabled then
		 tool.Activated:Connect(function()
			local mouse = player:GetMouse()
			mouse.Button1Down:Connect(function()
		tool.Bounce:FireServer(mouse.Hit.p)
		end)
		end)
	end