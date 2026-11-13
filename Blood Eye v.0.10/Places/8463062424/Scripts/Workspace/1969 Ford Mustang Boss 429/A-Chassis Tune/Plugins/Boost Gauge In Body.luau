local car = script.Parent.Car.Value
local _Tune = require(car["A-Chassis Tune"])
local Drive={}
while true do
	wait()
	local turbo = script.Parent.Values.APSI.Value
	local turbo2 = script.Parent.Values.TPSI.Value
	
	car.Body.Boost.SurfaceGui.BoostGauge.BAnalog.Rotation= 120 + (turbo/turbo2)*200
end



