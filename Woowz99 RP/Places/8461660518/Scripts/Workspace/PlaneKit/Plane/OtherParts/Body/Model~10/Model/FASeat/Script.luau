while true do
	wait(0.1)
	script.Parent.PartBOTTOM.Transparency = 1
		script.Parent.PartMIDDLE.Transparency = 0
		script.Parent.Seat.CanCollide = true
		local human = script.Parent.Seat:findFirstChild("SeatWeld") 
		if (human ~= nil ) then
		script.Parent.PartBOTTOM.Transparency = 0
		script.Parent.PartMIDDLE.Transparency = 1
		script.Parent.Seat.CanCollide = false
		wait(1)
	end
end
