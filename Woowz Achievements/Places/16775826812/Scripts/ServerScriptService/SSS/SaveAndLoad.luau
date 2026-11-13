local rs = game:GetService("ReplicatedStorage").RS
local dss = game:GetService("DataStoreService")
local allsaved = require(script.Parent.AllPlayerSaveData)
local plrs = game:GetService("Players")

rs.Load.OnServerInvoke = function(plr)
	local saveddata = dss:GetDataStore(plr.UserId)
	local getSuccess, result = pcall(function()
		return saveddata:GetAsync(plr.UserId)
	end)
	if getSuccess then
		return result
	else
		return nil
	end
end

function Save(plr)
	local saveddata = dss:GetDataStore(plr.UserId)
	local data = allsaved.SavedDatas[plr.UserId]
	if data == nil then warn("Not has data to save!") return end
	local setSuccess, errorMessage = pcall(function()
		local thatsave = {
			["Achievements"] = data.Achievements,
			["OtherData"] = data.OtherData,
		}
		saveddata:SetAsync(plr.UserId, thatsave)
	end)
	if not setSuccess then
		warn(errorMessage)
	end
end

rs.Save.OnServerEvent:Connect(Save)

game:BindToClose(function()
	local players = plrs:GetPlayers()
	for index, player in pairs(players) do
		local maxTries = 2
		local currentTries = 0

		repeat
			currentTries += 1

			local success, errorMessage = xpcall(function()
				Save(player)
			end, warn)
		until currentTries >= maxTries 
	end
end)

while wait(0.01) do
	for _, plr in pairs(plrs:GetPlayers()) do
		local Success, Err = pcall(function() allsaved.SavedDatas[plr.UserId] = rs.GetSaveData:InvokeClient(plr) end)
	end
end