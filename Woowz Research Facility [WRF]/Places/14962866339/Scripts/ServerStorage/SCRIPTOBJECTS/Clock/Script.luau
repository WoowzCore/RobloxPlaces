local data = game:GetService("ServerScriptService").ServerInfo.Data
local clock = script.Parent.ClockCenter

local function upd()
	local s,m,h = data.Second.Value,data.Minute.Value,data.Hour.Value
	if h>=12 then
		h = h - 12
	end
	local rot_s = (s/60)
	local rot_m = (m/60) + rot_s/60
	local rot_h = (h/12) + rot_m/60
	
	clock.s.C0 = CFrame.Angles(0,math.rad(rot_s*(-360)),0)
	clock.m.C0 = CFrame.Angles(0,math.rad(rot_m*(-360)),0)
	clock.h.C0 = CFrame.Angles(0,math.rad(rot_h*(-360)),0)
end
upd()

data.Second:GetPropertyChangedSignal("Value"):Connect(function()
	upd()
end)

