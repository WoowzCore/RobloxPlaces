while true do
	if script.Parent.Parent.Parent.Parent.AMECOTouch.Speed.Value == 0 then
		script.Parent.BodyAngularVelocity.MaxTorque = Vector3.new(0,0,0)
	elseif script.Parent.Parent.Parent.Parent.AMECOTouch.Speed.Value == 1 then
		script.Parent.BodyAngularVelocity.MaxTorque = Vector3.new(0,.5,0)
	elseif script.Parent.Parent.Parent.Parent.AMECOTouch.Speed.Value == 2 then
		script.Parent.BodyAngularVelocity.MaxTorque = Vector3.new(0,1,0)
	elseif script.Parent.Parent.Parent.Parent.AMECOTouch.Speed.Value == 3 then
		script.Parent.BodyAngularVelocity.MaxTorque = Vector3.new(0,1.25,0)
	elseif script.Parent.Parent.Parent.Parent.AMECOTouch.Speed.Value == 4 then
		script.Parent.BodyAngularVelocity.MaxTorque = Vector3.new(0,1.55,0)
	elseif script.Parent.Parent.Parent.Parent.AMECOTouch.Speed.Value == 5 then
		script.Parent.BodyAngularVelocity.MaxTorque = Vector3.new(0,2,0)
	elseif script.Parent.Parent.Parent.Parent.AMECOTouch.Speed.Value == 6 then
		script.Parent.BodyAngularVelocity.MaxTorque = Vector3.new(0,2.5,0)
	end
	wait()
end