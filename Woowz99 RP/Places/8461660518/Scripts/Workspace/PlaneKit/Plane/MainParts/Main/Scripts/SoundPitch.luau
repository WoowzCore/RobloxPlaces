local Normal1 = script.Parent.Parent.Parent.Sound1.Normal
local Normal2 = script.Parent.Parent.Parent.Sound2.Normal
local On = script.Parent.Parent.Variables.On
local Throttle = script.Parent.Parent.Variables.Throttle
local BasePitch = script.Parent.Parent.Variables.BasePitch
local MaxPitch = script.Parent.Parent.Variables.MaxPitch

while true do
	wait()
		if Throttle.Value > 0 then
			Normal1.Pitch = BasePitch.Value + (MaxPitch.Value-BasePitch.Value)*Throttle.Value / 100
			Normal2.Pitch = BasePitch.Value + (MaxPitch.Value-BasePitch.Value)*Throttle.Value / 100
		else
			Normal1.Pitch = BasePitch.Value
			Normal2.Pitch = BasePitch.Value
		if On.Value == true then
			Normal1:Resume()
			Normal2:Resume()
		else
			Normal1:Stop()
			Normal2:Stop()
		end
	end
end

