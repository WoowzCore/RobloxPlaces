local serverowner = game:GetService("ReplicatedStorage").GetServerInfoData:InvokeServer("Owner")
local plrservice = game:GetService("Players")
local nickname = ""
local plr = plrservice.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

if serverowner ~= 0 then
	s,e = pcall(function()
		nickname = " ["..plrservice:GetPlayerByUserId(serverowner).Name.."]"
	end)
end

local result = base.t.g("other.no")
if serverowner == game:GetService("Players").LocalPlayer.UserId then
	result = base.t.g("other.yes")
end
script.Parent.Text = base.t.g("debug.owner")..result..nickname