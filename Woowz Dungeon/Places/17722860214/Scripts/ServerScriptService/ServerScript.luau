local rs = game:GetService("ReplicatedStorage")
game:GetService("Players").PlayerAdded:Connect(function(plr)
	rs.Start:FireClient(plr)
end)
rs.UpdatePhysic.OnServerEvent:Connect(function(plr)
	for i, part in ipairs(workspace:GetDescendants()) do
		if(part:IsA("BasePart"))then
			if(part.Anchored==false)then
				part:SetNetworkOwner(plr)
			end
		end
	end
end)