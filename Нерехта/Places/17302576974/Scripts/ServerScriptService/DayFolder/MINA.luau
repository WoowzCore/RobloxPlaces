local mina = workspace["--Map--"].Mine

for i=1,1000 do
	local raycastparams = RaycastParams.new()
	raycastparams.IgnoreWater = true
	local raycastresult = workspace:Raycast(Vector3.new(math.random(-1000,1000),1000,math.random(-1000,1000)),Vector3.new(0,-2000,0),raycastparams)
	if raycastresult then
		local mine_ = mina:Clone()
		mine_.Parent = workspace["--Map--"]
		mine_.CFrame = CFrame.new(raycastresult.Position.X,raycastresult.Position.Y+0.1,raycastresult.Position.Z) * CFrame.Angles(0,0,math.rad(90))
		print("find")
	end
end