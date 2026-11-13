local leftbuttons = script.Parent
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))
local plrscript = require(chr:WaitForChild("PlayerScript"))
local rs = game:GetService("ReplicatedStorage")
rs.Scream.OnClientEvent:Connect(plrscript.Scream)

local attack_button, emotions_button, scream_button, other_button = leftbuttons.AttackMode, leftbuttons.Emotions, leftbuttons.Scream, leftbuttons.Other

attack_button.MouseButton1Click:Connect(function()
	if not script.Parent.Parent.OtherPanel.Enabled then
		base.AttackMode = not base.AttackMode
	end
end)

emotions_button.MouseButton1Click:Connect(function()
	if not script.Parent.Parent.OtherPanel.Enabled then
		print("emotions")
	end
end)

scream_button.MouseButton1Click:Connect(function()
	if not script.Parent.Parent.OtherPanel.Enabled then
		plrscript.Scream()
	end
end)

other_button.MouseButton1Click:Connect(function()
	if not script.Parent.Parent.OtherPanel.Enabled then
		base.GuiActives.Other = not base.GuiActives.Other
	end
end)

local buttonpress_scream = false
while wait() do
	plrscript.screamtimer += 1
	if plrscript.screamtimer>=plrscript.screamtimermax and buttonpress_scream==false then
		buttonpress_scream = true
		scream_button.BackgroundColor3 = Color3.fromRGB(25, 27, 29)
	end
	if plrscript.screamtimer<plrscript.screamtimermax and buttonpress_scream then
		buttonpress_scream = false
		scream_button.BackgroundColor3 = Color3.fromRGB(17, 19, 20)
	end
	
	if base.AttackMode then
		attack_button.ImageColor3 = Color3.fromRGB(255,0,0)
	else
		attack_button.ImageColor3 = Color3.fromRGB(255,255,255)
	end
end