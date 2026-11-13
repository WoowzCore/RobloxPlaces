--[[
		___      _______                _     
	   / _ |____/ ___/ /  ___ ____ ___ (_)__ 
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/
 						SecondLogic @ Inspare
]]
local FE = workspace.FilteringEnabled
local car = script.Parent.Car.Value
local handler = car:WaitForChild("AC6_FE_Sounds")
local _Tune = require(car["A-Chassis Tune"])
local on = 0
local throt=0
local redline=0

script:WaitForChild("Rev")
script:WaitForChild("Elec")

for i,v in pairs(car.DriveSeat:GetChildren()) do
	for _,a in pairs(script:GetChildren()) do
		if v.Name==a.Name then v:Stop() wait() v:Destroy() end
	end
end

handler:FireServer("newSound","Rev",car.DriveSeat,script.Rev.SoundId,0,script.Rev.SetVol.Value,true)
handler:FireServer("newSound","Elec",car.DriveSeat,script.Elec.SoundId,0,script.Elec.SetVol.Value,true)
handler:FireServer("playSound","Rev")
handler:FireServer("playSound","Elec")
car.DriveSeat:WaitForChild("Rev")
car.DriveSeat:WaitForChild("Elec")

while wait() do
	local _RPM = script.Parent.Values.RPM.Value
	
	if script.Parent.Values.Throttle.Value <= _Tune.IdleThrottle/100 then
		throt = math.max(.3,throt-.2)	
	else
		throt = math.min(1,throt+.1)	
	end	
	if script.Parent.Values.RPM.Value > _Tune.Redline-_Tune.RevBounce/4 and script.Parent.Values.Throttle.Value > _Tune.IdleThrottle/100 then
		redline=.5
	else
		redline=1
	end
	if not script.Parent.IsOn.Value then on=math.max(on-.015,0) else on=1 end
	local RevVol = script.Rev.SetVol.Value
	local ElecVol = script.Elec.SetVol.Value
	if not _Tune.Engine then RevVol = 0 end
	if not _Tune.Electric then ElecVol = 0 end
	local RevPitch = math.max((((script.Rev.SetPitch.Value + script.Rev.SetRev.Value*_RPM/_Tune.Redline))*on^2),script.Rev.SetPitch.Value)
	local ElecPitch = math.max((((script.Elec.SetPitch.Value + script.Elec.SetRev.Value*_RPM/_Tune.Redline))*on^2),script.Elec.SetPitch.Value)
	handler:FireServer("updateSound","Rev",script.Rev.SoundId,RevPitch,RevVol)
	handler:FireServer("updateSound","Elec",script.Elec.SoundId,ElecPitch,ElecVol)
end
