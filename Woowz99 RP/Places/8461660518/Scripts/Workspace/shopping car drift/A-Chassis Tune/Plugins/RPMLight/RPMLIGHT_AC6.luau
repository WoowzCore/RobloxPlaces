--[[
		___      _______                _     
	   / _ |____/ ___/ /  ___ ____ ___ (_)__ 
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/
 						SecondLogic @ Inspare   RPM LIGHT BY TOUGEZILA
]]



local car = script.Parent.Parent.Car.Value
car.DriveSeat.HeadsUpDisplay = false

local _Tune = require(car["A-Chassis Tune"])

local _pRPM = _Tune.PeakRPM
local _lRPM = _Tune.Redline

local revEnd = math.ceil(_lRPM/1000)

local Drive={}


local RPMON = 6000

local RPMOFF = RPMON -100

script.Parent.Parent.Values.RPM.Changed:connect(function()
local Roundspeed = script.Parent.Parent.Values.RPM.Value

if Roundspeed <= RPMON then script.Parent.RPMLIGHT.Image = "rbxassetid://90124950"

elseif Roundspeed >= RPMOFF then script.Parent.RPMLIGHT.Image = "rbxassetid://117959738"
end 

end)



