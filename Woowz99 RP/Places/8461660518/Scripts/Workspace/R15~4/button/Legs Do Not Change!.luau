function onTouched(hit)
--right
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("rightleg1") == nil then
		local g = script.Parent.Parent.rightleg1:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "UnionOperation" or C[i].className =="Part" then
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
				Y.Part0 = hit.Parent["RightUpperLeg"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			h[i].Anchored = false
			h[i].CanCollide = false
		end
		
	end

	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("rightleg2") == nil then
		local g = script.Parent.Parent.rightleg2:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "UnionOperation" or C[i].className =="Part" then
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
				Y.Part0 = hit.Parent["RightLowerLeg"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			h[i].Anchored = false
			h[i].CanCollide = false
		end
		
	end

	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("rfoot") == nil then
		local g = script.Parent.Parent.rfoot:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "UnionOperation" or C[i].className =="Part" then
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
				Y.Part0 = hit.Parent["RightFoot"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			h[i].Anchored = false
			h[i].CanCollide = false
		end
		
	end
--left
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("leftleg1") == nil then
		local g = script.Parent.Parent.leftleg1:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "UnionOperation" or C[i].className =="Part" then
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
				Y.Part0 = hit.Parent["LeftUpperLeg"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			h[i].Anchored = false
			h[i].CanCollide = false
		end
		
	end

	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("leftleg2") == nil then
		local g = script.Parent.Parent.leftleg2:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "UnionOperation" or C[i].className =="Part" then
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
				Y.Part0 = hit.Parent["LeftLowerLeg"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			h[i].Anchored = false
			h[i].CanCollide = false
		end
		
	end

	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("lfoot") == nil then
		local g = script.Parent.Parent.lfoot:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "UnionOperation" or C[i].className =="Part" then
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
				Y.Part0 = hit.Parent["LeftFoot"]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, 0, 0)
				Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			h[i].Anchored = false
			h[i].CanCollide = false
		end
		
	end

end

script.Parent.Touched:connect(onTouched)