local rps = game:GetService("ReplicatedStorage")
local ss = game:GetService("ServerStorage")
local base = require(script.Parent.Base)
local tp = game:GetService("TeleportService")
local sss = game:GetService("ServerScriptService")
local data = script.Parent.ServerInfo.Data

script.Parent.SetHoliday:Fire()

local compiled = false

game:GetService("Players").PlayerAdded:Connect(function(plr)
	base.GiveAchievement(plr,2153629333)
	print("["..plr.Name.." ("..plr.UserId..")] Зашёл!")
	plr.Chatted:Connect(function(msg)
		print("["..plr.Name.." ("..plr.UserId..")]: "..msg)
	end)
	
	local teleportdata = plr:GetJoinData().TeleportData
	if teleportdata ~= nil then
		if teleportdata[1] ~= "" then
			local mainadmins_ = string.split(teleportdata[1],"/")
			local admins, mainadmins = mainadmins_[1],mainadmins_[2]
		
			local function adminhe(usrid,main)
				local serverowneradmin = Instance.new("BoolValue",ss.ADMINS)
				serverowneradmin.Name = tostring(usrid)
				serverowneradmin.Value = main
			end
		
			for _, p in pairs(string.split(admins,",")) do
				if p ~= "" then
					adminhe(p,false)
				end
			end
		
			for _, p in pairs(string.split(mainadmins,",")) do
				if p ~= "" then
					adminhe(p,true)
				end
			end
		end
		if teleportdata[2] ~= "skip" then
			local holiday = teleportdata[2]
			if holiday == "none" then holiday = "" end
			data.Holiday.Value = holiday
		end
	end
	
	if game.PrivateServerOwnerId ~= 0 then
		if game.PrivateServerOwnerId == plr.UserId then
			base.GiveAchievement(plr,2153629352)
			if ss.ADMINS:FindFirstChild(tostring(plr.UserId)) == nil then
				local serverowneradmin = Instance.new("BoolValue",ss.ADMINS)
				serverowneradmin.Name = tostring(plr.UserId)
				serverowneradmin.Value = true
			else
				ss.ADMINS:FindFirstChild(tostring(plr.UserId)).Value = true
			end
		end
	end
	
	sss.ServerInfo.Data.Owner.Value = game.PrivateServerOwnerId
	sss.ServerInfo.Data.PrivateServer.Value = game.PrivateServerId
	
	if not compiled then
		compiled = true
		script.Parent.CompileScriptableObjects:Fire()
	end
end)

game:GetService("Players").PlayerRemoving:Connect(function(plr)
	rps.DataStorage.Update:Fire(plr)
	print("["..plr.Name.." ("..plr.UserId..")] Вышел!")
end)

while wait(1) do
	sss.ServerInfo.Data.Age.Value += 1
end