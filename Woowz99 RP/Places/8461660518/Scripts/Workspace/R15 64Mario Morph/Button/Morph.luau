function onTouched(hit)
----
	if hit.Parent:findFirstChild("Humanoid") ~= nil then
		local target1 = "Head"
		local target2 = "Head2"
		if hit.Parent:findFirstChild(target2) == nil then
			local g = script.Parent.Parent[target2]:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "UnionOperation" or C[i].className =="Part" or C[i].className == "WedgePart" or C[i].className == "MeshPart" then
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
				Y.Part0 = hit.Parent[target1]
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
----
----
	if hit.Parent:findFirstChild("Humanoid") ~= nil then
		local target1 = "LeftFoot"
		local target2 = "LeftFoot2"
		if hit.Parent:findFirstChild(target2) == nil then
			local g = script.Parent.Parent[target2]:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "UnionOperation" or C[i].className =="Part" or C[i].className == "WedgePart" or C[i].className == "MeshPart" then
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
				Y.Part0 = hit.Parent[target1]
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
----
----
	if hit.Parent:findFirstChild("Humanoid") ~= nil then
		local target1 = "LeftHand"
		local target2 = "LeftHand2"
		if hit.Parent:findFirstChild(target2) == nil then
			local g = script.Parent.Parent[target2]:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "UnionOperation" or C[i].className =="Part" or C[i].className == "WedgePart" or C[i].className == "MeshPart" then
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
				Y.Part0 = hit.Parent[target1]
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
----
----
	if hit.Parent:findFirstChild("Humanoid") ~= nil then
		local target1 = "LeftLowerArm"
		local target2 = "LeftLowerArm2"
		if hit.Parent:findFirstChild(target2) == nil then
			local g = script.Parent.Parent[target2]:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "UnionOperation" or C[i].className =="Part" or C[i].className == "WedgePart" or C[i].className == "MeshPart" then
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
				Y.Part0 = hit.Parent[target1]
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
----
----
	if hit.Parent:findFirstChild("Humanoid") ~= nil then
		local target1 = "LeftLowerLeg"
		local target2 = "LeftLowerLeg2"
		if hit.Parent:findFirstChild(target2) == nil then
			local g = script.Parent.Parent[target2]:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "UnionOperation" or C[i].className =="Part" or C[i].className == "WedgePart" or C[i].className == "MeshPart" then
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
				Y.Part0 = hit.Parent[target1]
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
----
----
	if hit.Parent:findFirstChild("Humanoid") ~= nil then
		local target1 = "LeftUpperArm"
		local target2 = "LeftUpperArm2"
		if hit.Parent:findFirstChild(target2) == nil then
			local g = script.Parent.Parent[target2]:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "UnionOperation" or C[i].className =="Part" or C[i].className == "WedgePart" or C[i].className == "MeshPart" then
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
				Y.Part0 = hit.Parent[target1]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(-0.26, 0, 0)
				Y.Parent = Y.Part0
			end

		local h = g:GetChildren()
		for i = 1, # h do
			h[i].Anchored = false
			h[i].CanCollide = false
		end
	end
	end
