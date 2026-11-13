while wait() do
	if script.Parent.Throttle.Value > 0 then
		script.Parent.Normal.Pitch = script.Parent.BasePitch.Value + (script.Parent.MaxPitch.Value-script.Parent.BasePitch.Value)*script.Parent.Throttle.Value
		script.Parent.Normal2.Pitch = script.Parent.BasePitch.Value + (script.Parent.MaxPitch.Value-script.Parent.BasePitch.Value)*script.Parent.Throttle.Value
	else
		script.Parent.Normal.Pitch = script.Parent.BasePitch.Value
		script.Parent.Normal2.Pitch = script.Parent.BasePitch.Value
	end
	if script.Parent.On.Value == true then
		script.Parent.Normal:Resume()
		wait (1)
		script.Parent.Normal2:Resume()
	else
		script.Parent.Normal:Pause()
		script.Parent.Normal2:Pause()
	end
end