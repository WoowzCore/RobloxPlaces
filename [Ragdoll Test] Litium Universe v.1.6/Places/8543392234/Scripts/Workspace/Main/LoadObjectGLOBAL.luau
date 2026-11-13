local ThereSaved = game.Scene.SavedObjects
local function LoadObject(OrigTransform,LoadNeed,random)
	local RandRot = 0
	local RandY = 0
	if random then
		RandRot = math.random(0,360)
		RandY = -(math.random(0,20))
	end
	
		print(LoadNeed)
	local objOrig = ThereSaved:WaitForChild(LoadNeed)
	local obj = objOrig:Clone()

	obj.Parent = game.Scene.Map

	obj:SetPrimaryPartCFrame(CFrame.new(Vector3.new(OrigTransform.Position.x,OrigTransform.Position.y+RandY,OrigTransform.Position.z)) * CFrame.Angles(math.rad(OrigTransform.Orientation.X),math.rad(OrigTransform.Orientation.Y+RandRot),math.rad(OrigTransform.Orientation.Z)))

	OrigTransform:Destroy()
	
end

game.ServerScriptService.LoadObject.Event:Connect(LoadObject)