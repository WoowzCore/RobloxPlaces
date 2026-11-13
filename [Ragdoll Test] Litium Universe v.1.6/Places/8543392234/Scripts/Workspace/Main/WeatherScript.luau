

local HereGlobalValues = game.Scene.Main.GlobalValue

local function SetValue(name,value)
	local Value = HereGlobalValues:WaitForChild(name)
	Value.Value = value
end

local function GetValue(name)
	local Value = HereGlobalValues:WaitForChild(name)
	return Value.Value
end

local Weather = game.Weather--Глобальное освещение
Weather.GlobalShadows = true
local Sky = Weather.Sky--Небо
local Atmosphere = Weather.Atmosphere--Туман
local Terrain = game.Scene.Terrain
local Clouds = Terrain.Clouds
local Graphics = {--Различная графика, эффекты
	Bloom = Weather.Bloom;--Яркие вспышки
	DOF = Weather.DOF;--Размытие
	SunRays = Weather.SunRays;--Солнечные лучи
	CC = Weather.ColorCorrection;--Цветовая коррекция
}


local Haze = 0
local MakeToThisHaze = 0

local HazeColor = Color3.new(1,1,1)

local Shadows = 0
local MakeToThisShadows = 0
local SetShadowsbool = true

local Brightness = 6
local MakeThisBrightness = 6
local DayLightBrightness = 6
local NightLightBrightness = 4
local MoonLightBrightness = {
	Full = 4;
	StartDark = 3;
	MiddleDark = 2;
	EndDark = 1;
	FullDark = 0;
	StartLight = 1;
	MiddleLight = 2;
	EndLight = 3;
}

local SkyTextures = {
	Planets = {
		Sun = 8546317146;--6196665106;
		DarkSun = 8574510479;
		Moon = {
			Full = 8544966914;
			StartDark = 8545127503;
			MiddleDark = 8545131889;
			EndDark = 8545134978;
			FullDark = 8545134978;
			StartLight = 8545144004;
			MiddleLight = 8545146394;
			EndLight = 8545175079;
		};
	};
	Sunny = {
		Bk = 6444884337;
		Dn = 6444884785;
		Ft = 6444884337;
		Lf = 6444884337;
		Rt = 6444884337;
		Up = 6412503613;
		
	};
}

local function SetSky(weather)
	local BK = SkyTextures.Sunny.Bk
	local DN = SkyTextures.Sunny.Dn
	local FT = SkyTextures.Sunny.Ft
	local LF = SkyTextures.Sunny.Lf
	local RT = SkyTextures.Sunny.Rt
	local UP = SkyTextures.Sunny.Up
	
	Sky.SkyboxBk = "rbxassetid://"..BK
	Sky.SkyboxDn = "rbxassetid://"..DN
	Sky.SkyboxFt = "rbxassetid://"..FT
	Sky.SkyboxLf = "rbxassetid://"..LF
	Sky.SkyboxRt = "rbxassetid://"..RT
	Sky.SkyboxUp = "rbxassetid://"..UP
	
end

local function SetPlanet(planet,texture,size)
	if size == nil then
		if planet == "Sun" then
			Sky.SunAngularSize = 7
		else
			Sky.MoonAngularSize = 2
		end
	else
		if planet == "Sun" then
			Sky.SunAngularSize = size
		else
			Sky.MoonAngularSize = size
		end
	end
	
	if texture == 0 then

	else
		if planet == "Sun" then
			Sky.SunTextureId = "rbxassetid://"..texture
		else
			Sky.MoonTextureId = "rbxassetid://"..texture
		end
	end
end

local GoWeatherR = 2

local function GetRandomWeather(id)
	local itog = "Sunny"
	
	if id == 0 then
		itog = "Sunny"
	else if id == 1 then
			itog = "Cloudy"
		else if id == 2 then
				itog = "Rain"
			end
		end
	end
	return itog
end

local function GoWeather(WeatherID)
	
	if WeatherID == "Sunny" then
		
		MakeToThisShadows = 0
		if GetValue("MapTime") > 5 and GetValue("MapTime") < 7 then
			MakeToThisHaze = 2.2
		else
			if GetValue("MapTime") > 17 and GetValue("MapTime") < 19 then
				MakeToThisHaze = 2.2
			else
				MakeToThisHaze = 1
			end
			end
		
		
		
		
	else if WeatherID == "Cloudy" then
			MakeToThisHaze = 4
			MakeToThisShadows = 0.5
		else if WeatherID == "Rain" then
				MakeToThisHaze = 4
				MakeToThisShadows = 0.5
				
			end
		end
	end
