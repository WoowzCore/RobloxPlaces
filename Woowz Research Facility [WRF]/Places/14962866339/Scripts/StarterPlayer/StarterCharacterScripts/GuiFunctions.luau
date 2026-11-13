local guif = {}

function guif.SetViewportFrame(vpf : ViewportFrame,objects,cframebase,mirror : boolean?)
	if mirror == nil then mirror = false end
	if cframebase == nil then cframebase = CFrame.new() end
	for _, p in pairs(vpf:GetDescendants()) do
		if not p:IsA("Camera") then
			p:Destroy()
		end
	end
	
	local function reflectOne(part, mod)
		if typeof(cframebase) ~= "CFrame" then
			cframebase = cframebase.CFrame
		end

		local mpart = part:Clone()
		for _, p in pairs(mpart:GetChildren()) do
			if p:IsA("HingeConstraint") or p:IsA("Script") or p:IsA("LocalScript") or p:IsA("ModuleScript") or p:IsA("DragDetector") or p:IsA("ValueBase") or p:IsA("ClickDetector") or p:IsA("PackageLink") or p:IsA("SurfaceGui") or p:IsA("Light") or p:IsA("Sound") or p:IsA("Weld") or p:IsA("WeldConstraint") or p:IsA("Attachment") then
				p:Destroy()
			end
		end
		
		if mpart:IsA("BasePart") then
			local mir = 1
			if mirror then mir = -1 end
			local x,y,z,r00,r01,r02,r10,r11,r12,r20,r21,r22 = cframebase:toObjectSpace(part.CFrame):components()
			mpart.CFrame = cframebase:toWorldSpace(CFrame.new(x*mir,y,z,r00,r01*mir,r02*mir,r10*mir,r11,r12,r20*mir,r21,r22)) 
		end

		mpart.Parent = mod
	end

	local function reflectAll( srcModel, tgtModel )
		
		if typeof(srcModel) ~= "table" then
			srcModel = srcModel:GetChildren()
		end
		for k,v in pairs(srcModel) do

			if v:IsA("Model") or v:IsA("Accessory") then
				local m2 = Instance.new("Model", tgtModel)
				m2.Name = v.Name
				reflectAll(v, m2)
			elseif v:IsA("BasePart") or v:IsA("Humanoid") or v:IsA("Pants") or v:IsA("Shirt")  then
				reflectOne(v, tgtModel)
			end
		end
	end
	
	local function updtable(t)
		local nt = {}
		
		for _, p in pairs(t) do
			local parent = p
			
			parent = parent:FindFirstAncestorOfClass("Model")
			
			if parent == nil then
				parent = p
			end
			
			local str = ""
			if parent:IsA("Model") then
				str = parent:GetFullName()..tostring(parent.WorldPivot)
			else
				str = parent:GetFullName()..tostring(parent.CFrame)
			end
			
			if nt[str] == nil then
				nt[str] = parent
			end
		end
		
		return nt
	end
	
	objects = updtable(objects)
	reflectAll(objects, vpf)
end

return guif
