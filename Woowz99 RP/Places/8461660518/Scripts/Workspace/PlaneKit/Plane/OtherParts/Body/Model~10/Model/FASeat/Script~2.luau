while true do
	wait(0.1)
	script.Parent.Seat.Transparency = 1
		script.Parent.Part.Transparency = 0
		script.Parent.Part.CanCollide = true
		local human = script.Parent.Seat:findFirstChild("SeatWeld") 
		if (human ~= nil ) then
		script.Parent.Seat.Transparency = 0
		script.Parent.Part.Transparency = 1
		script.Parent.Part.CanCollide = false
		wait(1)
	end
end