end

local function SetTime(tim)
	Weather.ClockTime = tim
end

local function NewNight()
	SetValue("MoonPhase",GetValue("MoonPhase")+1)
	if GetValue("MoonPhase") > 7 then
		SetValue("MoonPhase",0)
	end
	if GetValue("MoonPhase") == 0 then
		SetPlanet("Moon",SkyTextures.Planets.Moon.Full)
		NightLightBrightness = MoonLightBrightness.Full
	else if GetValue("MoonPhase") == 1 then
			SetPlanet("Moon",SkyTextures.Planets.Moon.StartDark)
			NightLightBrightness = MoonLightBrightness.StartDark
		else if GetValue("MoonPhase") == 2 then
				SetPlanet("Moon",SkyTextures.Planets.Moon.MiddleDark)
				NightLightBrightness = MoonLightBrightness.MiddleDark
			else if GetValue("MoonPhase") == 3 then
					SetPlanet("Moon",SkyTextures.Planets.Moon.EndDark)
					NightLightBrightness = MoonLightBrightness.EndDark
				else if GetValue("MoonPhase") == 4 then
						SetPlanet("Moon",SkyTextures.Planets.Moon.FullDark)
						NightLightBrightness = MoonLightBrightness.FullDark
					else if GetValue("MoonPhase") == 5 then
							SetPlanet("Moon",SkyTextures.Planets.Moon.StartLight)
							NightLightBrightness = MoonLightBrightness.StartLight
						else if GetValue("MoonPhase") == 6 then
								SetPlanet("Moon",SkyTextures.Planets.Moon.MiddleLight)
								NightLightBrightness = MoonLightBrightness.MiddleLight
							else if GetValue("MoonPhase") == 7 then
									SetPlanet("Moon",SkyTextures.Planets.Moon.EndLight)
									NightLightBrightness = MoonLightBrightness.EndLight
									
								end
							end
						end
					end
				end
			end
		end
	end
end

local function NewDay()
	SetValue("Day",GetValue("Day")+1)
end

local function GoTime()
	
	if GetValue("NowDay") then
		if GetValue("Weather") == "Sunny" then
			MakeThisBrightness = DayLightBrightness
		else
			MakeThisBrightness = 0
		end
	else
		MakeThisBrightness = NightLightBrightness
	end
	
	if GetValue("MapTime") > 6 and GetValue("MapTime") < 18 then
		SetValue("NowDay",true)
	else
		SetValue("NowDay",false)
	end
	SetValue("NowNight",not GetValue("NowDay"))
	
	if GetValue("MapTime") > 24 then
		SetValue("MapTime",0.02)
		NewDay()
	end
	
	if GetValue("MapTime") >= 11.98 and GetValue("MapTime") < 12 then
		SetValue("MapTime",12)
		NewNight()
	end
	
	if GetValue("NowDay") then
		SetValue("MapTime",GetValue("MapTime")+0.005)
	else
		SetValue("MapTime",GetValue("MapTime")+0.05)
	end
	
	SetTime(GetValue("MapTime"))
	
end

local SetBrightnessbool = true
local SetHazebool = true
local function SetBrightness()
	local times = 0.05

	if Brightness < MakeThisBrightness then
		SetBrightnessbool = false
		Brightness = Brightness + times
		wait(times)
		SetBrightnessbool = true
	end

	if Brightness > MakeThisBrightness then
		SetBrightnessbool = false
		Brightness = Brightness - times
		wait(times)
		SetBrightnessbool = true
	end

end

local function SmoothColor(colorOne,colorTwo,times)
	
	local r1 = colorOne.R
	local g1 = colorOne.G
	local b1 = colorOne.B
	
	local r2 = colorTwo.R
	local g2 = colorTwo.G
	local b2 = colorTwo.B
	
	local rBool = true
	local gBool = true
	local bBool = true
	
	if r1 < r2 then
		rBool = false
		r1 = r1 + times
		wait(times)
		rBool = true
	end

	if r1 > r2 then
		rBool = false
		r1 = r1 - times
		wait(times)
		rBool = true
	end
	
	if g1 < g2 then
		gBool = false
		g1 = g1 + times
		wait(times)
		gBool = true
	end

	if g1 > g2 then
		gBool = false
		g1 = g1 - times
		wait(times)
		gBool = true
	end
	
	if b1 < b2 then
		bBool = false
		b1 = b1 + times
		wait(times)
		bBool = true
	end

	if b1 > b2 then
		bBool = false
		b1 = b1 - times
		wait(times)
		bBool = true
	end
	
	return Color3.new(r1,g1,b1)
