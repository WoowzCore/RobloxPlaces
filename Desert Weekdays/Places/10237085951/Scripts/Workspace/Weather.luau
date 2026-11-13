local Lighting = game.Lighting
local ticks = 1/30
local Minuts_In_Tick = 0.05
local Time = 0
Lighting.TimeOfDay = math.random(0,24)

local Time_Cycles = {
	All_Day = 0;
	Day = 0;
}

function SetOptionsOnLighting()
	Lighting.ShadowSoftness = 1-Time_Cycles.Day
	Lighting.Brightness = 7*Time_Cycles.All_Day
end

function TimeCycleUpdate()
	Time = Lighting:GetMinutesAfterMidnight() + Minuts_In_Tick
	Lighting:SetMinutesAfterMidnight(Time)
	Time = Time/60
	
	if Time < 12 then
		Time_Cycles.All_Day = Time/12
	else
		Time_Cycles.All_Day = (24 - Time)/12
	end
	
	if Time >= 6 and Time <= 18 then
		if Time > 12 then
			Time_Cycles.Day = (18-Time)/6
		else
			Time_Cycles.Day = (Time-6)/6
		end
	else
			Time_Cycles.Day = 0
	
	end
	
	--print(Time_Cycles.Day)
	SetOptionsOnLighting()
end

while wait(ticks) do
	TimeCycleUpdate()
end