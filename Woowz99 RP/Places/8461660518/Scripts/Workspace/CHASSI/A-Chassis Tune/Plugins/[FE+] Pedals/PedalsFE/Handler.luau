local car = script.Parent.Parent

local F = {}

F.PedalUpdate = function(pedal,val)
	if pedal == "Gas" then
		car.Misc.GP.SS.Motor.DesiredAngle = val
	elseif pedal == "Brake" then
		car.Misc.BP.SS.Motor.DesiredAngle = val
	elseif pedal == "Clutch" then
		car.Misc.CP.SS.Motor.DesiredAngle = val
		wait(0.3)
		car.Misc.CP.SS.Motor.DesiredAngle = 0
	end
end

script.Parent.OnServerEvent:connect(function(pl,Fnc,...)
	F[Fnc](...)
end)