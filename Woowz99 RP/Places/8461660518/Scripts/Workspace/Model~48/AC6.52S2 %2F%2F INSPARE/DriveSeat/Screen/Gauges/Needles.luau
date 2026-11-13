local player=game.Players.LocalPlayer
script.Parent.Parent:WaitForChild("CarSeat")
local carSeat=script.Parent.Parent.CarSeat.Value


while true do
	wait()
	
	
	local rpmvalue = carSeat.Velocity.magnitude
	local power = carSeat.Power.Value
	if carSeat.Throttle == 1 then
		script.Parent.NeedleP.Rotation = (-power)-90
	else
		script.Parent.NeedleP.Rotation = (rpmvalue/1.4)-90
	end
	if script.Parent.NeedleP.Rotation > -50 then
		script.Parent.NeedleP.Rotation = -50
	end
	local speed = carSeat.Velocity.magnitude
	script.Parent.NeedleS.Rotation = (speed/1.6)+20

end
