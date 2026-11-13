eng = script.Parent.Parent.Engine
seat = script.Parent
maxSpeed = seat.MaxSpeed
rotSpeed = seat.TurnSpeed
BV = eng.BodyVelocity
BAV = eng.BodyAngularVelocity
currSpeed = 0
oldSpeed = 0

function stop()
	local speed = seat.Velocity.magnitude
	if speed < 2 then					--If We're Barely Moving
		currSpeed = 0
		script.Parent.Parent.Engine.Moving.Volume = 0.1							--Kill Velocity
		script.Parent.Parent.Engine.Idle.Volume = 0.5
	else								--If not
		currSpeed = (speed * 0.9 - 0.8) * currSpeed / math.abs(currSpeed)
		script.Parent.Parent.Engine.Moving.Volume = 0.3
		script.Parent.Parent.Engine.Idle.Volume = 0.3
	end
end

while wait(0.1) do
	
	
	if seat.Throttle == -1 then								--Turning
		script.Parent.Parent.Engine.Moving.Volume = .3
		script.Parent.Parent.Engine.Idle.Volume = 0.2
		
		BAV.angularvelocity = Vector3.new(0,rotSpeed * seat.Steer,0)
	else
		BAV.angularvelocity = Vector3.new(0,-rotSpeed * seat.Steer,0)
	end
	
	
	if seat.Throttle == 0 and currSpeed == 0 then
		script.Parent.Parent.Engine.Idle.Volume = 0.5
	end
	
	if seat.Throttle == 0 and currSpeed ~= 0 then			--If We're Trying to Stop
		stop()
		script.Parent.Parent.Engine.Idle.Volume = 0.5	
		script.Parent.Parent.Engine.Moving.Volume = 0.1
	end
	
	if seat.Throttle == 1 then								--If We're Trying to go Forwards
		script.Parent.Parent.Engine.Idle.Volume = 0.1
		script.Parent.Parent.Engine.Moving.Volume = 0.2
		if currSpeed < 0 then									--If going backwards
			script.Parent.Parent.Engine.Idle.Volume = 0.1
			script.Parent.Parent.Engine.Moving.Volume = 0.2
			stop()
		else
			currSpeed = currSpeed + 1							--Go slightly faster than we already are
			if currSpeed > maxSpeed then							--Limit our speed
				script.Parent.Parent.Engine.Moving.Volume = .3
				currSpeed = maxSpeed
			end
		end
		
	elseif seat.Throttle == -1 then							--If We're Trying to go Backwards
		script.Parent.Parent.Engine.Idle.Volume = 0.1
		script.Parent.Parent.Engine.Moving.Volume = 0.2
		if currSpeed > 0 then									--If Going Forwards
			script.Parent.Parent.Engine.Idle.Volume = 0.1
			script.Parent.Parent.Engine.Moving.Volume = 0.2
			stop()													--Stop
		else												--Otherwise
			currSpeed = currSpeed - 0.8							--Reverse
			if currSpeed < maxSpeed * -0.7 then					--If Going Too Fast
				currSpeed = maxSpeed * -0.7
			end
		end
	end
	
	dir = eng.CFrame.lookVector
	BV.velocity = dir*Vector3.new(currSpeed,currSpeed,currSpeed)
end
