local plrscr = {}
local plr = game:GetService("Players").LocalPlayer
local sd = require(plr.PlayerScripts.SPS:WaitForChild("SaveData"))
local vd = game:GetService("ReplicatedStorage").RS.GetVisualData:InvokeServer() 

function plrscr.Grant(achievementname)
	if sd.Achievements[achievementname] == false then
		print("Got the achievement ["..vd.Achievements[achievementname]["Name"].."]")
		sd.Achievements[achievementname] = true
	end
end

return plrscr