end

local function SetHaze()
	local times = 0.1
	if Haze >=2 then
		times = 0.01
	end

	if Haze < MakeToThisHaze then
		SetHazebool = false
		Haze = Haze + times
		wait(times)
		SetHazebool = true
	end

	if Haze > MakeToThisHaze then
		SetHazebool = false
		Haze = Haze - times
		wait(times)
		SetHazebool = true
	end

end

local function SetShadow()
	local times = 0.005

	if Shadows < MakeToThisShadows then
		SetShadowsbool = false
		Shadows=Shadows + times
		wait(times)
		SetShadowsbool = true
	end

	if Shadows > MakeToThisShadows then
		SetShadowsbool = false
		Shadows = Shadows - times
		wait(times)
		SetShadowsbool = true
	end

end

local function Start()
	SetPlanet("Sun",SkyTextures.Planets.Sun)
	SetPlanet("Moon",SkyTextures.Planets.Moon.Full)
end
Start()

local function SetRandomWeather(id,no)
	local w = id
	if no then
		if w == no then
			w = GetRandomWeather(id)
			if w == no then
				w = GetRandomWeather(id)
				if w == no then
					w = GetRandomWeather(id)
					if w == no then
						w = GetRandomWeather(id)
						if w == no then
							w = GetRandomWeather(id)
						end
					end
				end
			end
		end
	end
	SetValue("Weather",w)
end

local function SmoothNumber(first,second,times)
	local first2
	if first < second then
		first2 = first + times
	end
	if first > second then
		first2 = first - times
	end
	return first2
end

SetRandomWeather(GetRandomWeather(math.random(0,GoWeatherR)))
SetValue("MapTime",math.random(9,16))
SetValue("MoonPhase",math.random(0,7))

local WeatherWait = 0
local function SetWeatherNatural()
	WeatherWait = math.random(5,1000)
	SetRandomWeather(GetRandomWeather(math.random(0,GoWeatherR),GetValue("Weather")))
end	

Clouds.Cover = math.random(0,100)/100
Clouds.Density = math.random(0,100)/100

local function WaitWeather()
	wait(1)

	GoTime()
	GoWeather(GetValue("Weather"))
	
	Clouds.Cover = SmoothNumber(Clouds.Cover,GetValue("CloudsPower"),0.005)
	Clouds.Density = SmoothNumber(Clouds.Cover,GetValue("CloudsDensity"),0.005)
	local cloudcolor = 1-(Atmosphere.Haze/8)+( math.abs((GetValue("MapTime")-12))/12)
	Clouds.Color  =  Color3.new(cloudcolor,cloudcolor,cloudcolor)
	
	DayLightBrightness = 6 - ((Clouds.Cover+Clouds.Density)/2)*6
	
	if GetValue("MapTime") < 18.5 and GetValue("MapTime") > 18 then
		Brightness = 0
	end
	if SetBrightnessbool then
		SetBrightness()
		Weather.Brightness = Brightness
	end
	if SetHazebool then
		SetHaze()
		Atmosphere.Haze = Haze
	end
	if SetShadowsbool then
		SetShadow()
		Weather.ShadowSoftness = Shadows
	end

	if GetValue("MapTime") > 5.5 and GetValue("MapTime") < 7.5 then
		HazeColor = Color3.new(1,0.2,0)
	else
		if GetValue("MapTime") > 17.5 and GetValue("MapTime") < 18.5 then
			HazeColor = Color3.fromRGB(255, 184, 60)
		else
			if GetValue("NowNight") then

				HazeColor = Color3.new(0,0,0)
			else

				if GetValue("Weather") == "Sunny" then
					HazeColor = Color3.new(1,1,1)
				else
					HazeColor = Color3.fromRGB(117,117,117)
				end

			end


		end
	end

	if Haze < 4 then
		if Haze < 2.5 then
			SetPlanet("Sun",SkyTextures.Planets.Sun)
			Graphics.SunRays.Enabled = true
		else
			SetPlanet("Sun","8575880464")--8574510479
			Graphics.SunRays.Enabled = false
		end
	else
		SetPlanet("Sun","8548397383")
		Graphics.SunRays.Enabled = true
	end

	Atmosphere.Color = SmoothColor(Atmosphere.Color,HazeColor,0.01)

	WeatherWait = WeatherWait - 1
	if WeatherWait <= 0 then
		SetWeatherNatural()
	end
end

while true do
	wait()
	
	WaitWeather()
end
