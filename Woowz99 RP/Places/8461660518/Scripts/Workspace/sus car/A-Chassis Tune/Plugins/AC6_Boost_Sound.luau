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
local BOV_Loudness = 1	--volume of the BOV (not exact volume so you kinda have to experiment with it)
local BOV_Pitch = 0.9	--max pitch of the BOV (not exact so might have to mess with it)

--Supercharger
local Whine_Pitch = 1.4		--max pitch of the whine (not exact so might have to mess with it)

--Both
local Loudness = .75 --volume of the boost supplier (not exact volume so you kinda have to experiment with it also)

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

handler:FireServer("newSound","Whistle",car.DriveSeat,script.Whistle.SoundId,0,script.Whistle.Volume,true)
handler:FireServer("newSound","Whine",car.DriveSeat,script.Whine.SoundId,0,script.Whine.Volume,true)
handler:FireServer("newSound","BOV",car.DriveSeat,script.BOV.SoundId,0,script.BOV.Volume,true)
handler:FireServer("playSound","Whistle")
handler:FireServer("playSound","Whine")
car.DriveSeat:WaitForChild("Whistle")
car.DriveSeat:WaitForChild("Whine")
car.DriveSeat:WaitForChild("BOV")
local ticc = tick()
local _TCount = 0
if _Tune.Aspiration == "Single" or _Tune.Aspiration == "Super" then _TCount = 1 elseif _Tune.Aspiration == "Double" then _TCount = 2 end

while wait() do
	local psi = (((script.Parent.Values.Boost.Value)/(_Tune.Boost*_TCount))*2)
	local WP,WV,BP,BV,HP,HV = 0
	
	BOVact = math.floor(psi*20)
	if _Tune.Aspiration == "Single" or _Tune.Aspiration == "Double" then
		WP = (psi)
		WV = (psi/4)*Loudness
		
		BP = (1-(-psi/20))*BOV_Pitch
		BV = (((-0.5+((psi/2)*BOV_Loudness)))*(1 - script.Parent.Values.Throttle.Value))
	
		if BOVact < BOVact2 then if car.DriveSeat.BOV.IsPaused then if FE then handler:FireServer("playSound","BOV") else car.DriveSeat.BOV:Play() end end end
		if BOVact >= BOVact2 then if FE then handler:FireServer("stopSound","BOV") else car.DriveSeat.BOV:Stop() end end
	elseif _Tune.Aspiration == "Super" then
		psi = psi/2
		HP = psi*Whine_Pitch
		HV = (psi/4)*Loudness
	end
		
	if FE then
		handler:FireServer("updateSound","Whistle",script.Whistle.SoundId,WP,WV)
		handler:FireServer("updateSound","Whine",script.Whine.SoundId,HP,HV)
		handler:FireServer("updateSound","BOV",script.BOV.SoundId,BP,BV)
	else
		car.DriveSeat.Whistle.Pitch = WP
		car.DriveSeat.Whistle.Volume = WV
		car.DriveSeat.Whine.Pitch = HP
		car.DriveSeat.Whine.Volume = HV
		car.DriveSeat.BOV.Pitch = BP
		car.DriveSeat.BOV.Volume = BV
	end
	if (tick()-ticc) >= 0.1 then
		BOVact2 = math.floor(psi*20)
		ticc = tick()
	end
end