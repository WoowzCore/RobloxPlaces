local rs = game:GetService("ReplicatedStorage")
local holiday = rs.GetServerInfoData:InvokeServer("Holiday")
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

if holiday == "" then
	holiday = base.t.g("other.no")
elseif holiday == "Halloween" then
	holiday = base.t.g("other.holiday.halloween")
elseif holiday == "Christmas" then
	holiday = base.t.g("other.holiday.christmas")
elseif holiday == "Easter" then
	holiday = base.t.g("other.holiday.easter")
elseif holiday == "Cosmonautics" then
	holiday = base.t.g("other.holiday.cosmonautics")
else
	holiday = base.t.g("other.holiday.wrfday")
end
script.Parent.Text = base.t.g("debug.holiday")..holiday