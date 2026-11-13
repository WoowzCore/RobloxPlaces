local W_light = game.Weather
local W_atmosphere = W_light.Atmosphere
local W_Sky = W_light.Sky
local W_Bloom = W_light.Bloom
local W_SunRays = W_light.SunRays
local W_ColorCorrection = W_light.ColorCorrection

local UpdateSpeed = 2--Скорость обновления кадров

local CycleTime = 8--Время, так же первоначальное время при создании карты
local CycleTimeSpeed = 0.05--Скорость времени

local StartNight = 18--Начало ночи
local StartDay = 6--Начало дня

local LightWeather = 0--Яркость света при погоде
local LightCycle = 0--Яркость света при определённом времени

local WeatherTime = 0--Когда обновится погода?
local MinWeatherTime = 10--Минимальное время для ожидания смены погоды
local MaxWeatherTime = 500--Максимальное время для ожидания смены погоды
local WeatherTimeSpeed = 0.5--Скорсоть смены погоды

local WeatherCount = 1--Кол-во вариаций погоды

local WitherName = ""--Название погоды
local WitherID = math.random(0,WeatherCount)--Айди погоды

local NowNight = false--Сейчас ночь?
local NowDay = true--Сейчас день?

local HazeColor = Color3.fromRGB(184,184,184)

local function ResetHazeColor()
	HazeColor = Color3.fromRGB(184,184,184)
end

local function SetWeather(id)
	
	WeatherTime = math.random(MinWeatherTime,MaxWeatherTime)
	WitherID = id

	if id == 0 then--Солнечно
		WitherName = "Sunny"
		W_atmosphere.Density = 0.355
		W_atmosphere.Offset = 0
		W_atmosphere.Glare = 0
		W_atmosphere.Haze = 0
		W_Bloom.Intensity = 0.05
		W_Bloom.Size = 56
		W_Bloom.Threshold = 0.8
		LightWeather = 6.77
		ResetHazeColor()
	else if id == 1 then--Облачно
		WitherName = "Cloudy"
		W_atmosphere.Density = 0.387
		W_atmosphere.Offset = 0
		W_atmosphere.Glare = 0
		W_atmosphere.Haze = 10
		W_Bloom.Intensity = 0.05
		W_Bloom.Size = 56
		W_Bloom.Threshold = 0.8
		ResetHazeColor()
		LightWeather = 3.06
		end
	end
end

local function GetRandomWithod(int)
	local i = math.random(0,WeatherCount)
	if i == int then
		i = GetRandomWithod(int)
		if i == int then
			i = GetRandomWithod(int)
			if i == int then
				i = GetRandomWithod(int)
				if i == int then
					i = GetRandomWithod(int)
					if i == int then
						i = GetRandomWithod(int)
 									return i
					else
						return i
					end
				else
					return i
				end
			else
				return i
			end
		else
			return i
		end
	else
		return i
	end
	
end

	local function SetRandomWeather()
	SetWeather(GetRandomWithod(WitherID))
end

local function InDay()
	LightCycle = 1
	W_ColorCorrection.Saturation = 0
	if WitherName == "Cloudy" then
		ResetHazeColor()
	end
	
	
end
local function InNight()
	LightCycle = 0
	W_ColorCorrection.Saturation = -0.7
	if WitherName == "Cloudy" then
		HazeColor = Color3.fromRGB(47,47,47)
	end
	
	
end
local b = game.Workspace.NowNight.Value
while true do
	wait(UpdateSpeed)
	
	NowDay = not NowNight
	
	if CycleTime < StartDay or CycleTime > StartNight then
		NowNight = true
	else
		NowNight = false
	end
	
		CycleTime = CycleTime + CycleTimeSpeed
	W_light.ClockTime = CycleTime
	if CycleTime >= 23.9 then
		CycleTime = 0.1
	end
		
		WeatherTime = WeatherTime - WeatherTimeSpeed
		if WeatherTime <= 0 then	
			SetRandomWeather()
	end
	
	if NowDay == true then
		InDay()
	else
		InNight()
	end
	
	b = NowNight
	
	W_light.Brightness = LightWeather*LightCycle
	W_atmosphere.Color = HazeColor

end
