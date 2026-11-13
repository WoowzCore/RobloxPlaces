local F = {}
local body = script.Parent.Parent.Parent.Body
local carSeat = script.Parent.Parent
local player = nil

F.updateSpeed = function()
body.Display.BMWHeadupDisplay.G.Speed.Text = (math.floor(body.Parent.DriveSeat.Velocity.magnitude*((10/12) * (60/88))))
end

script.Parent.OnServerEvent:connect(function(pl,Fnc,...)
	player = pl
	F[Fnc](...)
end)