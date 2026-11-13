--borrowed from rikone2's enjin kenta, credits to him for this
while true do
	wait()
	local speed = script.Parent.Velocity.Magnitude
	local speedf = math.floor(speed)
	local odonum = script.Parent.ODO
	local odo = script.Parent.Parent.Body.Dash.DashSc.G.Modes.MPG.MPGCounter
	odonum.Value=rodo
	rodo = (odonum.Value+((speedf/30000)/5.280) )
	odo.Text = ((math.ceil((rodo)*10))/10)
end