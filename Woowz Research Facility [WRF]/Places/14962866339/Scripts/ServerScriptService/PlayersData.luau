local ss = game:GetService("ServerStorage")
local rs = game:GetService("ReplicatedStorage")
local plrs = game:GetService("Players")
local plrsdata = require(ss.PLAYERSDATA)
local base = require(script.Parent.Base)
local datastore = game:GetService("DataStoreService"):GetDataStore("PlayerLastData")

local function SetData(id,data)
	id = tostring(id)
	local admin = base.CheckAdmin(id)
	local dev = (id == "1734081766")
	data["ServerInformation"] = {
		["Admin"] = admin,
		["Dev"] = dev
	}
	if plrsdata.Data[id] ~= nil then
		if plrsdata.Data[id]["Rotation"] ~= nil then
			data["Rotation"] = plrsdata.Data[id]["Rotation"]
		end
	end
	plrsdata.Data[id] = data
end

rs.GetPlayerDataClient.OnServerInvoke = function(plr,plrtarget)
	return plrsdata.Data[tostring(plrtarget)]
end

function SetPlayerSavedData(plr) -- Обновить данные у игрока
	wait(1)
	local ss, err = pcall(function()
		local lastdata = datastore:GetAsync(tostring(plr.UserId))
		if lastdata ~= nil then
			rs.SetPlayerDataValue:InvokeClient(plr,"GuiActives.Help",lastdata[1])
		else
			rs.SetPlayerDataValue:InvokeClient(plr,"GuiActives.Help",true)
		end
	end)
	if not ss then
		warn(err)
	end
end
function UpdatePlayerSavedData(plr) -- Обновить данные в DataStorage
	local ss, err = pcall(function()
		local plrdata = plrsdata.Data[tostring(plr.UserId)]
		if plrdata ~= nil then
			local savethisdata = {plrdata.GuiActives.Help}
			datastore:SetAsync(tostring(plr.UserId),savethisdata)
		end
	end)
	if not ss then
		warn(err)
	end
end

rs.DataStorage.Set.Event:Connect(SetPlayerSavedData)
rs.DataStorage.Update.Event:Connect(UpdatePlayerSavedData)

local categorys = {
	["Optimization"] = "o",
	["Privacity"] = "p",
	["Keys"] = "k",
	["Debug"] = "d",
	["Other"] = "h",
	["Gameplay"] = "g",
	["Graphic"] = "r",
	
	["o"] = "Optimization",
	["p"] = "Privacity",
	["k"] = "Keys",
	["d"] = "Debug",
	["h"] = "Other",
	["g"] = "Gameplay",
	["r"] = "Graphic"
}

function UpdatePlayerSettings(plr,settingslist,settingslist_old)
	if settingslist_old == nil then return end
	for _, setting in pairs(settingslist) do
		if _ == "Optimization" or _ == "Privacity" or _ == "Keys" or _ == "Debug" or _ == "Other" or _ == "Gameplay" or _ == "Graphic" then
			for name, val in pairs(setting) do
				if settingslist_old[_][name] ~= val then
					local ss, err = pcall(function()
						if typeof(val) == "EnumItem" then
							val = string.split(tostring(val),".")[#string.split(tostring(val),".")]
							val = "(KEYCODE)"..tostring(val)
						end
						datastore:SetAsync(tostring(plr.UserId).."_s_"..categorys[_].."."..name,val)
					end)
					if not ss then
						warn(err)
					end
				end
			end
		end
	end
end

function GetPlayerSettings(plr,settingslist)
	wait(1)
	local result = {}
	for _, setting in pairs(settingslist) do
		if _ == "Optimization" or _ == "Privacity" or _ == "Keys" or _ == "Debug" or _ == "Other" or _ == "Gameplay" or _ == "Graphic" then
			if result[_] == nil then
				result[_] = {}
			end
			
			for name, val in pairs(setting) do
				local ss, err = pcall(function()
					local newval = datastore:GetAsync(tostring(plr.UserId).."_s_"..categorys[_].."."..name)
					if string.find(tostring(newval),"%(KEYCODE%)") then
						newval = string.gsub(newval,"%(KEYCODE%)","")
						newval = Enum.KeyCode[newval]
					end
					result[_][name] = newval
				end)
				if not ss then
					warn(err)
				end
			end
		end
	end
	
	
	return result
end

rs.DataStorage.UpdateSettings.OnServerEvent:Connect(UpdatePlayerSettings)
rs.DataStorage.GetSettings.OnServerInvoke = GetPlayerSettings

game:BindToClose(function()
	for i, plr in pairs(plrs:GetPlayers()) do
		if plrsdata~=nil then
			if plrsdata.Data[tostring(plr.UserId)] ~= nil then
				if plrsdata.Data[tostring(plr.UserId)].Settings ~= nil then
					UpdatePlayerSettings(plr,plrsdata.Data[tostring(plr.UserId)].Settings,plrsdata.Data[tostring(plr.UserId)].BaseDontDestroy.OldSettings)
				end
			end
		end
	end
end)

plrs.PlayerRemoving:Connect(function(p)
	if plrsdata.Data[tostring(p.UserId)] == nil then return end
	UpdatePlayerSettings(p,plrsdata.Data[tostring(p.UserId)].Settings,plrsdata.Data[tostring(p.UserId)].BaseDontDestroy.OldSettings)
end)

plrs.PlayerAdded:Connect(function(p)
	local c = p.Character or p.CharacterAdded:Wait()
	local h = c:WaitForChild("Humanoid")
	h:GetPropertyChangedSignal("Health"):Connect(function()
		if h.Health <= 0 then
			UpdatePlayerSettings(p,plrsdata.Data[tostring(p.UserId)].Settings,plrsdata.Data[tostring(p.UserId)].BaseDontDestroy.OldSettings)
		end
	end)
end)

while wait(0.02) do
	for _, plr in pairs(plrs:GetPlayers()) do
		local data = nil
		local suc = pcall(function() data = rs.Player.GetPlayerData:InvokeClient(plr) end)
		if suc then
			SetData(plr.UserId,data)
		end
	end
end