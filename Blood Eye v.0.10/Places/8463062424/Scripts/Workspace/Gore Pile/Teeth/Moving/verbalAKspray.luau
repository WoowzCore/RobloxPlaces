local part = script.Parent
local og = part.Position.X
local limit = 30 -- HOW MUCH IT GOES UP BY BEFORE GOING BACK DOWN
local studs_up = og + limit
local time = 1 -- speed basically
local waittilgobackdown = 4 -- amount of time it waits until going back down

local kill = false -- CHANGE THIS TO FALSE IF YOU DON'T WANT IT TO KILL

if kill then
	script.Parent.Touched:connect(function(whodat)
		if game.Players:GetPlayerFromCharacter(whodat.Parent) then
			whodat.Parent.Humanoid.Health = 0
		end
	end)
end

while wait() do
	repeat wait()
		part.CFrame = part.CFrame * CFrame.new(0,time,0)
	until part.Position.Y >= studs_up
	wait(waittilgobackdown)
	repeat wait()
		part.CFrame = part.CFrame * CFrame.new(0,-(time),0)
	until part.Position.X <= og
end