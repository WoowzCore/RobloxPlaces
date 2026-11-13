seat = script.Parent

function onChildAdded(part)
	if part.className == "Weld" then
		local torso = part.Part1
		if torso ~= nil then
			local parent = torso.Parent
			parent:FindFirstChild("Left Arm").Transparency = 1
			parent:FindFirstChild("Right Arm").Transparency = 1
		end
	end
end
function onChildRem(part)
	if part.className == "Weld" then
		local torso = part.Part1
		if torso ~= nil then
			local parent = torso.Parent
			if parent ~= nil then
			parent:FindFirstChild("Left Arm").Transparency = 0
			parent:FindFirstChild("Right Arm").Transparency = 0
			end
		end
	end
end


seat.ChildAdded:connect(onChildAdded)
seat.ChildRemoved:connect(onChildRem)