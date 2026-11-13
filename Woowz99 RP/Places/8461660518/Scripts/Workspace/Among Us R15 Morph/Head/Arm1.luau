function onTouched(hit)
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Hand1") == nil then
		local g = script.Parent.Parent.Hand1:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "UnionOperation"or C[i].className =="Part" or C[i].className == "MeshPart" then
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
				Y.Part0 = hit.Parent.LeftHand
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

function onTouched(hit)
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("LowArm1") == nil then
		local g = script.Parent.Parent.LowArm1:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "UnionOperation"or C[i].className =="Part" or C[i].className == "MeshPart" then
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
				Y.Part0 = hit.Parent.LeftLowerArm
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


function onTouched(hit)
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("UpArm1") == nil then
		local g = script.Parent.Parent.UpArm1:clone()
		g.Parent = hit.Parent
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "UnionOperation"or C[i].className =="Part" or C[i].className == "MeshPart" then
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
				Y.Part0 = hit.Parent.LeftUpperArm
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