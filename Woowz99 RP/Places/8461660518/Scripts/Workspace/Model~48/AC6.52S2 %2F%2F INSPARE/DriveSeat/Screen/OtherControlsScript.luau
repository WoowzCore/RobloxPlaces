while wait() do
	local carSeat = script.Parent.CarSeat.Value
	local speed = carSeat.Velocity.magnitude
	local m = carSeat.Parent.Parent.Body2.MR.Motor
	local n = carSeat.Parent.Parent.Body2.ML.Motor
	local sw = carSeat.Parent.Parent.SW.SS.Motor
	if carSeat.Steer == 1 then
		m.DesiredAngle = (-1000/(speed+57.15)-16)/45
		n.DesiredAngle = m.DesiredAngle
		sw.DesiredAngle = -1
	elseif carSeat.Steer == -1 then
		m.DesiredAngle = (1000/(speed+57.15)+16)/45
		n.DesiredAngle = m.DesiredAngle
		sw.DesiredAngle = 1
	else
		m.DesiredAngle = 0
		n.DesiredAngle = 0
		sw.DesiredAngle = 0
	end
end