while true do
	wait()
	if script.Parent.Throttle.Value > 0 then
	script.Parent.Normal.Pitch = script.Parent.BasePitch.Value + (script.Parent.MaxPitch.Value-script.Parent.BasePitch.Value)*script.Parent.Throttle.Value
	script.Parent.Normal2.Pitch = script.Parent.BasePitch.Value + (script.Parent.MaxPitch.Value-script.Parent.BasePitch.Value)*script.Parent.Throttle.Value
	script.Parent.Buzzsaw.Pitch = script.Parent.BasePitch.Value + ((script.Parent.MaxPitch.Value-script.Parent.BasePitch.Value)*script.Parent.Throttle.Value) / 5
	script.Parent.Buzzsaw2.Pitch = script.Parent.BasePitch.Value + ((script.Parent.MaxPitch.Value-script.Parent.BasePitch.Value)*script.Parent.Throttle.Value) / 5
	script.Parent.Spool.Pitch = script.Parent.BasePitch.Value + ((script.Parent.MaxPitch.Value-script.Parent.BasePitch.Value)*script.Parent.Throttle.Value) * 1.4
	script.Parent.Spool2.Pitch = script.Parent.BasePitch.Value + ((script.Parent.MaxPitch.Value-script.Parent.BasePitch.Value)*script.Parent.Throttle.Value) * 1.4
	else
	script.Parent.Normal.Pitch = script.Parent.BasePitch.Value
	script.Parent.Normal2.Pitch = script.Parent.BasePitch.Value
	script.Parent.Buzzsaw.Pitch = script.Parent.BasePitch.Value
	script.Parent.Buzzsaw2.Pitch = script.Parent.BasePitch.Value
	end
	if script.Parent.Throttle.Value > 0.8 then 
		if script.Parent.Buzzsaw:findFirstChild("PlayNormal") == nil then
		local script1 = script.PlayNormal:Clone()
		script1.Parent = script.Parent.Buzzsaw
		script1.Disabled = false
		end
		if script.Parent.Buzzsaw2:findFirstChild("PlayDelay") == nil then
		local script2 = script.PlayDelay:Clone()
		script2.Parent = script.Parent.Buzzsaw2
		script2.Disabled = false
		end
	else
		if script.Parent.Buzzsaw:findFirstChild("PlayNormal") then
			script.Parent.Buzzsaw.PlayNormal:Remove() 
			script.Parent.Buzzsaw:Stop()
		end
		if script.Parent.Buzzsaw2:findFirstChild("PlayDelay") then
			script.Parent.Buzzsaw2.PlayDelay:Remove() 
			script.Parent.Buzzsaw2:Stop()
		end
	end
	if script.Parent.Throttle.Value > 0.1 then 
		if script.Parent.Spool:findFirstChild("PlayNormal") == nil then
		local script1 = script.PlayNormal:Clone()
		script1.Parent = script.Parent.Spool
		script1.Disabled = false
		end
		if script.Parent.Spool2:findFirstChild("PlayDelay") == nil then
		local script2 = script.PlayDelay:Clone()
		script2.Parent = script.Parent.Spool2
		script2.Disabled = false
		end
	else
		if script.Parent.Spool:findFirstChild("PlayNormal") then
			script.Parent.Spool.PlayNormal:Remove() 
			script.Parent.Spool:Stop()
		end
		if script.Parent.Spool2:findFirstChild("PlayDelay") then
			script.Parent.Spool2.PlayDelay:Remove() 
			script.Parent.Spool2:Stop()
		end
	end
	if script.Parent.On.Value == true then
		if script.Parent.Normal:findFirstChild("PlayNormal") == nil then
		local script1 = script.PlayNormal:Clone()
		script1.Parent = script.Parent.Normal
		script1.Disabled = false
		end
		if script.Parent.Normal2:findFirstChild("PlayDelay") == nil then
		local script2 = script.PlayDelay:Clone()
		script2.Parent = script.Parent.Normal2
		script2.Disabled = false
		end
	else 
		if script.Parent.Normal:findFirstChild("PlayNormal") then
			script.Parent.Normal.PlayNormal:Remove() 
			script.Parent.Normal:Stop()
		end
		if script.Parent.Normal2:findFirstChild("PlayDelay") then
			script.Parent.Normal2.PlayDelay:Remove() 
			script.Parent.Normal2:Stop()
		end
	end
end

