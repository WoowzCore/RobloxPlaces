--[[
	    ___      _______                _       _______
	   / _ |____/ ___/ /  ___ ____ ___ (_)__   /__  __/
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<     / /
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/	/_/   
						SecondLogic @ Inspare
						Avxnturador @ Novena
]]
local FE = workspace.FilteringEnabled
local car = script.Parent.Car.Value
local handler = car:WaitForChild("AC6_FE_Sounds")
local _Tune = require(car["A-Chassis Tune"])
local BOVact = 0
local BOVact2 = 0

--Turbocharger
local BOV_Loudness = .75	--volume of the BOV (not exact volume so you kinda have to experiment with it)
local BOV_Pitch = 0.9	--max pitch of the BOV (not exact so might have to mess with it)
local T_Loudness = .325 --volume of the turbo(s) (not exact volume so you kinda have to experiment with it also)

--Supercharger
local Whine_Pitch = 1.3		--max pitch of the whine (not exact so might have to mess with it)
local S_Loudness = 1.3 --volume of the supercharger(s) (not exact volume so you kinda have to experiment with it also)

script:WaitForChild("Whistle")
script:WaitForChild("Whine")
script:WaitForChild("BOV")

for i,v in pairs(car.DriveSeat:GetChildren()) do
	for _,a in pairs(script:GetChildren()) do
		if v.Name==a.Name then v:Stop() wait() v:Destroy() end
	end
end

car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		for i,v in pairs(car.DriveSeat:GetChildren()) do
			for _,a in pairs(script:GetChildren()) do
				if v.Name==a.Name then v:Stop() wait() v:Destroy() end
			end
		end
	end
end)

if not _Tune.Engine then return end
handler:FireServer("newSound","Whistle",car.DriveSeat,script.Whistle.SoundId,0,script.Whistle.Volume,true)
handler:FireServer("newSound","Whine",car.DriveSeat,script.Whine.SoundId,0,script.Whine.Volume,true)
handler:FireServer("newSound","BOV",car.DriveSeat,script.BOV.SoundId,0,script.BOV.Volume,true)
handler:FireServer("playSound","Whistle")
handler:FireServer("playSound","Whine")
car.DriveSeat:WaitForChild("Whistle")
car.DriveSeat:WaitForChild("Whine")
car.DriveSeat:WaitForChild("BOV")
local ticc = tick()
local _TCount = _Tune.Turbochargers
local _SCount = _Tune.Superchargers

while wait() do
	local psi = (((script.Parent.Values.Boost.Value)/((_Tune.T_Boost*_TCount)+(_Tune.S_Boost*_SCount)))*2)
	local tpsi = (((script.Parent.Values.BoostTurbo.Value)/(_Tune.T_Boost*_TCount))*2)
	local spsi = ((script.Parent.Values.BoostSuper.Value)/(_Tune.S_Boost*_SCount))
	--(script.Parent.Values.RPM.Value/_Tune.Redline)
	local WP,WV,BP,BV,HP,HV = 0,0,0,0,0,0
	
	BOVact = math.floor(tpsi*20)
	if _TCount~=0 then
		WP = (tpsi)
		WV = (tpsi/4)*T_Loudness
		
		BP = (1-(-tpsi/20))*BOV_Pitch
		BV = (((-0.5+((tpsi/2)*BOV_Loudness)))*(1 - script.Parent.Values.Throttle.Value))
	
		if BOVact < BOVact2 then if car.DriveSeat.BOV.IsPaused then if FE then handler:FireServer("playSound","BOV") else car.DriveSeat.BOV:Play() end end end
		if BOVact >= BOVact2 then if FE then handler:FireServer("stopSound","BOV") else car.DriveSeat.BOV:Stop() end end
	else
		WP,WV,BP,BV=0,0,0,0
	end
	if _SCount~=0 then
		HP = (script.Parent.Values.RPM.Value/_Tune.Redline)*Whine_Pitch
		HV = (spsi/4)*S_Loudness
	else
		HP,HV = 0,0
	end

	handler:FireServer("updateSound","Whistle",script.Whistle.SoundId,WP,WV)
	handler:FireServer("updateSound","Whine",script.Whine.SoundId,HP,HV)
	handler:FireServer("updateSound","BOV",script.BOV.SoundId,BP,BV)
	
	if (tick()-ticc) >= 0.1 then
		BOVact2 = math.floor(tpsi*20)
		ticc = tick()
	end
end