local car = script.Parent.Parent.Car.Value
local mouse = game.Players.LocalPlayer:GetMouse()
local cValues = script.Parent.Parent.Values
local Lights = car.Body.Lights

local mode=0
local LightOn=script.Parent.LightOn.Value
local LInd=false
local RInd=false
local PsOn=false
local lSteer=0
local rSteer=0

local day = 390
local night = 1050
local pulseDur = .33
local cancelThr = .4

function UpdateLight(prt,mat,col,trn,lon,lrg)
	prt.Material = mat
	prt.BrickColor = col
	prt.Transparency = trn
	prt.L.Enabled = lon
	prt.L.Range = lrg
end

car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		UpdateLight(Lights.RV,Enum.Material.SmoothPlastic,BrickColor.new("Institutional white"),0.4,false,15)
		if LightOn then
			UpdateLight(Lights.RR,Enum.Material.Neon,BrickColor.new("Bright red"),0,true,10)
		else
			UpdateLight(Lights.R,Enum.Material.SmoothPlastic,BrickColor.new("Bright red"),0,false,10)
		end
	end
end)

function ToggleLight()
	if LightOn then
		car.Body.Cover.Transparency = 1
		UpdateLight(Lights.FL,Enum.Material.Neon,BrickColor.new("Institutional white"),0.4,true,40)
		UpdateLight(Lights.FR,Enum.Material.Neon,BrickColor.new("Bright Red"),0.4,true,40)
		car.Body.FL.Transparency = 0.2
		car.Body.FR.Transparency = 0.2
	elseif LightOn then
		car.Body.Cover.Transparency = 1
		UpdateLight(Lights.FL,Enum.Material.Neon,BrickColor.new("Institutional white"),0.4,true,40)
		UpdateLight(Lights.FR,Enum.Material.Neon,BrickColor.new("Bright Red"),0.4,true,40)
		car.Body.FL.Transparency = 0.2
		car.Body.FR.Transparency = 0.2
	elseif not LightOn then
		car.Body.Cover.Transparency = 0
		UpdateLight(Lights.FL,Enum.Material.SmoothPlastic,BrickColor.new("Institutional white"),0.4,false,0)
		UpdateLight(Lights.FR,Enum.Material.SmoothPlastic,BrickColor.new("Bright Red"),0.4,false,0)
	end
	if cValues.Brake.Value>0 then
		UpdateLight(Lights.RR,Enum.Material.Neon,BrickColor.new("Really red"),0,true,15)
		UpdateLight(Lights.R,Enum.Material.Neon,BrickColor.new("Really red"),0,true,15)
		UpdateLight(Lights.R,Enum.Material.Neon,BrickColor.new("Really red"),0,true,15)
		UpdateLight(Lights.R,Enum.Material.Neon,BrickColor.new("Really red"),0,true,15)
	else
		if LightOn then
			UpdateLight(Lights.RR,Enum.Material.Neon,BrickColor.new("Bright red"),0,true,10)
			UpdateLight(Lights.R,Enum.Material.Neon,BrickColor.new("Bright red"),0,true,10)
			UpdateLight(Lights.R,Enum.Material.Neon,BrickColor.new("Bright red"),0,true,10)
			UpdateLight(Lights.R,Enum.Material.Neon,BrickColor.new("Bright red"),0,true,10)
		else
			UpdateLight(Lights.RR,Enum.Material.SmoothPlastic,BrickColor.new("Bright red"),0,false,10)
			UpdateLight(Lights.R,Enum.Material.SmoothPlastic,BrickColor.new("Bright red"),0,false,10)
			UpdateLight(Lights.R,Enum.Material.SmoothPlastic,BrickColor.new("Bright red"),0,false,10)
			UpdateLight(Lights.R,Enum.Material.SmoothPlastic,BrickColor.new("Bright red"),0,false,10)
		end
	end
end

function AutoLight()
	if mode == 0 then
		if (game.Lighting:GetMinutesAfterMidnight()<day or game.Lighting:GetMinutesAfterMidnight()>night) then
			if not LightOn then
				LightOn = true
				ToggleLight()
			end
		else
			if LightOn then
				LightOn = false
				ToggleLight()
			end
		end
	end
