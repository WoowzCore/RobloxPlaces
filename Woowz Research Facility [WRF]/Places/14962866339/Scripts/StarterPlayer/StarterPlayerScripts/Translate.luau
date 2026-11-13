local plrservice = game:GetService("Players")
local plr = plrservice.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))
local t = require(script.Parent.Translation)

local function translate()
	local plrgui = plr:WaitForChild("PlayerGui")
	for _, ui in pairs(plrgui:GetDescendants()) do
		if ui.Name == "TID" then
			if ui.Parent:IsA("TextBox") then
				ui.Parent.PlaceholderText = t.Get(ui.Value)
			else
				ui.Parent.Text = t.Get(ui.Value)
			end
		end
	end
end

plr.CharacterAdded:Connect(function()
	wait(0.1)
	translate()
end)

wait(0.1)
translate()