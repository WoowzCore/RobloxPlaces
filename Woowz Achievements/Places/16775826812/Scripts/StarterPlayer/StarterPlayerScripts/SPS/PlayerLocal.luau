local rs = game:GetService("ReplicatedStorage").RS
local plrs = game:GetService("Players")
local saved = require(script.Parent.SaveData)

saved.LoadSavedData(rs.Load:InvokeServer())

rs.GetSaveData.OnClientInvoke = function()
	return saved
end

plrs.PlayerRemoving:Connect(function(plr)
	if plr.UserId == plrs.LocalPlayer.UserId then
		rs.Save:FireServer()
	end
end)