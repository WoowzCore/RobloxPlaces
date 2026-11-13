local rs = game:GetService("ReplicatedStorage")
local data = require(script.Parent.Data)
local commanddata = require(game:GetService("ServerStorage").COMMANDSDATA)
local plrsdata = require(game:GetService("ServerStorage").PLAYERSDATA)
local pservice = game:GetService("Players")

rs.RotateHead.OnServerInvoke = function(plr, rothead, rotarm, rotlleg, rotrleg, rotroot)
	local plrid = plr.UserId
	data.PlayerRotationHeads[plrid] = rothead
	data.PlayerRotationArms[plrid] = rotarm
	data.PlayerRotationLegsL[plrid] = rotlleg
	data.PlayerRotationLegsR[plrid] = rotrleg
	data.PlayerRotationRoot[plrid] = rotroot
	if plrsdata.Data[tostring(plr.UserId)] then
		if plrsdata.Data[tostring(plr.UserId)]["Rotation"] == nil then plrsdata.Data[tostring(plr.UserId)]["Rotation"] = {} end
		plrsdata.Data[tostring(plr.UserId)]["Rotation"]["Head"] = rothead
		plrsdata.Data[tostring(plr.UserId)]["Rotation"]["Arm"] = rotarm
		plrsdata.Data[tostring(plr.UserId)]["Rotation"]["LegL"] = rotlleg
		plrsdata.Data[tostring(plr.UserId)]["Rotation"]["LegR"] = rotrleg
		plrsdata.Data[tostring(plr.UserId)]["Rotation"]["Root"] = rotroot
	end
	return data.PlayerRotationHeads, data.PlayerRotationArms, data.PlayerRotationLegsL, data.PlayerRotationLegsR, data.PlayerRotationRoot
end

commanddata.PregenerateCommands()
rs.GetCommand.OnServerInvoke = function(plr,id)
	return commanddata.Data[id]
end

rs.GetServerInfoData.OnServerInvoke = function(plr,data)
	for _, d in pairs(script.Parent.ServerInfo.Data:GetChildren()) do
		if d.Name == data then
			return d.Value
		end
	end
	return nil
end

while wait() do
	for _, p in pairs(pservice:GetPlayers()) do
		local chr = p.Character or p.CharacterAdded:Wait()
		if chr:FindFirstChild("Head") then
			rs.GetHumanoidHealths:FireClient(p,chr:WaitForChild("Head"):WaitForChild("Health").Value,
				chr:WaitForChild("Torso"):WaitForChild("Health").Value,
				chr:WaitForChild("Left Arm"):WaitForChild("Health").Value,
				chr:WaitForChild("Right Arm"):WaitForChild("Health").Value,
				chr:WaitForChild("Left Leg"):WaitForChild("Health").Value,
				chr:WaitForChild("Right Leg"):WaitForChild("Health").Value,
				chr:WaitForChild("Head"):WaitForChild("Health").Value,
				chr:WaitForChild("Torso"):WaitForChild("HealthMax").Value,
				chr:WaitForChild("Left Arm"):WaitForChild("HealthMax").Value,
				chr:WaitForChild("Right Arm"):WaitForChild("HealthMax").Value,
				chr:WaitForChild("Left Leg"):WaitForChild("HealthMax").Value,
				chr:WaitForChild("Right Leg"):WaitForChild("HealthMax").Value
			)
		end
	end
end