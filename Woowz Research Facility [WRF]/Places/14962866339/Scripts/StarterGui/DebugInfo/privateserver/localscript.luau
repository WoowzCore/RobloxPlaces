local serverowner = game:GetService("ReplicatedStorage").GetServerInfoData:InvokeServer("PrivateServer")
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))
local result = base.t.g("other.no")
if serverowner ~= "" then
	result = base.t.g("other.yes")
end
script.Parent.Text = base.t.g("debug.private")..result