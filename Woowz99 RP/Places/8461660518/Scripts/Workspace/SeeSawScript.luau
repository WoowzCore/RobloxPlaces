local Swing = script.Parent:WaitForChild("Swing")

-- Seats
local Seat1 = Swing:WaitForChild("Seat1")
local Seat2 = Swing:WaitForChild("Seat2")

-- Motor(s)
local SeeSawMotor = script.Parent:WaitForChild("SeeSawMotor")

local function OnSeatsChange(ChangedSeat)
	local Seat1Occupant = Seat1.Occupant
	local Seat2Occupant = Seat2.Occupant
	local Seat1T = Seat1.Throttle
	local Seat2T = Seat2.Throttle
	
	if Seat1Occupant and Seat2Occupant == nil then
		SeeSawMotor.DesiredAngle = 0.3
	elseif Seat2Occupant and Seat1Occupant == nil then
		SeeSawMotor.DesiredAngle = -0.3
	end
	
	if Seat1Occupant and Seat2Occupant then

		-- When both inputs are equal or would seem equal, make it balanced
		if Seat2T == 0 and Seat1T == 0 or Seat1T == -1 and Seat2T == -1 or Seat1T == 1 and Seat2T == 1 or Seat1T == -1 and Seat2T == 0 or Seat1T == 0 and Seat2T == -1 then
			SeeSawMotor.DesiredAngle = 0
			return
		end

		-- Seat1 logic
		if Seat1T == 1 and Seat2T == 0 or Seat1T == 1 and Seat2T == -1 then
			SeeSawMotor.DesiredAngle = 0.3
		end
		
		-- Seat2 logic
		if Seat2T == 1 and Seat1T == 0 or Seat2T == 1 and Seat1T == -1 then
			SeeSawMotor.DesiredAngle = -0.3
		end
	end
end

-- Events to listen to any player inputs
Seat1.Changed:connect(OnSeatsChange)
Seat2.Changed:connect(OnSeatsChange)