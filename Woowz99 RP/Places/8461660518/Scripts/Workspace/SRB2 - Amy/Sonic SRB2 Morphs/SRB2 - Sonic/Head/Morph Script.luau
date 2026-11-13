function onTouched(hit)
	
		if hit.Parent:findFirstChild("Arm1") ~= nil then
		hit.Parent:findFirstChild("Arm1"):Destroy()
	end

	if hit.Parent:findFirstChild("Arm2") ~= nil then
		hit.Parent:findFirstChild("Arm2"):Destroy()
	end

	if hit.Parent:findFirstChild("Leg1") ~= nil then
		hit.Parent:findFirstChild("Leg1"):Destroy()
	end

	if hit.Parent:findFirstChild("Leg2") ~= nil then
		hit.Parent:findFirstChild("Leg2"):Destroy()
	end

	if hit.Parent:findFirstChild("Chest") ~= nil then
		hit.Parent:findFirstChild("Chest"):Destroy()
	end

	if hit.Parent:findFirstChild("xHead") ~= nil then
		hit.Parent:findFirstChild("xHead"):Destroy()
	end	
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Arm1") == nil then
		local g = script.Parent.Parent.Arm1:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "Part" or C[i].className == "UnionOperation" then
				local W = Instance.new("Weld")
				W.Part0 = g.Middle
				W.Part1 = C[i]
				local CJ = CFrame.new(g.Middle.Position)
				local C0 = g.Middle.CFrame:inverse()*CJ
				local C1 = C[i].CFrame:inverse()*CJ
				W.C0 = C0
				W.C1 = C1
				W.Parent = g.Middle
			end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent["Left Arm"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			if h[i].className == "Part" or C[i].className == "UnionOperation" then
				h[i].Anchored = false
				h[i].CanCollide = false
			end
		end
		
	end

	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Arm2") == nil then
		local g = script.Parent.Parent.Arm2:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "Part" or C[i].className == "UnionOperation" then
				local W = Instance.new("Weld")
				W.Part0 = g.Middle
				W.Part1 = C[i]
				local CJ = CFrame.new(g.Middle.Position)
				local C0 = g.Middle.CFrame:inverse()*CJ
				local C1 = C[i].CFrame:inverse()*CJ
				W.C0 = C0
				W.C1 = C1
				W.Parent = g.Middle
			end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent["Right Arm"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			if h[i].className == "Part" or C[i].className == "UnionOperation" then
				h[i].Anchored = false
				h[i].CanCollide = false
			end
		end
		
	end
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Leg1") == nil then
		local g = script.Parent.Parent.Leg1:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "Part" or C[i].className == "UnionOperation" then
				local W = Instance.new("Weld")
				W.Part0 = g.Middle
				W.Part1 = C[i]
				local CJ = CFrame.new(g.Middle.Position)
				local C0 = g.Middle.CFrame:inverse()*CJ
				local C1 = C[i].CFrame:inverse()*CJ
				W.C0 = C0
				W.C1 = C1
				W.Parent = g.Middle
			end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent["Left Leg"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			if h[i].className == "Part" or C[i].className == "UnionOperation" then
				h[i].Anchored = false
				h[i].CanCollide = false
			end
		end
		
	end
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Leg2") == nil then
		local g = script.Parent.Parent.Leg2:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "Part" or C[i].className == "UnionOperation" then
				local W = Instance.new("Weld")
				W.Part0 = g.Middle
				W.Part1 = C[i]
				local CJ = CFrame.new(g.Middle.Position)
				local C0 = g.Middle.CFrame:inverse()*CJ
				local C1 = C[i].CFrame:inverse()*CJ
				W.C0 = C0
				W.C1 = C1
				W.Parent = g.Middle
			end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent["Right Leg"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			if h[i].className == "Part" or C[i].className == "UnionOperation" then
				h[i].Anchored = false
				h[i].CanCollide = false
			end
		end
		
	end
	
	
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("xHead") == nil then
		local g = script.Parent.Parent.xHead:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "Part" or C[i].className == "UnionOperation" then
				local W = Instance.new("Weld")
				W.Part0 = g.Middle
				W.Part1 = C[i]
				local CJ = CFrame.new(g.Middle.Position)
				local C0 = g.Middle.CFrame:inverse()*CJ
				local C1 = C[i].CFrame:inverse()*CJ
				W.C0 = C0
				W.C1 = C1
				W.Parent = g.Middle
			end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent["Head"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			if h[i].className == "Part" or C[i].className == "UnionOperation" then
				h[i].Anchored = false
				h[i].CanCollide = false
			end
		end
		
	end
	
	
	
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Chest") == nil then
		local g = script.Parent.Parent.Chest:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "Part" or C[i].className == "UnionOperation" then
				local W = Instance.new("Weld")
				W.Part0 = g.Middle
				W.Part1 = C[i]
				local CJ = CFrame.new(g.Middle.Position)
				local C0 = g.Middle.CFrame:inverse()*CJ
				local C1 = C[i].CFrame:inverse()*CJ
				W.C0 = C0
				W.C1 = C1
				W.Parent = g.Middle
			end
				local Y = Instance.new("Weld")
				Y.Part0 = hit.Parent.Torso
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			if h[i].className == "Part" or C[i].className == "UnionOperation" then
				h[i].Anchored = false
				h[i].CanCollide = false
			end
		end
		hit.Parent:findFirstChild("Head").BrickColor = BrickColor.new(125)
hit.Parent:findFirstChild("Head").Transparency = 0.98
hit.Parent:findFirstChild("Torso").BrickColor = BrickColor.new(23)
hit.Parent:findFirstChild("Torso").Transparency = 1
hit.Parent:findFirstChild("Left Arm").BrickColor = BrickColor.new(23)
hit.Parent:findFirstChild("Left Arm").Transparency = 1
hit.Parent:findFirstChild("Right Arm").BrickColor = BrickColor.new(23)
hit.Parent:findFirstChild("Right Arm").Transparency = 1
hit.Parent:findFirstChild("Left Leg").BrickColor = BrickColor.new(23)
hit.Parent:findFirstChild("Left Leg").CanCollide = true
hit.Parent:findFirstChild("Left Leg").Transparency = 1
hit.Parent:findFirstChild("Right Leg").BrickColor = BrickColor.new(23)
hit.Parent:findFirstChild("Right Leg").CanCollide = true
hit.Parent:findFirstChild("Right Leg").Transparency = 1
	end
end
script.Parent.Touched:connect(onTouched)