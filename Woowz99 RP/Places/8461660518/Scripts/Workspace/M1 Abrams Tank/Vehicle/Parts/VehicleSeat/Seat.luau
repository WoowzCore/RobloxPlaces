function sitting()
	local w = script.Parent:findFirstChild("SeatWeld")
	if w ~= nil then
	print("Found Weld")
	script.Parent.Parent.Engine.Idle:Play()
	script.Parent.Parent.Engine.Moving:Play()
	end
end

function jumped()
	local w = script.Parent:findFirstChild("SeatWeld")
	if w == nil then
	print("Lost weld")
	script.Parent.Parent.Engine.Idle:Stop()
	script.Parent.Parent.Engine.Moving:Stop()
	end
end


script.Parent.ChildAdded:connect(sitting)
script.Parent.ChildRemoved:connect(jumped)