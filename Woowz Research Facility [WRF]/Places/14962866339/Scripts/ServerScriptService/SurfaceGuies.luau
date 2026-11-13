local rs = game:GetService("ReplicatedStorage")
local plrs = game:GetService("Players")
local t = game:GetService("TextService")

rs.ChangeTextGuiUpdate.OnServerEvent:Connect(function(plr,text,id,textid,obj,te,filter)
	local success, errorMessage
	if filter then
		success, errorMessage = pcall(function()
			text = t:FilterStringAsync(text, plr.UserId):GetNonChatStringForBroadcastAsync()
		end)
	else
		success = true
	end
	if success then
		local textvalue = obj:FindFirstChild(te)
		if textvalue == nil then
			textvalue = Instance.new("StringValue")
			textvalue.Name = te
			textvalue.Parent = obj
		end
		textvalue.Value = text
		
		for _, plr2 in pairs(plrs:GetPlayers()) do
			rs.ChangeTextGui:FireClient(plr2,text,id,textid,obj)
		end
	elseif errorMessage then
		print("Error generating TextFilterResult:", errorMessage)
	end
end)