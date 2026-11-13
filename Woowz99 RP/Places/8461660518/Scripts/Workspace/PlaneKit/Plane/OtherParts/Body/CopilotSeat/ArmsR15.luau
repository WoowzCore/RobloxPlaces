seat = script.Parent

function onChildAdded(part)
	if part.className == "Weld" then
		local torso = part.Part1
		if torso ~= nil then
			local parent = torso.Parent
			parent:FindFirstChild("LeftUpperArm").Transparency = 1
			parent:FindFirstChild("RightUpperArm").Transparency = 1
			parent:FindFirstChild("LeftLowerArm").Transparency = 1
			parent:FindFirstChild("RightLowerArm").Transparency = 1
			parent:FindFirstChild("LeftHand").Transparency = 1
			parent:FindFirstChild("RightHand").Transparency = 1
		end
	end
end
function onChildRem(part)
	if part.className == "Weld" then
		local torso = part.Part1
		if torso ~= nil then
			local parent = torso.Parent
			if parent ~= nil then
			parent:FindFirstChild("LeftUpperArm").Transparency = 0
			parent:FindFirstChild("RightUpperArm").Transparency = 0
			parent:FindFirstChild("LeftLowerArm").Transparency = 0
			parent:FindFirstChild("RightLowerArm").Transparency = 0
			parent:FindFirstChild("LeftHand").Transparency = 0
			parent:FindFirstChild("RightHand").Transparency = 0
			end
		end
	end
end


seat.ChildAdded:connect(onChildAdded)
seat.ChildRemoved:connect(onChildRem)