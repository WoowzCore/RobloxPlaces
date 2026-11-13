game.ReplicatedStorage:WaitForChild("CreateObject").OnServerEvent:Connect(function(player, name, Pos, frozzen)
	print(name)
	local OrigObject = game.Workspace.SavedObjects:WaitForChild(name)
	local obj = OrigObject:Clone()
	obj.Parent = game.Workspace
	if obj:IsA("Part") then
	obj.Position = Pos
	obj.Anchored = frozzen
	else
		local CF = CFrame.new(Pos)
	obj:SetPrimaryPartCFrame(CF)
	end
end)

game.ReplicatedStorage:WaitForChild("DestroyObject").OnServerEvent:Connect(function(player, obj)
	
	if not obj.GameObject == nil then
		print(obj.Name)
		obj:Destroy()
	end
end)