----
----
	if hit.Parent:findFirstChild("Humanoid") ~= nil then
		local target1 = "LeftUpperLeg"
		local target2 = "LeftUpperLeg2"
		if hit.Parent:findFirstChild(target2) == nil then
			local g = script.Parent.Parent[target2]:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "UnionOperation" or C[i].className =="Part" or C[i].className == "WedgePart" or C[i].className == "MeshPart" then
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
				Y.Part0 = hit.Parent[target1]
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
----
----
	if hit.Parent:findFirstChild("Humanoid") ~= nil then
		local target1 = "LowerTorso"
		local target2 = "LowerTorso2"
		if hit.Parent:findFirstChild(target2) == nil then
			local g = script.Parent.Parent[target2]:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "UnionOperation" or C[i].className =="Part" or C[i].className == "WedgePart" or C[i].className == "MeshPart" then
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
				Y.Part0 = hit.Parent[target1]
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
----
----
	if hit.Parent:findFirstChild("Humanoid") ~= nil then
		local target1 = "RightFoot"
		local target2 = "RightFoot2"
		if hit.Parent:findFirstChild(target2) == nil then
			local g = script.Parent.Parent[target2]:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "UnionOperation" or C[i].className =="Part" or C[i].className == "WedgePart" or C[i].className == "MeshPart" then
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
				Y.Part0 = hit.Parent[target1]
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
----
----
	if hit.Parent:findFirstChild("Humanoid") ~= nil then
		local target1 = "RightHand"
		local target2 = "RightHand2"
		if hit.Parent:findFirstChild(target2) == nil then
			local g = script.Parent.Parent[target2]:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "UnionOperation" or C[i].className =="Part" or C[i].className == "WedgePart" or C[i].className == "MeshPart" then
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
				Y.Part0 = hit.Parent[target1]
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
----
----
	if hit.Parent:findFirstChild("Humanoid") ~= nil then
		local target1 = "RightLowerArm"
		local target2 = "RightLowerArm2"
		if hit.Parent:findFirstChild(target2) == nil then
			local g = script.Parent.Parent[target2]:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "UnionOperation" or C[i].className =="Part" or C[i].className == "WedgePart" or C[i].className == "MeshPart" then
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
				Y.Part0 = hit.Parent[target1]
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
----
----
	if hit.Parent:findFirstChild("Humanoid") ~= nil then
		local target1 = "RightLowerLeg"
		local target2 = "RightLowerLeg2"
		if hit.Parent:findFirstChild(target2) == nil then
			local g = script.Parent.Parent[target2]:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "UnionOperation" or C[i].className =="Part" or C[i].className == "WedgePart" or C[i].className == "MeshPart" then
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
				Y.Part0 = hit.Parent[target1]
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
----
----
	if hit.Parent:findFirstChild("Humanoid") ~= nil then
		local target1 = "RightUpperArm"
		local target2 = "RightUpperArm2"
		if hit.Parent:findFirstChild(target2) == nil then
			local g = script.Parent.Parent[target2]:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "UnionOperation" or C[i].className =="Part" or C[i].className == "WedgePart" or C[i].className == "MeshPart" then
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
				Y.Part0 = hit.Parent[target1]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0.26, 0, 0)
				Y.Parent = Y.Part0
			end

		local h = g:GetChildren()
		for i = 1, # h do
			h[i].Anchored = false
			h[i].CanCollide = false
		end
	end
	end
----
----
	if hit.Parent:findFirstChild("Humanoid") ~= nil then
		local target1 = "RightUpperLeg"
		local target2 = "RightUpperLeg2"
		if hit.Parent:findFirstChild(target2) == nil then
			local g = script.Parent.Parent[target2]:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "UnionOperation" or C[i].className =="Part" or C[i].className == "WedgePart" or C[i].className == "MeshPart" then
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
				Y.Part0 = hit.Parent[target1]
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
----
----
	if hit.Parent:findFirstChild("Humanoid") ~= nil then
		local target1 = "UpperTorso"
		local target2 = "UpperTorso2"
		if hit.Parent:findFirstChild(target2) == nil then
			local g = script.Parent.Parent[target2]:clone()
			g.Parent = hit.Parent
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].className == "UnionOperation" or C[i].className =="Part" or C[i].className == "WedgePart" or C[i].className == "MeshPart" then
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
				Y.Part0 = hit.Parent[target1]
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0, -0.5, 0)
				Y.Parent = Y.Part0
			end

		local h = g:GetChildren()
		for i = 1, # h do
			h[i].Anchored = false
			h[i].CanCollide = false
		end
	end
	end
----
end

script.Parent.Touched:connect(onTouched)