end

cValues.Brake.Changed:connect(function()
	if cValues.Brake.Value>0 then
		UpdateLight(Lights.RR,Enum.Material.Neon,BrickColor.new("Really red"),0,true,15)
		UpdateLight(Lights.R,Enum.Material.Neon,BrickColor.new("Really red"),0,true,15)
		UpdateLight(Lights.R,Enum.Material.Neon,BrickColor.new("Really red"),0,true,15)
		UpdateLight(Lights.R,Enum.Material.Neon,BrickColor.new("Really red"),0,true,15)
	else
		if LightOn then
			UpdateLight(Lights.RR,Enum.Material.Neon,BrickColor.new("Bright red"),0,true,10)
			UpdateLight(Lights.R,Enum.Material.Neon,BrickColor.new("Bright red"),0,true,10)
			UpdateLight(Lights.R,Enum.Material.Neon,BrickColor.new("Bright red"),0,true,10)
			UpdateLight(Lights.R,Enum.Material.Neon,BrickColor.new("Bright red"),0,true,10)
		else
			UpdateLight(Lights.RR,Enum.Material.SmoothPlastic,BrickColor.new("Bright red"),0,false,10)
			UpdateLight(Lights.R,Enum.Material.SmoothPlastic,BrickColor.new("Bright red"),0,false,10)
			UpdateLight(Lights.R,Enum.Material.SmoothPlastic,BrickColor.new("Bright red"),0,false,10)
			UpdateLight(Lights.R,Enum.Material.SmoothPlastic,BrickColor.new("Bright red"),0,false,10)
		end
	end
end)

cValues.Gear.Changed:connect(function()
	if cValues.Gear.Value == -1 then
		UpdateLight(Lights.RVR,Enum.Material.Neon,BrickColor.new("Institutional white"),0.2,true,15)
		UpdateLight(Lights.RVL,Enum.Material.Neon,BrickColor.new("Institutional white"),0.2,true,15)
	else
		UpdateLight(Lights.RVR,Enum.Material.SmoothPlastic,BrickColor.new("Institutional white"),0.2,false,15)
		UpdateLight(Lights.RVL,Enum.Material.SmoothPlastic,BrickColor.new("Institutional white"),0.2,false,15)
	end
end)

script.Parent.Toggle.MouseButton1Click:connect(function()
	if mode==0 then
		script.Parent.Toggle.Text = "Lights: On"
		mode=1
		LightOn=true
	elseif mode==1 then
		script.Parent.Toggle.Text = "Lights: Off"
		mode=2
		LightOn=false
	else
		script.Parent.Toggle.Text = "Lights: Auto"
		mode=0
		AutoLight()
	end
	ToggleLight()
end)


mouse.keyDown:connect(function(k)
	if k=="z" then
		if RInd then
			RInd=false
			LInd=true
		else
			LInd=not LInd
		end
	elseif k=="c" then
		if LInd then
			LInd=false
			RInd=true
		else
			RInd=not RInd
		end		
	elseif k=="x" then
		if LInd and RInd then
			LInd = false
			RInd = false
		else
			LInd = true
			RInd = true
		end
	end
end)

game:GetService("UserInputService").InputBegan:connect(function(input,IsRobloxFunction)
	if input.KeyCode ==Enum.KeyCode.DPadLeft and input.UserInputState == Enum.UserInputState.Begin then
		if RInd then
			RInd=false
			LInd=true
		else
			LInd=not LInd
		end
	elseif input.KeyCode ==Enum.KeyCode.DPadRight and input.UserInputState == Enum.UserInputState.Begin then
		if LInd then
			LInd=false
			RInd=true
		else
			RInd=not RInd
		end
	elseif input.KeyCode ==Enum.KeyCode.DPadUp and input.UserInputState == Enum.UserInputState.Begin then
		if LInd and RInd then
			LInd = false
			RInd = false
		else
			LInd = true
			RInd = true
		end
	end
end)
game.Lighting.Changed:connect(AutoLight)
AutoLight()